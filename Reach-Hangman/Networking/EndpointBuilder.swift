import Foundation

enum DifficultyEndpoint {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
}

struct EndpointBuilder {
    static private let apiBase = "http://app.linkedin-reach.io/words"
    static private let  minLength = "&minLength=4"
    static private let count = "&count=20"

    static func endpoint(_ type: DifficultyEndpoint) -> URL {
        let path: String
        let start: String
        switch type {
        case .one: path = "?difficulty=1"
            start = String(Int.random(in: 1...15244))
        case .two: path = "?difficulty=2"
            start = String(Int.random(in: 1...16165))
        case .three: path = "?difficulty=3"
            start = String(Int.random(in: 1...16181))
        case .four: path = "?difficulty=4"
            start = String(Int.random(in: 1...16193))
        case .five: path = "?difficulty=5"
            start = String(Int.random(in: 1...16221))
        case .six: path = "?difficulty=6"
            start = String(Int.random(in: 1...16220))
        case .seven: path = "?difficulty=7"
            start = String(Int.random(in: 1...16221))
        case .eight: path = "?difficulty=8"
            start = String(Int.random(in: 1...16220))
        case .nine: path = "?difficulty=9"
            start = String(Int.random(in: 1...16220))
        case .ten: path = "?difficulty=10"
            start = String(Int.random(in: 1...16224))
        }
        return URL(string: apiBase + path + minLength + start + count)!
    }
}
