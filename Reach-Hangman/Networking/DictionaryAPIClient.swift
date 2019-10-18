import Foundation

enum APIClientError: Error {
    case noWords
}

protocol WordsRetrievable {
    func getWord(difficulty: DifficultyLevel, completion: @escaping (Result<String, Error>) -> Void)
}

class DictionaryAPIClient: WordsRetrievable {
    private let client: DataRetrieving
    private let wordsCache: WordsCaching

    init(dataRetriever: DataRetrieving = NetworkClient(),
         cache: WordsCaching = LevelWordsCache.shared) {
        self.client = dataRetriever
        self.wordsCache = cache
    }

    func getWord(difficulty: DifficultyLevel, completion: @escaping (Result<String, Error>) -> Void) {
        if let newWord = wordsCache.popWord(for: difficulty) {
            completion(.success(newWord))
        } else {
            getWords(difficulty: difficulty, completion: { [weak self] (result) in
                switch result {
                case .success(let words):
                    self?.wordsCache.add(words: words, for: difficulty)
                    if let word = self?.wordsCache.popWord(for: difficulty) {
                        completion(.success(word))
                    } else {
                        completion(.failure(APIClientError.noWords))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }

    private func getWords(difficulty: DifficultyLevel, completion: @escaping (Result<[String], NetworkError>) -> Void) {
        getWordData(request: URLRequest(url: EndpointBuilder.endpoint(for: difficulty)),
                      completion: completion)
    }

    private func getWordData(request: URLRequest,
                               completion: @escaping (Result<[String], NetworkError>) -> Void) {
        client.get(request: request) { result in
            switch result {
            case .success(let data):
                if let words = String(data: data, encoding: .utf8)?.components(separatedBy: .newlines) {
                    completion(.success(words))
                } else {
                    completion(.failure(NetworkError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
