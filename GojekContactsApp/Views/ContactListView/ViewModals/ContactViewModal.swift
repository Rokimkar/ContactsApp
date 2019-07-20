//
//  ContactViewModal.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

protocol ContactViewModal {
    var contactName: String? {get}
    var contactLastName: String? {get}
    var isFavorited: Bool {get}
    func favoriteContact(success: @escaping (Bool?) -> Void)
}

extension Contact: ContactViewModal{
    
    var contactName: String? {
        return self.firstName
    }
    
    var contactLastName: String? {
        return self.lastName
    }
    
    var isFavorited: Bool{
        return Bool(self.favorite ?? true)
    }
    
    func favoriteContact(success: @escaping (Bool?) -> Void) {
        NetworkManager.fetchData(endPoint: UpdateContactEndpoint(contactId: self.id ?? 0, appendedParameters: ["favorite" : !isFavorited]), success: {[weak self] (response: Contact) in
            self?.favorite = response.favorite
            success(self?.favorite)
        }) {[weak self] (error: Error?) in
            success(self?.favorite)
        }
    }
    
}
