//
//  DetailController.swift
//  PryanikyTestApp
//
//  Created by rau4o on 7/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

private let cellId = "cellId"
private let heightRow: CGFloat = 100

class DetailController: UIViewController {
    
    // MARK: - Properties
    
    var arrayData: [Variant] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        initialSetup()
    }
    
    // MARK: - Helper function
    
    func configureModel(with model: DataClass) {
        DispatchQueue.main.async {
            self.textLabel.text = model.text ?? "ops no text"
            self.imageView.kf.setImage(with: URL(string: model.url ?? "noImage"))
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setup UI

private extension DetailController {
    func initialSetup() {
        configureUI()
    }
    
    private func configureUI() {
        [textLabel, imageView, idLabel, tableView].forEach {
            view.addSubview($0)
        }
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(100)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(idLabel.snp.bottom).offset(10)
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let modelIndex = arrayData[indexPath.row]
        DispatchQueue.main.async {
            cell.textLabel?.text = modelIndex.text
        }
        return cell
    }
}
