//
//  VKFeedInteractor.swift
//  VK
//
//  Created by User on 15.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol VKFeedBusinessLogic {
    func makeRequest(request: VKFeed.Model.Request.RequestType)
}

class VKFeedInteractor: VKFeedBusinessLogic {
    
    var presenter: VKFeedPresentationLogic?
    var service: VKFeedService?
    
    func makeRequest(request: VKFeed.Model.Request.RequestType) {
        if service == nil {
            service = VKFeedService()
        }
        
        switch request {
       
        case .getNewsFeed:
            service?.getFeed(completion: {[weak self] (revealedIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedIds))
            })
        case .getUser:
            service?.getUser(completion: {[weak self] (user) in
                guard let user = user else {return}
                self?.presenter?.presentData(response: .presentUser(user: user))
            })
        case .revealPostText(postID: let postID):
            service?.revealPostIds(forPostID: postID, completion: {[weak self] (revealedIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedIds))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooter)
            service?.getNextBatch(completion: {[weak self] (revealPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealPostIds))
            })
        }
    }
}
