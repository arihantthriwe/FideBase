//
//  RegisterViewController.swift
//  FideBase
//
//  Created by Arihant Thriwe on 04/09/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {


    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var repasswordField: UITextField!
    @IBOutlet weak var createpasswordField: UITextField!
    @IBOutlet weak var groupField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tandC: UIButton!
    @IBOutlet weak var faq: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appIcon.image = UIImage(named: "LoginPage")
        // Do any additional setup after loading the view.
//       view.layer.contents = UIImage(imageLiteralResourceName : "background").cgImage
        setupButtonStyle()
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
    }
    
    func setupButtonStyle(){
        registerButton.layer.cornerRadius = 15.0
        tandC.layer.cornerRadius = 10.0
        faq.layer.cornerRadius = 10.0
 //       password.layer.cornerRadius = 10.0
    }
    @objc func registerClicked(){
        emailField.resignFirstResponder()
        createpasswordField.resignFirstResponder()
        dobField.resignFirstResponder()
        groupField.resignFirstResponder()
        repasswordField.resignFirstResponder()
        nameField.resignFirstResponder()
        
        guard let name = nameField.text,
              let email = emailField.text,
              let cpassword = createpasswordField.text,
              let rpassword = repasswordField.text,
              !name.isEmpty,
              !email.isEmpty,
              !cpassword.isEmpty,
              !rpassword.isEmpty,
              cpassword.count >= 6,
              rpassword.count >= 6 else{
            alertUserRegistrationError()
            return
        }
        //Firebase Registration
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: cpassword, completion: { authResult,error in
            guard let result = authResult, error == nil else{
                print("Error Creating User")
                return
            }
            let user = result.user
            print("Created User\(user)")
        })
        
        

    }
    func alertUserRegistrationError(){
        let alert = UIAlertController(title: "Whoops", message: "Please fill all details correctly for Registration", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
