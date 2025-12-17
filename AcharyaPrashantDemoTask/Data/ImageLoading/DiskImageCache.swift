//  DiskImageCache.swift
//  AcharyaPrashantDemoTask

import UIKit

final class DiskImageCache: ImageCacheType {

    private let directoryURL: URL
    private let fileManager = FileManager.default

    init(directoryName: String = "ImageDiskCache") {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        directoryURL = caches.appendingPathComponent(directoryName, isDirectory: true)
        try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
    }

    private func fileURL(forKey key: String) -> URL {
        let filename = key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
        return directoryURL.appendingPathComponent(filename)
    }

    func image(forKey key: String) -> UIImage? {
        let url = fileURL(forKey: key)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    func store(_ image: UIImage, forKey key: String) {
        let url = fileURL(forKey: key)
        guard let data = image.pngData() else { return }
        try? data.write(to: url)
    }
}

