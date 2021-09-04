//
//  ViewController.swift
//  FideBase
//
//  Created by Arihant Thriwe on 03/09/21.
//

import UIKit

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

//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "background")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
  //      view.layer.contents = UIImage(imageLiteralResourceName : "background").cgImage
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        setupButtonStyle()
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let islogged_in = UserDefaults.standard.bool(forKey: "Logged_in")
        
        if !islogged_in {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
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

