//
//  FeedCell.swift
//  VK
//
//  Created by User on 15.10.2020.
//

import UIKit

//Ячейка из ксиба
class FeedCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var postAttachmentPhoto: WebImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var icoImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func prepareForReuse() {
        self.icoImageView.image = nil
        self.postAttachmentPhoto.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        self.backgroundColor = .clear
        selectionStyle = .none
        self.icoImageView.layer.cornerRadius = icoImageView.frame.width / 2
        self.icoImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(fromPost post: PostDataModel) {
        self.icoImageView.setImage(fromString: post.iconUrlString!)
   
        self.nameLabel.text = post.name
        self.dateLabel.text = post.date
        self.postLabel.text = post.text
        self.likesLabel.text = post.likes
        self.commentsLabel.text = post.comments
        self.sharesLabel.text = post.shares
        self.viewsLabel.text = post.views
        
        //Set rects
        self.postLabel.frame = post.postSizes.postLabelRect
        self.postAttachmentPhoto.frame = post.postSizes.imageRect
        self.bottomView.frame = post.postSizes.bottomViewrect
        
        
        
        
        
        if let photo = post.attachmentsPhoto?.first , post.attachmentsPhoto?.count == 1{
             let url = photo.srcBIG
            self.postAttachmentPhoto.setImage(fromString: url)
            self.postAttachmentPhoto.isHidden = false
        }else {
            self.postAttachmentPhoto.isHidden = true
        }
        
    }
    
}
