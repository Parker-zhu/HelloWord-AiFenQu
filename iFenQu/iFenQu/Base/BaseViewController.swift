//
//  BaseViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

enum LoadingStatus {
    case loading,error,normal
}
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
    lazy var loadingView:LoadingView = { () -> LoadingView in
        let view = LoadingView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 80))
        view.center = self.view.center
        
        self.view.addSubview(view)
        return view
    }()
    
    var loadingStatus: LoadingStatus = .normal {
        didSet{
            switch loadingStatus {
            case .normal:
                loadingView.removeFromSuperview()
            case .loading:
                
                loadingView.loading()

            default:
                loadingView.error()

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
