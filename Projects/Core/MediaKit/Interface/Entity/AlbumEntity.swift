//
//  AlbumEntity.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit

public protocol AlbumEntity: SongsContainerEntity {
    var id: String { get }
    var title: String? { get }
    var artist: String? { get }
    var artworkImage: UIImage? { get }
}
