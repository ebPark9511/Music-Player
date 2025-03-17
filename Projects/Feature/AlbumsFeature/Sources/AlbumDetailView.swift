//
//  AlbumDetailView.swift
//  AlbumsFeature
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MusicDomainInterface

struct AlbumDetailView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .padding()
        }
    }
}
