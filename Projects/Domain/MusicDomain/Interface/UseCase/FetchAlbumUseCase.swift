//
//  FetchAlbumUseCase.swift
//  MusicDomainInterface
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public protocol FetchAlbumUseCase {
    func execute() -> Album
}
