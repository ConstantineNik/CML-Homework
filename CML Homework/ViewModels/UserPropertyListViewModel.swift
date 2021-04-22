//
//  UserPropertyListViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

protocol UserPropertyListViewModelProtocol {
    var updateUserInfo: (() -> ()) { get set }
    var updateViewData: (() -> ()) { get set }
    func fetchData()
}

class UserPropertyListViewModel: NSObject, UserPropertyListViewModelProtocol {
    
    var updateUserInfo: (() -> ()) = {}
    var updateViewData: (() -> ()) = {}
    
    private var apiManager: APIManager!
    
    override init() {
        super.init()
        self.apiManager = APIManager()
        getCurrentUser()
    }
    
    private(set) var userInfo: UserInfo? {
        didSet {
            self.updateUserInfo()
        }
    }
    
    
    private(set) var userProperties: [UserProperty]? {
        didSet {
            self.updateViewData()
        }
    }
    
    func getCurrentUser() {
        apiManager.performGetCurrentUser { [weak self] (result) in
            switch result {
            case .success(let user):
                self?.userInfo = user
                self?.fetchData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchData() {
        apiManager.performGetAllProperties { [weak self] (result) in
            
            switch result {
            case .success(let props):
                self?.userProperties = props.data
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
