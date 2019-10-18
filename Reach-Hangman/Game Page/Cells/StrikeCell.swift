import UIKit

class StrikeCollectionViewCell: UICollectionViewCell {

    lazy var colorUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureCell()
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func configureCell() {
        backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }

    private func setupViews() {
        setupColorView()
    }

    private func setupColorView() {
        addSubview(colorUIView)
        NSLayoutConstraint.activate([
            colorUIView.topAnchor.constraint(equalTo: topAnchor),
            colorUIView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorUIView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorUIView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
