//
//  ServiceViewController.swift
//  Services
//
//  Created by Кирилл on 28.03.2024.
//

import UIKit

//MARK: - class ServicesViewController

final class ServiceViewController: UIViewController {
    
    //MARK: Private Properties
    
    ///Активити индикатор
    private let activityIndicator = UIActivityIndicatorView()
    ///Таблица
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    ///Массив с сервисами (получены из сети)
    private var services = [Service]()
    
    //MARK: Methods Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchServise()
        setupUI()
    }
    
    //MARK: Private Methods
    
    ///Метод загрузки данных сервисов
    private func fetchServise() {
        NetworkManager.shared.fetchService(url: Link.urlString.rawValue) { [weak self] services in
            guard let self = self else { return }
            self.services = services
            self.tableView.reloadSections(.init(integer: 0), with: .fade)
            self.activityIndicator.stopAnimating()
        }
    }
    
    ///Метод установки UI
    private func setupUI() {
        setupActivityIndicator()
        setupView()
        setupConstraint()
    }
    
    ///Метод настройки активити индикатора
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
    }
    
    ///Метод настройки View
    private func setupView() {
        view.backgroundColor = .white
        title = "Services"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        tableView.bounces = false
    }
    
    ///Метод настройки констрейнтов
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - TableView Protokols

extension ServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///Метод отображения колличества ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    ///Метод настройки ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath) as? ServiceCell else { return UITableViewCell() }
        let model = services[indexPath.row]
        cell.config(service: model)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    ///Метод задает исполнение по таппу на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///Отключам выделени ячейки
        tableView.deselectRow(at: indexPath, animated: true)
        ///Получить сервис по индексу
        let service = services[indexPath.row]
        ///Открыть ссылку на сервис в Safari или App
        if let url = URL(string: service.link) {
            UIApplication.shared.open(url)
            
        }
    }
}
