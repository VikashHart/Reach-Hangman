import UIKit

protocol GameVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var difficultyLevel: DifficultyLevel { get set }
    var onGuessesUpdated: (() -> Void)? { get set }
    var onPlaceholdersUpdated: (() -> Void)? { get set }
    var onWrongAnswerCountUpdated: (() -> Void)? { get set }
    var onWinStateChanged: (() -> Void)? { get set }
    var onStatusChanged: (() -> Void)? { get set }
    var statusMessage: String { get }
    var placeholder: String { get }
    var wrongAnswerCount: Int { get }
    var winStatus: WinState { get }
    var usedGuesses: String { get }
    
    func newGame()
    func check(guess: String)
    func getColor(index: Int) -> UIColor
}

class GameVCViewModel: GameVCViewModeling {
    private(set) var cellSpacing: CGFloat
    private(set) var numberOfCells: CGFloat
    private(set) var numberOfSpaces: CGFloat
    var difficultyLevel: DifficultyLevel
    var onGuessesUpdated: (() -> Void)?
    var onPlaceholdersUpdated: (() -> Void)?
    var onWrongAnswerCountUpdated: (() -> Void)?
    var onWinStateChanged: (() -> Void)?
    var onStatusChanged: (() -> Void)?
    private(set) var secretWord: String = String()
    var statusMessage: String {
        didSet {
            onStatusChanged?()
        }
    }
    
    var placeholder: String = "" {
        didSet {
            self.onPlaceholdersUpdated?()
        }
    }
    
    var wrongAnswerCount: Int = 0 {
        didSet {
            self.onWrongAnswerCountUpdated?()
        }
    }
    
    var winStatus: WinState = .playing {
        didSet {
            self.onWinStateChanged?()
        }
    }
    
    var usedGuesses: String = "" {
        didSet {
            onGuessesUpdated?()
        }
    }
    
    private var usedLetters: Set<Character> = [] {
        didSet {
            combineLettersAndPhrases()
        }
    }
    
    private var usedPhrases: Set<String> = [] {
        didSet {
            combineLettersAndPhrases()
        }
    }
    
    private var apiClient: WordsRetrievable
    private let underscore: String = "_ "
    private let separator: String = ", "

    init(difficultyLevel: DifficultyLevel,
         statusMessage: String = "Playing",
         cellSpacing: CGFloat = 4,
         numberOfCells: CGFloat = 6,
         apiClient: WordsRetrievable = DictionaryAPIClient()) {
        self.difficultyLevel = difficultyLevel
        self.statusMessage = statusMessage
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.apiClient = apiClient
    }
    
    func newGame() {
        resetGame()
        getWord()
    }
    
    func check(guess: String) {
        
        let result: GuessResult
        if guess.count == 1,
            let letter = guess.first {
            result = check(letter: letter)
            
        } else {
            result = checkPhrase(phrase: guess)
            
        }
        update(with: result)
    }
    
    func getColor(index: Int) -> UIColor {
        var color = UIColor()
        
        if index + 1 <= wrongAnswerCount {
            switch index {
            case 0:
                color = .sheenGreen
            case 1:
                color = .bitterLemon
            case 2:
                color = .dandelion
            case 3:
                color = .aerospaceOrange
            case 4:
                color = .rossoCorosa
            case 5:
                color = .darkCandyApple
            default:
                break
            }
        } else {
            color = .white
        }
        return color
    }
    
    private func getWord() {
        apiClient.getWord(difficulty: difficultyLevel) { [weak self] (result) in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.setupGame(word: word.lowercased())
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func resetGame() {
        statusMessage = "Playing"
        placeholder = ""
        secretWord = ""
        usedGuesses = ""
        usedLetters = []
        usedPhrases = []
        wrongAnswerCount = 0
        winStatus = .playing
    }
    
    private func setupGame(word: String) {
        setWord(word: word)
        createPlaceholders(word: word)
    }
    
    private func setWord(word: String) {
        secretWord = word
    }
    
    private func createPlaceholders(word: String) {
        placeholder = String(repeating: underscore, count: word.count)
    }
    
    private func combineLettersAndPhrases() {
        var letters = String()
        let phrases = usedPhrases.joined(separator: separator)
        for char in usedLetters {
            let letter = String(char)
            letters.append(letter + separator)
        }
        usedGuesses = letters + phrases
    }
    
    private func checkGameStatus() {
        if !placeholder.contains(underscore) {
            winStatus = .win
            statusMessage = "You won!"
        } else if wrongAnswerCount == 6 {
            winStatus = .lose
            statusMessage = "You lost!"
        } else {
            winStatus = .playing
        }
    }
    
    private func update(with result: GuessResult) {
        switch result {
            
        case .alreadyUsed:
            statusMessage = "Already Used!"
            
        case .miss(let newPlaceholder):
            statusMessage = "Strike!"
            placeholder = newPlaceholder
            wrongAnswerCount += 1
            checkGameStatus()
            
        case .hit(let newPlaceholder):
            statusMessage = "Correct!"
            placeholder = newPlaceholder
            checkGameStatus()
            
        case .exact(let newPlaceholder):
            statusMessage = "Exact Match!"
            placeholder = newPlaceholder
            checkGameStatus()
            
        }
    }
    
    private func check(letter: Character) -> GuessResult {
        guard !usedLetters.contains(letter)
            else { return .alreadyUsed }
        
        usedLetters.insert(letter)
        let redacted = secretWord.replaceCharacters(with: underscore, allowedCharacters: usedLetters)

        guard secretWord.contains(letter)
            else { return .miss(redacted) }
        
        if secretWord == redacted {
            return .exact(redacted)
        } else {
            return .hit(redacted)
        }
    }
    
    private func checkPhrase(phrase: String) -> GuessResult {
        guard !usedPhrases.contains(phrase)
            else { return .alreadyUsed }
        
        if secretWord == phrase {
            return .exact(phrase)
            
        } else {
            usedPhrases.insert(phrase)
            return .miss(phrase)
            
        }
    }
}
