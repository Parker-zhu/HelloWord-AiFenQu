//
//  DiscoverViewController.h
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let vi = SlideshowView.init(frame: self.view.bounds)
//        self.view.addSubview(vi)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loginVc = ReceiverInfoViewController()
        self.navigationController?.pushViewController(loginVc, animated: true)
        
    }


}
