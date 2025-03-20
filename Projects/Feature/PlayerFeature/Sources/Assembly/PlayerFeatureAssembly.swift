//
//  PlayerFeatureAssembly.swift
//  RootFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerFeatureInterface
import PlayerDomainInterface
import MusicDomainInterface
import Swinject

public final class PlayerFeatureAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(PlayerCoordinating.self) { resolver in
            PlayerCoordinator(resolver: resolver)
        }
        
        container.register(PlayerFeatureBuilder.self) { resolver in
            PlayerFeatureBuilder {
                MiniPlayerView(store: .init(initialState: .init(), reducer: {
                    MiniPlayer(
                        resumePlaybackUseCase: resolver.resolve(ResumePlaybackUseCase.self)!,
                        pausePlaybackUseCase: resolver.resolve(PausePlaybackUseCase.self)!,
                        observeCurrentSongUseCase: resolver.resolve(ObserveCurrentSongUseCase.self)!,
                        observePlaybackStateUseCase: resolver.resolve(ObservePlaybackStateUseCase.self)!,
                        observePlaybackTimeUseCase: resolver.resolve(ObservePlaybackTimeUseCase.self)!
                    )
                }),coordinator: resolver.resolve(PlayerCoordinating.self)!
                )
            }
        }
        
        container.register(PlayerBuilder.self) { (resolver: Resolver, song: Song) in
            PlayerBuilder {
                PlayerView(store: .init(initialState: .init(), reducer: {
                    Player(
                        resumePlaybackUseCase: resolver.resolve(ResumePlaybackUseCase.self)!,
                        pausePlaybackUseCase: resolver.resolve(PausePlaybackUseCase.self)!,
                        observeCurrentSongUseCase: resolver.resolve(ObserveCurrentSongUseCase.self)!,
                        observePlaybackStateUseCase: resolver.resolve(ObservePlaybackStateUseCase.self)!,
                        observePlaybackTimeUseCase: resolver.resolve(ObservePlaybackTimeUseCase.self)!
                    )
                }))
            }
        }
        
    }
}



