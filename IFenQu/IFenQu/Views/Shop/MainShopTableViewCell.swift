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
    ///底部高度
    var footerHeight: CGFloat = 0
    ///顶部视图
    var headerLable: IButton!
    
    ///collectioncell的宽度
    var cellWidth = SCREEN_Width/5*2
    ///当前本cell的总高度
    var cellHeight: CGFloat = 0
    ///
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    ///点击了collectionViewCell调用，把cell展示到模型数据传过去
    var didSelectItem: ((Any) -> ())?
    ///cell的偏移
    var offSet = CGFloat(5)
    
    ///滚动方向
    var dirction: UICollectionViewScrollDirection = .horizontal {
        didSet{
            let cHeight = cellHeight - headerHeight - offSet
            
            layout.scrollDirection = dirction
            if dirction == .vertical {
                cellWidth = SCREEN_Width/2
                layout.itemSize = CGSize.init(width: cellWidth, height: cHeight/5)
                footerHeight = 40
            } else {
                cellWidth = SCREEN_Width/5*2
                layout.itemSize = CGSize.init(width: cellWidth, height: cHeight)
                footerHeight = 0
            }
            collectionView.isScrollEnabled = dirction != .vertical
            collectionView.height = cHeight + footerHeight
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        initSubView()
    }

    
    ///初始化子视图
    func initSubView() {
        
        headerLable = IButton.init(frame: CGRect.init(x: 0, y: offSet, width: SCREEN_Width, height: headerHeight))
        headerLable.titleLable.font = UIFont.systemFont(ofSize: 12)
        headerLable.backgroundColor = UIColor.white
        
        self.contentView.addSubview(headerLable)
        
        
        let cHeight = cellHeight - headerHeight - offSet
        layout = UICollectionViewFlowLayout.init()
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: headerLable.frame.maxY, width: SCREEN_Width, height: cHeight), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cHeight = cellHeight - headerHeight - offSet
        if cellHeight > 260 {
            layout.itemSize = CGSize.init(width: cellWidth, height: (cHeight - 40)/5)
        
        } else {
            layout.itemSize = CGSize.init(width: cellWidth, height: cHeight)
        }
        
        headerLable.frame = CGRect.init(x: 0, y: offSet, width: SCREEN_Width, height: headerHeight)
        
        collectionView.frame = CGRect.init(x: 0, y: headerLable.frame.maxY, width: SCREEN_Width, height: cHeight)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
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
        dirction = scrollDirection
        
    }
}

extension MainShopTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
        
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

