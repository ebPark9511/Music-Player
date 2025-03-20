//
//  PlayerDomainAssembly.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//


import Foundation
import PlayerDomainInterface
import Swinject
import MediaKitInterface

public final class PlayerDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        container.register(PlayerRepository.self) { (resolver: Resolver) in
            PlayerRepositoryImpl(mediaService: resolver.resolve(MediaService.self)!)
        }
        .inObjectScope(.container)
        
        // UseCase
        container.register(PlayMediaUseCase.self) { (resolver: Resolver) in
            PlayMediaUseCaseImpl(mediaService: resolver.resolve(MediaService.self)!)
        }
        container.register(PlayShuffleMediaUseCase.self) { (resolver: Resolver) in
            PlayShuffleMediaUseCaseImpl(playerRepository: resolver.resolve(PlayerRepository.self)!)
        }
        container.register(ObserveCurrentSongUseCase.self) { (resolver: Resolver) in
            ObserveCurrentSongUseCaseImpl(playerRepository: resolver.resolve(PlayerRepository.self)!)
        }
        container.register(PausePlaybackUseCase.self) { (resolver: Resolver) in
            PausePlaybackUseCaseImpl(playerRepository: resolver.resolve(PlayerRepository.self)!)
        }
        container.register(ResumePlaybackUseCase.self) { (resolver: Resolver) in
            ResumePlaybackUseCaseImpl(playerRepository: resolver.resolve(PlayerRepository.self)!)
        }
        container.register(ObservePlaybackStateUseCase.self) { (resolver: Resolver) in
            ObservePlaybackStateUseCaseImpl(mediaService: resolver.resolve(MediaService.self)!)
        }
        container.register(ObservePlaybackTimeUseCase.self) { (resolver: Resolver) in
            ObservePlaybackTimeUseCaseImpl(playerRepository: resolver.resolve(PlayerRepository.self)!)
        }
        
        
        
    }
}
