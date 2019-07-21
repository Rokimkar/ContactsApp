//
//  ContactDetailViewController.swift
//  GojekContactsApp
//
//  Created by S@nchit on 21/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var contactImageVIew: UIImageView!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    var gradient: CAGradientLayer?
    var contactViewModel: ContactViewModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactViewModel?.fetchFullContact {[weak self] in
            self?.bindData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    private func setUpView(){
        self.contactImageVIew.layer.cornerRadius = self.contactImageVIew.frame.height/2
        self.contactImageVIew.image = UIImage.init(named: ImageConstants.placeHolderImage)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updateContact))
        self.navigationItem.rightBarButtonItem = rightItem
        addBackgroundLayer()
    }
    
    private func bindData(){
        if let contact = contactViewModel{
            self.contactNameLabel.text = contact.contactName  + " " + contact.contactLastName
            self.contactEmailLabel.text = contact.emailId
            self.contactNumberLabel.text = contact.phoneNumberStr
            if contact.isFavorited{
                self.favoriteButton.setImage(UIImage.init(named: ImageConstants.favoriteImage), for: .normal)
            }else{
                self.favoriteButton.setImage(UIImage.init(named: ImageConstants.unFavoriteImage), for: .normal)
            }
        }
    }
    
    private func addBackgroundLayer(){
        self.gradient = CAGradientLayer()
        self.gradient?.colors = [UIColor.white.cgColor, ColorConstants.applicationColor.withAlphaComponent(0.1).cgColor]
        self.gradient?.locations = [0.0 , 1.0]
        self.gradient?.startPoint = CGPoint(x: 1.0, y: 0.0)
        self.gradient?.endPoint = CGPoint(x: 1.0, y: 1.0)
        let viewFrame: CGRect = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 330 + (self.navigationController?.navigationBar.frame.height ?? 0))
        self.gradient?.frame = viewFrame
        self.view.layer.insertSublayer(self.gradient!, at: 0)
    }
    
    @objc private func updateContact(){
        let updateContactVC: AddContactViewController = AddContactViewController(nibName: "AddContactViewController", bundle: nil)
        updateContactVC.contact = self.contactViewModel as? Contact ?? Contact.init()
        updateContactVC.title = "Edit Contact"
        updateContactVC.updateContactDelegate = self
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: updateContactVC)
        self.present(navigationController, animated: true) {
            //
        }
    }
    
    private func displayMessageInterface() {
        if let number = contactViewModel?.phoneNumberStr{
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = [number]
            composeVC.body = ""
            
            // Present the view controller modally.
            if MFMessageComposeViewController.canSendText() {
                self.present(composeVC, animated: true, completion: nil)
            } else {
                print("Can't send messages.")
            }
        }
        
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        contactViewModel?.favoriteContact(success: {[weak self] (status: Bool?) in
            if let isFavorited = status, isFavorited{
                self?.favoriteButton.setImage(UIImage.init(named: ImageConstants.favoriteImage), for: .normal)
            }else{
                self?.favoriteButton.setImage(UIImage.init(named: ImageConstants.unFavoriteImage), for: .normal)
            }
        })
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        // open email
    }
    
    @IBAction func callTapped(_ sender: Any) {
        // call
        if let number: String = contactViewModel?.phoneNumberStr,let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        // open message
        displayMessageInterface()
    }
}


extension ContactDetailViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
}

extension ContactDetailViewController: ContactUpdatedProtocol{
    func updatedContact(contact: Contact) {
        self.contactViewModel = contact
        bindData()
    }
}
