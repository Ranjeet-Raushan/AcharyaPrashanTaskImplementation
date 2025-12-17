//  MediaCoverageModels.swift
//  RanjeetTask
//  Created by Ranjeet Raushan on 14/12/25.

struct MediaCoverageResponseItem: Decodable {
    struct Thumbnail: Decodable {
        let domain: String
        let basePath: String
        let key: String
    }
    let id: String
    let thumbnail: Thumbnail
}

typealias MediaCoverageResponse = [MediaCoverageResponseItem]
