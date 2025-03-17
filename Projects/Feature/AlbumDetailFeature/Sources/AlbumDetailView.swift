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
                        trackNumber: String(index + 1),
                        title: song.title ?? "Unknown",
                        duration: song.duration
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
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playButtonTapped:
                return .none
                
            case .shuffleButtonTapped:
                return .none
                
            case .songItem:
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
                // Album Header
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
                        
                        Text(store.album.artist ?? "Unknown Artist")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Playback Controls
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
                
                // Song List
                VStack(spacing: 0) {
                    ForEach(store.songs) { song in
                        SongItemView(
                            store: store.scope(
                                state: { $0.songs[id: song.id]! },
                                action: { .songItem(id: song.id, action: $0) }
                            )
                        )
                        Divider()
                            .background(Color(uiColor: .systemGray5))
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

@Reducer
struct SongItem {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: String
        let trackNumber: String
        let title: String
        let duration: TimeInterval?
    }
    
    enum Action {
        case tapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tapped:
                return .none
            }
        }
    }
}

struct SongItemView: View {
    let store: StoreOf<SongItem>
    
    var body: some View {
        Button(action: { store.send(.tapped) }) {
            HStack(spacing: 12) {
                Text(store.trackNumber)
                    .frame(width: 25)
                    .foregroundColor(.secondary)
                    .font(.system(size: 17))
                
                Text(store.title)
                    .lineLimit(1)
                    .font(.system(size: 17))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        AlbumDetailView(
            store: Store(
                initialState: AlbumDetail.State(
                    album: Album(
                        id: "1",
                        title: "Brother",
                        artist: "Daniel Duke",
                        artworkImage: nil,
                        songs: [
                            Song(id: "1", title: "Build the Levees", duration: 180, trackNumber: 1),
                            Song(id: "2", title: "Borderline", duration: 210, trackNumber: 2),
                            Song(id: "3", title: "A Couple Things", duration: 195, trackNumber: 3),
                            Song(id: "10", title: "Aster", duration: 225, trackNumber: 10),
                            Song(id: "5", title: "Brother", duration: 200, trackNumber: 5)
                        ]
                    )
                )
            ) {
                AlbumDetail()
            }
        )
    }
}
