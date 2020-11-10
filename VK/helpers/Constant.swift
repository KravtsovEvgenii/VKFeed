//
//  Constant.swift
//  VK
//
//  Created by User on 22.10.2020.
//

import Foundation
import UIKit

struct Constant {
    static let cardViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 55
    static let postLabelInsets = UIEdgeInsets(top: 8 + topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 16)
    static let bottomViewHeight: CGFloat = 55
    static let bottomViewViewsWidth: CGFloat = 80
    static let bottovIconsize: CGFloat = 24
    static let minLinesToShowMoreButtonLimit: CGFloat = 2
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets (top: 0, left: 8, bottom: 0, right: 0)
    static let minifiedPostLimitLines: CGFloat = 4
    static let minifiedPostLines: CGFloat = 3
}
