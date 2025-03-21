//
//  PlayerView.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MusicDomainInterface
import PlayerDomainInterface
import Combine

@Reducer
struct Player {
    @ObservableState
    struct State: Equatable {
        var isPlaying: Bool = false
        var currentSong: Song?
        var currentTime: TimeInterval = 0
        var volume: Float = 0.5
        
        init(isPlaying: Bool = false, currentSong: Song? = nil, currentTime: TimeInterval = 0, volume: Float = 0.5) {
            self.isPlaying = isPlaying
            self.currentSong = currentSong
            self.currentTime = currentTime
            self.volume = volume
        }
    }
    
    enum Action {
        case onAppear
        case onDisappear
        case playButtonTapped
        case pauseButtonTapped
        case previousButtonTapped
        case currentSongUpdated(Song)
        case currentPlaybackStateUpdated(PlayerState)
        case playbackTimeUpdated(TimeInterval)
        case chagneVolume(Float)
        case volumeChangeRequested(Float) // 볼륨 변경 요청을 위한 새로운 액션
    }
    
    private let resumePlaybackUseCase: ResumePlaybackUseCase
    private let pausePlaybackUseCase: PausePlaybackUseCase
    private let observeCurrentSongUseCase: ObserveCurrentSongUseCase
    private let observePlaybackStateUseCase: ObservePlaybackStateUseCase
    private let observePlaybackTimeUseCase: ObservePlaybackTimeUseCase
    private let adjustVolumeUseCase: AdjustVolumeUseCase
    private let observeVolumeUseCase: ObserveVolumeUseCase
    private let playPreviousSongUseCase: PlayPreviousSongUseCase

    init(
        resumePlaybackUseCase: ResumePlaybackUseCase,
        pausePlaybackUseCase: PausePlaybackUseCase,
        observeCurrentSongUseCase: ObserveCurrentSongUseCase,
        observePlaybackStateUseCase: ObservePlaybackStateUseCase,
        observePlaybackTimeUseCase: ObservePlaybackTimeUseCase,
        adjustVolumeUseCase: AdjustVolumeUseCase,
        observeVolumeUseCase: ObserveVolumeUseCase,
        playPreviousSongUseCase: PlayPreviousSongUseCase
    ) {
        self.resumePlaybackUseCase = resumePlaybackUseCase
        self.pausePlaybackUseCase = pausePlaybackUseCase
        self.observeCurrentSongUseCase = observeCurrentSongUseCase
        self.observePlaybackStateUseCase = observePlaybackStateUseCase
        self.observePlaybackTimeUseCase = observePlaybackTimeUseCase
        self.adjustVolumeUseCase = adjustVolumeUseCase
        self.observeVolumeUseCase = observeVolumeUseCase
        self.playPreviousSongUseCase = playPreviousSongUseCase
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    let songStream = observeCurrentSongUseCase.execute()
                        .compactMap { songEntity -> Action? in
                            guard let songEntity else { return nil }
                            return Action.currentSongUpdated(Song(
                                id: songEntity.id,
                                title: songEntity.title,
                                artist: songEntity.artist,
                                artworkImage: songEntity.artworkImage,
                                duration: songEntity.duration
                            ))
                        }
                    
                    let playbackStream = observePlaybackStateUseCase.execute()
                        .map { Action.currentPlaybackStateUpdated($0) }
                    
                    let timeStream = observePlaybackTimeUseCase.execute()
                        .map { Action.playbackTimeUpdated($0) }
                    
                    let volumeStream = observeVolumeUseCase.execute()
                        .removeDuplicates()
                        .map { Action.chagneVolume($0) }
                    
                    for await action in songStream
                        .merge(with: playbackStream)
                        .merge(with: timeStream)
                        .merge(with: volumeStream)
                        .values {
                        await send(action)
                    }
                }.cancellable(id: CancelID.observation)
                
            case .onDisappear:
                return .cancel(id: CancelID.observation)
                
            case .playButtonTapped:
                resumePlaybackUseCase.execute()
                return .none
                
            case .pauseButtonTapped:
                pausePlaybackUseCase.execute()
                return .none
                
            case .previousButtonTapped:
                playPreviousSongUseCase.execute()
                return .none
                
            case let .currentSongUpdated(song):
                state.currentSong = song
                return .none
                
            case let .currentPlaybackStateUpdated(playbackState):
                state.isPlaying = playbackState == .playing
                return .none
                
            case let .playbackTimeUpdated(time):
                state.currentTime = time
                return .none
                
            case let .volumeChangeRequested(volume):
                adjustVolumeUseCase.execute(volume: volume)
                return .none
                
            case let .chagneVolume(volume):
                state.volume = volume
                return .none
            }
        }
    }
    
    private enum CancelID {
        case observation
    }
}


struct PlayerView: View {
    
    let store: StoreOf<Player>
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                }
                .frame(width: 44)
                
                Spacer()
                
                SongInfoView(song: store.currentSong)
                
                Spacer().frame(width: 44)
                
            }
            .padding([.top, .horizontal])
            
            Spacer()
            
            ArtworkImageView(image: store.currentSong?.artworkImage)
            
            Spacer()
            
            HStack(spacing: 30) {
                Button(action: {
                    print("한곡반복")
                }) {
                    Image(systemName: "repeat.1")
                        .foregroundColor(.blue.opacity(0.3))
                }
                
                Button(action: {
                    store.send(.previousButtonTapped)
                }) {
                    Image(systemName: "backward.fill")
                }
                
                Button(action: {
                    store.send(
                        store.isPlaying
                        ? .pauseButtonTapped
                        : .playButtonTapped
                    )
                }) {
                    Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                }
                
                Button(action: {
                    print("다음")
                }) {
                    Image(systemName: "forward.fill")
                }
                
                Button(action: {
                    print("랜덤재생")
                }) {
                    Image(systemName: "shuffle")
                        .foregroundColor(.blue.opacity(0.3))
                }
            }
            .font(.title2)
            .padding(.bottom, 16)
            
            HStack(spacing: 12) {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.gray)
                
                Slider(value: .init(
                    get: { Double(store.volume) },
                    set: { store.send(.volumeChangeRequested(Float($0))) }
                ), in: 0...1)
                .accentColor(.gray)
                
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 12))
            .padding(.horizontal)
            .padding(.bottom, 32)
            
            if let song = store.currentSong {
                PlaybackProgressView(currentTime: store.currentTime, duration: song.duration)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .onDisappear {
            store.send(.onDisappear) 
        }
    }
    
    private func timeString(from timeInterval: Double) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

private struct SongInfoView: View {
    let song: Song?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(song?.title ?? "")
                .fontWeight(.bold)
            
            Text(song?.artist ?? "")
                .foregroundColor(.gray)
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

private struct ArtworkImageView: View {
    let image: UIImage?
    
    var body: some View {
        (
            image == nil
            ? Image(systemName: "music.note")
            : Image(uiImage: image!)
        )
        .resizable()
        .background(.gray)
        .aspectRatio(contentMode: .fit)
        .frame(width: 300, height: 300)
        .cornerRadius(8)
        .shadow(radius: 10)
    }
}

private struct PlaybackProgressView: View {
    let currentTime: TimeInterval
    let duration: TimeInterval
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(timeString(from: currentTime))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("-" + timeString(from: duration - currentTime))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * (currentTime / duration), height: 4)
                }
            }
            .frame(height: 4)
            .padding(.top, 8)
        }
    }
    
    private func timeString(from timeInterval: Double) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
