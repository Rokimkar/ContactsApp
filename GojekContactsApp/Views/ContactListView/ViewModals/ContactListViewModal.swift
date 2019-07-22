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
    var contactLists: [Array<Contact>] = []
    var indexTitles: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    
    func fetchContacts(contacts : @escaping ContactListResponse){
        NetworkManager.fetchData(endPoint: ContactsEndPoint(), success: {[weak self] (response: [Contact]) in
            let sortedResponse: [Contact] = response.sorted(by: { (first, second) -> Bool in
                return first.firstName ?? "" < second.firstName ?? ""
            })
            self?.sortedContacts = sortedResponse
            self?.sortArrayAlphabetically()
            contacts(sortedResponse)
        }) { (error) in
            contacts([])
        }
    }
    
    private func sortArrayAlphabetically(){
        var contactList: [Array<Contact>] = []
        for _ in indexTitles{
            contactList.append([])
        }
        for contact: Contact in sortedContacts {
            if let firstUpperCaseLetter = contact.firstName?.prefix(1).uppercased() {
                if let index = indexTitles.firstIndex(of: firstUpperCaseLetter), index < indexTitles.count {
                    contactList[index].append(contact)
                }
                else {
                    contactList[indexTitles.count-1].append(contact)
                }
            }
        }
        contactLists = contactList
    }
}
