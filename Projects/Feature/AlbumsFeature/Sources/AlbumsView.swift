//
//  AlbumsView.swift
//  AlbumsFeature
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MusicDomainInterface

@Reducer
struct Albums {
    
    @ObservableState
    struct State: Equatable {
        var albums: IdentifiedArrayOf<AlbumItem.State> = []
    }
    
    enum Action: Sendable {
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}

struct AlbumsView: View {
    
    let store: StoreOf<Albums>
    
    private let spacing: CGFloat = 16
    private let columns = 2
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollView {
                    let gridItems = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
                    
                    LazyVGrid(
                        columns: gridItems,
                        spacing: spacing
                    ) {
                        ForEach(viewStore.albums) { album in
                            GeometryReader { geometry in
                                AlbumItemView(
                                    store: Store(initialState: album) {
                                        AlbumItem()
                                    }
                                )
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    .padding(spacing)
                }
                .navigationTitle("라이브러리")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    AlbumsView(
        store: Store(
            initialState: Albums.State(
                albums: IdentifiedArrayOf(
                    uniqueElements: [
                        AlbumItem.State(
                            id: "1",
                            image: Image(systemName: "music.note"),
                            title: "Random Access Memories",
                            artist: "Daft Punk"
                        ),
                        AlbumItem.State(
                            id: "2",
                            image: Image(systemName: "music.note.list"),
                            title: "Abbey Road",
                            artist: "The Beatles"
                        ),
                        AlbumItem.State(
                            id: "3",
                            image: Image(systemName: "music.quarternote.3"),
                            title: "The Dark Side of the Moon",
                            artist: "Pink Floyd"
                        ),
                        AlbumItem.State(
                            id: "4",
                            image: Image(systemName: "music.note.tv"),
                            title: "Thriller",
                            artist: "Michael Jackson"
                        )
                    ]
                )
            )
        ) {
            Albums()
        }
    )
}
