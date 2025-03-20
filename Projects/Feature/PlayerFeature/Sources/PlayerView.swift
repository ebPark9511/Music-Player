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
        
        init() { }
    }
    
    enum Action {
        case onAppear
        case playButtonTapped
        case pauseButtonTapped
        case currentSongUpdated(Song)
        case currentPlaybackStateUpdated(PlayerState)
        case playbackTimeUpdated(TimeInterval)
    }
    
    private let resumePlaybackUseCase: ResumePlaybackUseCase
    private let pausePlaybackUseCase: PausePlaybackUseCase
    private let observeCurrentSongUseCase: ObserveCurrentSongUseCase
    private let observePlaybackStateUseCase: ObservePlaybackStateUseCase
    private let observePlaybackTimeUseCase: ObservePlaybackTimeUseCase

    init(
        resumePlaybackUseCase: ResumePlaybackUseCase,
        pausePlaybackUseCase: PausePlaybackUseCase,
        observeCurrentSongUseCase: ObserveCurrentSongUseCase,
        observePlaybackStateUseCase: ObservePlaybackStateUseCase,
        observePlaybackTimeUseCase: ObservePlaybackTimeUseCase
    ) {
        self.resumePlaybackUseCase = resumePlaybackUseCase
        self.pausePlaybackUseCase = pausePlaybackUseCase
        self.observeCurrentSongUseCase = observeCurrentSongUseCase
        self.observePlaybackStateUseCase = observePlaybackStateUseCase
        self.observePlaybackTimeUseCase = observePlaybackTimeUseCase
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
                    
                    for await action in songStream
                        .merge(with: playbackStream)
                        .merge(with: timeStream)
                        .values {
                        await send(action)
                    }
                }
                
            case .playButtonTapped:
                resumePlaybackUseCase.execute()
                return .none
                
            case .pauseButtonTapped:
                pausePlaybackUseCase.execute()
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
            }
        }
    }
}


struct PlayerView: View {
    
    let store: StoreOf<Player>
    
    @Environment(\.dismiss) private var dismiss
    @State private var volume: Double = 0.5
    
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
                
                VStack(spacing: 0) {
                    Text(store.currentSong?.title ?? "")
                        .fontWeight(.bold)
                    
                    Text(store.currentSong?.artist ?? "")
                        .foregroundColor(.gray)
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(width: 44)
                
            }
            .padding([.top, .horizontal])
            
            Spacer()
            
            (
                store.currentSong?.artworkImage == nil
                ? Image(systemName: "music.note")
                : Image(uiImage: store.currentSong!.artworkImage!)
            )
            .resizable()
            .background(.gray)
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
            .cornerRadius(8)
            .shadow(radius: 10)
            
            Spacer()
            
            HStack(spacing: 30) {
                Button(action: {
                    print("한곡반복")
                }) {
                    Image(systemName: "repeat.1")
                        .foregroundColor(.blue.opacity(0.3))
                }
                
                Button(action: {
                    print("이전")
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
                
                Slider(value: $volume, in: 0...1)
                    .accentColor(.gray)
                
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 12))
            .padding(.horizontal)
            .padding(.bottom, 32)
            
            if let song = store.currentSong {
                VStack(spacing: 0) {
                    HStack {
                        Text(timeString(from: store.currentTime))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("-" + timeString(from: song.duration - store.currentTime))
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
                                .frame(width: geometry.size.width * (store.currentTime / song.duration), height: 4)
                        }
                    }
                    .frame(height: 4)
                    .padding(.top, 8)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    private func timeString(from timeInterval: Double) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
