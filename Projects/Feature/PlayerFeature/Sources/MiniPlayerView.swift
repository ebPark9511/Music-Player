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
import MediaKitInterface
import Combine

@Reducer
struct MiniPlayer {
    @ObservableState
    struct State: Equatable {
        var isPlaying: Bool = false
        var currentSong: Song?
        
        init() { }
    }
    
    enum Action {
        case playButtonTapped
        case pauseButtonTapped
        case currentSongUpdated(SongEntity)
        case onAppear
    }
    
    private let resumePlaybackUseCase: ResumePlaybackUseCase
    private let pausePlaybackUseCase: PausePlaybackUseCase
    private let observeCurrentSongUseCase: ObserveCurrentSongUseCase
    
    
    init(
        resumePlaybackUseCase: ResumePlaybackUseCase,
        pausePlaybackUseCase: PausePlaybackUseCase,
        observeCurrentSongUseCase: ObserveCurrentSongUseCase
    ) {
        self.resumePlaybackUseCase = resumePlaybackUseCase
        self.pausePlaybackUseCase = pausePlaybackUseCase
        self.observeCurrentSongUseCase = observeCurrentSongUseCase
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for await song in observeCurrentSongUseCase.execute().values {
                        if let song {
                            await send(.currentSongUpdated(song))
                        }
                    }
                }
                
            case .playButtonTapped:
                resumePlaybackUseCase.execute()
                state.isPlaying = true
                return .none
                
            case .pauseButtonTapped:
                pausePlaybackUseCase.execute()
                state.isPlaying = false
                return .none
                
            case let .currentSongUpdated(song):
                state.isPlaying = true
                state.currentSong = Song(id: song.id, title: song.title, duration: song.duration, trackNumber: song.trackNumber)
                return .none
            }
        }
    }
}

struct MiniPlayerView: View {
    
    let store: StoreOf<MiniPlayer>
    
    @State private var currentTime: Double = 0
    @State private var duration: Double = 180
    @State private var showFullPlayer: Bool = false
    
    init(store: StoreOf<MiniPlayer>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let song = store.currentSong {
                
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.blue)
                        .frame(width: geometry.size.width * 0.8,//(currentTime / duration),
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
                            
                            Text(song.title ?? "Unknown artist")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "music.note")
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
        .onTapGesture {
            showFullPlayer = true
        }
        .sheet(isPresented: $showFullPlayer) {
            PlayerView()
                .presentationDragIndicator(.visible)
        }
        .opacity(store.currentSong == nil ? 0 : 1)
        .animation(.easeInOut(duration: 0.3), value: store.currentSong)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

