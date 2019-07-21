//
//  CategoryCollectionViewCell.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        imageView.roundedCorners(radius: self.frame.height/2)
    }
    
    func setupUI(imageURL: String, title: String) -> Void {
        self.title.text = title
        self.imageView.af_setImage(withURL: URL(string: imageURL)!)
    }

}
