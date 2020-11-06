//
//  GalleryView.swift
//  VK
//
//  Created by User on 29.10.2020.
//

import Foundation
import UIKit
class GalleryCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
  
    var photos: [Photo]?
    
    init() {
        let layout = RowLayout()
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        layout.delegate = self
        backgroundColor = .white
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(GalleryViewCell.self, forCellWithReuseIdentifier: GalleryViewCell.reuseIdentifier)
    }
    
    func set(photos: [Photo]?) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return photos?.count ?? 0
    }
//    override func numberOfItems(inSection section: Int) -> Int {
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryViewCell.reuseIdentifier, for: indexPath) as! GalleryViewCell
        cell.set(imageUrl: photos?[indexPath.row].srcBIG)
        return cell
    }
    
}
//MARK: Flow Layout

extension GalleryCollectionView: RowLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = (photos?[indexPath.row].width) ?? 0
        let height = (photos?[indexPath.row].height) ?? 0
        
        return CGSize(width: width, height: height)
    }
    
  
}
