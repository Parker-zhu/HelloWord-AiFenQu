//
//  MineHeaderView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/9.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///我的  - 顶部视图
import UIKit

class MineHeaderView: UIView,LoginSuccess {

    private var userInfoBtn: IButton!
    private var headerImage: UIImageView!
    ///用户模型
    private var userModel: UserModel? {
        didSet{
            
            CacheManager.manager.userModel = userModel
            if let url = URL.init(string: userModel!.headImage) {
                self.headerImage.setImageWith(url, placeholderImage: nil)
            }
            self.userInfoBtn.titleLable.text = userModel!.nickName + "\n" + userModel!.mobile
            
            self.userInfoBtn.positionType = .wl_ir
        }
    }
    
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
        btn.titleLable.font = UIFont.systemFont(ofSize: 14)
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
            _ = AlertView.show(text: "确定退出登陆", btn1Text: "取消", btn1TextColor: UIColor.black, btn2Text: "确认", btn2TextColor: xyellow, btn2Block: { () -> ()? in
                PopView.disMiss()
                return ()
            })
        }
        
        let aboutBtn = UIButton.init()
        self.addSubview(aboutBtn)
        aboutBtn.setImage(UIImage.init(named: "about"), for: .normal)
        aboutBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(quit.mas_left)?.offset()(-20)
            make?.top.equalTo()(self.mas_top)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        aboutBtn.block = {
            weakSelf?.findVc(vc: self)?.navigationController?.pushViewController(AboutViewController(), animated: true)
        }
        
    }
    
    private func findVc(vc:UIView) -> UIViewController? {
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
        ///获取用户信息
        Network.dataRequest(header: ("ifq_access_token",tokenModel.accessToken!), url: Url.getEnvironment() + "account/v1/info", param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                guard let data = result?.responseDic["data"] as? [String:Any] else {
                    return
                }
                self.userModel = UserModel.initWithDic(dic: data)
                
            }
        }
        
    }
    
}
