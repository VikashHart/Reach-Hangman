import Foundation

protocol WordsRetrievable {
    func getWords(difficulty: DifficultyEndpoint, completion: @escaping (Result<[Word], NetworkError>) -> Void)
}

class DictionaryAPIClient: WordsRetrievable {
    private let client: DataRetrieving

    init(dataRetriever: DataRetrieving = NetworkClient()) {
        self.client = dataRetriever
    }

    func getWords(difficulty: DifficultyEndpoint, completion: @escaping (Result<[Word], NetworkError>) -> Void) {
        getWordData(request: URLRequest(url: EndpointBuilder.endpoint(difficulty)),
                      completion: completion)
    }

    private func getWordData(request: URLRequest,
                               completion: @escaping (Result<[Word], NetworkError>) -> Void) {
        client.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let wordsModel = try JSONDecoder().decode(DictionaryWordsModel.self, from: data)
                    completion(.success(wordsModel.words))
                } catch {
                    completion(.failure(NetworkError.jsonDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
