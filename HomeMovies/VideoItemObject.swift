//
//  VideoItemObject.swift
//  Home Movies
//
//  Created by Brett Whitelaw on 12/19/22.
//

import Foundation

class VideoItem: Identifiable {
    var title = ""
    var id = ""
    var videoUrl = ""
}

struct VideoItemJSON: Decodable {
    let title: String
    let id: String
    let videoUrl: String
}
