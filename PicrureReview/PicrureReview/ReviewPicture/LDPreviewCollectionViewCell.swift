//
//  LDPreviewCollectionViewCell.swift
//  PicrureReview
//
//  Created by Artron_LQQ on 2017/5/8.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

let LD_PEVIEWCELL_REUSEID = "LDPreviewCollectionViewCell"
class LDPreviewCollectionViewCell: UICollectionViewCell {
    
    var page: String {
        
        didSet {
            
            self.pageLabel.text = page
        }
    }
    
    var image: String {
        
        didSet {
            
            self.imageView.image = UIImage.init(named: image)
        }
    }
    
    lazy var imageView: UIImageView = {
        
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        self.addSubview(img)
        
        img.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(self).offset(-12)
        })
        return img
    }()
    
    private lazy var pageLabel: UILabel = {
        
        let label = UILabel.init()
        
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self.imageView.snp.bottom)
        })
        return label
    }()
    
    override init(frame: CGRect) {
        
        self.page = "0"
        self.image = ""
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
