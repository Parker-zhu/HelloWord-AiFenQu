//
//  ShopViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///首页

import UIKit

class ShopViewController: BaseViewController {
    
    var slideView: SlideshowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSlideView()
        
        
    }
    
    ///初始化顶部轮播图
    func initSlideView() {
        
    }
    
    func loadData() {
        let param = ["":""]
        Network.dataRequest(url: "", param: param, reqmethod: .GET) { (result) in
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadData()
    }

}

extension ShopViewController: SlideshowViewDelegate {
    
    func slideshowViewScrollView(_ slideshowView: SlideshowView, didSelectItemIndex index: NSInteger) {
        
    }
}
