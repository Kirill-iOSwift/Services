//
//  ViewController.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import UIKit

class ServicesViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var models = [Service]()
    
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getModels()
        view.backgroundColor = .white
        set()
        
    }
    
    
    func set() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        networkManager.deligate = self
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        let number = models[indexPath.row]
        let image = ImageManager.shared.fetchImageData(from: number.iconUrl)
        var content = cell.defaultContentConfiguration()
        
        content.text = number.name
        content.secondaryText = number.description
        content.secondaryTextProperties.numberOfLines = 2
        content.image = UIImage(data: image!)
        content.imageProperties.maximumSize = CGSize(width: 70, height: 70)
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension ServicesViewController: UpdateDataDelegateProtocol {
    func updateData(model: [Service]) {
        DispatchQueue.main.async {
            self.models = model
            self.tableView.reloadData()
            print(self.models.count)
        }
    }
}
