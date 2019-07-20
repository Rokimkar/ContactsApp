//
//  ContactsEndpoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct ContactsEndPoint: EndPoint{
    var path: String{
        return "contacts.json"
    }
    
    var method: RequestMethod{
        return .GET
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var parameters: [String : String]?{
        return nil
    }
}
