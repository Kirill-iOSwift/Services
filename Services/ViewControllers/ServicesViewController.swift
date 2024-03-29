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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        set()
        fetchServise()
    }
    func fetchServise() {
        NetworkManager.shared.fetchService(url: UrlString.url.rawValue) { services in
            self.models = services
            self.tableView.reloadData()
        }
    }
    
    func set() {
        
        title = "Services"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
                
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ServicesCell else { return UITableViewCell() }
        
        let model = models[indexPath.row]
        cell.config(service: model)
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Получить сервис по индексу
        let service = models[indexPath.row]
        
        // Открыть ссылку на сервис в Safari
        if let url = URL(string: service.link) {
            UIApplication.shared.open(url)
        }
    }
}
