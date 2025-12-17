//  CompositeImageCache.swift
//  RanjeetTask
//  Created by Ranjeet Raushan on 14/12/25.

import UIKit

final class CompositeImageCache: ImageCacheType {

    private let memory: ImageCacheType
    private let disk: ImageCacheType

    init(memory: ImageCacheType, disk: ImageCacheType) {
        self.memory = memory
        self.disk = disk
    }

    func image(forKey key: String) -> UIImage? {
        if let img = memory.image(forKey: key) {
            return img
        }
        if let img = disk.image(forKey: key) {
            memory.store(img, forKey: key)
            return img
        }
        return nil
    }

    func store(_ image: UIImage, forKey key: String) {
        memory.store(image, forKey: key)
        disk.store(image, forKey: key)
    }
}
