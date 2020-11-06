//
//  UserResponse.swift
//  VK
//
//  Created by User on 04.11.2020.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}
struct UserResponse:Decodable {
    let photo100: String?
    enum CodingKeys: String, CodingKey {
          case photo100 = "photo_100"
      }
}
