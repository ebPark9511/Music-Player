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
import AlbumsFeatureInterface

@Reducer
struct Albums {
    
    @ObservableState
    struct State: Equatable {
        var albums: [Album] = []
        var albumItems: IdentifiedArrayOf<AlbumItem.State> = []
    }
    
    enum Action: Sendable {
        case onAppear
        case fetchAlbums
        case fetchComplete([Album])
        case fetchFailed(Error)
    }
    
    private let authorizeMediaLibraryUseCase: AuthorizeMediaLibraryUseCase
    private let fetchAlbumsUseCase: FetchAlbumsUseCase
    
    init(
        authorizeMediaLibraryUseCase: AuthorizeMediaLibraryUseCase,
        fetchAlbumsUseCase: FetchAlbumsUseCase
    ) {
        self.authorizeMediaLibraryUseCase = authorizeMediaLibraryUseCase
        self.fetchAlbumsUseCase = fetchAlbumsUseCase
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        try await authorizeMediaLibraryUseCase.execute()
                        await send(.fetchAlbums)
                    } catch {
                        await send(.fetchFailed(error))
                    }
                }
                
            case .fetchAlbums:
                return .run { send in
                    do {
                        let albums = try await fetchAlbumsUseCase.execute()
                        await send(.fetchComplete(albums))
                    } catch {
                        await send(.fetchFailed(error))
                    }
                }
                
            case let .fetchComplete(albums):
                state.albums = albums
                state.albumItems = IdentifiedArrayOf(uniqueElements: albums.map { album in
                    AlbumItem.State(
                        id: album.id,
                        image: album.artworkImage.map { Image(uiImage: $0) } ?? Image(systemName: "music.note"),
                        title: album.title ?? "-",
                        artist: album.artist ?? "-"
                    )
                })
                return .none
                
            case .fetchFailed(let error):
                print("Failed to fetch albums:", error)
                return .none
            }
        }
    }
    
    
}

struct AlbumsView: View {
    
    private let store: StoreOf<Albums>
    
    @State private var path: NavigationPath
    private let coordinator: AlbumsCoordinating
    
    private let spacing: CGFloat = 16
    private let columns = 2
    
    init(
        store: StoreOf<Albums>,
        path: NavigationPath = .init(),
        coordinator: AlbumsCoordinating
    ) {
        self.store = store
        self.path = path
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                let gridItems = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns)
                
                LazyVGrid(
                    columns: gridItems,
                    spacing: spacing
                ) {
                    ForEach(store.albumItems) { albumItem in
                        AlbumItemView(
                            store: Store(initialState: albumItem) {
                                AlbumItem()
                            }
                        )
                        .onTapGesture {
                            if let album = store.state.albums.first(where: { $0.id == albumItem.id }) {
                                self.path.append(AlbumsDestination.albumDetail(album))
                            }
                        }
                    }
                }
                .navigationDestination(for: AlbumsDestination.self) { destination in
                    switch destination {
                    case .albumDetail(let album):
                        AnyView(coordinator.coordinateToAlbumDetail(with: album))
                    }
                }
                .padding(spacing)
            }
            .navigationTitle("라이브러리")
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - Preview
private struct PreviewAuthorizeMediaLibraryUseCase: AuthorizeMediaLibraryUseCase {
    func execute() async throws {}
}

private struct PreviewFetchAlbumsUseCase: FetchAlbumsUseCase {
    func execute() async throws -> [Album] {
        return [
            Album(id: "1", title: "Random Access Memories", artist: "Daft Punk", artworkImage: nil, songs: []),
            Album(id: "2", title: "Abbey Road", artist: "The Beatles", artworkImage: nil, songs: [])
        ]
    }
}

private struct PreviewAlbumsCoordinator: AlbumsCoordinating {
    func coordinateToAlbumDetail(with album: Album) -> any View {
        Text("buildAlbumDetail")
    }
}


#Preview {
    AlbumsView(
        store: Store(
            initialState: Albums.State()
        ) {
            Albums(
                authorizeMediaLibraryUseCase: PreviewAuthorizeMediaLibraryUseCase(),
                fetchAlbumsUseCase: PreviewFetchAlbumsUseCase()
            )
        },
        coordinator: PreviewAlbumsCoordinator()
    )
}
