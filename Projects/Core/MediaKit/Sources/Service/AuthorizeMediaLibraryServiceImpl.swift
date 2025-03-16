//
//  AuthorizeMediaLibraryServiceImpl.swift
//  MediaKit
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MediaKitInterface

public final class AuthorizeMediaLibraryServiceImpl: AuthorizeMediaLibraryService {
    
    public init() { }
    
    public func getAuthorizationStatus() -> MediaKitAuthorizationStatus {
        let status: MPMediaLibraryAuthorizationStatus = MPMediaLibrary.authorizationStatus()
        return status.toMediaKitStatus
    }
    
    public func requestAuthorization() async -> MediaKitAuthorizationStatus {
        return await withCheckedContinuation { continuation in
            MPMediaLibrary.requestAuthorization { status in
                continuation.resume(returning: status.toMediaKitStatus)
            }
        }
    }
}

private extension MPMediaLibraryAuthorizationStatus {
    var toMediaKitStatus: MediaKitAuthorizationStatus {
        switch self {
        case .notDetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .authorized:
            return .authorized
        @unknown default:
            return .denied
        }
    }
}
