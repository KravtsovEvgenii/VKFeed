//
//  FeedCellLayoutCalculator.swift
//  VK
//
//  Created by User on 19.10.2020.
//

import Foundation
import UIKit

//В модель структуры будем передавать динамические размеры жлементов ячейки
struct Sizes:PostSizes {
    var moreButtonrect: CGRect
    var postLabelRect: CGRect
    var imageRect: CGRect
    var bottomViewrect: CGRect
    var totalHeight: CGFloat
}



protocol FeedCellLayoutProtocol {
    func getSizes(fromText text: String?, photoAttachment photos: [Photo]?, isFullSizedPost: Bool)-> PostSizes
}


final class FeedCellLayoutCalculator: FeedCellLayoutProtocol{
    
    func getSizes(fromText text: String?, photoAttachment photos: [Photo]?, isFullSizedPost: Bool) -> PostSizes {
        var showMoreButton = false
        
        let cardViewWidth = screenWidth - Constant.cardViewInsets.left - Constant.cardViewInsets.right
        
        //Post Label Calculations
        var postLabelFrame: CGRect = CGRect(origin: CGPoint(x: Constant.postLabelInsets.left,y: Constant.postLabelInsets.top), size: CGSize.zero)
        if let text = text, !text.isEmpty {
            let labelWidth = cardViewWidth - Constant.postLabelInsets.left - Constant.postLabelInsets.right
            
            var height = text.calculateHeight(width: labelWidth, font: Constant.postLabelFont)
            
            
            let limitHeight = Constant.postLabelFont.lineHeight * Constant.minifiedPostLimitLines
            //Проверяем сколько строк в лейбле. Если больше то сворачиваем и отображаем кнопку "показать больше" соответственно если указано что пост должен быть Full Sized то отображаем полностью
            if !isFullSizedPost &&  height > limitHeight {
                height = Constant.postLabelFont.lineHeight * Constant.minifiedPostLines
                showMoreButton = true
            }
            postLabelFrame.size = CGSize(width: labelWidth, height: height)
        }
        
        // MARK: Работа с moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreButton {
            moreTextButtonSize = Constant.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constant.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        //Photo frame calculations
        let photoTop = postLabelFrame.size == CGSize.zero ? Constant.postLabelInsets.top : moreTextButtonFrame
            .maxY + Constant.postLabelInsets.bottom
        
        var photoFrame = CGRect(origin: CGPoint(x: 0, y: photoTop), size: CGSize.zero)
        if let photo = photos?.first,  photos?.count == 1{
            let ratio = CGFloat(photo.height) / CGFloat(photo.width)
            photoFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        } else if photos?.count ?? 0 > 1 {
            var photoSizes = [CGSize]()
            for photo in photos! {
                let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                photoSizes.append(photoSize)
            }
            let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photoSizes)
            photoFrame.size = CGSize(width: cardViewWidth, height: rowHeight ?? 0)
        }
        //BottomView Calculations
        let bottomViewTop = max(postLabelFrame.maxY, photoFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constant.bottomViewHeight))
        
        //TotalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constant.cardViewInsets.bottom
        return Sizes(moreButtonrect: moreTextButtonFrame,
                     postLabelRect: postLabelFrame,
                     imageRect: photoFrame,
                     bottomViewrect: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
}

