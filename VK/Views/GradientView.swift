//
//  GradientView.swift
//  VK
//
//  Created by User on 05.11.2020.
//

import Foundation
import UIKit

class GradientView: UIView {
    //Проперти, которые появятся в атрибут инспекторе в сториборде
    @IBInspectable var startColor: UIColor? {
        didSet {
            setupGradientColor()
        }
    }
    @IBInspectable var endColor: UIColor? {
        didSet {
            setupGradientColor()
        }
    }
    
    let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = bounds
        
    }
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColor()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.9)
    }
    private func setupGradientColor() {
        if let start = startColor, let end = endColor {
            gradientLayer.colors = [start.cgColor, end.cgColor]
        }
        
    }
    
}
