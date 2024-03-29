//
//  NetworkImage.swift
//  Services
//
//  Created by Кирилл on 29.03.2024.
//

import UIKit

//MARK: - class NetworkImage

///Класс для загрузки и кэширования картинок
final class NetworkImage {
    
    //MARK: Properties
    
    ///Кэш
    private let imageCache = NSCache<NSString, UIImage>()
    
    ///Синглтон
    static let shared = NetworkImage()
    private init() {}
    
    //MARK: Methods
    
    ///Метод загрузки картинки и кэширования
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        ///Проверяем наличие картинки в кэше, возвращем если есть
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            ///Создаем задачу если нет картинки в кэше
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                ///Добавляем в кэш и возвращаем
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}
