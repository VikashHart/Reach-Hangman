import UIKit

class MainMenuView: UIView {

    let font = "AvenirNext-Regular"

    lazy var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hangman"
        label.font = UIFont(name: font, size: 30)
        label.textAlignment = .center
        label.textColor = .orange
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var selectedDifficultyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var difficultyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select difficulty", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupTitleLabel()
        setupDifficultyLabel()
        setupDifficultyButton()
        setupStartButton()
    }

    private func setupTitleLabel() {
        addSubview(gameTitleLabel)
        NSLayoutConstraint.activate([
            gameTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 0.1),
            gameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            gameTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
            ])
    }

    private func setupDifficultyLabel() {
        addSubview(selectedDifficultyLabel)
        NSLayoutConstraint.activate([
            selectedDifficultyLabel.topAnchor.constraint(equalToSystemSpacingBelow: gameTitleLabel.bottomAnchor, multiplier: 0.1),
            selectedDifficultyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedDifficultyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedDifficultyLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
            ])
    }

    private func setupDifficultyButton() {
        addSubview(difficultyButton)
        NSLayoutConstraint.activate([
            difficultyButton.topAnchor.constraint(equalToSystemSpacingBelow: selectedDifficultyLabel.bottomAnchor, multiplier: 0.1),
            difficultyButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            difficultyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            difficultyButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
            ])
    }

    private func setupStartButton() {
        addSubview(startGameButton)
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(equalToSystemSpacingBelow: difficultyButton.bottomAnchor, multiplier: 0.1),
            startGameButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            startGameButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            startGameButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            startGameButton.bottomAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 0.1)
            ])
    }
}
