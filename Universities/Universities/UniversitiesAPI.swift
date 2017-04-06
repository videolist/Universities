//
//  UniversitiesAPI.swift
//  Universities
//
//  Created by Vadim on 4/6/17.
//  Copyright © 2017 Digital Prunes. All rights reserved.
//

import Foundation
import Alamofire

class UniversitiesAPI {
    
    enum fields: String {
        case name = "name"
        case country = "country"
        case webPage = "web_page"
        case countryCode = "alpha_two_code"
        case domain = "domain"
    }
    
    static func getUniversities(with filter:[fields:String]? = nil, completionHandler: ((Bool) -> Void)? = nil) {
        
        // Fetch Request
        var url = "http://universities.hipolabs.com/search"
        if filter != nil {
            var separator = "?"
            for (field,value) in filter! {
                url += "\(separator)\(field.rawValue)=\(value)"
                separator = "&"
            }
        }
        
        print("url: \(url)")
        
        RealmUniversity.deleteAll()
        Alamofire.request(url, method: HTTPMethod.get)
            .validate(statusCode: 200..<201)
            .responseJSON { response in
                print("error \(response.result.error)")
                if (response.result.error == nil) {
                    if let jsonArray = response.result.value as? [[String:String]] {
                        let queue = OperationQueue()
                        queue.maxConcurrentOperationCount = 1
                        for info in jsonArray {
                            queue.addOperation {
                                 let _ = RealmUniversity.update(from: info)?.persist()
                            }
                        }
                        completionHandler?(true)
                    } else {
                        completionHandler?(false)
                    }
                } else {
                    completionHandler?(false)
                }
        }
    }

}
