//
//  UserPropertyListViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

protocol UserPropertyListViewModelProtocol {
    var updateViewData: (() -> ()) { get set }
    func fetchData()
}

class UserPropertyListViewModel: NSObject, UserPropertyListViewModelProtocol {
    
    var updateViewData: (() -> ()) = {}
    
    private var apiManager: APIManager!
    
    override init() {
        super.init()
        self.apiManager = APIManager()
        fetchData()
    }
    
    private(set) var userProperties: [UserProperty]? {
        didSet {
            self.updateViewData()
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
