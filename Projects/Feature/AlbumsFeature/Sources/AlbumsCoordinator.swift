//
//  AlbumsCoordinator.swift
//  AlbumsFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import MusicDomainInterface
import AlbumsFeatureInterface
import AlbumDetailFeatureInterface
import Swinject

struct AlbumsCoordinator: AlbumsCoordinating {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func coordinateToAlbumDetail(with album: Album) -> any View {
        resolver.resolve(AlbumDetailBuilder.self, argument: album)!
    }
}
