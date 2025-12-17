//  FetchMediaCoveragesUseCase.swift
//  AcharyaPrashantDemoTask

import Foundation

 final class FetchMediaCoveragesUseCase: FetchMediaCoveragesUseCaseType {

    private let apiClient: MediaCoverageAPIClientType

    init(apiClient: MediaCoverageAPIClientType) {
        self.apiClient = apiClient
    }

    @discardableResult
    func execute(limit: Int,
                 completion: @escaping (Result<[ImageItem], Error>) -> Void) -> Cancellable? {
        apiClient.fetchMediaCoverages(limit: limit) { result in
            switch result {
            case .success(let response):
                let items: [ImageItem] = response.compactMap { item in
                    guard let url = URL(string: "\(item.thumbnail.domain)/\(item.thumbnail.basePath)/0/\(item.thumbnail.key)") else {
                        return nil
                    }
                    return ImageItem(id: item.id, url: url)
                }
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
