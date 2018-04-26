//
//  ConfirmView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/13.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
protocol ConfirmViewDelegate {
    ///点击确定
    func didConfirm()
}
///商品详情底部确认的视图View

import UIKit


class ConfirmView: UIView {
    @IBOutlet weak var priceTextLable: UILabel!
    
    @IBOutlet weak var priceTexxtLableWidth: NSLayoutConstraint!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var minPriceLable: UILabel!
    
    var delegate: ConfirmViewDelegate?
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didConfirm()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        sureBtn.shadeColor()
        
        timeLable.textColor = UIColor.darkGray
        timeLable.font = UIFont.systemFont(ofSize: 12)
        timeLable.layer.cornerRadius = 2
        timeLable.layer.masksToBounds = true
        timeLable.layer.borderWidth = 0.5
        timeLable.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    ///是否是确定的价格
    private var isFixedPrice = false
    
    ///加载数据
    func loadData(models:[GoodModel]) {
        isFixedPrice = models.count == 1
        var price = models[0].amount!
            for data in models {
                if data.amount!.float() < price.float() {
                    price = data.amount!
                }
                
        }
        priceText = price
        
    }
    
    private var priceText = "" {
        didSet{
            ///处理金额
            var text = "金额 ¥\(priceText.getDecimals())"
            if !isFixedPrice {
                text += "起"
            }
            let attr = NSMutableAttributedString.init(string: text)
            attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: (text as NSString).range(of: priceText.getDecimals()))
            priceTextLable.attributedText = attr
            let minPrice = "\(priceText.float()/12.0)".getDecimals()
            minPriceLable.text = "每期 ¥ \(minPrice)"
            var pwidth = (priceTextLable.text?.getTextSize(font: 18).width)!
            
            if (minPriceLable.text?.getTextSizeB(font: minPriceLable.font).width)! > pwidth - 50 {
                pwidth = (minPriceLable.text?.getTextSizeB(font: minPriceLable.font).width)! + 50
                
            }
            priceTexxtLableWidth.constant = pwidth
        }
    }
}
