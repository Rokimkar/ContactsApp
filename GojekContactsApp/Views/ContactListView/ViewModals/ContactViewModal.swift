//
//  ContactViewModal.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

protocol ContactViewModal {
    var contactName: String {get}
    var contactLastName: String {get}
    var isFavorited: Bool {get}
    var emailId: String {get}
    var phoneNumberStr: String {get}
    func favoriteContact(success: @escaping (Bool?) -> Void)
    func fetchFullContact(success: @escaping()-> Void)
}

extension Contact: ContactViewModal{
    
    var contactName: String {
        return self.firstName ?? ""
    }
    
    var contactLastName: String {
        return self.lastName ?? ""
    }
    
    var isFavorited: Bool{
        return Bool(self.favorite ?? true)
    }
    
    var emailId: String{
        return self.email ?? ""
    }
    
    var phoneNumberStr: String{
        return self.phoneNumber ?? ""
    }
    
    func createContact(success: @escaping ()->Void){
        let appendedParameter: [String:Any] = [ServerConstants.firstName:self.contactName,ServerConstants.lastName:contactLastName,ServerConstants.phoneNumber:phoneNumberStr,ServerConstants.email:emailId]
        NetworkManager.fetchData(endPoint: CreateContactEndpoint(appendedParameters: appendedParameter), success: { (contact: Contact?) in
            success()
        }) { (error: Error?) in
            success()
        }
    }
    
    func fetchFullContact(success: @escaping () -> Void) {
        NetworkManager.fetchData(endPoint: ContactDetailEndpoint(contactId: self.id ?? 0), success: {[weak self] (contact: Contact) in
            self?.id = contact.id
            self?.firstName = contact.firstName
            self?.lastName = contact.lastName
            self?.phoneNumber = contact.phoneNumber
            self?.email = contact.email
            self?.createdAt = contact.createdAt
            self?.updatedAt = contact.updatedAt
            self?.favorite = contact.favorite
            self?.url = contact.url
            self?.profilePicture = contact.profilePicture
            success()
        }) { (error: Error?) in
            success()
        }
    }
    
    func favoriteContact(success: @escaping (Bool?) -> Void) {
        NetworkManager.fetchData(endPoint: UpdateContactEndpoint(contactId: self.id ?? 0, appendedParameters: [ServerConstants.favorite : !isFavorited]), success: {[weak self] (response: Contact) in
            self?.favorite = response.favorite
            success(self?.favorite)
        }) {[weak self] (error: Error?) in
            success(self?.favorite)
        }
    }
    
}
