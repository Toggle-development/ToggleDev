// swiftlint:disable all
import Amplify
import Foundation

extension Post {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case poster
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let post = Post.keys
    
    model.pluralName = "Posts"
    
    model.fields(
      .id(),
      .field(post.title, is: .required, ofType: .string),
      .field(post.poster, is: .required, ofType: .string)
    )
    }
}