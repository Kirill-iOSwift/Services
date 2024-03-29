//
//  NetworkManager.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

//MARK: - enum Link (base url)

enum Link: String {
    case urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
}

//MARK: - class NetworkManager

final class NetworkManager {
    
    //MARK: Properties
    
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: Methods
    
    func fetchService(url: String, completion: @escaping([Service]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let type = try JSONDecoder().decode(Response.self, from: data)
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
