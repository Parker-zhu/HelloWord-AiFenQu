//
//  OrderViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/26.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///我的订单
import UIKit

class OrderViewController: BaseViewController {

    var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        initTableView()
    }

    func initTableView() {
        contentTableView = UITableView.init(frame:self.view.bounds, style: .plain)
        contentTableView.backgroundColor = xlightGray
        contentTableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.rowHeight = 180
        
        self.view.addSubview(contentTableView)
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
extension OrderViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
