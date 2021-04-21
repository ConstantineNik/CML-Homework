//
//  ViewController.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    private var viewModel: LoginViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = LoginViewModel()
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        viewModel.logIn { self.goToPropertyListView() }
    }
    
    func goToPropertyListView() {
        performSegue(withIdentifier: "goToPropertyList", sender: self)
    }
    
}

