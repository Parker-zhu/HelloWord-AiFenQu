//
//  DiscountCouponViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/26.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///我的优惠券
import UIKit

class DiscountCouponViewController: BaseViewController {

    @IBOutlet weak var contentScrollView: UIScrollView!
    
    var unusedTableView: UITableView!
    var usedTableView: UITableView!
    var passTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的优惠券"
        initSubViews()
        
    }

    func initSubViews() {
        contentScrollView.isPagingEnabled = true
        contentScrollView.contentSize = CGSize.init(width: SCREEN_Width * CGFloat(3), height: 0)
        contentScrollView.backgroundColor = xlightGray
        for i in 0..<3 {
            let tableView = UITableView.init(frame: CGRect.init(x: SCREEN_Width * CGFloat(i), y: 0, width: SCREEN_Width, height: contentScrollView.height))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: "DiscountCouponTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            tableView.rowHeight = 180
            switch i {
            case 0:
                unusedTableView = tableView
            case 1:
                usedTableView = tableView
            default:
                passTableView = tableView
            }
            contentScrollView.addSubview(tableView)
        }
    }
    
    @objc func btnAction(btn:UIButton) {
        
    }
}
extension DiscountCouponViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
