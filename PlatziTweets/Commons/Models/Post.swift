//
//  Post.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 07/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: String
    let author: User
    let text: String
    let imageUrl: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}
