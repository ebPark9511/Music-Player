//
//  AlbumsFactoryImpl.swift
//  AlbumsFeatureInterface
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import AlbumsFeatureInterface
import MusicDomainInterface
import SwiftUI

public struct AlbumsRootView: View {
    
    private let authorizeMediaLibraryUseCase: AuthorizeMediaLibraryUseCase
    private let fetchAlbumsUseCase: FetchAlbumsUseCase
    
    init(authorizeMediaLibraryUseCase: AuthorizeMediaLibraryUseCase, fetchAlbumsUseCase: FetchAlbumsUseCase) {
        self.authorizeMediaLibraryUseCase = authorizeMediaLibraryUseCase
        self.fetchAlbumsUseCase = fetchAlbumsUseCase
    }
    
    public var body: some View {
        AlbumsView(store: .init(initialState: .init(), reducer: {
            Albums(
                authorizeMediaLibraryUseCase: authorizeMediaLibraryUseCase,
                fetchAlbumsUseCase: fetchAlbumsUseCase
            )
        }))
    }
    
}
