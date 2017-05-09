//
//  LDPreviewViewController.swift
//  PicrureReview
//
//  Created by Artron_LQQ on 2017/5/5.
//  Copyright © 2017年 Artup. All rights reserved.
//
/*
 横屏后状态栏消失, 如果想显示, 需要在Info.plist文件内添加字段
 View controller-based status bar appearanc
 
 类型为bool, 值为 YES
 */

import UIKit

class LDPreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var isNavigationBarHidden = true
    
    var dataSources: Array<String> = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg"]
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
//        layout.itemSize = CGSize.init(width: 100, height: 100)
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        self.view.addSubview(collection)
        
        collection.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(64)
        })
        return collection
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.navigationController?.isNavigationBarHidden)! == false {
            
            self.navigationController?.isNavigationBarHidden = true
            isNavigationBarHidden = false
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if !isNavigationBarHidden {
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        
        self.collectionView.register(LDPreviewCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: LD_PEVIEWCELL_REUSEID)
        self.topView()
    }

    func topView() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(64)
        }
        
        let backBtn = UIButton.init(type: .custom)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        bgView.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(bgView)
            make.top.equalTo(20)
            make.width.equalTo(backBtn.snp.height)
        }
        
        let previewButton = UIButton.init(type: .custom)
        previewButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        previewButton.setTitle("预览", for: .normal)
        previewButton.setTitleColor(UIColor.white, for: .normal)
        previewButton.addTarget(self, action: #selector(previewButtonClick), for: .touchUpInside)
        bgView.addSubview(previewButton)
        previewButton.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.right.equalTo(bgView)
            make.width.equalTo(previewButton.snp.height)
        }
        
    }
    
    func backButtonClick() {
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        if let nav = self.navigationController {
            
            nav.popViewController(animated: true)
        }
    }
    
    func previewButtonClick() {
        let book = LDBookViewController()
        book.dataSource = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg"]
        self.navigationController?.pushViewController(book, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LD_PEVIEWCELL_REUSEID, for: indexPath) as! LDPreviewCollectionViewCell
        
        cell.backgroundColor = UIColor.red
        cell.page = "\(indexPath.row)"
        cell.image = self.dataSources[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        print("[\(self.debugDescription) success deinit]")
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
