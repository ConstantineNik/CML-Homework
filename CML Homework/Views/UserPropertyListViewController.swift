//
//  UserPropertyListViewController.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import UIKit

class UserPropertyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: UserPropertyListViewModelProtocol! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.delegate = self
        
        viewModel = UserPropertyListViewModel()
        viewModel.updateUserInfo()
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controllerdoes not exist")
        }
        
        self.viewModel.updateUserInfo = {
            DispatchQueue.main.async {
                self.title = "\(self.viewModel.userInfo?.firstName ?? "User") Properties"
            }
        }
        
        navBar.backgroundColor = .darkGray
    }
    
    func updateTableView() {
        self.viewModel.updateViewData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToProperty" {
            let destinationVC = segue.destination as! PropertyDetailsViewController
            destinationVC.userProperty = self.viewModel?.userProperties?[tableView.indexPathForSelectedRow!.row]
        }
    }

}

//MARK: - UITableView Data Source
extension UserPropertyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userProperties?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personProperty = viewModel.userProperties?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PropertyCell
        
        cell.name.text = personProperty?.name

        return cell
    }
}

//MARK: - UITableView Delegate Methods
extension UserPropertyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToProperty", sender: self)
    }
}
