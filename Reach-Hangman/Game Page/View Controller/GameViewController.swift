import UIKit

class GameViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    private var viewModel: GameVCViewModeling!
    private var gamePageView = GamePageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        bindViewModel()
    }

    init(difficultyLevel: DifficultyLevel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = GameVCViewModel(difficultyLevel: difficultyLevel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func bindViewModel() {
        bindStatus()
        bindUsedGuesses()
        bindPlaceholders()
        bindWrongAnswerCount()
        bindWinState()
    }

    private func bindStatus() {
        viewModel.onStatusChanged = {
            self.gamePageView.updateWith(status: self.viewModel.statusMessage)
        }
    }

    private func bindUsedGuesses() {
        viewModel.onGuessesUpdated = { [weak self] in
            self?.gamePageView.usedGuessesLabel.text = self?.viewModel.usedGuesses
        }
    }

    private func bindPlaceholders() {
        viewModel.onPlaceholdersUpdated = { [weak self] in
            self?.gamePageView.secretWordLabel.text = self?.viewModel.placeholder
        }
    }

    private func bindWrongAnswerCount() {
        viewModel.onWrongAnswerCountUpdated = { [weak self] in
            self?.gamePageView.strikeCollectionView.reloadData()
        }
    }

    private func bindWinState() {
        viewModel.onWinStateChanged = { [weak self] in
            guard let winState = self?.viewModel.winStatus,
            let status = self?.viewModel.statusMessage
                else { return }
            switch winState {
            case .playing:
                return
            case .win:
                self?.gamePageView.updateWith(status: status)
                self?.view.resignFirstResponder()
                self?.presentNewGameAlert()
            case .lose:
                self?.gamePageView.updateWith(status: status)
                self?.view.resignFirstResponder()
                self?.presentNewGameAlert()
            }
        }
    }

    private func configureVC() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.orange
        configureViews()
        configureButtons()
        gamePageView.strikeCollectionView.delegate = self
        gamePageView.strikeCollectionView.dataSource = self
        gamePageView.guessTextField.delegate = self
        viewModel.newGame()
    }

    private func configureButtons() {
        gamePageView.backButton.addTarget(self,
                                          action: #selector(goBack),
                                          for: .touchUpInside)
    }

    @objc private func goBack() {
        presentExitingGameAlert()
    }

    private func presentExitingGameAlert() {
        let alert = UIAlertController(title: "You are about to exit the game! Exiting will discard progress, are you sure you want to end game?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.coordinator?.dismiss()
        }))

        self.present(alert, animated: true)
    }

    private func presentNewGameAlert() {
        let alert = UIAlertController(title: "Would you like to play again?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            self.coordinator?.dismiss()
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.viewModel.newGame()
        }))

        self.present(alert, animated: true)
    }

    private func configureViews() {
        setupGamePageView()
    }

    private func setupGamePageView() {
        gamePageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gamePageView)
        NSLayoutConstraint.activate([
            gamePageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gamePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamePageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension GameViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(viewModel.numberOfCells)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StrikeCell", for: indexPath) as? StrikeCollectionViewCell else { return UICollectionViewCell() }
        let color: UIColor = indexPath.row + 1 <= viewModel.wrongAnswerCount ? viewModel.getColor(index: indexPath.row) : .white
            cell.colorUIView.backgroundColor = color

        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 40
        let width = (screenWidth - (viewModel.cellSpacing * viewModel.numberOfSpaces)) / viewModel.numberOfCells
        let height: CGFloat = width * 0.4
        return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: viewModel.cellSpacing, left: viewModel.cellSpacing, bottom: viewModel.cellSpacing, right: viewModel.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let guess = textField.text?.replacingOccurrences(of: " ", with: "")
            else { return false }
        switch guess.isOnlyLetters() {
        case true:
            viewModel.check(guess: guess.lowercased())
            textField.text = ""
            return true
        case false:
            gamePageView.statusLabel.text = "invalid entry"
            return false
        }
    }
}
