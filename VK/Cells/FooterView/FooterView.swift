//
//  FooterView.swift
//  VK
//

import Foundation
import UIKit
//Активити контроллер и лейбл с количеством загруженных постов для юзера, когда он долистывает до конца ленты
class FooterView: UIView {
    
    private var myLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .black
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myLabel)
        addSubview(loader)
        
        myLabel.anchor(top: topAnchor,
                       leading: leadingAnchor,
                       bottom: nil,
                       trailing: trailingAnchor,
                       padding: UIEdgeInsets(top: 8, left: 20, bottom: 777, right: 20))
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
