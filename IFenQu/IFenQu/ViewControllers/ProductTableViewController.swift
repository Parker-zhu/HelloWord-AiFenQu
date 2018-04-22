//
//  ProductTableViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ProductTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var shopModel = [ShopModel]()
    
    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.rowHeight = 160
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = xlightGray
        table.register(UINib.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "产品列表"
        openLoadingStatus = true
        loadData()
    }

    
    func loadData() {
        Network.dataRequest(url: Url.getProducts(), param: nil, reqmethod: .GET) { (result) in
            if let data = result?.responseDic["data"] as? [[String:Any]] {
                self.openLoadingStatus = false
            for model in data {
                self.shopModel.append(ShopModel.deserialize(from: model)!)
            }
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopModel.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell

        
        cell.setModel(model: shopModel[indexPath.row])
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
