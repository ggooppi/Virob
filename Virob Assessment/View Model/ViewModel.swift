//
//  ViewModel.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper

class ViewModel: NSObject {
    
    var popular = Popular()
    
    var selectedCategory = "popular"
    
    func getPopularListWithCategory(completionHandler: @escaping (_ status:Bool, _ error: String?) -> Void) -> Void {
        
        Webservice.shared.networkCall(endpoint: selectedCategory) { (status, response, error) in
            if status{
                if let response = response {
                    self.popular = Mapper<Popular>().map(JSONObject: response)!
                    completionHandler(true, nil)
                }else{
                    completionHandler(false, error)
                }
            }else{
                completionHandler(false, error)
            }
        }
        
    }
    
    func getShops(completionHandler: @escaping (_ status:Bool, _ error: String?) -> Void) -> Void {
        
        Webservice.shared.networkCall(endpoint: selectedCategory) { (status, response, error) in
            if status{
                if let response = response {
                    let data = Mapper<Popular>().map(JSONObject: response)!
                    self.popular.data = data.data
                    completionHandler(true, nil)
                }else{
                    completionHandler(false, error)
                }
            }else{
                completionHandler(false, error)
            }
        }
        
    }
}
