import UIKit

protocol MainMenuVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var numberOfLevels: Int { get }
    var selectedDifficulty: DifficultyLevel { get }

    func setLevel(index: Int)
}

class MainMenuVCViewModel: MainMenuVCViewModeling {
    private(set) var cellSpacing: CGFloat
    private(set) var numberOfCells: CGFloat
    private(set) var numberOfSpaces: CGFloat
    private(set) var numberOfLevels: Int
    private(set) var selectedDifficulty: DifficultyLevel
    private let apiClient: WordsRetrievable

    init(difficulty: DifficultyLevel = .three,
        cellSpacing: CGFloat = 10,
        numberOfCells: CGFloat = 1,
        numberOfLevels: Int = 10,
        apiClient: WordsRetrievable = DictionaryAPIClient()) {
        self.selectedDifficulty = difficulty
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.numberOfLevels = numberOfLevels
        self.apiClient = apiClient
    }

    func setLevel(index: Int) {
        guard let difficulty = DifficultyLevel(rawValue: index + 1)
            else { fatalError("could not generate difficulty level for index value \(index)")}
        selectedDifficulty = difficulty
    }
}
