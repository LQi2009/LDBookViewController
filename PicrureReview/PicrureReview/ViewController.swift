//
//  ViewController.swift
//  PicrureReview
//
//  Created by Artron_LQQ on 2017/5/5.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        let but = UIButton.init(type: .custom)
        
        but.backgroundColor = UIColor.red
        but.frame = CGRect.init(x: 100, y: 100, width: 100, height: 40)
        but.setTitle("打开", for: .normal)
        but.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        self.view.addSubview(but)
        
        
//        but.snp.makeConstraints { (make) in
//            make.width.equalTo(but.snp.height).multipliedBy(2)
//        }
    }

    
    func buttonClick() {
        
        let preview = LDPreviewViewController()
        
        
        self.navigationController?.pushViewController(preview, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

