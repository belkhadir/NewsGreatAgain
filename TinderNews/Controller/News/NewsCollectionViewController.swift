//
//  NewsCollectionViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/22/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewsCollectionViewController: UICollectionViewController {
    
    
    enum Section: Int {
        case article
        case ads
        
        init(section: Int) {
            self.init(rawValue: section)!
        }
        
        init(at indexPath: IndexPath) {
            self.init(section: indexPath.section)
        }
    }
    
    fileprivate var articles = [Article]() {
        didSet {
            if articles.isEmpty {
                fetchmoreNews()
            }
        }
    }
    
    
    
    fileprivate var page = Page.Position(current: 1,max: 0, next: 1, previous: 1)
    
    fileprivate let loadingView = JGProgressHUD(style: JGProgressHUDStyle.light)
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView.collectionViewLayout = TinderLayout()
        if let layout = collectionView.collectionViewLayout as? TinderLayout {
            layout.delegate = self
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchmoreNews()
        prepareViewController()
    }

    fileprivate func prepareViewController() {
        
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        collectionView.register(AdsCollectionViewCell.self, forCellWithReuseIdentifier: AdsCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
//        let sections = Section(section: section)
//        switch sections {
//        case .ads:
//            return 1
//        case .article:
//            return articles.count
//        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        cell.configure(cell: articles[indexPath.item])
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.item]
        
        let controller = DetailNewsTableViewController()
        controller.article = article
        
        DispatchQueue.main.async { [unowned self] in
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    // Mark: fetch more news
    
    func fetchmoreNews() {
        loadingView.show(in: view)
        if page.max == page.current {
            call {
                self.loadingView.dismiss()
            }
            return
        }
        NewService.getNewsFornext(page: page) { [weak self](result) in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                let data = success.data.filter {
                    return !($0.urlToImage == nil && $0.title == nil)
                }
                weakSelf.articles.append(contentsOf: data)
                weakSelf.page = success.page.position
                DispatchQueue.main.async {
                    weakSelf.loadingView.dismiss()
                    weakSelf.collectionView.reloadData()
                }
            }
        }
    }
    
    // Mark: Create Dummy data
    
    func dummyData() {
        guard let dummydata = convertToArticles() else {
            return
        }
        articles = dummydata.data
        collectionView.reloadData()
    }
    

}


// Mark: Header and footer view for UICollectionView

extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
            print(cell.frame)
            return cell
        case UICollectionView.elementKindSectionFooter:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.reuseIdentifier, for: indexPath) as! FooterCollectionReusableView
            return cell
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

// Mark:  Tinder Delegate

extension NewsCollectionViewController: TinderDelegate {
    func didLike(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        reloadCollectionView()
    }
    
    func didDislike(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        if !articles.isEmpty {
            articles.removeLast()
        }
        collectionView.reloadData()
    }
}
