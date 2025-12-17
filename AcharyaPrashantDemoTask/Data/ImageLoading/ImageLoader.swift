//  ImageLoader.swift
//  AcharyaPrashantDemoTask

import UIKit 

protocol ImageLoaderType {
    @discardableResult
    func loadImage(from url: URL,
                   completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable?
    func cancelLoad(for url: URL)
}

final class ImageLoader: ImageLoaderType {

    private let cache: ImageCacheType
    private let session: URLSession

    private var tasks: [URL: URLSessionDataTask] = [:]
    private let lock = NSLock()

    init(cache: ImageCacheType,
         session: URLSession = {
             let config = URLSessionConfiguration.default
             config.urlCache = nil
             config.requestCachePolicy = .reloadIgnoringLocalCacheData
             return URLSession(configuration: config)
         }()) {
        self.cache = cache
        self.session = session
    }

    @discardableResult
    func loadImage(from url: URL,
                   completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {

        let key = url.absoluteString

        if let cached = cache.image(forKey: key) {
            completion(.success(cached))
            return nil
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.removeTask(for: url) }

            if let error = error as NSError?, error.code == NSURLErrorCancelled {
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else { 
                completion(.failure(NSError(domain: "InvalidImageData", code: -1, userInfo: nil)))
                return
            }
            self?.cache.store(image, forKey: key)
            completion(.success(image))
        }

        storeTask(task, for: url)
        task.resume()
        return task
    }

    func cancelLoad(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        if let task = tasks[url] {
            task.cancel()
            tasks.removeValue(forKey: url)
        }
    }

    private func storeTask(_ task: URLSessionDataTask, for url: URL) {
        lock.lock(); defer { lock.unlock() }
        tasks[url] = task
    }

    private func removeTask(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        tasks.removeValue(forKey: url)
    }
}

