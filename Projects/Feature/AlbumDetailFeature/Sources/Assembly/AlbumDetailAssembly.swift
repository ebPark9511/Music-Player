//
//  AlbumDetailAssembly.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import AlbumDetailFeatureInterface
import MusicDomainInterface
import PlayerDomainInterface
import Swinject

public final class AlbumDetailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AlbumDetailBuilder.self) { (resolver, album: Album) in
            AlbumDetailBuilder {
                AlbumDetailView(store: .init(initialState: .init(album: album), reducer: {
                    AlbumDetail(
                        playMusicUseCase: resolver.resolve(PlayMediaUseCase.self)!,
                        pausePlaybackUseCase: resolver.resolve(PausePlaybackUseCase.self)!,
                        playShuffleMediaUseCase: resolver.resolve(PlayShuffleMediaUseCase.self)!
                    )
                }))
            }
        }
        
    }
}

