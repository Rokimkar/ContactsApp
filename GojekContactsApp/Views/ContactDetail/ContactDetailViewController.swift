//
//  ContactDetailViewController.swift
//  GojekContactsApp
//
//  Created by S@nchit on 21/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

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
        addBackgroundLayer()
    }
    
    private func bindData(){
        if let contact = contactViewModel{
            self.contactNameLabel.text = contact.contactName  + " " + contact.contactLastName
            self.contactEmailLabel.text = contact.emailId
            self.contactNumberLabel.text = contact.phoneNumberStr
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
    
    @IBAction func favoriteTapped(_ sender: Any) {
        contactViewModel?.favoriteContact(success: { (status: Bool?) in
            if let isFavorited = status, isFavorited{
                self.favoriteButton.setImage(UIImage.init(named: ImageConstants.favoriteImage), for: .normal)
            }else{
                self.favoriteButton.setImage(UIImage.init(named: ImageConstants.unFavoriteImage), for: .normal)
            }
        })
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        // open email
    }
    
    @IBAction func callTapped(_ sender: Any) {
        // call
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        // open message
    }
}
