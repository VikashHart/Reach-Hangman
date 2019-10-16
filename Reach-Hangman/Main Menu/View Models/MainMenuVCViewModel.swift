import UIKit

protocol MainMenuVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var numberOfLevels: Int { get }
    var selectedDifficulty: DifficultyEndpoint? { get set }
    var wordData: [Word]? { get }
    var onDataRecieved: (() -> Void)? { get set }

    func fetchNewData()
    func setLevel(index: Int)
}

class MainMenuVCViewModel: MainMenuVCViewModeling {
    var cellSpacing: CGFloat
    var numberOfCells: CGFloat
    var numberOfSpaces: CGFloat
    var numberOfLevels: Int
    var selectedDifficulty: DifficultyEndpoint?
    var wordData: [Word]?
    var onDataRecieved: (() -> Void)?
    private let apiClient: WordsRetrievable

    init(cellSpacing: CGFloat = 10, numberOfCells: CGFloat = 1, numberOfLevels: Int = 10, apiClient: WordsRetrievable = DictionaryAPIClient()) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.numberOfLevels = numberOfLevels
        self.apiClient = apiClient
    }

    func fetchNewData() {

    }

    func setLevel(index: Int) {
        switch index {
        case 0:
            selectedDifficulty = .one
        case 1:
            selectedDifficulty = .two
        case 2:
            selectedDifficulty = .three
        case 3:
            selectedDifficulty = .four
        case 4:
            selectedDifficulty = .five
        case 5:
            selectedDifficulty = .six
        case 6:
            selectedDifficulty = .seven
        case 7:
            selectedDifficulty = .eight
        case 8:
            selectedDifficulty = .nine
        case 9:
            selectedDifficulty = .ten
        default:
            break
        }
    }
}
