//  ImageCacheType.swift
//  RanjeetTask
//  Created by Ranjeet Raushan on 14/12/25.

import UIKit

protocol ImageCacheType {
    func image(forKey key: String) -> UIImage?
    func store(_ image: UIImage, forKey key: String)
}

