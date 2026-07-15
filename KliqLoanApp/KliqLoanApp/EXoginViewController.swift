////
////  LoginViewController.swift
////  KliqLoanApp
////
////  Created by Kliq Tech on 2.02.2025.
////
//
//import UIKit
//
//// MARK: - LoginViewController
//class LoginViewController: UIViewController {
//    private let logoImageView = UIImageView()
//    private let emailField = UITextField()
//    private let passwordField = UITextField()
//    private let loginButton = UIButton(type: .system)
//    private let errorLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        buildUI()
//    }
//
//    private func buildUI() {
//        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
//        title = "Kliq Loan"
//
//        logoImageView.image = UIImage(named: "kliq_logo")
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//
//        emailField.placeholder = "E-mail address"
//        emailField.borderStyle = .roundedRect
//        emailField.keyboardType = .emailAddress
//        emailField.autocapitalizationType = .none
//        emailField.backgroundColor = .white
//        emailField.layer.cornerRadius = 8
//        emailField.layer.borderWidth = 1
//        emailField.layer.borderColor = UIColor.lightGray.cgColor
//        emailField.translatesAutoresizingMaskIntoConstraints = false
//
//        passwordField.placeholder = "Password"
//        passwordField.borderStyle = .roundedRect
//        passwordField.isSecureTextEntry = true
//        passwordField.backgroundColor = .white
//        passwordField.layer.cornerRadius = 8
//        passwordField.layer.borderWidth = 1
//        passwordField.layer.borderColor = UIColor.lightGray.cgColor
//        passwordField.translatesAutoresizingMaskIntoConstraints = false
//
//        loginButton.setTitle("Sign In", for: .normal)
//        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        loginButton.backgroundColor = UIColor(red: 0.13, green: 0.17, blue: 0.27, alpha: 1.0)
//        loginButton.setTitleColor(.white, for: .normal)
//        loginButton.layer.cornerRadius = 10
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        loginButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
//
//        errorLabel.text = ""
//        errorLabel.textColor = .red
//        errorLabel.font = UIFont.systemFont(ofSize: 12)
//        errorLabel.textAlignment = .center
//        errorLabel.numberOfLines = 0
//        errorLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let stackView = UIStackView(arrangedSubviews: [logoImageView, emailField, passwordField, errorLabel, loginButton])
//        stackView.axis = .vertical
//        stackView.spacing = 14
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            logoImageView.heightAnchor.constraint(equalToConstant: 50),
//            emailField.heightAnchor.constraint(equalToConstant: 48),
//            passwordField.heightAnchor.constraint(equalToConstant: 48),
//            loginButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    @objc private func handleSignIn() {
//        // No validation, no session management, direct navigation
//        if emailField.text == "" || passwordField.text == "" {
//            errorLabel.text = "Please fill all fields"
//            return
//        }
//
//        if emailField.text != nil && emailField.text!.contains("@") == false {
//            errorLabel.text = "Invalid email"
//            return
//        }
//
//        if passwordField.text != nil && passwordField.text!.count < 6 {
//            errorLabel.text = "Password too short"
//            return
//        }
//
//        let homeVC = HomeViewController()
//        navigationController?.pushViewController(homeVC, animated: true)
//    }
//}
