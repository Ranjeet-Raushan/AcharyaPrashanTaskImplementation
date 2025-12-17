//  MemoryImageCache.swift
//  RanjeetTask
//  Created by Ranjeet Raushan on 14/12/25.

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
