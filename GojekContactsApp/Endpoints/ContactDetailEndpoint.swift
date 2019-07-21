//
//  ContactDetailEndpoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 21/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct ContactDetailEndpoint: EndPoint {
    var path: String{
        return "contacts/\(contactId).json"
    }
    
    var method: RequestMethod{
        return .GET
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var parameters: [String : Any]?{
        return nil
    }
    
    var contactId: Int
}
