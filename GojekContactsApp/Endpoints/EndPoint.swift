//
//  EndPoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import Alamofire

public enum RequestMethod: String{
    case GET = "get"
    case POST = "post"
}

protocol EndPoint {
    var path: String {get}
    var method: RequestMethod {get}
    var headers : [String : String]? {get}
    var parameters: [String: String]? {get}
}

extension EndPoint {
    var baseUrl: String{
        return "http://gojek-contacts-app.herokuapp.com/"
    }
    
    var requestMethod: HTTPMethod {
        var httpMethod: HTTPMethod = .get
        switch method {
        case .GET:
            httpMethod = .get
        case .POST:
            httpMethod = .post
        }
        return httpMethod
    }
}
