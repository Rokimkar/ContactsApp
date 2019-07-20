//
//  NetworkManager.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import Alamofire


public typealias responseData<T:Codable> = (T)->Void

class NetworkManager{
    class func fetchData<T:Codable>(endPoint: EndPoint, success: @escaping responseData<T>, failure: @escaping (Error)-> Void){
        let url: String = endPoint.baseUrl + endPoint.path
        Alamofire.request(url, method: endPoint.requestMethod, parameters: endPoint.parameters, encoding: JSONEncoding.default, headers: endPoint.headers).responseData{ (data) in
            if let data = data.result.value{
                JsonSerialiser.serialiseData(data: data, success: { (serialisedItem : T?) in
                    if let _ = serialisedItem{
                        success(serialisedItem!)
                    }else{
                        failure(NSError.init(domain: "Item is nil while serialising", code: 0, userInfo: ["source":"network"]))
                    }
                }, failure: { (error: Error) in
                    failure(error)
                })
            }else{
                
            }
        }
    }
}
