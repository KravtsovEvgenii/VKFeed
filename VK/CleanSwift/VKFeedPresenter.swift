//
//  VKFeedPresenter.swift
//  VK
//
//  Created by User on 15.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VKFeedPresentationLogic {
  func presentData(response: VKFeed.Model.Response.ResponseType)
}

class VKFeedPresenter: VKFeedPresentationLogic {
  weak var viewController: VKFeedDisplayLogic?
    
    var sizesCalculator: FeedCellLayoutProtocol = FeedCellLayoutCalculator()
    
    var dateFormatter: DateFormatter  {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "dd/MMM/yyy"
        return df
    }
  
  func presentData(response: VKFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed (let response, let revealedPostIds):
        let groups = response.response.groups
        let profiles = response.response.profiles
        let cells = response.response.items.map({ (item)  in
            cellViewModel(fromResponse: item, groups: groups, profiles: profiles, revealedPostIds: revealedPostIds)
        })
        let feedModel = FeedViewModel.init(cells: cells)
        viewController?.displayData(viewModel: .displayNewsFeed(feed: feedModel))
    case .presentUser(user: let user):
        let userModel = UserModel(photoUrlString: user.photo100)
        viewController?.displayData(viewModel: .displayUser(userModel: userModel))
    case .presentFooter:
        viewController?.displayData(viewModel: .displayFooter)
    }
  }
    private func cellViewModel(fromResponse item: Item, groups: [Group], profiles: [Profile], revealedPostIds: [Int])->FeedViewModel.Cell {
        
        let presentable = convertToPresentable(sourceID: item.sourceId, groups: groups, profiles: profiles)
        let date = Date(timeIntervalSince1970: Double(item.date))
        let stringDate = dateFormatter.string(from: date)
        
        let isFullSized = revealedPostIds.contains(item.postId)
        let photos = item.getAttachmentPhotos()
        
        let sizes = sizesCalculator.getSizes(fromText: item.text, photoAttachment: photos, isFullSizedPost: isFullSized)
        //Заменяем <br> если вдруг они возникнут у нас в тексте на переход на следующую строку.
        let postText = item.text?.replacingOccurrences(of: "<br>", with: "\n")
        return FeedViewModel.Cell(postID: item.postId,
                                  text: postText,
                                  date: stringDate,
                                  name: presentable.name,
                                  likes: formatAmount(amount: item.likes?.count),
                                  comments: formatAmount(amount: item.comments?.count),
                                  shares: formatAmount(amount: item.reposts?.count),
                                  views: formatAmount(amount: item.views?.count),
                                  iconUrlString: presentable.photo,
                                  attachmentsPhoto: photos,
                                  postSizes: sizes)
    }
    private func formatAmount(amount: Int?)-> String? {
        guard let amount = amount, amount > 1 else {return nil}
        var stringAmount = String(amount)
        if stringAmount.count > 6 {
            stringAmount = stringAmount.dropLast(6) + "M"
        }else if stringAmount.count > 3 {
            stringAmount = stringAmount.dropLast(3) + "K"
        }
        
        return stringAmount
    }
    
    private func convertToPresentable(sourceID: Int, groups: [Group], profiles: [Profile] )-> ProfileRepresenatable {

        let profilesOrGroup: [ProfileRepresenatable] = sourceID >= 0 ? profiles: groups
        let normalID = sourceID >= 0 ? sourceID:-sourceID
        let representable = profilesOrGroup.first { (myRepresentable) -> Bool in
            myRepresentable.id == normalID
        }
        return representable!

    }
//    private func photoAttachment(feedItem: Item) -> FeedViewModel.FeedCellPhotoAttachementViewModel? {
//        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
//            attachment.photo
//        }), let firstPhoto = photos.first else {
//            return nil
//        }
//        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
//                                                          width: firstPhoto.width,
//                                                          height: firstPhoto.height)
//    }
  }
  

