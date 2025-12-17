//  MediaCoverageModels.swift
//  AcharyaPrashantDemoTask

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
