//
//  AlbumsFeatureAssembly.swift
//  AlbumsFeature
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import AlbumsFeatureInterface
import MusicDomainInterface
import Swinject

public final class AlbumsFeatureAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AlbumsRootView.self) { resolver in
            AlbumsRootView(
                authorizeMediaLibraryUseCase: resolver.resolve(AuthorizeMediaLibraryUseCase.self)!,
                fetchAlbumsUseCase: resolver.resolve(FetchAlbumsUseCase.self)!
            )
            
        }
        
    }
}

