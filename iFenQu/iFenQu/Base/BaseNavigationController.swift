//
//  BaseNavigationController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 30))
            backBtn.addTarget(self, action: #selector(navBack), for: .touchUpInside)
            backBtn.setImage(UIImage.init(named: "Group 635"), for: .normal)
            backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -30, bottom: 0, right: 0)
           viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
            
    }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func navBack() {
        self.popViewController(animated: true)
    }

}
