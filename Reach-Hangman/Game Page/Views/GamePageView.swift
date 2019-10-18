import UIKit

class GamePageView: UIView {

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 24)
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let cell = "StrikeCell"

    lazy var strikeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(StrikeCollectionViewCell.self, forCellWithReuseIdentifier: cell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let font = "AvenirNext-Regular"

    lazy var usedGuessesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Used Guesses"
        label.font = UIFont(name: font, size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usedGuessesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var secretWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 40)
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var guessTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Letter or Word",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.textAlignment = .center
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 20
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.layer.borderWidth = 1
        tf.keyboardAppearance = UIKeyboardAppearance.dark
        tf.returnKeyType = UIReturnKeyType.go
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        setupBackButton()
        setupStatusLabel()
        setupStrikeCollectionView()
        setupUsedGuessesTitleLabel()
        setupUsedGuessesLabel()
        setupSecretWordLabel()
        setupGuessTextField()
    }

    private func setupBackButton() {
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.20)
            ])
    }

    private func setupStatusLabel() {
        addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 44),
            statusLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }

    private func setupStrikeCollectionView() {
        addSubview(strikeCollectionView)
        NSLayoutConstraint.activate([
            strikeCollectionView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            strikeCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            strikeCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            strikeCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03)
            ])
    }

    private func setupUsedGuessesTitleLabel() {
        addSubview(usedGuessesTitleLabel)
        NSLayoutConstraint.activate([
            usedGuessesTitleLabel.topAnchor.constraint(equalTo: strikeCollectionView.bottomAnchor, constant: 10),
            usedGuessesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usedGuessesTitleLabel.heightAnchor.constraint(equalToConstant: 44),
            usedGuessesTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33)
            ])
    }

    private func setupUsedGuessesLabel() {
        addSubview(usedGuessesLabel)
        NSLayoutConstraint.activate([
            usedGuessesLabel.topAnchor.constraint(equalTo: usedGuessesTitleLabel.bottomAnchor, constant: 10),
            usedGuessesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usedGuessesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            usedGuessesLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
            ])
    }

    private func setupSecretWordLabel() {
        addSubview(secretWordLabel)
        NSLayoutConstraint.activate([
            secretWordLabel.topAnchor.constraint(equalTo: usedGuessesLabel.bottomAnchor, constant: 20),
            secretWordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            secretWordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            secretWordLabel.heightAnchor.constraint(equalToConstant: 44)
            ])
    }

    private func setupGuessTextField() {
        addSubview(guessTextField)
        NSLayoutConstraint.activate([
            guessTextField.topAnchor.constraint(equalTo: secretWordLabel.bottomAnchor, constant: 20),
            guessTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            guessTextField.heightAnchor.constraint(equalToConstant: 44),
            guessTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
    }

    func updateWith(status: String) {
        statusLabel.text = status
    }
}
