// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var postOwner: User
  public var caption: String
  public var numberOfLikes: Int
  public var status: PostStatus
  public var comments: List<Comment>?
  public var owner: String?
  
  public init(id: String = UUID().uuidString,
      postOwner: User,
      caption: String,
      numberOfLikes: Int,
      status: PostStatus,
      comments: List<Comment>? = [],
      owner: String? = nil) {
      self.id = id
      self.postOwner = postOwner
      self.caption = caption
      self.numberOfLikes = numberOfLikes
      self.status = status
      self.comments = comments
      self.owner = owner
  }
}
