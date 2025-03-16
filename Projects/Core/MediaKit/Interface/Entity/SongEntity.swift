//
//  SongEntity.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public protocol SongEntity {
    var id: String { get }
    var title: String? { get }
    var duration: TimeInterval { get }
    var trackNumber: Int { get }
}

