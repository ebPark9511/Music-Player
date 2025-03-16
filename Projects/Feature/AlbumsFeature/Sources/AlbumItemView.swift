//
//  AlbumView.swift
//  AlbumListFeature
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import SwiftUI

@Reducer
struct AlbumItem {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: String
        let image: Image
        let title: String
        let artist: String
    }
    
}

struct AlbumItemView: View {
    
    let store: StoreOf<AlbumItem>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 8) {
                viewStore.image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewStore.title)
                        .font(.headline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        
                    Text(viewStore.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.primary.opacity(0.5), radius: 4, x: 0, y: 0)
        }
    }
    
}

#Preview {
    AlbumItemView(
        store: Store(
            initialState: AlbumItem.State(
                id: "0",
                image: .init(systemName: "music.note"),
                title: "Random Access Memories",
                artist: "Daft Punk"
            )
        ) {
            AlbumItem()
        }
    )
    .frame(width: 200, height: 200)
    .preferredColorScheme(.dark)
}
