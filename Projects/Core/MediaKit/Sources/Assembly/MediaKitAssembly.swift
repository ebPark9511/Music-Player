//
//  MediaKitAssembly.swift
//  MediaKit
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import MediaPlayer
import MediaKitInterface
import Swinject

public final class MediaKitAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MPMusicPlayerController.self) { _ in .applicationMusicPlayer }
        .inObjectScope(.container)
        container.register(AuthorizeMediaLibraryService.self) { (resolver: Resolver) in
            AuthorizeMediaLibraryServiceImpl()
        }
        container.register(MediaLibraryDataSource.self) { (resolver: Resolver) in
            MediaLibraryDataSourceImpl()
        }
        container.register(MediaService.self) { (resolver: Resolver) in
            MediaServiceImpl(player: resolver.resolve(MPMusicPlayerController.self)!)
        }
    }
}
