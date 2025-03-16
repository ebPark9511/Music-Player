public protocol MusicRepository {
    func fetchAlbums() async throws -> [Album]
    func fetchAlbum(id: String) async throws -> Album?
    func fetchSongs(in album: Album) async throws -> [Song]
} 