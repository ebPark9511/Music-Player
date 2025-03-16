//
//  MediaLibraryDataSourceImpl.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import MediaPlayer

final class MediaLibraryDataSourceImpl: MediaLibraryDataSource {
    func fetchAlbums() async -> [any AlbumEntity] {
        MPMediaQuery.albums().collections ?? []
    }    
}




