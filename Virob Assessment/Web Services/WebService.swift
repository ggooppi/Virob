//
//  WebService.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class Webservice: NSObject {
    
    //MARK: Properties
    static let shared = Webservice()
    
    private var requestURL: (String)->String = { endpoint in
        return "\(kBaseURL)\(endpoint)"
    }
    
    private override init() {}

    func networkCall(endpoint: String, completionHandler: @escaping ((Bool, [String:Any]?, String?) -> Void)) -> Void {
        
        Alamofire.request(requestURL(endpoint), method: .post, headers: kHeader)
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let responseObject = response.result.value as? [String:Any]{
                        completionHandler(true, responseObject, nil)
                    }
                case .failure(_):
                    completionHandler(false, nil, "Something Went Wrong")
                }
        }
        
    }

}
