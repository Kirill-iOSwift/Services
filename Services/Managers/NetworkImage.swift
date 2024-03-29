//
//  NetworkImage.swift
//  Services
//
//  Created by Кирилл on 29.03.2024.
//

import UIKit

//MARK: - class NetworkImage

final class NetworkImage {
    
    //MARK: Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    static let shared = NetworkImage()
    private init() {}
    
    //MARK: Methods
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}
