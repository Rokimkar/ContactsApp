//
//  EndPoint.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseUrl: String {get set}
    var path: String {get set}
    var requestMethod: HTTPMethod {get set}
    var headers : [String : String]? {get}
}
