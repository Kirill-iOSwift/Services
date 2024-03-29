//
//  Model.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

//MARK: - Models JSON

struct Response: Decodable {
    let body: Body
    let status: Int
}

struct Body: Decodable {
    let services: [Service]
}

//MARK: Model View

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}
