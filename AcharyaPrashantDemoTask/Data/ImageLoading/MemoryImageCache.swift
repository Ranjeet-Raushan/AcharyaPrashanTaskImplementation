//  MemoryImageCache.swift
//  AcharyaPrashantDemoTask

import UIKit

final class MemoryImageCache: ImageCacheType {

    private let cache = NSCache<NSString, UIImage>()

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func store(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
