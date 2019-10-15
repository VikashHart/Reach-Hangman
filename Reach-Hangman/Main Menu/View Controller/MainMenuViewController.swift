import UIKit

class MainMenuViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    private let mainMenuView = MainMenuView()
    private let levelSelectionView = LevelSectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

