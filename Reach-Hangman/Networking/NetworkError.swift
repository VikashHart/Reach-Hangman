import Foundation

enum NetworkError: Error {
    case decodingError
    case networkError
    case clientError
    case serverError
    case unknownError
}
