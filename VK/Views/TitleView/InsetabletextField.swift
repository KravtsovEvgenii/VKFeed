//
//  InsetableTextField.swift
//  VK
//
//

import Foundation
import UIKit

class InsetableTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9341395497, green: 0.9341614842, blue: 0.9341497421, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: "Search",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textColor = .black
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let image = UIImage(systemName: "magnifyingglass")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
}

