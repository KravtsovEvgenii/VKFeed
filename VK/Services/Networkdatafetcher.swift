//
//  Networkdatafetcher.swift
//  VK
//
//  Created by User on 15.10.2020.
//

import Foundation

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (VKResponse?)->Void)
    func getUser(response: @escaping (UserResponse?)->Void)
}

class NetworkDataFetcher: DataFetcher{
   
    
  
    let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let id = authService.userId else {return}
        let params = ["user_ids": id, "fields": "photo_100"]
        networking.request(fromPath: API.user, withParams: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.parseJSON(type: UserResponseWrapped.self, data: data)
            response(decoded?.response.first)
        }
    }
    
    
    
    func getFeed(nextBatchFrom: String?,response: @escaping (VKResponse?) -> Void) {
        var params = ["filters":"post,photo"]
        params["start_from"] = nextBatchFrom
        networking.request(fromPath: API.newsFeed, withParams: params) {(data, error) in
            let decoded = self.parseJSON(type: VKResponse.self, data: data)
  
            response(decoded)
        }
    }
    private func parseJSON<T: Decodable>(type: T.Type, data: Data?)-> T?{
        let jsonDecoder = JSONDecoder()
        guard let data = data else {return nil}
        
        
        do {
        let decoded = try jsonDecoder.decode(type.self, from: data)
            
            return decoded
        }catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
