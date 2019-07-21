//
//  ViewController.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var dataCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() -> Void {
        categoryCollectionView.isHidden = true
        dataCollectionView.isHidden = true
        navTitle.title = viewModel.selectedCategory.capitalized
        categoryCollectionView.register(UINib(nibName: categoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: categoryCollectionViewCellIdentifier)
        dataCollectionView.register(UINib(nibName: shopCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: shopCollectionViewCellIdentifier)
        dataCollectionView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: UIControl.Event.valueChanged)
        fetchCategory()
    }
    
    @objc func pulledToRefresh() -> Void {
        fetchShops()
    }
    
    private func fetchCategory() -> Void {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getPopularListWithCategory { (status, error) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            if status{
                self.categoryCollectionView.reloadData()
                self.dataCollectionView.reloadData()
                self.categoryCollectionView.isHidden = false
                self.dataCollectionView.isHidden = false
            }else{
                print(error!)
            }
        }
    }
    
    func fetchShops() -> Void {
        self.refreshControl.endRefreshing()
        viewModel.getShops { (status, error) in
            if status{
                self.dataCollectionView.reloadData()
            }else{
                print(error!)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return viewModel.popular.categories.count
        } else{
            if viewModel.popular.data.count == 0 {
                collectionView.showNoData(title: "No Data", description: "Check Internet Connection and pull to refresh", action: nil)
            }else {
                collectionView.hideNoData()
            }
            return viewModel.popular.data.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCellIdentifier, for: indexPath) as! CategoryCollectionViewCell
            if viewModel.selectedCategory == viewModel.popular.categories[indexPath.row].categorySlug{
                cell.imageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }else{
                cell.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopCollectionViewCellIdentifier, for: indexPath) as! ShopCollectionViewCell
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let cell = cell as! CategoryCollectionViewCell
            let data = viewModel.popular.categories[indexPath.row]
            cell.setupUI(imageURL: data.icon, title: data.bcategoryName)
        } else{
            let cell = cell as! ShopCollectionViewCell
            let project = viewModel.popular.data[indexPath.row]
            cell.setup(shopDetail: project)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            viewModel.selectedCategory = viewModel.popular.categories[indexPath.row].categorySlug
            categoryCollectionView.reloadData()
            navTitle.title = viewModel.selectedCategory.capitalized
            fetchShops()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == categoryCollectionView{
//            return CGSize(width: 120, height: 120)
//        } else{
//            return CGSize(width: collectionView.frame.width, height: 320)
//        }
//
//    }
}

