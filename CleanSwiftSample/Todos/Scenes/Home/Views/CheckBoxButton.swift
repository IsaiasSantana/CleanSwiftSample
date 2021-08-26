import Foundation
import UIKit

final class CheckBoxButton: UIButton {
    // icon by https://www.flaticon.com/authors/pixel-perfect
    private let checkedImage = UIImage(named: "check")
    private let uncheckedImage = UIImage()

    var isChecked: Bool = false {
        didSet {
            setImage(isChecked ? checkedImage : nil, for: .normal)
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupSelf()
    }

    private func setupSelf() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    
        widthAnchor.constraint(equalToConstant: 32).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
}
