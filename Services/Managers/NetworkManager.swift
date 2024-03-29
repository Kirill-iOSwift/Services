//
//  NetworkManager.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

//MARK: - enum Link (base url)

///Перечисление с адресами
enum Link: String {
    case urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
}

//MARK: - class NetworkManager

///Класс для работы с сетью
final class NetworkManager {
    
    //MARK: Properties
    
    ///Синглтон
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: Methods
    
    ///Метод загрузки данных по сервисам
    func fetchService(url: String, completion: @escaping([Service]) -> Void) {
        guard let url = URL(string: url) else { return }
        ///Создаем задачу
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                ///Декодируем ответ
                let type = try JSONDecoder().decode(Services.self, from: data)
                DispatchQueue.main.async {
                    let services = type.body.services
                    completion(services)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
