import UIKit

class MainMenuView: UIView {

    let font = "AvenirNext-Regular"

    lazy var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hangman"
        label.font = UIFont(name: font, size: 70)
        label.textAlignment = .center
        label.textColor = .orange
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var selectedDifficultyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 24)
        label.textAlignment = .center
        label.textColor = .orange
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var difficultyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select difficulty", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
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
        backgroundColor = .black
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
            gameTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            gameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }

    private func setupDifficultyLabel() {
        addSubview(selectedDifficultyLabel)
        NSLayoutConstraint.activate([
            selectedDifficultyLabel.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 80),
            selectedDifficultyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),            selectedDifficultyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }

    private func setupDifficultyButton() {
        addSubview(difficultyButton)
        NSLayoutConstraint.activate([
            difficultyButton.topAnchor.constraint(equalTo: selectedDifficultyLabel.bottomAnchor, constant: 80),
            difficultyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            difficultyButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            difficultyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }

    private func setupStartButton() {
        addSubview(startGameButton)
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(equalTo: difficultyButton.bottomAnchor, constant: 60),
            startGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startGameButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            startGameButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            ])
    }

    func updateWith(level: Int) {
        selectedDifficultyLabel.text = "Level \(level + 1)"
    }
}
