//
//  LDBookViewController.swift
//  PicrureReview
//
//  Created by Artron_LQQ on 2017/5/5.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

class LDBookViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var dataSource: Array<String> = [] {
        
        didSet {
            
            self.resetData()
        }
    }
    
    private var dataContent: Array<LDBookPreViewModel> = []
    private var isNavigationBarHidden = true
    private lazy var pageViewController: UIPageViewController = {
        
        let page = UIPageViewController.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey: NSNumber(value: UIPageViewControllerSpineLocation.mid.rawValue)])
        
        page.dataSource = self
        page.delegate = self
        page.view.backgroundColor = UIColor.red
        self.addChildViewController(page)
        self.view.addSubview(page.view)
        page.didMove(toParentViewController: self)
        page.view.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(70)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-6)
            make.width.equalTo(page.view.snp.height).multipliedBy(2)
        })
        return page
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
        self.topView()
        
        let vc1 = LDContentBookViewController()
        vc1.bookModel = self.dataContent[0]
        
        let vc2 = LDContentBookViewController()
        vc2.addShadow()
        vc2.bookModel = self.dataContent[1]
        
        self.pageViewController.setViewControllers([vc1, vc2], direction: .forward, animated: false) { (finished) in  }
    }
    
    /* 重置数据源
     1. 数据源数组只能是偶数, 不是偶数的要填充空白页, 使之为偶数
     2. 为达到实际书本预览效果, 需要插入空白页来形成书本
     */
    func resetData() {
        if self.dataContent.count > 0 {
            self.dataContent.removeAll()
        }
        
        var index = 0
        for str in self.dataSource {
            
            index += 1
            let model = LDBookPreViewModel()
            model.imageString = str
            model.page = "第-\(index)-页"
            
            self.dataContent.append(model)
        }
        
        if self.dataContent.count % 2 == 1 {
            // 奇数: 填充5页
            let model1 = LDBookPreViewModel()
            self.dataContent.insert(model1, at: 0)
            
            let model2 = LDBookPreViewModel()
            model2.page = "封皮"
            self.dataContent.insert(model2, at: 1)
            
            let model3 = LDBookPreViewModel()
            self.dataContent.insert(model3, at: 2)
            
            let model4 = LDBookPreViewModel()
            model4.page = "封底"
            self.dataContent.append(model4)
            
            let model5 = LDBookPreViewModel()
            self.dataContent.append(model5)
        } else {
            // 偶数: 填充6页
            let model1 = LDBookPreViewModel()
            self.dataContent.insert(model1, at: 0)
            
            let model2 = LDBookPreViewModel()
            model2.page = "封皮"
            self.dataContent.insert(model2, at: 1)
            
            let model3 = LDBookPreViewModel()
            self.dataContent.insert(model3, at: 2)
            
            let model4 = LDBookPreViewModel()
            self.dataContent.append(model4)
            
            let model5 = LDBookPreViewModel()
            model5.page = "封底"
            self.dataContent.append(model5)
            
            let model6 = LDBookPreViewModel()
            self.dataContent.append(model6)
        }
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
        
        let titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = "预览"
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(0)
            make.centerX.equalTo(bgView)
            make.width.equalTo(50)
        }
    }
    
    func backButtonClick() {
        
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.dataContent.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let sourceVC = viewController as! LDContentBookViewController
        
        var index: Int = self.dataContent.index(of: sourceVC.bookModel)!
//        var index = self.dataContent.index{$0.imageString == sourceVC.bookModel.imageString}
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        
        let vc = LDContentBookViewController()
        vc.bookModel = self.dataContent[index]
        if index > 0 {
            vc.addShadow()
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let sourceVC = viewController as! LDContentBookViewController
        
        var index: Int = self.dataContent.index(of: sourceVC.bookModel)!
        
        if index == self.dataContent.count - 1 || index == NSNotFound {
            return nil
        }
        
        index += 1
        
        let vc = LDContentBookViewController()
        vc.bookModel = self.dataContent[index]
        if index != self.dataContent.count - 1 {
            vc.addShadow()
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        pageViewController.view.isUserInteractionEnabled = false
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            pageViewController.view.isUserInteractionEnabled = true
        }
    }
    
//    //设置设备支持方向
//    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
//        return .all
//    }
//    //设置优选方向
//    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
//        return .portrait
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - 设置横屏显示, 且不支持自动旋转
    // 不能自动旋转
    override var shouldAutorotate: Bool {
        
        return false
    }
    // 仅支持横屏
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .landscape
    }
// MARK: - 重写状态栏属性, 设置状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
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

// MARK: - 内容控制器, 根据自己UI自定义
fileprivate class LDContentBookViewController: UIViewController {
    
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
}

// MARK: - 内部使用的model
fileprivate class LDBookPreViewModel: Equatable {
    
    var imageString: String = ""
    var page: String = ""
    // 唯一标识符, 只作为比较使用
    lazy var id: String = {
        
        let date = Date.init()
        
        let time = date.timeIntervalSince1970
        
        return "\(time)"
    }()
}
// MARK: - 按照model的id进行比较
fileprivate func ==(m0: LDBookPreViewModel, m1: LDBookPreViewModel) -> Bool {
    return m0.id == m1.id
}
