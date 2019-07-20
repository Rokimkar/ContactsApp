//
//  ContactListViewModal.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

typealias ContactListResponse = ([Contact]?) -> Void

class ContactListViewModal{
    
    var sortedContacts: [Contact] = []
    
    func fetchContacts(contacts : @escaping ContactListResponse){
        NetworkManager.fetchData(endPoint: ContactsEndPoint(), success: {[weak self] (response: [Contact]) in
            let sortedResponse: [Contact] = response.sorted(by: { (first, second) -> Bool in
                return first.firstName ?? "" < second.firstName ?? ""
            })
            self?.sortedContacts = sortedResponse
            contacts(sortedResponse)
        }) { (error) in
            contacts([])
        }
    }
}
