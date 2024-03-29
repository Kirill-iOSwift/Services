//
//  NetworkManager.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

enum UrlString: String {
    case url = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
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
    
    func fetchImage(from url: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
}

