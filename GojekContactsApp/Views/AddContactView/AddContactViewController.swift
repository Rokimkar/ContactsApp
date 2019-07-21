//
//  AddContactViewController.swift
//  GojekContactsApp
//
//  Created by S@nchit on 21/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

public enum AddContactTextFields: Int {
    case firstName = 0
    case lastName = 1
    case phoneNumber = 2
    case email = 3
}

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    private var contact: Contact = Contact.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupTextFields(){
        self.emailTextField.delegate = self
    }
    
    private func updateData(updatedText: String,textField: AddContactTextFields){
        switch textField {
        case .firstName:
            contact.firstName = updatedText
        case .lastName:
            contact.lastName = updatedText
        case .phoneNumber:
            contact.phoneNumber = updatedText
        case .email:
            contact.email = updatedText
        }
    }
    
    private func handleAlert(textField: AddContactTextFields){
        var alertText: String = "All fields are mandatory"
        switch textField {
        case .firstName:
            break
        case .lastName:
            break
        case .phoneNumber:
            alertText = "Please enter valid mobile number"
            
        case .email:
            alertText = "Please enter email"
        
        }
        let alert: UIAlertController = UIAlertController(title: "Error", message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func createContact(){
        
    }

}

extension AddContactViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField){
        if let textfieldTags: AddContactTextFields = AddContactTextFields(rawValue: textField.tag){
            updateData(updatedText: textField.text ?? "", textField: textfieldTags)
        }
    }
}
