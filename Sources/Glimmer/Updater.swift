import Foundation
import Combine

/// A Glimmer GitHub update checker, initialized to the given repository
public class GlimmerUpdater {
    /// The GitHub user or group that owns the repository from which releases will be queried
    public let repositoryOwner: String
    /// The name of the repository from which releases will be queried
    public let repositoryName: String
    
    private var apiURL: String {
        return "https://api.github.com/repos/\(self.repositoryOwner)/\(self.repositoryName)/releases/latest"
    }
    
    /// - Parameter repositoryOwner: The GitHub user or group that owns the repository
    /// - Parameter repositoryName: The name of the repository
    public init(repositoryOwner: String, repositoryName: String) {
        self.repositoryOwner = repositoryOwner
        self.repositoryName = repositoryName
    }
    
    /// Fetch the latest GitHub release for the repository defined in this updater
    /// - Returns: A Combine `Publisher` that resolves to a single `GlimmerRelease` and then completes, or fails with a `GlimmerError`
    public func getLatestRelease() -> AnyPublisher<GlimmerRelease, GlimmerError> {
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        guard let endpoint = URL(string: self.apiURL) else {
            return Fail(error: .invalidEndpointURL(self.apiURL)).eraseToAnyPublisher()
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return session.dataTaskPublisher(for: URLRequest(url: endpoint)).tryMap { (data, response) -> Data in
            guard let response = response as? HTTPURLResponse else {
                throw GlimmerError.invalidResponse(detail: "non-HTTP response")
            }
            if response.statusCode != 200 {
                throw GlimmerError.invalidResponse(detail: "non-200 HTTP status code: \(response.statusCode)")
            }
            return data
        }.decode(type: GlimmerRelease.self, decoder: jsonDecoder).mapError { (error) -> GlimmerError in
            switch error {
            case let urlError as URLSession.DataTaskPublisher.Failure:
                return .networkError(urlError)
            case _ as Swift.DecodingError:
                return .decodingError
            case let error as GlimmerError:
                return error
            default:
                return .unknownError
            }
        }.eraseToAnyPublisher()
    }
}
