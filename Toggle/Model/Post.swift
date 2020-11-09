// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var title: String
  public var poster: String
  
  public init(id: String = UUID().uuidString,
      title: String,
      poster: String) {
      self.id = id
      self.title = title
      self.poster = poster
  }
}