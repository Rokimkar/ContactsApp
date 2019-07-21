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

protocol ContactUpdatedProtocol: class {
    func updatedContact(contact: Contact) -> Void
}

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var cameraIconImageView: UIImageView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    private var gradient: CAGradientLayer?
    weak var updateContactDelegate: ContactUpdatedProtocol?
    var contact: Contact = Contact.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createContact))
        self.navigationItem.rightBarButtonItem = rightItem
        addBackgroundLayer()
        setupTextFields()
    }
    
    private func addBackgroundLayer(){
        self.gradient = CAGradientLayer()
        self.gradient?.colors = [UIColor.white.cgColor, ColorConstants.applicationColor.withAlphaComponent(0.1).cgColor]
        self.gradient?.locations = [0.0 , 1.0]
        self.gradient?.startPoint = CGPoint(x: 1.0, y: 0.0)
        self.gradient?.endPoint = CGPoint(x: 1.0, y: 1.0)
        let viewFrame: CGRect = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 200 + (self.navigationController?.navigationBar.frame.height ?? 0))
        self.gradient?.frame = viewFrame
        self.view.layer.insertSublayer(self.gradient!, at: 0)
    }
    
    private func setupTextFields(){
        self.firstNameTextfield.delegate = self
        self.emailTextField.delegate = self
        self.lastNameTextfield.delegate = self
        self.phoneNumberTextField.delegate = self
        
        self.firstNameTextfield.text = contact.firstName
        self.lastNameTextfield.text = contact.lastName
        self.phoneNumberTextField.text = contact.phoneNumber
        self.emailTextField.text = contact.email
        
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
    
    @objc private func createContact(){
        func checkContactAndShowAlert(){
            var textFieldEmptyTag: AddContactTextFields?
            if contact.firstName == nil{
                textFieldEmptyTag = .firstName
            }
            if contact.lastName == nil{
                textFieldEmptyTag = .lastName
            }
            if contact.email == nil{
                textFieldEmptyTag = .email
            }
            if contact.phoneNumber == nil{
                textFieldEmptyTag = .phoneNumber
            }
            if let _ = textFieldEmptyTag{
                handleAlert(textField: textFieldEmptyTag!)
            }else{
                if let _ = contact.id{
                    contact.updateContact { [weak self] in
                        if let contact = self?.contact{
                            self?.updateContactDelegate?.updatedContact(contact: contact)
                        }
                        
                        self?.dismiss(animated: true, completion: {
                            
                        })
                    }
                }else{
                    contact.createContact {[weak self] in
                        self?.dismiss(animated: true, completion: {
                            //
                        })
                    }
                }
                
            }
            
        }
        self.emailTextField.resignFirstResponder()
        checkContactAndShowAlert()
    }

}

extension AddContactViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField){
        if let textfieldTags: AddContactTextFields = AddContactTextFields(rawValue: textField.tag){
            updateData(updatedText: textField.text ?? "", textField: textfieldTags)
        }
    }
}
