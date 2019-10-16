import Foundation

enum winState{
    case win
    case lose
    case playing
}

class GameBrainModel {

    var secretWord = [String]()
    var placeholder = [String]()
    var usedGuesses = [String]()
    var wrongAnswerCount: Int = 0
    var winStatus: winState = .playing

    func resetGame() {
        placeholder = []
        secretWord = []
        usedGuesses = [String]()
        wrongAnswerCount = 0
        winStatus = .playing
    }

    func setupGame(word: String) {
        setWord(word: word)
        createPlaceholders(word: word)
    }

    func guessChecker(guess: String) {
        guard guess.count == 1 && guess.isOnlyLetters() && !usedGuesses.contains(guess) || guess.count == secretWord.count && guess.isOnlyLetters() else { return }
        let entry = guess.lowercased()

        switch entry.count {
        case 1:
            if !secretWord.contains(entry) {
                wrongAnswerCount += 1
                usedGuesses.append(entry)
                checkGameStatus()
            } else {
                for (index, letter) in secretWord.enumerated() {
                    if entry == "\(letter)" {
                        placeholder[index] = String(letter)
                        usedGuesses.append(String(letter))
                    }
                }
                checkGameStatus()
            }

        case placeholder.count:
            let word = secretWord.reduce("", +)
            if entry != word {
                wrongAnswerCount += 1
                usedGuesses.append(entry)
                checkGameStatus()
            } else {
                checkGameStatus()
            }
        default:
            break
        }
    }

    private func setWord(word: String) {
        for element in word {
            secretWord.append(String(element.lowercased()))
        }
    }

    private func createPlaceholders(word: String) {
        placeholder = Array(repeating: "_ ", count: word.count)
    }

    private func checkGameStatus() {
        if !placeholder.contains("_ ") {
            winStatus = .win
            resetGame()
        } else if wrongAnswerCount == 6 {
            winStatus = .lose
            resetGame()
        } else {
            winStatus = .playing
        }
    }
}
