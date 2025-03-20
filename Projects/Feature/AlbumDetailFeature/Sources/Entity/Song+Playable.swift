//
//  Song+Playable.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit
import PlayerDomainInterface
import MusicDomainInterface

extension Song: @retroactive Playable { }
