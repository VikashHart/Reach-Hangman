import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainMenuViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }

    func presentGamePage(difficultyLevel: DifficultyLevel) {
        let vc = GameViewController(difficultyLevel: difficultyLevel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
