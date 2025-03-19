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

import SwiftUI

public final class PlayerFeatureAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        container.register(PlayerFeatureBuilder.self) { resolver in
            PlayerFeatureBuilder {
                MiniPlayerView()
            }
        }
        
    }
}

