//
//  RedditDataModel.swift
//  tmobile
//
//  Created by naga vineel golla on 4/23/21.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let kind: String?
    let data: WelcomeData?
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let after: String?
    let children: [Child]?
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData?
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String?
    let numComments: Int?
    let hideScore: Bool?
    let score: Int?
    let url: String?
    let thumbnail: String?
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case numComments = "num_comments"
        case title,hideScore,score,url,thumbnail
    }



}
    
