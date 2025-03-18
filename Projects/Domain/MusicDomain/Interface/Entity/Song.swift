//
//  Song.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public struct Song: Equatable, Identifiable, Hashable {
    public var id: String
    public var title: String?
    public var duration: TimeInterval
    public var trackNumber: Int
    
    public init(id: String, title: String? = nil, duration: TimeInterval, trackNumber: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.trackNumber = trackNumber
    }
   
}
