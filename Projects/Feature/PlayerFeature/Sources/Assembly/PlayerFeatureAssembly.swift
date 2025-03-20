//
//  PlayerFeatureAssembly.swift
//  RootFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import PlayerFeatureInterface
import Swinject
import PlayerDomainInterface

public final class PlayerFeatureAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
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
                }))
            }
        }
        
    }
}



