//
//  MainShopTableViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum TitleType {
    case line,cicrl,arrows
}

class MainShopTableViewCell: UITableViewCell {
    ///顶部头高度
    var headerHeight:CGFloat = 30
    var footerHeight: CGFloat = 0
    var headerLable: IButton!
//    lazy var headerLable = { () -> IButton in
//        let lable = IButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: headerHeight))
//        lable.titleLable.font = UIFont.systemFont(ofSize: 12)
//        lable.backgroundColor = UIColor.white
//        self.addSubview(lable)
//        return lable
//    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        initSubView()
    }

    func initSubView() {
        
        headerLable = IButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: headerHeight))
        headerLable.titleLable.font = UIFont.systemFont(ofSize: 12)
        headerLable.backgroundColor = UIColor.white
        
        self.addSubview(headerLable)
        
        let cHeight = cellHeight - headerHeight - offSet
        layout = UICollectionViewFlowLayout.init()
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: headerLable.height, width: SCREEN_Width, height: cHeight + footerHeight), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView)
    }
    var didSelectItem: ((Any) -> ())?
    ///cell的偏移
    var offSet = CGFloat(5)
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    ///滚动方向
    var dirction: UICollectionViewScrollDirection = .horizontal {
        didSet{
            let cHeight = cellHeight - headerHeight - offSet
            if dirction == .vertical {
                cellWidth = SCREEN_Width/2 
            }
            
            layout.scrollDirection = dirction
            if dirction == .vertical {
                layout.itemSize = CGSize.init(width: cellWidth, height: cHeight/5)
                footerHeight = 40
            } else {
                layout.itemSize = CGSize.init(width: cellWidth, height: cHeight)
            }
            collectionView.isScrollEnabled = dirction != .vertical
        }
    }
    ///collectioncell的宽度
    var cellWidth = SCREEN_Width/5*2
    ///cell的高度
    var cellHeight: CGFloat = 0
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
//    lazy var collectionView = { () -> UICollectionView in
//
//        let cHeight = cellHeight - headerHeight - offSet
//        let layout = UICollectionViewFlowLayout.init()
//        layout.scrollDirection = dirction
//        if dirction == .vertical {
//            layout.itemSize = CGSize.init(width: cellWidth, height: cHeight/5)
//            footerHeight = 40
//        } else {
//        layout.itemSize = CGSize.init(width: cellWidth, height: cHeight)
//        }
//        let c = UICollectionView.init(frame: CGRect.init(x: 0, y: headerLable.height, width: SCREEN_Width, height: cHeight + footerHeight), collectionViewLayout: layout)
//        c.isScrollEnabled = dirction != .vertical
//        c.backgroundColor = UIColor.white
//        c.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        c.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
//        c.dataSource = self
//        c.delegate = self
//        c.showsVerticalScrollIndicator = false
//        c.showsHorizontalScrollIndicator = false
//        self.contentView.addSubview(c)
//        return c
//    }()
    
    ///设置数据
    func setModel(model:[Any],title:(String,TitleType),scrollDirection:UICollectionViewScrollDirection,selectModel:@escaping (Any)->()) {
        
        didSelectItem = selectModel
        
        headerLable.titleLable.text = title.0
        
        headerLable.positionType = .wl_c_ir
        
        switch title.1 {
        case .line:
            headerLable.titleLable.drawLine(lineColor: UIColor.darkGray)
        case .cicrl:
            let headerTextWidth = title.0.getTextSizeB(font: headerLable.titleLable.font, size: CGSize.init(width: SCREEN_Width, height: SCREEN_Height)).width
            headerLable.titleLable.width = headerTextWidth + 20
            headerLable.titleLable.layer.cornerRadius = headerLable.titleLable.height/2
            headerLable.titleLable.layer.masksToBounds = true
            headerLable.titleLable.layer.borderWidth = 0.5
            headerLable.titleLable.layer.borderColor = UIColor.lightGray.cgColor
            
            
        default:
            headerLable.titleLable.drawCircle(lineColor: UIColor.lightGray, backColor: UIColor.clear, isDrawArrows: true)
        }
        collectionView.height = cellHeight
        dirction = scrollDirection
        
    }
    
    
}

extension MainShopTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
//        if dirction != nil && dirction == .vertical {
//            cell.setModel(model: nil)
//        } else {
        if self.cellHeight < 200 {
        cell.setModel(model: nil)
        } else {
           cell.setModel(model: "")
        }
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectItem != nil {
            didSelectItem!("aaa")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
        footerView.backgroundColor = xlightGray
        if footerView.subviews.last is UIButton {
            
        } else {
        let btn = IButton.init(frame:CGRect.init(x: 0, y: 1, width: SCREEN_Width, height: footerHeight - 1))
        btn.titleLable.text = "查看更多"
        btn.imageView.image = UIImage.init(named: "path")
        btn.backgroundColor = UIColor.white
        btn.titleLable.font = UIFont.systemFont(ofSize: 12)
        btn.positionType = .wl_c_ir
        footerView.addSubview(btn)
        }
        return footerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.dirction == .vertical {
            return CGSize.init(width: SCREEN_Width, height: footerHeight)
        } else {
            return CGSize.init(width: 0, height: 0)
        }
    }
}

