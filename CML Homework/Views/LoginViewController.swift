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
        let email = loginTextField.text!
        let password = passwordTextField.text!
        
//        let isValidFields = viewModel.textFieldValidation(email: email, password: password)
//        switch isValidFields {
//        case .success:
//            break
//        case .failure(_, let message):
//            let alert = UIAlertController(title: "Attantion", message: message.localized(), preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
        
        viewModel.logIn(email: email, password: password) { result in
            
            switch result {
                case .success:
                    self.goToPropertyListView()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.getMessage(), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    }
        }
    }
    
    func goToPropertyListView() {
        performSegue(withIdentifier: "goToPropertyList", sender: self)
    }
    
}

