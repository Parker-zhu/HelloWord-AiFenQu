//
//  BrandZoneViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/12.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///品牌专区
import UIKit

class BrandZoneViewController: BaseViewController {

    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout.init()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize.init(width: SCREEN_Width/2 - 4, height: 200)
        
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
    
        collection.backgroundColor = UIColor.white
        collection.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        self.view.addSubview(collection)
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "品牌专区"
        collectionView.reloadData()
        // Do any additional setup after loading the view.
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

extension BrandZoneViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
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
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        headerView.backgroundColor = xlightGray
        if headerView.subviews.last is UIButton {
            
        } else {
            let btn = XButton.init(frame:CGRect.init(x: 0, y: 3, width: SCREEN_Width, height: 50))
            btn.setTitle("查看更多", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.block = {
                print("查看更多")
            }
            btn.setImage(UIImage.init(named: "path"), for: .normal)
            btn.position = .centerLeft
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            headerView.addSubview(btn)
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_Width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
