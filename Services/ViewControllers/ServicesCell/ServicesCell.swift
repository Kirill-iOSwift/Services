//
//  ServicesCell.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import UIKit

//MARK: - class ServicesCell

final class ServicesCell: UITableViewCell {
   
    //MARK: - Methods
    
    func config(service: Service) {
        var content = defaultContentConfiguration()
        content.text = service.name
        content.secondaryText = service.description
        content.imageProperties.maximumSize = CGSize(width: 70, height: 70)
        content.secondaryTextProperties.numberOfLines = 2
       
        NetworkImage.shared.loadImage(url: service.iconUrl) { image in
            DispatchQueue.main.async {
                content.image = image
                self.contentConfiguration = content
            }
        }
    }
}
