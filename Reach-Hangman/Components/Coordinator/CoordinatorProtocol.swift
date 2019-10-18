import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
    func dismiss()
    func presentGamePage(difficultyLevel: DifficultyLevel)
}
