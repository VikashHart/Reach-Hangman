import UIKit

class MainMenuViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    private var viewModel: MainMenuVCViewModeling = MainMenuVCViewModel()
    private let mainMenuView = MainMenuView()
    private let levelSelectionView = LevelSectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    private func configureVC() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.orange
        configureView()
        configureButtons()
        levelSelectionView.collectionView.delegate = self
        levelSelectionView.collectionView.dataSource = self
        mainMenuView.updateWith(level: viewModel.selectedDifficulty.rawValue)
    }

    private func configureButtons(){
        mainMenuView.difficultyButton.addTarget(self,
                                                action: #selector(selectLevel),
                                                for: .touchUpInside)
        mainMenuView.startGameButton.addTarget(self,
                                               action: #selector(startGame),
                                               for: .touchUpInside)
        levelSelectionView.dismissButton.addTarget(self,
                                                   action: #selector(dismissView),
                                                   for: .touchUpInside)
    }

    @objc private func selectLevel() {
        setupLevelSelectionView()
    }

    @objc private func startGame() {
        coordinator?.presentGamePage(difficultyLevel: viewModel.selectedDifficulty)
    }

    @objc private func dismissView() {
        levelSelectionView.removeFromSuperview()
    }

    private func configureView() {
        setupMainMenuView()
    }

    private func setupMainMenuView() {
        mainMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainMenuView)
        NSLayoutConstraint.activate([
            mainMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            mainMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainMenuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    private func setupLevelSelectionView() {
        levelSelectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(levelSelectionView)
        NSLayoutConstraint.activate([
            levelSelectionView.topAnchor.constraint(equalTo: view.topAnchor),
            levelSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            levelSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            levelSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension MainMenuViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setLevel(index: indexPath.row)
        let level = viewModel.selectedDifficulty
        mainMenuView.updateWith(level: level.rawValue)
        levelSelectionView.removeFromSuperview()
    }
}

extension MainMenuViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfLevels
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as? LevelCollectionViewCell else { return UICollectionViewCell() }
        let level = indexPath.row
        cell.updateWith(level: level)
        return cell
    }
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width * 0.7
        let width = (screenWidth - (viewModel.cellSpacing * viewModel.numberOfSpaces)) / viewModel.numberOfCells
        let height: CGFloat = width * 0.20
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
