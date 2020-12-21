// swiftlint:disable all
import Amplify
import Foundation

extension Post {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case postOwner
    case caption
    case numberOfLikes
    case videoUrl
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let post = Post.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", operations: [.create, .delete, .update])
    ]
    
    model.pluralName = "Posts"
    
    model.fields(
      .id(),
      .field(post.postOwner, is: .required, ofType: .string),
      .field(post.caption, is: .required, ofType: .string),
      .field(post.numberOfLikes, is: .required, ofType: .int),
      .field(post.videoUrl, is: .required, ofType: .string)
    )
    }
}