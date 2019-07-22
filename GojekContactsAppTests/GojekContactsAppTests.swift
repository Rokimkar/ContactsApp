//
//  GojekContactsAppTests.swift
//  GojekContactsAppTests
//
//  Created by S@nchit on 22/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import XCTest

@testable import GojekContactsApp

class GojekContactsAppTests: XCTestCase {
    
    var contactViewModal: ContactViewModal!
    var contactListViewModel: ContactListViewModal!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        contactViewModal = nil
        contactListViewModel = nil
    }
    
    func testEditContactFlow(){
        // Creating Edited Contact
        let editedContactExpectation: XCTestExpectation = expectation(description: "Contact edited")
        let editedContact: Contact = Contact()
        editedContact.id = 7793
        editedContact.firstName = "test"
        editedContact.lastName = "case"
        editedContact.phoneNumber = "9999912123"
        editedContact.email = "test@sample.com"
        editedContact.updateContact { (updatedContact, isUpdated) in
            if isUpdated{
                editedContactExpectation.fulfill()
                XCTAssertTrue(isUpdated, "Server responded with updated contact")
            }else{
                XCTFail("Contact can't be edited")
            }
            XCTAssertEqual(editedContact.id ?? 0, updatedContact.id ?? 0, "Contact updated Successfully")
        }
        
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertNoThrow(editedContact, "Contact from server")
        }
    }
    
    func testAddContactFlow(){
        let createdContactExpectation: XCTestExpectation = expectation(description: "Contact created")
        let contactToBeAdded: Contact = Contact()
        contactToBeAdded.firstName = "test"
        contactToBeAdded.lastName = "case"
        contactToBeAdded.phoneNumber = "9999912123"
        contactToBeAdded.email = "test@sample.com"
        contactToBeAdded.createContact { (updatedContact, isCreated) in
            if !isCreated{
                XCTFail("Contact can't be created")
            }else{
                createdContactExpectation.fulfill()
                XCTAssertTrue(isCreated, "Contact created")
            }
        }
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertNoThrow(contactToBeAdded, "Contact from server")
        }
        
    }

}
