//
//  AudioServiceImpl.swift
//  MediaKitInterface
//
//  Created by 박은비 on 3/22/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaKitInterface
import Combine
import AVFoundation
import MediaPlayer

final class AudioServiceImpl: AudioService {
    
    private let audioSession: AVAudioSession
    
    init(
        audioSession: AVAudioSession
    ) {
        self.audioSession = audioSession
        
        do {
            try audioSession.setCategory(.playback, options: .mixWithOthers)
            try audioSession.setActive(true)
        } catch {
            print("Failed to setup audio session:", error)
        }
    }
    
      
    func setVolume(_ volume: Float) {
        MPVolumeView.setVolume(volume)
    }
    
    func observeVolume() -> AnyPublisher<Float, Never> {
        return Just(audioSession.outputVolume)
            .merge(with:
                    NotificationCenter.default.publisher(for: Notification.Name("SystemVolumeDidChange"))
                .compactMap { notification in
                    notification.userInfo?["Volume"] as? Float
                }
            )
            .eraseToAnyPublisher()
    }
    
}

private extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            slider?.value = volume
        }
    }
}
