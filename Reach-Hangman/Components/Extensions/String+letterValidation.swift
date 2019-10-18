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

    func replaceCharacters(with replacement: String, allowedCharacters: Set<Character>) -> String {
        var redactedString = ""

        for char in self {
            if allowedCharacters.contains(char) {
                redactedString += String(char)
            } else {
                redactedString += replacement
            }
        }
        return redactedString
    }
}
