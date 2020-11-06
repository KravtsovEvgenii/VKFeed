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
    let attachments: [Attechment]?
    
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

struct Attechment: Decodable {
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


//
//
//
//import Foundation
////MARK: Custom protocol
//protocol ProfileRepresentable {
//    var name: String? {get}
//    var id : Int? {get}
//    var photo: String? {get}
//}
//
//// MARK: - VKResponse
//struct VKResponse: Codable {
//    let response: Response?
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let items: [Item]?
//    let profiles: [Profile]?
//    let groups: [Group]?
//    let nextFrom: String?
//
//    enum CodingKeys: String, CodingKey {
//        case items, profiles, groups
//        case nextFrom = "next_from"
//    }
//}
//
//// MARK: - Group
//struct Group: Codable,ProfileRepresentable {
//    let id: Int?
//    let name, screenName: String?
//    let isClosed: Int?
//    let type: String?
//    let photo50, photo100, photo200: String?
//
//    var photo: String?{
//        return self.photo100
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case screenName = "screen_name"
//        case isClosed = "is_closed"
//        case type
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//        case photo200 = "photo_200"
//    }
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let sourceID, date: Int?
//    let canDoubtCategory, canSetCategory: Bool?
//    let postType: PostTypeEnum?
//    let text: String?
//    let markedAsAds: Int?
//    let attachments: [ItemAttachment]?
//    let postSource: ItemPostSource?
//    let comments: Comments?
//    let likes: Likes?
//    let reposts: Reposts?
//    let views: Views?
//    let isFavorite: Bool?
//    let postID: Int?
//    let type: PostTypeEnum?
//    let signerID: Int?
//    let copyright: Copyright?
//    let copyHistory: [CopyHistory]?
//
//
//    func getAttachmentPhoto()-> Photo? {
//       guard let photos = self.attachments?.compactMap({ (item) in
//        item.photo
//       })else {return nil}
//        if let photo = photos.first {
//                return photo
//        }
//        return nil
//    }
//
//
//    enum CodingKeys: String, CodingKey {
//        case sourceID = "source_id"
//        case date
//        case canDoubtCategory = "can_doubt_category"
//        case canSetCategory = "can_set_category"
//        case postType = "post_type"
//        case text
//        case markedAsAds = "marked_as_ads"
//        case attachments
//        case postSource = "post_source"
//        case comments, likes, reposts, views
//        case isFavorite = "is_favorite"
//        case postID = "post_id"
//        case type
//        case signerID = "signer_id"
//        case copyright
//        case copyHistory = "copy_history"
//    }
//}
//
//// MARK: - ItemAttachment
//struct ItemAttachment: Codable {
//    let type: AttachmentType?
//    let photo: Photo?
//    let link: PurpleLink?
//}
//
//// MARK: - PurpleLink
//struct PurpleLink: Codable {
//    let url: String?
//    let title, linkDescription, buttonText, buttonAction: String?
//    let target: String?
//    let photo: Photo?
//    let isFavorite: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case url, title
//        case linkDescription = "description"
//        case buttonText = "button_text"
//        case buttonAction = "button_action"
//        case target, photo
//        case isFavorite = "is_favorite"
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let albumID, date, id, ownerID: Int?
//    let hasTags: Bool?
//    let sizes: [Size]?
//    let text: String?
//    let userID: Int?
//    let accessKey: String?
//    let postID: Int?
//
//
//    var height: Int? {
//        return getImageSize().height ?? 0
//    }
//    var width: Int? {
//        return getImageSize().width ?? 0
//    }
//    var photoURL: String? {
//        return getImageSize().url ?? ""
//    }
//
//
//    func getImageSize()->Size {
//        if let size = self.sizes?.first(where: {$0.type == .x}){
//            return size
//        }else {
//            return (sizes?.first)!
//        }
//    }
//
//
//    enum CodingKeys: String, CodingKey {
//        case albumID = "album_id"
//        case date, id
//        case ownerID = "owner_id"
//        case hasTags = "has_tags"
//        case sizes, text
//        case userID = "user_id"
//        case accessKey = "access_key"
//        case postID = "post_id"
//    }
//}
//
//// MARK: - Size
//struct Size: Codable {
//    let height: Int?
//    let url: String?
//    let type: SizeType?
//    let width: Int?
//}
//
//enum SizeType: String, Codable {
//    case a = "a"
//    case b = "b"
//    case c = "c"
//    case d = "d"
//    case e = "e"
//    case k = "k"
//    case l = "l"
//    case m = "m"
//    case o = "o"
//    case p = "p"
//    case q = "q"
//    case r = "r"
//    case s = "s"
//    case w = "w"
//    case x = "x"
//    case y = "y"
//    case z = "z"
//}
//
//enum AttachmentType: String, Codable {
//    case link = "link"
//    case photo = "photo"
//}
//
//// MARK: - Comments
//struct Comments: Codable {
//    let count, canPost: Int?
//    let groupsCanPost: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case canPost = "can_post"
//        case groupsCanPost = "groups_can_post"
//    }
//}
//
//// MARK: - CopyHistory
//struct CopyHistory: Codable {
//    let id, ownerID, fromID, date: Int?
//    let postType: PostTypeEnum?
//    let text: String?
//    let attachments: [CopyHistoryAttachment]?
//    let postSource: CopyHistoryPostSource?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerID = "owner_id"
//        case fromID = "from_id"
//        case date
//        case postType = "post_type"
//        case text, attachments
//        case postSource = "post_source"
//    }
//}
//
//// MARK: - CopyHistoryAttachment
//struct CopyHistoryAttachment: Codable {
//    let type: AttachmentType?
//    let photo: Photo?
//    let link: FluffyLink?
//}
//
//// MARK: - FluffyLink
//struct FluffyLink: Codable {
//    let url: String?
//    let title, caption, linkDescription: String?
//    let photo: Photo?
//    let isFavorite: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case url, title, caption
//        case linkDescription = "description"
//        case photo
//        case isFavorite = "is_favorite"
//    }
//}
//
//// MARK: - CopyHistoryPostSource
//struct CopyHistoryPostSource: Codable {
//    let type: PostSourceType?
//    let platform: String?
//}
//
//enum PostSourceType: String, Codable {
//    case api = "api"
//    case vk = "vk"
//}
//
//enum PostTypeEnum: String, Codable {
//    case post = "post"
//}
//
//// MARK: - Copyright
//struct Copyright: Codable {
//    let id: Int?
//    let link: String?
//    let type, name: String?
//}
//
//// MARK: - Likes
//struct Likes: Codable {
//    let count, userLikes, canLike, canPublish: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userLikes = "user_likes"
//        case canLike = "can_like"
//        case canPublish = "can_publish"
//    }
//}
//
//// MARK: - ItemPostSource
//struct ItemPostSource: Codable {
//    let type: PostSourceType?
//}
//
//// MARK: - Reposts
//struct Reposts: Codable {
//    let count, userReposted: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userReposted = "user_reposted"
//    }
//}
//
//// MARK: - Views
//struct Views: Codable {
//    let count: Int?
//}
//
//// MARK: - Profile
//struct Profile: Codable, ProfileRepresentable {
//    let firstName, lastName: String?
//    let isClosed, canAccessClosed: Bool?
//    let sex: Int?
//    let screenName: String?
//    let photo50, photo100: String?
//    let online: Int?
//    let onlineInfo: OnlineInfo?
//    let deactivated: String?
//
//    var name: String? {
//        return self.firstName!  + " " + self.lastName!
//    }
//
//    var photo: String? {
//        return self.photo100
//    }
//    var id: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case isClosed = "is_closed"
//        case canAccessClosed = "can_access_closed"
//        case sex
//        case screenName = "screen_name"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//        case online
//        case onlineInfo = "online_info"
//        case deactivated
//    }
//}
//
//// MARK: - OnlineInfo
//struct OnlineInfo: Codable {
//    let visible, isOnline, isMobile: Bool?
//    let lastSeen, appID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case visible
//        case isOnline = "is_online"
//        case isMobile = "is_mobile"
//        case lastSeen = "last_seen"
//        case appID = "app_id"
//    }
//}
//
//
//
