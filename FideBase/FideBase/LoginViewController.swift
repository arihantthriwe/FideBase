//
//  ViewController.swift
//  FideBase
//
//  Created by Arihant Thriwe on 03/09/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Log In"
        appIcon.image = UIImage(named: "LoginPage")
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        setupButtonStyle()
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {

        validateAuth()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
    func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser != nil {
            userLoggedin()
        }
    }
    func setupButtonStyle(){
        registerButton.layer.cornerRadius = 15.0
        loginButton.layer.cornerRadius = 15.0
    }

    @objc func registerClicked(){
        let registerVC = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard?.instantiateViewController(identifier: "RegisterViewController"))!
        self.present(vc, animated: true)
    }
    @objc func loginClicked(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        //Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let result = authResult, error == nil else{
                print("Failed to log in user with email:\(email)")
                return
            }
            let user = result.user
            print("Logged in user: \(user)")
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            self?.userLoggedin()
        })
        
    }
    func userLoggedin(){
        let dashboardVC = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard?.instantiateViewController(identifier: "DashboardViewController"))!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to Login", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            emailField.becomeFirstResponder()
        }
        return true
    }
}

