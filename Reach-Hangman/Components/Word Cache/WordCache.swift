import Foundation

protocol WordsCaching {
    func popWord(for level: DifficultyLevel) -> String?
    func add(words: [String], for level: DifficultyLevel)
}

class LevelWordsCache: WordsCaching {
    static let shared = LevelWordsCache()
    private var wordsCache: [DifficultyLevel: [String]] = [:]

    func popWord(for level: DifficultyLevel) -> String? {
        guard var words = wordsCache[level],
            let word = words.popLast()
            else { return nil }

        wordsCache[level] = words

        return word
    }

    func add(words: [String], for level: DifficultyLevel) {
        var levelWords = wordsCache[level] ?? []

        levelWords.append(contentsOf: words)
        
        wordsCache[level] = levelWords
    }
}
