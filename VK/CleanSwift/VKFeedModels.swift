//
//  VKFeedModels.swift
//  VK
//
//  Created by User on 15.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum VKFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case getUser
        case revealPostText(postID: Int)
        case getNextBatch
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: VKResponse, revealedPostIds: [Int])
        case presentUser(user: UserResponse)
        case presentFooter
        
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feed: FeedViewModel)
        case displayUser(userModel:UserModel)
        case displayFooter
      }
    }
  }
  
}
struct UserModel: TitleViewViewModel{
    var photoUrlString: String?
}
struct FeedViewModel {
    struct Cell:PostDataModel{
        var postID: Int
        var text: String?
        var date: String
        var name: String
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var iconUrlString: String?
        var attachmentsPhoto: [Photo]?
        var postSizes: PostSizes
        var photoAttachement: FeedCellPhotoAttachementViewModel? 
    }
    let cells: [Cell]
    var footerViewtext: String? {
        //Локализация строки под количество постов
        let footerText = String.localizedStringWithFormat(NSLocalizedString("newsFeedCount", comment: ""), self.cells.count)
        return footerText
    }
}


protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}
protocol PostDataModel{
    var text: String? {get}
    var date: String {get}
    var name: String {get}
    var likes: String? {get}
    var comments: String? {get}
    var shares: String? {get}
    var views: String? {get}
    var iconUrlString: String? {get}
    var attachmentsPhoto: [Photo]? {get}
    var postSizes: PostSizes {get}
}
protocol PostSizes {
    var postLabelRect: CGRect {get}
    var imageRect: CGRect {get}
    var bottomViewrect: CGRect {get}
    var totalHeight: CGFloat {get}
    var moreButtonrect: CGRect {get}
}
