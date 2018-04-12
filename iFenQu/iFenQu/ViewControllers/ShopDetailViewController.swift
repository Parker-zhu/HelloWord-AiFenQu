//
//  ShopDetailViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/12.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品详情
import UIKit

class ShopDetailViewController: BaseViewController {

    lazy var contentScrollView = { () -> UIScrollView in
        let scroll = UIScrollView.init(frame: self.view.bounds)
        scroll.contentSize = CGSize.init(width: SCREEN_Width, height: self.view.height)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        scroll.backgroundColor = UIColor.clear
        return scroll
    }()
    
    lazy var slideView = { () -> SlideshowView in 
        let slide = SlideshowView.slideshowViewWithFrame(CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 400), imageURLPaths: ["MacBook Pro 新款15寸 3 mbl","MacBook Pro 新款15寸 3 mbl","MacBook Pro 新款15寸 3 mbl"], titles: nil, didSelectItemAtIndex: { (index) in
            
        })
        slide.imageViewContentMode = .scaleAspectFit
        slide.pageControlCurrentPageColor = UIColor.black
        slide.pageControlBottom = 40
        slide.autoScrollTimeInterval = 0
        slide.backgroundColor = UIColor.white
        contentScrollView.addSubview(slide)
        return slide
    }()
    
    lazy var shopNameLable = { () -> UILabel in
        let lable = UILabel.init()
        contentScrollView.addSubview(lable)
        lable.numberOfLines = 0
        lable.backgroundColor = UIColor.white
        lable.textColor = UIColor.darkGray
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MacBook Pro 新款15寸 3 mbl"
        self.view.backgroundColor = xlightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "share"), style: .done, target: self, action: #selector(share))
        shopNameLable.text = "MacBook Pro 新款15寸 3 mblMacBook Pro 新款15寸 3 mbl"
        shopNameLable.mas_makeConstraints { (make) in
            make?.top.equalTo()(slideView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)?.offset()(20)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.height.equalTo()(shopNameLable.text!.getTextSize(font: 14, size: CGSize.init(width: SCREEN_Width - 40, height: 500)).height + 40)
            
        }
    }

    @objc func share() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
