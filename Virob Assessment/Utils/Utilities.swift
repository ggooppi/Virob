//
//  Utilities.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class Utilities: NSObject {
    
}

// MARK: - UIVIew Properties
extension UIView{
    
    func applyShadow(cornerRadius: CGFloat?, color: UIColor?, opacity: Float?, offsetWidth: CGFloat?, offsetHeight: CGFloat?) -> Void {
        self.layer.cornerRadius = (cornerRadius != nil) ? cornerRadius! : CGFloat(3.0)
        self.layer.shadowColor = (color != nil) ? color?.cgColor : UIColor.darkGray.cgColor
        self.layer.shadowOffset = (offsetWidth != nil) ? CGSize(width: offsetWidth!, height: offsetHeight!) : CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = (opacity != nil) ? opacity! : Float(0.3)
        self.layer.shadowRadius = 5.0
        
    }
    
    func roundedCorners(radius: CGFloat) -> Void {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UICollectionView {
    
    func showNoData(title: String, description: String, image: UIImage? = nil, actionTitle: String? = nil, action: (() -> Void)?) -> Void {
        
        let bgView = UIView(frame: self.frame)
        
        let verticalStackView = UIStackView(frame: bgView.frame)
        verticalStackView.distribution = .fillProportionally
        verticalStackView.alignment = .center
        verticalStackView.spacing = 10
        verticalStackView.axis = .vertical
        bgView.addSubview(verticalStackView)
        verticalStackView.center = bgView.center
        
        let topPaddingView = UIView(frame: CGRect.zero)
        topPaddingView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        topPaddingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        verticalStackView.addArrangedSubview(topPaddingView)
        
        
        let noDataImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 180))
        noDataImageView.contentMode = .scaleAspectFit
        if image != nil {
            noDataImageView.image = image
        } else {
            noDataImageView.image = UIImage(named: "noData")
        }
        noDataImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        noDataImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        verticalStackView.addArrangedSubview(noDataImageView)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        verticalStackView.addArrangedSubview(titleLabel)
        
        
        let groupView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width - 40, height: 70))
        groupView.widthAnchor.constraint(equalToConstant: self.frame.width - 40).isActive = true
        groupView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: groupView.frame.width, height: 50))
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .themeLightGrayBlue
        descriptionLabel.numberOfLines = 0
        groupView.addSubview(descriptionLabel)
        descriptionLabel.center.x = groupView.center.x
        
        
        if actionTitle != nil {
            let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: descriptionLabel.frame.width, height: 20))
            actionButton.setTitle(actionTitle!, for: UIControl.State.normal)
            actionButton.titleColor(for: UIControl.State.normal)
            actionButton.setTitleColor(UIColor.themeTextBlue, for: UIControl.State.normal)
            actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            if action != nil {
                actionButton.addAction(for: UIControl.Event.touchUpInside) {
                    action!()
                }
            }
            groupView.addSubview(actionButton)
            actionButton.center = CGPoint(x: groupView.center.x, y: descriptionLabel.frame.maxY)
        }
        
        verticalStackView.addArrangedSubview(groupView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = bgView
        
    }
    
    func hideNoData() -> Void {
        self.backgroundView = nil
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIColor {
    
    @nonobjc class var themeYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var themeLightGrayBlue: UIColor {
        return "8a8a8f".toRGBColor()
    }
    
    
    @nonobjc class var themeTextBlue: UIColor {
        return "0087fc".toRGBColor()
    }
    
    @nonobjc class var themeLightBlue: UIColor {
        return "00c6ce".toRGBColor().withAlphaComponent(0.3)
    }
    
}
extension String {
    
    func toRGBColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
