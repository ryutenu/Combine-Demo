//
//  ViewController.swift
//  Combine-Demo
//
//  Created by Alan Liu on 2021/12/09.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var companyList = [String]()
    
    var observer: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        observer = ApiCaller.shared.fetchCompanyList()
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("finished")
                case .failure(let error): print(error)
                }
        }, receiveValue: { [weak self] value in
            self?.companyList = value
            self?.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            fatalError()
        }
        cell.textLabel?.text = companyList[indexPath.row]
        return cell
    }
}
