//
//  UpdateContactEndpoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 21/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct UpdateContactEndpoint: EndPoint {
    var path: String{
        return "contacts/\(contactId).json"
    }
    
    var method: RequestMethod{
        return .PUT
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var parameters: [String : Any]?{
        return appendedParameters
    }
    
    var contactId: Int
    var appendedParameters: [String:Any]
    
    
}
