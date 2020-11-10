//
//  VKFeedWorker.swift
//  VK
//
//  Created by User on 15.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class VKFeedService {
    
    private var revealedPostIds = [Int]()
    private var feedResponse: VKResponse?
    
    var authService: AuthService
    var networking: Networking
    var dataFetcher: DataFetcher
    var newPostOffset: String?
    
    init () {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.dataFetcher = NetworkDataFetcher(networking: networking)
        
    }
    
    
    func getFeed(completion: @escaping ([Int],VKResponse)->Void){
        dataFetcher.getFeed(nextBatchFrom: nil) {[weak self] (response) in
            self?.feedResponse = response
            guard let feed = self?.feedResponse else {return}
            completion(self!.revealedPostIds,feed)
        }
        
        
    }
    func getUser(completion: @escaping (UserResponse?)->Void){
        dataFetcher.getUser { (user) in
            completion(user)
        }
    }
    func revealPostIds(forPostID postID: Int, completion:@escaping([Int],VKResponse)->Void) {
        self.revealedPostIds.append(postID)
        guard let feed = self.feedResponse else {return}
        completion(revealedPostIds,feed)
    }
    //Получаем новые посты
    func getNextBatch(completion: @escaping ([Int],VKResponse)->Void) {
        newPostOffset = feedResponse?.response.nextFrom
        dataFetcher.getFeed(nextBatchFrom: newPostOffset) { [weak self](feed) in
            guard let feed = feed else {return}
            guard self?.feedResponse?.response.nextFrom != feed.response.nextFrom else {return}
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            }else {
                self?.feedResponse?.response.items.append(contentsOf: feed.response.items)
                
                //Определяем какие из профайлов уже есть в массиве и добавляем несуществующие.
                var profiles = feed.response.profiles
                if let oldprofiles = self?.feedResponse?.response.profiles {
                    let oldProfilesFiltered = oldprofiles.filter { (oldProfile) -> Bool in
                        !feed.response.profiles.contains(where: {$0.id == oldProfile.id
                        })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.response.profiles = profiles
                
                //То же самое с группами
                var updatedGroups = feed.response.groups
                if let oldGroups = self?.feedResponse?.response.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) -> Bool in
                        !feed.response.groups.contains(where: {$0.id == oldGroup.id
                        })
                    }
                    updatedGroups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.response.groups = updatedGroups
                self?.feedResponse?.response.nextFrom = feed.response.nextFrom
                
            }
            guard let feedResponse = self?.feedResponse else {return}
            completion(self!.revealedPostIds,feedResponse)
        }
    }
}
