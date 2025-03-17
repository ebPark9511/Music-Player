//
//  AlbumDetailAssembly.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import AlbumDetailFeatureInterface
import Swinject

public final class AlbumDetailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AlbumDetailRootView.self) { resolver in
            AlbumDetailRootView()
        }
        
    }
}

