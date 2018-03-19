//
//  ImagePageControl.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
import Foundation

class ImagePageControl: UIPageControl {

    
    /// 当前选中点的图片
    open var dotInActiveImage: UIImage?
    
    /// 普通状态点的图片
    open var dotActiveImage: UIImage?
    
    
    override open var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
        
    override open var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    /// 更新 点
    func updateDots() {
        
        for (i,view) in self.subviews.enumerated() {
            var imageView = self.imageView(forSubview: view)
            if imageView == nil {
                if i == 0 {
                    imageView = UIImageView(image: dotInActiveImage)
                } else {
                    imageView = UIImageView(image: dotActiveImage)
                }
                imageView!.center = view.center
                imageView?.frame = CGRect.init(x: view.frame.origin.x, y: view.frame.origin.y+2, width: 8, height: 8)
                view.addSubview(imageView!)
                view.clipsToBounds = false
            }
            
            if i == self.currentPage {
                imageView!.image = dotInActiveImage
            } else {
                imageView!.image = dotActiveImage
            }
        }
    }
    
    ///获取 点 所在的视图
    fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
        
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }
}
