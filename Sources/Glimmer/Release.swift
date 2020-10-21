import Foundation

/// Represents a single GitHub release
public struct GlimmerRelease: Decodable {
    /// The name of the release (`name` field)
    public let name: String
    /// A textual description of the release (`body` field)
    public let description: String
    /// The repository tag associated with the release (`tag_name` field)
    public let tag: String
    /// The date/time at which the release was published (`published_at` field)
    public let publishedAt: Date
    /// The GitHub user who created the release (`author` field)
    public let author: User
    /// The address of the release page on `github.com`
    public let webURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case description = "body"
        case tag = "tag_name"
        case publishedAt = "published_at"
        case author
        case webURL = "html_url"
    }
    
    /// A simple representation of a GitHub user
    public struct User: Decodable {
        /// The user's name
        public let name: String
        /// A URL for the user's profile picture
        public let avatarURL: URL
        /// A URL for the user's profile page
        public let profileURL: URL
        
        enum CodingKeys: String, CodingKey {
            case name = "login"
            case avatarURL = "avatar_url"
            case profileURL = "html_url"
        }
    }
}
