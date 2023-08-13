//
//  YouTubeSearchRespnse.swift
//  Netflix Clone
//
//  Created by A on 01/06/2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]?
}


struct VideoElement: Codable {
    let id: IdVideoElement?
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String?
}
