//
//  LogInViewControl.swift
//  BuyGoodsToHome
//
//  Created by Anton on 9/2/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class LogInViewControl: UIViewController {
    
    var messageController: UserToDoVC?
    
    let inputConteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        button.addTarget(self, action: #selector(handlLogRigistr), for: .touchUpInside)
        
        return button
    }()
    
    func handlLogRigistr() {
        if loginSegmentControl.selectedSegmentIndex == 0 {
            handleLog()
        } else {
            handlRegister()
        }
    }
    
    func handleLog() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else {return}
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            //!!!!self.present(mainScreen, animated: true, completion: nil)
            //self.performSegue(withIdentifier: "main", sender: self)
            let mainScreen = UserToDoVC()
            self.present(mainScreen, animated: true, completion: nil)
        })
    }
    
    let listTextFiel: UITextField = {
        let tfList = UITextField()
        return tfList
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password:"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no image icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 70
        imageView.layer.masksToBounds = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectUserImage)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Lanch screen")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let loginSegmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.layer.cornerRadius = 10
        sc.layer.masksToBounds = true
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleChangeLoginReg), for: .valueChanged)
        return sc
    }()
    
    func handleChangeLoginReg() {
        let title = loginSegmentControl.titleForSegment(at: loginSegmentControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        inputConstraitHeight?.constant = loginSegmentControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextFieldHeight?.isActive = false
        nameTextFieldHeight = nameTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextField.isHidden = loginSegmentControl.selectedSegmentIndex == 0 ? true:false
        nameTextFieldHeight?.isActive = true
        
        emailTextFieldHeight?.isActive = false
        emailTextFieldHeight = emailTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeight?.isActive = true
        
        passwordTextFieldHeight?.isActive = false
        passwordTextFieldHeight = passwordTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeight?.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        
        view.addSubview(backImage)
        view.addSubview(inputConteinerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(userImage)
        view.addSubview(loginSegmentControl)
        
        setupInputConteinerView()
        setupLoginRegisterButton()
        setupLoginSegmentControl()
        setupBackImage()
        setupUserImage()
    }
    
    
    func setupBackImage(){
        backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupLoginSegmentControl() {
        loginSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSegmentControl.bottomAnchor.constraint(equalTo: inputConteinerView.topAnchor, constant: -10).isActive = true
        loginSegmentControl.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor, multiplier: 1).isActive = true
        loginSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var inputConstraitHeight: NSLayoutConstraint?
    var nameTextFieldHeight: NSLayoutConstraint?
    var emailTextFieldHeight: NSLayoutConstraint?
    var passwordTextFieldHeight: NSLayoutConstraint?
    
    var nameSeparatorHeight: NSLayoutConstraint?
    var emailSeparatorHeight: NSLayoutConstraint?
    
    func setupInputConteinerView() {
        
        // constraint Conteiner View
        
        inputConteinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputConteinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputConteinerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputConstraitHeight = inputConteinerView.heightAnchor.constraint(equalToConstant: 150)
        inputConstraitHeight?.isActive = true
        
        // add TextFields(Name,Email,Password) and Separators to Container View
        
        inputConteinerView.addSubview(nameTextField)
        inputConteinerView.addSubview(nameSeparator)
        inputConteinerView.addSubview(emailTextField)
        inputConteinerView.addSubview(emailSeparator)
        inputConteinerView.addSubview(passwordTextField)
        
        // set constraint for TextFields and Separators
        
        nameTextField.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputConteinerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        
        nameTextFieldHeight = nameTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeight?.isActive = true
        
        nameSeparator.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        nameSeparatorHeight = nameSeparator.heightAnchor.constraint(equalToConstant: 1)
        nameSeparatorHeight?.isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        emailTextFieldHeight = emailTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeight?.isActive = true
        
        emailSeparator.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        emailSeparatorHeight = emailSeparator.heightAnchor.constraint(equalToConstant: 1)
        emailSeparatorHeight?.isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        passwordTextFieldHeight = passwordTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeight?.isActive = true
    }
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputConteinerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo:inputConteinerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func setupUserImage() {
        userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImage.bottomAnchor.constraint(equalTo: loginSegmentControl.topAnchor, constant: -8).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
}
