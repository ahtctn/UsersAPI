//
//  UserViewModel.swift
//  UsersAPI
//
//  Created by Ahmet Ali ÇETİN on 1.04.2023.
//

import UIKit

final class UserViewModel {
    var users: [UserModel] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchUsers() {
        
        self.eventHandler?(.loading)
        APIManager.shared.fetchUsers { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let users):
                self.users = users
                print("Users:\(users)")
                self.eventHandler?(.dataLoaded)
            
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
            
        }
    }
    
}

extension UserViewModel {
    enum Event {
        case loading
        case dataLoaded
        case stopLoading
        case error(_ error: Error?)
    }
}
