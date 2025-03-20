//
//  SongItemView.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/20/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MusicDomainInterface

@Reducer
struct SongItem {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: String
        let trackNumber: String
        let title: String
        let song: Song
    }
    
    enum Action {
        case tapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tapped:
                return .none
            }
        }
    }
}

struct SongItemView: View {
    let store: StoreOf<SongItem>
    
    var body: some View {
        Button(action: { store.send(.tapped) }) {
            HStack(spacing: 12) {
                Text(store.trackNumber)
                    .frame(width: 25)
                    .foregroundColor(.secondary)
                    .font(.system(size: 17))
                
                Text(store.title)
                    .lineLimit(1)
                    .font(.system(size: 17))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }
}
