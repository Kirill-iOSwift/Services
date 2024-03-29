//
//  Model.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}

struct Response: Decodable {
    let body: Body
    let status: Int
}

struct Body: Decodable {
    let services: [Service]
}
