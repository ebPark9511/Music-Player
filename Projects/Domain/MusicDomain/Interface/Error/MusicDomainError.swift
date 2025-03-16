//
//  MusicDomainError.swift
//  MusicDomain
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation

public enum MusicDomainError: Error {
    case unauthorized
    case fetchFailed
    case invalidData
}
