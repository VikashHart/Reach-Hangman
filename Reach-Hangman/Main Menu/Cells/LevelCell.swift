import UIKit

class LevelCollectionViewCell: UICollectionViewCell {

    let font = "AvenirNext-Regular"

    lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.orange
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupLevelLabel()
    }

    private func setupLevelLabel() {
    addSubview(levelLabel)
    NSLayoutConstraint.activate([
        levelLabel.topAnchor.constraint(equalTo: topAnchor),
        levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        levelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        levelLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func updateWith(level: Int) {
        levelLabel.text = "Level \(level + 1)"
    }
}
