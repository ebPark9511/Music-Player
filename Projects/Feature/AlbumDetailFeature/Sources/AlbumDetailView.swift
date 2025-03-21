//
//  AlbumDetailView.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MusicDomainInterface
import PlayerDomainInterface

@Reducer
struct AlbumDetail {
    @ObservableState
    struct State: Equatable {
        var album: Album
        var songs: IdentifiedArrayOf<SongItem.State>
        
        init(album: Album) {
            self.album = album
            self.songs = IdentifiedArrayOf(
                uniqueElements: album.songs.enumerated().map { index, song in
                    SongItem.State(
                        id: song.id,
                        trackNumber: String(index+1),
                        title: song.title ?? "-",
                        song: song
                    )
                }
            )
        }
    }
    
    enum Action {
        case playButtonTapped
        case shuffleButtonTapped
        case songItem(id: SongItem.State.ID, action: SongItem.Action)
    }
    
    private let playMusicUseCase: PlayMediaUseCase
    private let pausePlaybackUseCase: PausePlaybackUseCase
    private let playShuffleMediaUseCase: PlayShuffleMediaUseCase
    
    init(
        playMusicUseCase: PlayMediaUseCase,
        pausePlaybackUseCase: PausePlaybackUseCase,
        playShuffleMediaUseCase: PlayShuffleMediaUseCase
    ) {
        self.playMusicUseCase = playMusicUseCase
        self.pausePlaybackUseCase = pausePlaybackUseCase
        self.playShuffleMediaUseCase = playShuffleMediaUseCase
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playButtonTapped:
                self.playMusicUseCase.execute(items: state.album.songs.map { $0 })
                return .none
                
            case .shuffleButtonTapped:
                self.playShuffleMediaUseCase.execute(items: state.album.songs.map { $0 })
                return .none
                
            case let .songItem(id, action: .tapped):
                guard let selectedIndex = state.songs.firstIndex(where: { $0.id == id }) else { return .none }
                let songsFromSelected = Array(state.album.songs[selectedIndex...])
                self.playMusicUseCase.execute(items: songsFromSelected)
                return .none
            }
        }
    }
}

struct AlbumDetailView: View {
    
    let store: StoreOf<AlbumDetail>
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
            
                HStack(spacing: 16) {
                    (
                        self.store.album.artworkImage == nil ?
                        Image(systemName: "music.note") :
                            Image(uiImage: store.album.artworkImage!)
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(store.album.title ?? "Unknown Album")
                            .font(.title)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(3)
                        
                        Text(store.album.artist ?? "Unknown Artist")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Button(action: { store.send(.playButtonTapped) }) {
                        Image(systemName: "play.fill")
                            .imageScale(.large)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Button(action: { store.send(.shuffleButtonTapped) }) {
                        Image(systemName: "shuffle")
                            .imageScale(.large)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 0) {
                    ForEach(store.songs) { song in
                        SongItemView(
                            store: store.scope(
                                state: { $0.songs[id: song.id]! },
                                action: { .songItem(id: song.id, action: $0) }
                            )
                        )
                        Divider().background(Color(uiColor: .systemGray5))
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
