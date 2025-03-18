//
//  AlbumsCoordinating.swift
//  AlbumsFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import MusicDomainInterface

public protocol AlbumsCoordinating {
    func coordinateToAlbumDetail(with album: Album) -> any View
}
