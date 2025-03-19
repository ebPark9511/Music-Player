//
//  RootFeatureAssembly.swift
//  RootFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import AlbumsFeatureInterface
import RootFeatureInterface
import PlayerFeatureInterface
import Swinject

public final class RootFeatureAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        container.register(RootFeatureBuilder.self) { resolver in
            
            RootFeatureBuilder {
                RootFeatureView {
                    resolver.resolve(AlbumsBuilder.self)
                } playerViewBuilder: {
                    resolver.resolve(PlayerFeatureBuilder.self)
                }

            }
            
            
        }
        
    }
}

