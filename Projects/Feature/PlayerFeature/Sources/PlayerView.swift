//
//  PlayerView.swift
//  PlayerFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPlaying: Bool = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 180
    @State private var volume: Double = 0.5
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                }
                .frame(width: 44)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("title")
                        .fontWeight(.bold)
                    
                    Text("artist")
                        .foregroundColor(.gray)
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(width: 44)
                
            }
            .padding([.top, .horizontal])
            
            Spacer()
            
            Image.init(systemName: "photo")
                .resizable()
                .background(.gray)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .cornerRadius(8)
                .shadow(radius: 10)
            
            Spacer()
            
            HStack(spacing: 30) {
                Button(action: {
                    print("한곡반복")
                }) {
                    Image(systemName: "repeat.1")
                        .foregroundColor(.blue.opacity(0.3))
                }
                
                Button(action: {
                    print("이전")
                }) {
                    Image(systemName: "backward.fill")
                }
                
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                }
                
                Button(action: {
                    print("다음")
                }) {
                    Image(systemName: "forward.fill")
                }
                
                Button(action: {
                    print("랜덤재생")
                }) {
                    Image(systemName: "shuffle")
                        .foregroundColor(.blue.opacity(0.3))
                }
            }
            .font(.title2)
            .padding(.bottom, 16)
            
            HStack(spacing: 12) {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.gray)
                
                Slider(value: $volume, in: 0...1)
                    .accentColor(.gray)
                
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 12))
            .padding(.horizontal)
            .padding(.bottom, 32)
            
            VStack(spacing: 0) {
                HStack {
                    Text(timeString(from: currentTime))
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("-" + timeString(from: duration - currentTime))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 4)
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: geometry.size.width * (currentTime / duration), height: 4)
                    }
                }
                .frame(height: 4)
                .padding(.top, 8)
            }
        }
    }
    
    private func timeString(from timeInterval: Double) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
