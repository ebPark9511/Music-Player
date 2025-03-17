//
//  FetchAlbumUseCaseImpl.swift
//  MusicDomainInterface
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MusicDomainInterface

final class FetchAlbumUseCaseImpl: FetchAlbumUseCase {
    
    private let album: Album

    init(album: Album) {
        self.album = album
    }

    func execute() -> Album {
        album
    }
}
