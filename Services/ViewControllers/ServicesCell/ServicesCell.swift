//
//  ServicesCell.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import UIKit

class ServicesCell: UITableViewCell {
   
    private var imageData: UIImageView!
    
    func config(service: Service) {
        var content = defaultContentConfiguration()
        content.text = service.name
        content.secondaryText = service.description
        content.imageProperties.maximumSize = CGSize(width: 70, height: 70)
        content.secondaryTextProperties.numberOfLines = 2
        content.image = UIImage(systemName: "photo")
        
        NetworkManager.shared.fetchImage(from: service.iconUrl) { data in
            content.image = UIImage(data: data)
            self.contentConfiguration = content
        }
        
        contentConfiguration = content
        
    }
}
