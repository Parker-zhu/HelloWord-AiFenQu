//
//  AreaChooesView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/23.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///地址选择视图
protocol AreaChooesViewDelegate {
    func didSelectedArea(area:[String:String])
}
import UIKit

class AreaChooesView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {

    var delegate: AreaChooesViewDelegate?
    
    var pickerView: UIPickerView!
    
    var areaModels = [AreaModel]() {
        didSet{
            pickerView.reloadAllComponents()
        }
    }
    var currentIndex: (one:Int,two:Int,three:Int) = (0,0,0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = xlightGray
        
        let headerLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: 40))
        headerLable.backgroundColor = UIColor.white
        headerLable.text = "选择区域"
        headerLable.textAlignment = .center
        headerLable.font = UIFont.systemFont(ofSize: 14)
        headerLable.textColor = UIColor.darkGray
        self.addSubview(headerLable)
        
        pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: headerLable.frame.maxY + 1, width: frame.width, height: 250))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        self.addSubview(pickerView)
        
        let sureBtn = UIButton.init(frame: CGRect.init(x: 0, y: pickerView.frame.maxY, width: frame.width, height: 49))
        sureBtn.shadeColor()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        self.addSubview(sureBtn)
        
        loadJson()
        
    }
    @objc func sureAction() {
        PopView.disMiss()
        
        let dic = ["provinceName":(areaModels[currentIndex.one].name)!,"cityName":(areaModels[currentIndex.one].sub![currentIndex.two].name)!,"areaName":(areaModels[currentIndex.one].sub![currentIndex.two].sub![currentIndex.three].name)!]
        
        if delegate != nil {
            delegate?.didSelectedArea(area: dic)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadJson() {
        let path = Bundle.main.path(forResource: "openArea", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            /*
             * try 和 try! 的区别
             * try 发生异常会跳到catch代码中
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = jsonData as! [[String:Any]]
            for model in jsonArr {
                self.areaModels.append(AreaModel.deserialize(from: model)!)
            }
            
        } catch let error as Error! {
            print("读取本地数据出现错误!",error)
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if areaModels.count > 0 {
            return 3
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return areaModels.count
        case 1:
            return (areaModels[currentIndex.one].sub?.count)!
        default:
            return (areaModels[currentIndex
                .one].sub![currentIndex.two].sub!.count)
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentIndex = (row,0,0)
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        } else if component == 1 {
            currentIndex.two = row
            currentIndex.three = 0
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        } else {
            currentIndex.three = row
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
//        if component == 0 {
//            return areaModels[row].name
//        } else if component == 1 {
//            return areaModels[currentIndex.one].sub?[row].name
//
//        } else{
//            return areaModels[currentIndex.one].sub![currentIndex.two].sub![row].name
//        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lable = UILabel.init()
        var text = ""
        if component == 0 {
            text = areaModels[row].name!
        } else if component == 1 {
            text = (areaModels[currentIndex.one].sub?[row].name)!
            
        } else{
            text = areaModels[currentIndex.one].sub![currentIndex.two].sub![row].name!
        }
        lable.text = text
        lable.textAlignment = .center
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.systemFont(ofSize: 14)
        return lable
    }
}
