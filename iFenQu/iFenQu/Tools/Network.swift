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
        var resultData: (code: Int, responseDic: [String: Any]) = (0,["":""])
        
        let afn = AFHTTPSessionManager.init(baseURL: nil)
        afn.requestSerializer.timeoutInterval = 15
//        afn.responseSerializer.acceptableContentTypes = ["text/html"]
        afn.requestSerializer.setValue("application/json", forHTTPHeaderField: "content-type")
        var error: NSError?

        let request =  afn.requestSerializer.request(withMethod: reqmethod.rawValue, urlString: url, parameters: param, error: &error)
        let dataTask = afn.dataTask(with: request as URLRequest) { (serverResponse: URLResponse, response: Any?, error: Error?) in
            if error == nil {
                
                resultData.code = 1
                resultData.responseDic = response as! [String: Any]
                callBack(resultData)
            }
        }
        dataTask.resume()
        
    }
    
    class func dataRequest(header: String,url:String,param:[String:Any]?,reqmethod:ReqMethod,callBack: @escaping (_ result: (code: Int, responseDic: [String: Any])?) -> Void) {
        
        var resultData: (code: Int, responseDic: [String: Any]) = (0,["":""])
        
        let afn = AFHTTPSessionManager.init(baseURL: nil)
        
        afn.requestSerializer.timeoutInterval = 15
        //        afn.responseSerializer.acceptableContentTypes = ["text/html"]
        afn.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        afn.requestSerializer.setValue(header, forHTTPHeaderField: "Ifenqu-Validate")
        
//        afn.requestSerializer.setValue("account.ifenqu.com", forHTTPHeaderField: "authority")
//        afn.requestSerializer.setValue("application/json", forHTTPHeaderField: "accept")
//        afn.requestSerializer.setValue("zh-CN,zh", forHTTPHeaderField: "Accept-Language")
        var error: NSError?
        
        let request =  afn.requestSerializer.request(withMethod: reqmethod.rawValue, urlString: url, parameters: param, error: &error)
        let dataTask = afn.dataTask(with: request as URLRequest) { (serverResponse: URLResponse, response: Any?, error: Error?) in
            if error == nil {
                
                resultData.code = 1
                resultData.responseDic = response as! [String: Any]
                callBack(resultData)
            }
        }
        dataTask.resume()
        
    }
}
