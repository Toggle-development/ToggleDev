// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var postOwner: String
  public var caption: String
  public var numberOfLikes: Int
  public var videoUrl: String
  
  public init(id: String = UUID().uuidString,
      postOwner: String,
      caption: String,
      numberOfLikes: Int,
      videoUrl: String) {
      self.id = id
      self.postOwner = postOwner
      self.caption = caption
      self.numberOfLikes = numberOfLikes
      self.videoUrl = videoUrl
  }
}