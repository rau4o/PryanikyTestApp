//
//  TableWithDataController.swift
//  PryanikyTestApp
//
//  Created by rau4o on 7/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import Kingfisher

private let cellId = "cellId"

class TableWithDataController: UIViewController {
    
    // MARK: - Properties
    
    let vc = DetailController()
    var dataFetcherService = DataFetcherService()
    var dataArr: [Datum] = []
    var viewArr: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DataCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    // MARK: - Helper function
    
    func fetchData() {
        dataFetcherService.fetchData { [weak self] (welcome) in
            guard let self = self, let welcome = welcome else {return}
            let dataArray = welcome.data
            let viewArray = welcome.view
            for i in 0..<dataArray.count {
                self.dataArr.append(dataArray[i])
            }
            for i in 0..<viewArray.count {
                self.viewArr.append(viewArray[i])
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Setup UI

private extension TableWithDataController {
    func initialSetup() {
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension TableWithDataController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = dataArr[indexPath.row].data
        let variantsData = dataArr[indexPath.row].data.variants
        vc.configureModel(with: dataModel)
        vc.arrayData = variantsData ?? []
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension TableWithDataController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DataCell {
            let dataModel = dataArr[indexPath.row]
            let viewModel = viewArr[indexPath.row]
            cell.configureCell(with: dataModel, with: viewModel)
            return cell
        }
        return UITableViewCell()
    }
}
