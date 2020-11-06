//
//  NetworkService.swift
//  VK
//
//  Created by User on 14.10.2020.
//

import Foundation

protocol Networking {
    func request(fromPath path: String, withParams params: [String:String], completion: @escaping (Data?,Error?)->Void)
}

final class NetworkService: Networking {
   
    
    private let authService: AuthService
    init(authService: AuthService = SceneDelegate.shared().authService){
        self.authService = authService
    }
    
    func request(fromPath path: String, withParams params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        var params = params
        guard let token = authService.token else {return}
        params["access_token"] = token
        params["v"] = API.version
      
        if let url = getURL(from: path, andParams: params){
            let request = URLRequest(url: url)
            print(url)
            let task = createDataTask(fromRequest: request, completion: completion)
            task.resume()
        }
    }
    private func createDataTask(fromRequest request: URLRequest, completion: @escaping (Data?,Error?)->Void)->URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(data,error)
                
            }
        }
    }
    private func getURL(from path: String, andParams params: [String:String] ) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map({ URLQueryItem(name: $0, value: $1)  })
        return components.url
    }
    
   
}
