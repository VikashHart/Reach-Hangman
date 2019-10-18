import Foundation

private struct QueryParameters {
    static let minLength = "minLength"
    static let count = "count"
    static let difficulty = "difficulty"
    static let start = "start"
}

struct EndpointBuilder {
    static private let apiBase = "http://app.linkedin-reach.io/words"

    static func endpoint(for difficultyLevel: DifficultyLevel) -> URL {
        var components = URLComponents(string: apiBase)!
        let queryItems = [
            URLQueryItem(name: QueryParameters.minLength, value: "4"),
            URLQueryItem(name: QueryParameters.count, value: "20"),
            URLQueryItem(name: QueryParameters.difficulty, value: "\(difficultyLevel.rawValue)"),
            URLQueryItem(name: QueryParameters.start, value: "\(randomStart(for: difficultyLevel))")
        ]

        components.queryItems = queryItems

        return components.url!
    }

    private static func randomStart(for type: DifficultyLevel) -> Int {
        let start: Int
        switch type {
        case .one:
            start = Int.random(in: 1...15244)
        case .two:
            start = Int.random(in: 1...16165)
        case .three:
            start = Int.random(in: 1...16181)
        case .four:
            start = Int.random(in: 1...16193)
        case .five:
            start = Int.random(in: 1...16221)
        case .six:
            start = Int.random(in: 1...16220)
        case .seven:
            start = Int.random(in: 1...16221)
        case .eight:
            start = Int.random(in: 1...16220)
        case .nine:
            start = Int.random(in: 1...16220)
        case .ten:
            start = Int.random(in: 1...16224)
        }
        return start
    }
}
