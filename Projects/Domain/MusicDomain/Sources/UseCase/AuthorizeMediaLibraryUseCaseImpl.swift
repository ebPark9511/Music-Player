//
//  AuthorizeMediaLibraryUseCaseImpl.swift
//  MusicDomainInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import MusicDomainInterface

final class AuthorizeMediaLibraryUseCaseImpl: AuthorizeMediaLibraryUseCase {
    
    private let authorizeMediaLibraryService: AuthorizeMediaLibraryService
    
    init(authorizeMediaLibraryService: AuthorizeMediaLibraryService) {
        self.authorizeMediaLibraryService = authorizeMediaLibraryService
    }
    
    func execute() async throws {
        guard authorizeMediaLibraryService.getAuthorizationStatus() == .notDetermined else {
            throw MusicDomainError.unauthorized
        }
        
        switch await authorizeMediaLibraryService.requestAuthorization() {
        case .authorized:
            break
        default:
            throw MusicDomainError.unauthorized
        }
        
    }
}
