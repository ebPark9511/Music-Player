//
//  MusicDomainAssembly.swift
//  MusicDomain
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface
import MediaKitInterface
import Swinject

public final class MusicDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        container.register(MusicRepository.self) { (resolver: Resolver) in
            MusicRepositoryImpl(
                authorizeMediaLibraryService: resolver.resolve(AuthorizeMediaLibraryService.self)!,
                mediaLibraryDataSource: resolver.resolve(MediaLibraryDataSource.self)!
            )
        }
        
        container.register(AuthorizeMediaLibraryUseCase.self) { (resolver: Resolver) in
            AuthorizeMediaLibraryUseCaseImpl(authorizeMediaLibraryService: resolver.resolve(AuthorizeMediaLibraryService.self)!)
        }
        
        container.register(FetchAlbumsUseCase.self) { (resolver: Resolver) in
            FetchAlbumsUseCaseImpl(musicRepository: resolver.resolve(MusicRepository.self)!)
        }
        
        
    }
}
