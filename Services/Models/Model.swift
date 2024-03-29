//
//  Model.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

//MARK: - Models JSON

///Основная модель
struct Services: Decodable {
    let body: Body
    let status: Int
}

///Модель с массивом сервисов
struct Body: Decodable {
    let services: [Service]
}

//MARK: Model View

///Модель для View
struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: URL
    
    ///Перечисление с измененными ключами
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}
