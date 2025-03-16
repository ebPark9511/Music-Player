//
//  ArtworkImageConverter.swift
//  MediaKit
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MusicDomainInterface
import UIKit

struct ArtworkImageConverter: ImageConvertible {
    private let artwork: MPMediaItemArtwork
    
    init(artwork: MPMediaItemArtwork) {
        self.artwork = artwork
    }
    
    func image(at size: CGSize) -> UIImage? {
        artwork.image(at: size)
    }
} 