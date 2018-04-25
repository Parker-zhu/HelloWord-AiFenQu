//
//  BaseTabBarViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubVcStatus(vc: ShopViewController(), imageName: "Group 623", selectImageName: "Group 626", title: "商城")
        
        self.initSubVcStatus(vc: MessageViewController(), imageName: "message icon", selectImageName: "message02", title: "消息")
        
        self.initSubVcStatus(vc: MineViewController(), imageName: "Group 627", selectImageName: "Group 625", title: "我的")
        
    }
    
    /// 初始化子控制器的基本设置
    ///
    /// - Parameters:
    ///   - vc: 控制器
    ///   - imageName: 普通状态下的图片名字
    ///   - selectImageName: 选中状态的图片名字
    ///   - title: tabbar上的名字
    private func initSubVcStatus(vc: UIViewController,imageName: String,selectImageName: String,title: String) {
        
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectImageName)
        vc.tabBarItem.title = title
        self.addChildViewController(BaseNavigationController.init(rootViewController: vc))
    }
    

}
