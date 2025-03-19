//
//  PlayerView.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let albumArt: String
}

struct MiniPlayerView: View {
    @State private var isPlaying: Bool = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 180
    @State private var showFullPlayer: Bool = false
    
    let song = Song(
        title: "Build the Levees",
        artist: "Daniel Duke",
        albumArt: "album_cover"
    )
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                Rectangle()
                    .fill(.blue)
                    .frame(width: geometry.size.width * (currentTime / duration),
                           height: 4)
            }
            .frame(height: 4)
            
            HStack(spacing: 16) {
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 32))
                }
                .padding(.leading, 16)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(song.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(song.albumArt)
                        .resizable()
                        .background(.gray)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .cornerRadius(4)
                        .padding(.trailing, 16)
                }
                .onTapGesture {
                    showFullPlayer = true
                }
            }
            .frame(height: 72)
        }
        .background(Color(UIColor.systemBackground))
        .sheet(isPresented: $showFullPlayer) {
            PlayerView()
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.2).ignoresSafeArea()
        VStack {
            Spacer()
            MiniPlayerView()
        }
    }
}
