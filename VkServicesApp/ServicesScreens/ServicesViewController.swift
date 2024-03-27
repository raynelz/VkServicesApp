//
//  ViewController.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import UIKit
import SnapKit

final class ServicesViewController: UIViewController {

    let networkManager: NetworkManagerProtocol

    var services: [Service] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        return table
    }()

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configTableView()

        networkManager.fetchData { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let success):
                self.services = success.body.services
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func setupViews() {
        title = "Сервисы"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints({
            $0.top.equalTo(view.snp.topMargin)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottomMargin)
        })
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServicesItemsCell.self, forCellReuseIdentifier: "ItemsCell")
    }
}

extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: services[indexPath.row].link) {
            UIApplication.shared.open(url)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ItemsCell",
            for: indexPath
        ) as? ServicesItemsCell else { return UITableViewCell() }
        cell.configure(with: services[indexPath.row])
        return cell
    }

}
