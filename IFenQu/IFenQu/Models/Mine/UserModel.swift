//
//  UserModel.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/20.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///用户模型
import UIKit

class UserModel: NSObject {
    var userId: String?
    var headImage: String?
    var userName: String?
    
    var mobile: String?
    var signature: String?
    var birthday: String?
    
    var subscribe: String?
    var nickName: String?
    var userType: String?
    
    
    class func initWithDic(dic: [String : Any]) -> UserModel {
        let user = UserModel()
        user.userId = dic["userId"] as? String ?? ""
        user.headImage = dic["headImage"] as? String ?? ""
        user.userName = dic["userName"] as? String ?? ""
        
        user.mobile = dic["mobile"] as? String ?? ""
        user.signature = dic["signature"] as? String ?? ""
        user.birthday = dic["birthday"] as? String ?? ""
        
        user.subscribe = dic["subscribe"] as? String ?? ""
        user.nickName = dic["nickName"] as? String ?? ""
        user.userType = dic["userType"] as? String ?? ""
        return user
    }
}
