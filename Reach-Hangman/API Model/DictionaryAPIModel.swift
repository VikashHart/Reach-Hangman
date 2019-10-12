import Foundation

struct DictionaryWordsModel: Codable {
    let words: [Word]
}

struct Word: Codable {
    let word: String
}
