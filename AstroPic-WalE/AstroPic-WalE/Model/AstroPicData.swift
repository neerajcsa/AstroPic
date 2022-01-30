//
//  AstroPicData.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import Foundation

struct AstroPicData : Decodable {
    let copyright : String
    let date : String
    let explanation : String
    let hdurl : String
    let mediaType : String
    let serviceVersion : String
    let title : String
    let url : String
    
    enum codingKeys : String, CodingKey {
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}
