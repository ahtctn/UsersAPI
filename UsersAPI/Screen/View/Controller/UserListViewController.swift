//
//  ViewController.swift
//  UsersAPI
//
//  Created by Ahmet Ali ÇETİN on 31.03.2023.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
}

extension UserListViewController {
    func configuration() {
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.ID.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorColor = .clear
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchUsers()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                print("Product Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("dataLoaded")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .error(let error):
                print("\(error?.localizedDescription as Any)")
            }
        }
    }
}




extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.users[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ID.id, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        cell.user = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        print(viewModel.users[indexPath.row].name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

