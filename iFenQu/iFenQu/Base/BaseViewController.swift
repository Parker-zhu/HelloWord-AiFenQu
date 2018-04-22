//
//  BaseViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //在主界面隐藏navBar
        if self is ShopViewController || self is MineViewController{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 14)]
        // Do any additional setup after loading the view.
    }
    ///开启
    var loadingView:LoadingView?
    
    var openLoadingStatus = false {
        didSet{
            if openLoadingStatus {
                loadingView = LoadingView.init(frame: self.view.bounds)
                loadingView?.loading()
                self.view.addSubview(loadingView!)
            }
            else {
                loadingView?.removeFromSuperview()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    deinit {
        print(self)
    }
    
}
