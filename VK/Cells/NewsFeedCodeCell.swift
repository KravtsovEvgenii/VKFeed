//
//  NewsFeedCodeCell.swift
//  VK
//
//  Created by User on 22.10.2020.
//

import Foundation
import UIKit

protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell : UITableViewCell {
    static let reuseIdentifier = "NewsFeedCodeCell"
    
    
     weak var showDelegate: NewsfeedCodeCellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        moreButton.addTarget(self, action: #selector(moreButtontouchAction), for: .touchUpInside)
        iconImageView.layer.cornerRadius = Constant.topViewHeight / 2
        iconImageView.clipsToBounds = true
        selectionStyle = .none
        cardView.clipsToBounds = true
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdlLayer()
        overlayForthLayerOnBottom()
        
    }
    
    @objc func moreButtontouchAction() {
        showDelegate?.revealPost(for: self)
    }
    override func prepareForReuse() {
        iconImageView.image = nil
        postImageView.image = nil
    }

    
    //First layer
    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //More Button
    
    let moreButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4012392163, green: 0.6231879592, blue: 0.8316264749, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    //Second Layer
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    let postLabel: UILabel = {
//       let label = UILabel()
//        label.font = Constant.postLabelFont
//        label.textColor = .black
//        label.numberOfLines = 0
//        return label
//    }()
    let postLabel : UITextView = {
        let textView = UITextView()
        textView.font = Constant.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        //Задаем отступы для TextView
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        //Для определения ссылок
        textView.dataDetectorTypes = .all
       return textView
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()
    let galleryColletionView = GalleryCollectionView()
    
    
    let bottomView: UIView = {
        let view = UIView()
         return view
    }()
    
    
    //Third Layer
    let iconImageView: WebImageView = {
       let webView = WebImageView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let nameLebel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .systemBlue
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //Third Layer on Bottom View
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //Forth Layer on bottomView
    let likesImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "heart.fill")
        return view
    }()
    let commentsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "message.fill")
        return view
    }()
    let sharesImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrowshape.turn.up.left")
        return view
    }()
    let viewsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "eye")
        return view
    }()
    //Labels
    let likesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    

    private func overlayFirstLayer() {
        addSubview(cardView)
        //constraints
        cardView.fillSuperview(padding: Constant.cardViewInsets)
    }
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreButton)
        cardView.addSubview(bottomView)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryColletionView)
        
        //Constraints topView
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant:  8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant:  -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor,constant:  8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constant.topViewHeight).isActive = true
        //Constraints postLabel
    }
    
    private func overlayThirdlLayer() {
        overlayItemsOnBottomView()
        //LayerOntopView
        topView.addSubview(iconImageView)
        topView.addSubview(nameLebel)
        topView.addSubview(dateLabel)
        //Constraints icon Image
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constant.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constant.topViewHeight).isActive = true
        
        //name Label constraint
        nameLebel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLebel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLebel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLebel.heightAnchor.constraint(equalToConstant: Constant.topViewHeight / 2 - 8).isActive = true
         
        //Date Label
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -2).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14  ).isActive = true
    }
    private func overlayItemsOnBottomView() {
        //Lay views on bottomview
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        //Views on bottomView Constraints
        likesView.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constant.bottomViewViewsWidth, height: Constant.bottomViewHeight))
        
        commentsView.anchor(top: bottomView.topAnchor, leading: likesView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constant.bottomViewViewsWidth, height: Constant.bottomViewHeight))
        
        sharesView.anchor(top: bottomView.topAnchor, leading: commentsView.trailingAnchor, bottom: nil, trailing: nil, size: CGSize(width: Constant.bottomViewViewsWidth, height: Constant.bottomViewHeight))
        
        viewsView.anchor(top: bottomView.topAnchor, leading: nil, bottom: nil, trailing: bottomView.trailingAnchor, size: CGSize(width: Constant.bottomViewViewsWidth, height: Constant.bottomViewHeight))
        
    }
    //Forth Layer
    private func overlayForthLayerOnBottom() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        setConstraints(forView: likesView, imageView: likesImage, label: likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        setConstraints(forView: commentsView, imageView: commentsImage, label: commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        setConstraints(forView: sharesView, imageView: sharesImage, label: sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        setConstraints(forView: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    private func setConstraints(forView view:UIView,imageView: UIImageView,label: UILabel ){
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constant.bottovIconsize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.bottovIconsize).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        

    }
    
    func setup(fromPost post: PostDataModel) {
       self.iconImageView.setImage(fromString: post.iconUrlString!)
        self.nameLebel.text = post.name
        self.dateLabel.text = post.date
        self.postLabel.text = post.text
        self.likesLabel.text = post.likes
        self.commentsLabel.text = post.comments
        self.sharesLabel.text = post.shares
        self.viewsLabel.text = post.views
        
        self.postLabel.text = post.text
       
        //Set rects
        self.postLabel.frame = post.postSizes.postLabelRect
        
        self.bottomView.frame = post.postSizes.bottomViewrect
        self.moreButton.frame = post.postSizes.moreButtonrect
        
        if let photo = post.attachmentsPhoto?.first , post.attachmentsPhoto?.count == 1{
             let url = photo.srcBIG  
            self.postImageView.setImage(fromString: url)
            self.postImageView.isHidden = false
            galleryColletionView.isHidden = true
            postImageView.frame = post.postSizes.imageRect
        }else if post.attachmentsPhoto?.count ?? 0 > 1{
            self.postImageView.isHidden = true
            galleryColletionView.isHidden = false
            galleryColletionView.set(photos: post.attachmentsPhoto)
            galleryColletionView.frame = post.postSizes.imageRect
        }else {
            postImageView.isHidden = true
            galleryColletionView.isHidden = true
        }
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
