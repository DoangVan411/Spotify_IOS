//
//  ScrollableSegmentControlView.swift
//  Spotify
//
//  Created by VanDoang on 04/09/2025.
//

import UIKit

class ScrollableSegmentControlView: UIView {
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    private var indicatorCenterXConstraint: NSLayoutConstraint!
    private var indicatorLayer: CAShapeLayer!
    
    private func setupIndicator() {
        indicatorLayer = CAShapeLayer()
        indicatorLayer.fillColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1.0).cgColor
        layer.addSublayer(indicatorLayer)
    }
    
    private var titles: [String] = []
    var onSelect: ((Int) -> Void)?
    
    private var buttonWidthConstraint: CGFloat = 0
    
    init(titles: [String]) {
        super.init(frame: .zero)
        self.titles = titles
        setupViews()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .clear
            
            if let montserratFont = UIFont(name: "Montserrat-Bold", size: 20) {
                button.titleLabel?.font = montserratFont
            } else {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            }
            
            button.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .normal)
            button.setTitleColor(.white, for: .selected)
            
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            buttons.append(button)
            addSubview(button)
        }
        
        for (index, button) in buttons.enumerated() {
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
                button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(buttons.count))
            ])
            
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: buttons[index-1].trailingAnchor).isActive = true
            }
        }
        
        buttonWidthConstraint = 1 / CGFloat(buttons.count) * UIScreen.main.bounds.width
        
        if let firstButton = buttons.first {
            firstButton.isSelected = true
            selectedIndex = 0
        }
    }
    
    override func layoutSubviews() {
        updateIndicatorPosition(button: buttons[0])
    }
    
    private func updateIndicatorPosition(button: UIButton) {
        
        if let index = buttons.firstIndex(of: button) {
            let itemWidth = self.frame.width / CGFloat(buttons.count)
            let targetX = itemWidth * CGFloat(index) + itemWidth / 2
            
            let ellipseWidth: CGFloat = 16
            let ellipseHeight: CGFloat = 8
            let rect = CGRect(
                x: targetX - ellipseWidth/2,
                y: self.bounds.maxY - 4,
                width: ellipseWidth,
                height: ellipseHeight
            )
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY),
                controlPoint: CGPoint(x: rect.midX, y: rect.minY + ellipseHeight)
            )
            path.close()
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = indicatorLayer.path
            animation.toValue = path.cgPath
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            indicatorLayer.add(animation, forKey: "pathAnimation")
            indicatorLayer.path = path.cgPath
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        buttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedIndex = sender.tag
        
        updateIndicatorPosition(button: sender)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        onSelect?(selectedIndex)
    }
}
