//
//  FetchAlbumsUseCase.swift
//  MusicDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

/// 앨범 목록을 가져온다.
public protocol FetchAlbumsUseCase {
    func execute() async throws -> [Album]
}
