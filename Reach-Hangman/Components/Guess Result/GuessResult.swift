import Foundation

enum GuessResult {
    case hit(String)
    case miss(String)
    case exact(String)
    case alreadyUsed

}
