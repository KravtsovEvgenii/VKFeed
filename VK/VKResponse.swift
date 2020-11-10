//


import Foundation

struct VKResponse: Decodable {
    var response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [Item]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case nextFrom = "next_from"
        case items
        case profiles
        case groups
    }
}

struct Item: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Atteachment]?
    
    func getAttachmentPhotos()-> [Photo]? {
       guard let photos = self.attachments?.compactMap({ (item) in
        item.photo
       })else {return nil}
        return photos
    }
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postId = "post_id"
        case text
        case attachments
        case comments, likes, reposts, views
    }
}

struct Atteachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
         return getPropperSize().height
    }
    
    var width: Int {
        return getPropperSize().width
    }
    
    var srcBIG: String {
         return getPropperSize().url
    }
    
    //Вытаскиваем ссылку на фото нужного нам размена, в данном случае отталкиваясь от документации нам нужна фото типа "х"
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
             return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct CountableItem: Decodable {
    let count: Int
}

protocol ProfileRepresenatable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresenatable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    
    enum CodingKeys: String, CodingKey {
          case id
          case firstName = "first_name"
          case lastName = "last_name"
          case photo100 = "photo_100"
      }
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresenatable {
    let id: Int
    let name: String
    let photo100: String
    enum CodingKeys: String, CodingKey {
           case id, name
           case photo100 = "photo_100"
       }
    
    var photo: String { return photo100 }
}
