//
//  PlayerView.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import PlayerFeatureInterface
import ComposableArchitecture
import MusicDomainInterface
import PlayerDomainInterface
import Combine

@Reducer
struct MiniPlayer {
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
                                duration: songEntity.duration,
                                trackNumber: songEntity.trackNumber
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


struct MiniPlayerView: View {
    
    let store: StoreOf<MiniPlayer>
    
    private let coordinator: PlayerCoordinating
    @State private var showFullPlayer: Bool = false
    @State private var playerView: AnyView?
    
    init(
        store: StoreOf<MiniPlayer>,
        coordinator: PlayerCoordinating
    ) {
        self.store = store
        self.coordinator = coordinator
        self._playerView = State(initialValue: AnyView(coordinator.player()))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let song = store.currentSong {
                
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.blue)
                        .frame(width: geometry.size.width * (store.currentTime / song.duration),
                               height: 4)
                }
                .frame(height: 4)
                
                HStack(spacing: 16) {
                    Button(action: {
                        store.send(
                            store.isPlaying
                            ? .pauseButtonTapped
                            : .playButtonTapped
                        )
                    }) {
                        Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                    }
                    .padding(.leading, 16)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title ?? "Unknown title")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            
                            Text(song.artist ?? "Unknown artist")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 5)
                        
                        (
                            song.artworkImage == nil
                            ? Image(systemName: "music.note")
                            : Image(uiImage: song.artworkImage!)
                        )
                        .resizable()
                        .background(.gray)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .cornerRadius(4)
                        .padding(.trailing, 16)
                    }
                }
                .frame(height: 72)
                .padding(.horizontal, 10)
            }
            
        }
        .background(Color(UIColor.systemBackground))
        .contentShape(Rectangle())
        .onTapGesture {
            showFullPlayer = true
        }
        .sheet(
            isPresented: $showFullPlayer,
            content: {
                if let view = playerView {
                    view.presentationDragIndicator(.visible)
                }
            }
        )
        .opacity(store.currentSong == nil ? 0 : 1)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
