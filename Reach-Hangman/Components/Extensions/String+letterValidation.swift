import Foundation

extension String {
    private static let validLetterCharacters = CharacterSet.letters
    
    func isOnlyLetters() -> Bool {
        if self.lowercased()
            .rangeOfCharacter(from: String.validLetterCharacters.inverted) == nil {
            return true
        } else {
            return false
        }
    }
}
