//
//  File.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

class JsonSerialiser{
    class func serialiseData <T:Codable> (data : Data,success : (T?) -> Void,failure : (Error) -> Void){
        do {
            let decoder = JSONDecoder()
            let mappedData = try decoder.decode(T.self, from: data)
            success(mappedData)
        }catch{
            failure(NSError.init(domain: "serialisation error", code: 0, userInfo: nil))
        }
    }
}
