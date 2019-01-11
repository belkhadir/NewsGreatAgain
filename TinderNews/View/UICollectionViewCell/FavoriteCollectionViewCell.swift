//
//  FavoriteCollectionViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD
import CoreData

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AdsTableViewCell.self, forCellReuseIdentifier: AdsTableViewCell.reuseIdentifier)
        table.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 140
        table.rowHeight = 150
        table.separatorInset = UIEdgeInsets(top: 0, left: 120 + 16 + 8, bottom: 0, right: 0)
        table.addSubview(self.refreshControl)
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(FavoriteCollectionViewCell.handleRefresh),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    fileprivate var favoriteArticles = [Favorite]()
    
    weak var rootController: UIViewController?
    
    fileprivate var page = Page.Position(current: -1, max: 0, next: 1, previous: 1)
    fileprivate var dataPage = Page.DataPage.init(per: 0, total: -1)
    fileprivate let loadingView = JGProgressHUD(style: JGProgressHUDStyle.light)
    
    fileprivate func fetchFavorite() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            return try sharedContext.fetch(fetchRequest)
        }catch _{ return [Favorite]() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.addSubview(self.refreshControl)
//        fetchFavoriteNews()
        setupLayout()
        fetchNewsFromCoreData()
    }
    
    
    func fetchNewsFromCoreData() {
        favoriteArticles = fetchFavorite().filterDuplicates { $0.title == $1.title }
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    fileprivate func setupLayout() {
        addSubview(tableView)
        tableView.fillSuperView()
    }
    
    
    fileprivate func fetchFavoriteNews() {
//        if dataPage.total == favoriteArticles.count {
//            refreshControl.endRefreshing()
//            return
//        }
//
//
//        NewsService.getFavorite(page: page) { (result) in
//            switch result {
//            case .failure(let error):
//                print(error)
//                call {
//                    self.refreshControl.endRefreshing()
//                }
//            case .success(let value):
////                value.page.data
//
//                self.page = value.page.position
//                self.dataPage = value.page.data
//
//
//                self.favoriteArticles.append(contentsOf: value.data)
//                self.favoriteArticles = self.favoriteArticles.filterDuplicates() { $0.title == $1.title }
//                call {
//                    self.tableView.reloadData()
//                    self.refreshControl.endRefreshing()
//                }
//            }
//        }
    }
    
    @objc func handleRefresh() {
        page = Page.Position(current: 1,max: 0, next: 1, previous: 1)
        fetchFavoriteNews()
    }
}

extension FavoriteCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as! ArticleTableViewCell
        cell.configure(cell: Article(article: favoriteArticles[indexPath.item]))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailsViewController()
        detail.article = Article(article: favoriteArticles[indexPath.item])
        rootController?.present(detail, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let article = favoriteArticles[indexPath.item]
        let detail = DetailsViewController()
        
        detail.article = Article(article: favoriteArticles[indexPath.item])
        rootController?.present(detail, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let height = scrollView.frame.size.height
//        let contentYoffset = scrollView.contentOffset.y
//        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//
//        if distanceFromBottom < height {
//            fetchFavoriteNews()
//        }
    }
    
}
