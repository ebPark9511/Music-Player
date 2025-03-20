//
//  PlayerCoordinating.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/21/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import MusicDomainInterface

public protocol PlayerCoordinating {
    func player(with song: Song) -> any View
}
