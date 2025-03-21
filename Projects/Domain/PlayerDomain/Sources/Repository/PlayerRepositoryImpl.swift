//
//  PlayerRepositoryImpl.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import PlayerDomainInterface
import Combine
import MediaPlayer

final class PlayerRepositoryImpl: PlayerRepository {
    
    private let _mediaService: MediaService
    private let _playing: CurrentValueSubject<Playable?, Never> = .init(nil)
    private let _timer: CurrentValueSubject<TimeInterval, Never> = .init(0)
    private let _playerState: CurrentValueSubject<PlayerState?, Never> = .init(nil)
    private let _restart: PassthroughSubject<Void, Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?
    private var currentTime: TimeInterval = 0
    
    init(
        mediaService: MediaService
    ) {
        self._mediaService = mediaService
        
        self.bind()
    }
    
    private func bind() {
        let observeNowPlaying = _mediaService.observeNowPlaying()
            .map { $0.map { SongItem(entity: $0) } }
            .share()
            
        observeNowPlaying
            .sink { [weak self] playable in
                self?._playing.send(playable)
            }
            .store(in: &cancellables)
        
        let restartPublisher = _restart
            .compactMap { [weak self] _ in
                self?._playing.value?.duration
            }
        
        Publishers.Merge(
            observeNowPlaying.compactMap { $0?.duration },
            restartPublisher
        )
        .sink(receiveValue: { [weak self] duration in
            self?._timer.send(0)
            self?.currentTime = 0
            self?.startTimer(duration: duration)
        })
        .store(in: &cancellables)
        
        _mediaService.observePlaybackState()
            .compactMap { $0?.asPlayerState }
            .sink(receiveValue: { [weak self] state in
                self?._playerState.send(state)
            })
            .store(in: &cancellables)
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func startTimer(duration: TimeInterval) {
        timer?.cancel()
        currentTime = 0
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map { _ in duration }
            .scan(currentTime) { currentTime, _ in
                let nextTime = currentTime + 1
                return nextTime
            }
            .sink { [weak self] time in
                self?.currentTime = time
                self?._timer.send(time)
                
                if duration < time {
                    self?.timer?.cancel()
                    self?.timer = nil
                }
            }
    }
    
    func play(items: [Playable], isShuffle: Bool) {
        let _ = _mediaService.play(
            items: items.map { SongItem(playableEntity: $0) },
            isShuffle: isShuffle
        )
    }
    
    func previous() {
        if _timer.value > 3 {
            stopTimer()
            _mediaService.restartCurrentSong()
            
        } else {
            _mediaService.previous()
        }
        
        _restart.send()
    }
    
    func resume() {
        _mediaService.resume()
        if let playing = _playing.value {
            startTimer(duration: playing.duration)
        }
    }
    
    func pause() {
        _mediaService.pause()
        stopTimer()
    }
    
    func observeNowPlaying() -> AnyPublisher<Playable?, Never> {
        _playing
            .removeDuplicates(by: { lhs, rhs in
                lhs?.id == rhs?.id
            })
            .eraseToAnyPublisher()
    }

    func observePlaybackTime() -> AnyPublisher<TimeInterval, Never> {
        _timer.eraseToAnyPublisher()
    }
    
    func observePlaybackState() -> AnyPublisher<PlayerState, Never> {
        _playerState
            .compactMap { $0 }
            .removeDuplicates(by: { lhs, rhs in lhs == rhs })
            .eraseToAnyPublisher()
    }
}

private extension MPMusicPlaybackState {
    var asPlayerState: PlayerState? {
        PlayerState(rawValue: self.rawValue)
    }
}
