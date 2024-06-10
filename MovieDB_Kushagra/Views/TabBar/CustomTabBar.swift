import UIKit

class CustomTabBar: UITabBar {
    
    private let overlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOverlay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupOverlay()
    }
    
    private func setupOverlay() {
        addSubview(overlay)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let overlayHeight: CGFloat = 90  // Adjust this value to increase overlay size
        overlay.frame = CGRect(x: 0, y: bounds.height - overlayHeight, width: bounds.width, height: overlayHeight)
    }
}
