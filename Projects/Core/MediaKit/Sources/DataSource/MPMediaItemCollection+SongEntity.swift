//
//  MPMediaItemCollection+AlbumEntity.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import MediaPlayer

extension MPMediaItem: @retroactive SongEntity {
    
    public var id: String {
        playbackStoreID
    }
    
    public var duration: TimeInterval {
        playbackDuration
    }
    
    public var trackNumber: Int {
        albumTrackNumber
    }
    
    
}

