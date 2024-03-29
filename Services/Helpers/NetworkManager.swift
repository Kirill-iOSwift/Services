//
//  NetworkManager.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import Foundation

protocol UpdateDataDelegateProtocol {
    func updateData(model: [Service])
}

class NetworkManager {

    var deligate: UpdateDataDelegateProtocol?

    func getModels() {
        let url = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        getUrl(url: url)
    }


    func getUrl(url: String) {
        if let url = URL(string: url) {
            print(url)
            let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
                //                guard error != nil  else { return }
                if let safeData = data {
                    print(data!)
                    if let servicesData = try? JSONDecoder().decode(Response.self, from: safeData) {
                        
                        let models = servicesData.body.services
                        print(models.count)
                        self.deligate?.updateData(model: models)
                    }
                }
            }
            task.resume()
        }
    }
}


