//  ImageCacheType.swift
//  AcharyaPrashantDemoTask

import UIKit

protocol ImageCacheType {
    func image(forKey key: String) -> UIImage?
    func store(_ image: UIImage, forKey key: String)
}

