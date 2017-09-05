//
//  NewTaskVC.swift
//  BuyGoodsToHome
//
//  Created by Anton on 8/31/17.
//  Copyright © 2017 Anton Duda. All rights reserved.
//

import UIKit
import Firebase

class NewTaskVC: UIViewController,UITextFieldDelegate {

let backImage: UIImageView = {
    let image = UIImageView()
        image.image = UIImage(named: "choosse screen")
        image.translatesAutoresizingMaskIntoConstraints = false
    return image
}()

let backAlfa: UIImageView = {
    let imageAlfa = UIImageView()
        imageAlfa.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        imageAlfa.translatesAutoresizingMaskIntoConstraints = false
    return imageAlfa
    }()

let inputConteinerView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    return view
}()
        
let labelInfoToUser: UILabel = {
    let label = UILabel()
        label.text = "Chosse what to buy"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()
        
let listTextField: UITextField = {
    let tf = UITextField()
        tf.placeholder = "List:"
        tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
}()

let listSeparator: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()
   
    override func viewDidLoad() {
        super.viewDidLoad()
            
        listTextField.delegate = self
            
        view.addSubview(backImage)
        view.addSubview(backAlfa)
        view.addSubview(inputConteinerView)
            
//MARK: - Create NavigationBar

    let navi: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 64))
    
    self.view.addSubview(navi)
    let navigateTitle = UINavigationItem(title:"Add ToDo")
    let navItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    navigateTitle.leftBarButtonItem = navItem
    navi.setItems([navigateTitle], animated: true)
            
    setupInputConteinerView()
    setupBackImage()
    setupBackImageAlfa()
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
}
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid  else {
        return }
            let ref = FIRDatabase.database().reference().child("list").child(uid)
            let usersReference = ref.childByAutoId()
            usersReference.setValue(listTextField.text)
            
            listTextField.text = " "
            
            dismiss(animated: true, completion: nil)

        }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
        }
        
    func setupBackImage() {
        backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    
    func setupBackImageAlfa() {
        backAlfa.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backAlfa.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backAlfa.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backAlfa.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    
    var inputConstraitHeight: NSLayoutConstraint?
    var listTextFieldHeight: NSLayoutConstraint?
    var listSeparatorHeight: NSLayoutConstraint?
    var labelInfoToUserHeight: NSLayoutConstraint?
    var saveDataToFirebaseButtonHeight: NSLayoutConstraint?
        
    func setupInputConteinerView() {
            
//MARK: - Constraint Conteiner View
            
        inputConteinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputConteinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputConteinerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 12).isActive = true
        inputConstraitHeight = inputConteinerView.heightAnchor.constraint(equalToConstant: 150)
        inputConstraitHeight?.isActive = true
            
    // add Label, TextFields and Separator to Container View
            
        inputConteinerView.addSubview(labelInfoToUser)
        inputConteinerView.addSubview(listSeparator)
        inputConteinerView.addSubview(listTextField)
            
    // set constraint for Label, TextFields and Separators
       
        labelInfoToUser.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor, constant: 12).isActive = true
        labelInfoToUser.topAnchor.constraint(equalTo: inputConteinerView.topAnchor).isActive = true
        labelInfoToUser.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        labelInfoToUserHeight = labelInfoToUser.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: 1/2)
        labelInfoToUserHeight?.isActive = true
            
            
        listSeparator.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor).isActive = true
        listSeparator.topAnchor.constraint(equalTo: labelInfoToUser.bottomAnchor).isActive = true
        listSeparator.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        listSeparatorHeight = listSeparator.heightAnchor.constraint(equalToConstant: 1)
        listSeparatorHeight?.isActive = true
            
        listTextField.leftAnchor.constraint(equalTo: inputConteinerView.leftAnchor, constant: 12).isActive = true
        listTextField.topAnchor.constraint(equalTo: listSeparator.bottomAnchor).isActive = true
        listTextField.widthAnchor.constraint(equalTo: inputConteinerView.widthAnchor).isActive = true
        listTextFieldHeight = listTextField.heightAnchor.constraint(equalTo: inputConteinerView.heightAnchor, multiplier: 1/2)
        listTextFieldHeight?.isActive = true
    }
}
