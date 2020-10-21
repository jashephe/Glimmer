import Foundation

public enum GlimmerError: LocalizedError {
    case invalidEndpointURL(_ urlString: String)
    case networkError(_ error: URLSession.DataTaskPublisher.Failure)
    case decodingError
    case invalidResponse(detail: String?)
    case unknownError
    
    public var errorDescription: String? {
        switch self {
        case .invalidEndpointURL(let urlString):
            return "The API endpoint URL \"\(urlString)\" is invalid"
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .decodingError:
            return "An error occurred during response decoding"
        case .invalidResponse(let maybeDetail):
            return "An invalid response was received: \(maybeDetail ?? "no further information available")"
        case .unknownError:
            return "An unknown or unexpected error occurred"
        }
    }
}
