//
//  MineHeaderView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/9.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class MineHeaderView: UIView,LoginSuccess {

    var userInfoBtn: IButton!
    var headerImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(red: 255/255, green: 209/255, blue: 0, alpha: 1)
        //背景Image
        let imageView = UIImageView.init(frame: self.bounds)
        imageView.image = UIImage.init(named: "")
        self.addSubview(imageView)
        //头像
        let headImage = UIImageView.init(frame: CGRect.init(x: 20, y: self.height - 70, width: 50, height: 50))
        headImage.backgroundColor = UIColor.white
        
        headImage.image = UIImage.init(named: "people")
        self.addSubview(headImage)
        headImage.layer.cornerRadius = 25
        headImage.layer.masksToBounds = true
        headImage.contentMode = .center
        headerImage = headImage
        
        //btn
        let btn = IButton.init(frame: CGRect.init(x: 90, y: self.height - 70, width: self.width - 110, height: 50))
        self.addSubview(btn)
        btn.titleLable.text = "登陆/注册"
        btn.titleLable.font = UIFont.systemFont(ofSize: 12)
        btn.titleLable.textColor = UIColor.black
        btn.imageView.image = UIImage.init(named: "path")
        btn.positionType = .wl_il
        btn.titleLable.numberOfLines = 0
        userInfoBtn = btn
        weak var weakSelf = self
        btn.targetBlock = {
            let logvc = LoginViewController()
            logvc.delegate = self
            weakSelf?.findVc(vc: self)?.navigationController?.present(logvc, animated: true, completion: nil)
        }
        
        let quit = UIButton.init()
        self.addSubview(quit)
        quit.setImage(UIImage.init(named: "logout"), for: .normal)
        quit.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.mas_right)?.offset()(-20)
            make?.top.equalTo()(self.mas_top)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        quit.block = {
            let alert = AlertView.show(text: "退出登陆", btn1Text: "取消", btn1TextColor: UIColor.red, btn2Text: "确认", btn2TextColor: UIColor.blue, btn2Block: { () -> ()? in
                PopView.disMiss()
                return ()
            })
            PopView.show(view: alert)
            
        }
        
        let q = UIButton.init()
        self.addSubview(q)
        q.setImage(UIImage.init(named: "about"), for: .normal)
        q.mas_makeConstraints { (make) in
            make?.right.equalTo()(quit.mas_left)?.offset()(-20)
            make?.top.equalTo()(self.mas_top)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        q.block = {
            weakSelf?.findVc(vc: self)?.navigationController?.pushViewController(AboutViewController(), animated: true)
        }
        
    }
    func findVc(vc:UIView) -> UIViewController? {
        if vc.viewController != nil && vc.viewController is MineViewController {
            return vc.viewController
        }
        if vc.superview != nil {
            let v = findVc(vc: vc.superview!)
            print(v ?? "")
        }
        return nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loginSuccess(tokenModel: TokenModel) {
        Network.dataRequest(header: ("ifq_access_token",tokenModel.accessToken!), url: Url.getEnvironment() + "account/v1/info", param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [String:Any] else {
                    return
                }
                let user = UserModel.initWithDic(dic: data)
                CacheManager.manager.userModel = user
               let url = URL.init(string: user.headImage!)
                if url != nil {
                    self.headerImage.setImageWith(url!, placeholderImage: nil)
                }
                self.userInfoBtn.titleLable.text = user.nickName! + "\n" + user.mobile!
               
                self.userInfoBtn.positionType = .wl_ir
            }
        }
        
    }
    
}
