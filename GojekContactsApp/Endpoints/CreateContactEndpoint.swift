//
//  CreateContactEndpoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 22/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct CreateContactEndpoint: EndPoint {
    var path: String{
        return "contacts.json"
    }
    
    var method: RequestMethod{
        return .POST
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var parameters: [String : Any]?{
        return appendedParameters
    }
    
    var appendedParameters: [String : Any]?
}
