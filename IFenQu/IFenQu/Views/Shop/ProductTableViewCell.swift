//
//  ProductTableViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var describeLable: UILabel!
    @IBOutlet weak var tagView: UIView!
    var timeLable: UILabel!
    var totalPriceLable: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    var minPriceLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productImageView.contentMode = .scaleToFill
        // Initialization code
        
        minPriceLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: priceView.height))
        minPriceLable.textColor = UIColor.red
        
        priceView.addSubview(minPriceLable)
        
        timeLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: priceView.height))
        timeLable.text = "12期"
        let timeHeight = "12期".getTextSize(font: 10, size: CGSize.init(width: SCREEN_Width, height: SCREEN_Height)).height + 4
        timeLable.height = timeHeight
        timeLable.textAlignment = .center
        timeLable.font = UIFont.systemFont(ofSize: 10)
        timeLable.textColor = UIColor.red
        timeLable.layer.borderWidth = 1
        timeLable.layer.borderColor = UIColor.red.cgColor
        timeLable.layer.cornerRadius = timeHeight/2
        timeLable.layer.masksToBounds = true
        
        timeLable.center = minPriceLable.center
        priceView.addSubview(timeLable)
        
        
        totalPriceLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: priceView.height))
        totalPriceLable.textColor = UIColor.lightGray
        totalPriceLable.font = UIFont.systemFont(ofSize: 10)
        priceView.addSubview(totalPriceLable)
    }

    func setModel(model:ShopModel) {
        
        describeLable.text = model.productName
        let minText = "¥\(((model.totalPrice ?? 0)/12))" + "起"
        minPriceLable.adjustSize(title: minText, newFont: 14)
        let minWidth = minText.getTextSize(font: 14, size: CGSize.init(width: SCREEN_Width, height: priceView.height)).width
        minPriceLable.width = minWidth
        timeLable.x = minWidth
        
        let totalPriceText = "总价:" + "¥\(model.totalPrice ?? 0)起"
        totalPriceLable.text = totalPriceText
        totalPriceLable.width = totalPriceText.getTextSize(font: 12, size: CGSize.init(width: SCREEN_Width, height: priceView.height)).width
        totalPriceLable.x = timeLable.frame.maxX + 10
        if let url = URL.init(string: model.url ?? "") {
            productImageView.setImageWith(url, placeholderImage: nil)
        }
        
        
        
    }
}
