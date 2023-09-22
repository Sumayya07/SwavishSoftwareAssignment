//
//  SignupViewController.swift
//  SwavishSoftwareAssignment
//
//  Created by Sumayya Siddiqui on 21/09/23.
//

import UIKit
import Firebase
import Toast

class SignupViewController: UIViewController {
    
    @IBOutlet var txtFieldEmail: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var btnSignin: UIButton!
    
    let auth = Auth.auth()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        txtFieldEmail.layer.cornerRadius = 12
        txtFieldEmail.layer.borderWidth = 0.9
        txtFieldEmail.layer.borderColor = UIColor.black.cgColor
        
        txtFieldPassword.layer.cornerRadius = 12
        txtFieldPassword.layer.borderWidth = 0.9
        txtFieldPassword.layer.borderColor = UIColor.black.cgColor
        txtFieldPassword.isSecureTextEntry = true
        txtFieldPassword.textContentType = .oneTimeCode
        
        btnSignup.layer.cornerRadius = btnSignup.frame.size.height/2
        
        addPaddingToTextField(txtFieldEmail)
        addPaddingToTextField(txtFieldPassword)
    }
    
    func addPaddingToTextField(_ textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }

    
    func showToast(message: String) {
        self.view.makeToast(message)
    }
    
    func showToastAndNavigate(message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }

    
    func startLoading() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false  // to prevent user interaction while loading
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidInputs() -> Bool {
        guard let email = txtFieldEmail.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(title: "Error", message: "Please enter a valid email.")
            return false
        }
        
        guard let password = txtFieldPassword.text, !password.isEmpty, password.count >= 6 else {
            showAlert(title: "Error", message: "Password should be at least 6 characters long.")
            return false
        }
        
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        // A simple regex to validate the email. Consider using a more comprehensive regex for production apps.
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    @IBAction func btnSignupTapped(_ sender: Any) {
        
        // Resign the first responders to dismiss the keyboard
        txtFieldEmail.resignFirstResponder()
        txtFieldPassword.resignFirstResponder()
        
        if !isValidInputs() { return }  // Ensure inputs are valid.
           
           startLoading()  // Show the loading spinner.
           
           guard let email = txtFieldEmail.text, let password = txtFieldPassword.text else {
               return
           }

        auth.createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
               self?.stopLoading()
               
               if let error = error {
                   if error.localizedDescription.contains("The email address is already in use by another account.") {
                       self?.showAlert(title: "ALERT", message: "This account already exists. Please sign in.")
                   } else {
                       self?.showAlert(title: "Error", message: error.localizedDescription)
                   }
                   return
               }
               
               self?.showToastAndNavigate(message: "Successfully signed up!")
           }
       
    }
    
    
    @IBAction func btnSigninTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController

        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
