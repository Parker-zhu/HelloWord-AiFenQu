//
//  MineHeaderView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/9.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(red: 255/255, green: 209/255, blue: 0, alpha: 1)
        //背景Image
        let imageView = UIImageView.init(frame: self.bounds)
        imageView.image = UIImage.init(named: "")
        self.addSubview(imageView)
        //头像
        let headImage = UIImageView.init()
        headImage.image = UIImage.init(named: "timg (1)")
        self.addSubview(headImage)
        headImage.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.mas_left)?.offset()(20)
            make?.bottom.equalTo()(self.mas_bottom)?.offset()(-20)
            make?.width.equalTo()(60)
            make?.height.equalTo()(60)
        }
        //btn
        let btn = XButton.init()
        self.addSubview(btn)
        btn.setTitle("登陆/注册", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage(UIImage.init(named: "path"), for: .normal)
        btn.position = .centerLeft
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.mas_makeConstraints { (make) in
            make?.left.equalTo()(headImage.mas_right)?.offset()(20)
            make?.centerY.equalTo()(headImage.mas_centerY)
            make?.width.equalTo()(btn.titleLabel!.text!.getTextSize(font: 14, size: CGSize.init(width: SCREEN_Width, height: 40)).width + 20)
            make?.height.equalTo()(40)
        }
        weak var weakSelf = self
        btn.block = {
            weakSelf?.findVc(vc: self)?.navigationController?.present(LoginViewController(), animated: true, completion: nil)
        }
        
        let quit = UIButton.init()
        self.addSubview(quit)
        quit.setImage(UIImage.init(named: "Group 618"), for: .normal)
        quit.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.mas_right)?.offset()(-20)
            make?.top.equalTo()(self.mas_top)?.offset()(40)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        
        let q = UIButton.init()
        self.addSubview(q)
        q.setImage(UIImage.init(named: "Group 618"), for: .normal)
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
            findVc(vc: vc.superview!)
            print(vc)
        }
        return nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
