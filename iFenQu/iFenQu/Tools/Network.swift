//
//  Network.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///网络请求

import UIKit
import AFNetworking

enum ReqMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class Network {
    
    class func dataRequest(url:String,param:[String:Any]?,reqmethod:ReqMethod,callBack: @escaping (_ result: (code: Int, responseDic: [String: Any])?) -> Void) {
        
    let afn = AFHTTPSessionManager.init(baseURL: nil)
        afn.requestSerializer.timeoutInterval = 15
        afn.responseSerializer.acceptableContentTypes = ["text/html"]
        var error: NSError?
        let request =  afn.requestSerializer.request(withMethod: reqmethod.rawValue, urlString: url, parameters: param, error: &error)
        let dataTask = afn.dataTask(with: request as URLRequest) { (serverResponse: URLResponse, response: Any?, error: Error?) in
            
        }
        dataTask.resume()
        
    }
}
