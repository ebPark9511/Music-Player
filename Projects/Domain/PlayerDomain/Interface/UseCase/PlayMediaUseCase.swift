public protocol PlayMediaUseCase {
    func execute<T: Playable>(media: T) async throws
} 