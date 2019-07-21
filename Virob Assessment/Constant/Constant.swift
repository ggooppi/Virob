//
//  Constant.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation

//MARK: API Keys
private let kAccessToken = "usrtoken:74c14fa62349c91c67607d8382656c431eb8e0b6084e0343a0486ff05530df6c705c8bb4"

//MARK: Base URL
let kBaseURL = "http://3.130.85.122/api/v1/user/store/search/"

//MARK: LAT & LNG
private let kLAT = "12.9716"
private let kLNG = "77.5946"

//MARK: Header
var kHeader:[String:String] = [
    "Header": kAccessToken,
    "lat": kLAT,
    "lng":kLNG]

//MARK: Cell
let categoryCollectionViewCell = "CategoryCollectionViewCell"
let shopCollectionViewCell = "ShopCollectionViewCell"


//MARK: Cell Identifier
let categoryCollectionViewCellIdentifier = "categoryCollectionViewCell"
let shopCollectionViewCellIdentifier = "shopCollectionViewCell"



