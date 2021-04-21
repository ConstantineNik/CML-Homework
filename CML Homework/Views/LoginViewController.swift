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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        let apiManager: APIManager = APIManager()
        apiManager.performLogIn { [weak self] (result) in
            
            switch result {
            case .success:
                self?.goToPropertyListView()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func goToPropertyListView() {
        performSegue(withIdentifier: "goToPropertyList", sender: self)
    }
    
}

