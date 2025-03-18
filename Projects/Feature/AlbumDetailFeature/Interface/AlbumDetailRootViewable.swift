import SwiftUI
import MusicDomainInterface

public protocol AlbumDetailBuilder {
    func build(album: Album) -> any View
}

public struct AlbumDetailBuilderImpl: AlbumDetailBuilder {
    public init() {}
    
    public func build(album: Album) -> any View {
        AlbumDetailCoordinatorView(initialScreen: .detail(album))
    }
} 