//  MediaCoverageAPIClient.swift
//  AcharyaPrashantDemoTask

import Foundation

// Complete url: https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100

protocol MediaCoverageAPIClientType {
    func fetchMediaCoverages(limit: Int,
                             completion: @escaping (Result<MediaCoverageResponse, Error>) -> Void) -> Cancellable?
}

final class MediaCoverageAPIClient: MediaCoverageAPIClientType {

    private let session: URLSession
    private let baseURL = URL(string: "https://acharyaprashant.org")!

    init(session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession(configuration: config)
    }()) {
        self.session = session
    }

    @discardableResult
    func fetchMediaCoverages(limit: Int,
                             completion: @escaping (Result<MediaCoverageResponse, Error>) -> Void) -> Cancellable? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = "/api/v2/content/misc/media-coverages"
        components.queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
        guard let url = components.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1)))
            return nil
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error as NSError?, error.code == NSURLErrorCancelled {
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1)))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(MediaCoverageResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        return task
    }
}
