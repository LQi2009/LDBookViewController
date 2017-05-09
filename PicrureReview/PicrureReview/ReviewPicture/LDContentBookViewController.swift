//
//  LDContentBookViewController.swift
//  PicrureReview
//
//  Created by Artron_LQQ on 2017/5/8.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

class LDContentBookViewController: UIViewController {
    
    var bookModel: LDBookPreViewModel!{
        
        didSet{
            
            self.imageView.image = UIImage(named: bookModel.imageString)
            self.pageLabel.text = bookModel.page
        }
    }
    
    var backgroundView = UIView()
    
    lazy var imageView: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        img.snp.makeConstraints({ (make) in
            make.top.left.equalTo(self.view).offset(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(self.pageLabel.snp.top).offset(-6)
        })
        
        return img
    }()
    
    lazy var pageLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(12)
        })
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.backgroundView)
        self.backgroundView.backgroundColor = UIColor.white
        self.backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.init(top: 0, left: 0.5, bottom: 0, right: 0.5))
        }
    }

    func addShadow() {
        
//        self.view.layer.shadowColor = UIColor.black.cgColor
//        self.view.layer.shadowOpacity = 0.6
//        self.view.layer.shadowRadius = 1
//        self.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.backgroundView.layer.shadowColor = UIColor.black.cgColor
        self.backgroundView.layer.shadowOpacity = 0.6
        self.backgroundView.layer.shadowRadius = 1
        self.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
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
