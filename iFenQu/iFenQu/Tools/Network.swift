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
enum ResponseSerializerType {
    case responseHttp,responseJson
}

class Network {
    
    class func dataRequest(url:String,param:[String:Any]?,reqmethod:ReqMethod,callBack: @escaping (_ result: (code: Int, responseDic: [String: Any])?) -> Void) {
        dataRequest(header: nil, url: url, param: param, reqmethod: reqmethod, callBack: callBack)
        
    }
    
    class func dataRequest(header: (header:String,content:String)?,url:String,param:[String:Any]?,reqmethod:ReqMethod,responseSerializerType:ResponseSerializerType = .responseJson,callBack: @escaping (_ result: (code: Int, responseDic: [String: Any])?) -> Void) {
        
        var resultData: (code: Int, responseDic: [String: Any]) = (0,["":""])
        
        let net = AFNetworkReachabilityManager.shared()
        if net.networkReachabilityStatus == .notReachable {
            Hud.showError(text: "网络不可用")
            callBack(resultData)
            return
        }
        
        let afn = AFHTTPSessionManager.init(baseURL: nil)
        
        afn.requestSerializer = AFJSONRequestSerializer.init()
        
        switch responseSerializerType {
        case .responseHttp:
            afn.responseSerializer = AFHTTPResponseSerializer.init()
        default:
            afn.responseSerializer = AFJSONResponseSerializer.init()
        }
        
        afn.requestSerializer.timeoutInterval = 15
        afn.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if header != nil {
            afn.requestSerializer.setValue(header!.content, forHTTPHeaderField: header!.header)
        }
        
        afn.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json","text/json","text/javascript","text/html") as? Set<String>
        var error: NSError?
        
        let request =  afn.requestSerializer.request(withMethod: reqmethod.rawValue, urlString: url, parameters: param, error: &error)
        let dataTask = afn.dataTask(with: request as URLRequest) { (serverResponse: URLResponse, response: Any?, error: Error?) in
            if error == nil {
                
                resultData.code = 1
                if let responseData = response as? [String: Any] {
                    resultData.responseDic = responseData
                    callBack(resultData)
                }
                
                if let responseData = response as? Data {
                    if let dict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String:Any] {
                        if dict != nil {
                        resultData.responseDic = dict!
                        callBack(resultData)
                        }
                    }
                }
            }
            
        }
        dataTask.resume()
    }
    
}
