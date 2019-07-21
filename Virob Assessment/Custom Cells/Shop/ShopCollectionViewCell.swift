//
//  ShopCollectionViewCell.swift
//  Virob Assessment
//
//  Created by gopinath.a on 21/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var shopNmae: UILabel!
    @IBOutlet weak var offer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(shopDetail: Data) -> Void {
        if let URL = URL(string: shopDetail.logo){
            imageView.af_setImage(withURL: URL)
        }
        shopNmae.text = shopDetail.store_name
        offer.text = "Offer: \(shopDetail.offer)"
    }

}
