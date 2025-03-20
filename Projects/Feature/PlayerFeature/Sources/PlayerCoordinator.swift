//
//  PlayerCoordinator.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/21/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import MusicDomainInterface
import PlayerFeatureInterface
import Swinject

struct PlayerCoordinator: PlayerCoordinating {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func player(with song: Song) -> any View {
        resolver.resolve(PlayerBuilder.self, argument: song)!
    }
}
