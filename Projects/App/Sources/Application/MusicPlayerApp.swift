//
//  MusicPlayerApp.swift
//  Music-Player
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI
import AlbumsFeatureInterface

@main
struct MusicPlayerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppDelegate.container.resolve(AlbumsBuilder.self)!
        }
    }
}


