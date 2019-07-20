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
        let urlString: String = endPoint.baseUrl + endPoint.path
        
        if let url = URL(string: urlString){
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = endPoint.method.getAssociatedMethod()
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            if let appendedParameters = endPoint.parameters {
                let jsonData = try? JSONSerialization.data(withJSONObject: appendedParameters)
                request.httpBody = jsonData
            }
            SessionManager.default.request(request).responseData { (data) in
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
}
