//
//  String + Height.swift
//  VK
//
//  Created by User on 19.10.2020.
//

import Foundation

import UIKit

//Считаем rect в зависимости от количества текста и размера шрифта
extension String {
    func calculateHeight(width: CGFloat,font: UIFont)-> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(rect.height)
    }
}
