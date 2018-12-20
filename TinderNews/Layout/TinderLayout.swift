//
//  TinderLayout.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class TinderLayout: UICollectionViewLayout {

    typealias CellWithIndexPath = (cell: UICollectionViewCell, indexPath: IndexPath)
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    private let animationDuration: TimeInterval = 0.65
    private var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    private let maxOffsetThresholdPercentage: CGFloat = 0.3
    var holdCell: CGFloat = 100
    
    weak var delegate: TinderDelegate?
    
    private var topCellWithIndexPath: CellWithIndexPath? {
        let lastItem = collectionView?.numberOfItems(inSection: 0) ?? 0
        let indexPath = IndexPath(item: lastItem - 1, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        return (cell: cell, indexPath: indexPath)
    }
    
    private var bottomCellWithIndexPath: CellWithIndexPath? {
        guard let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 1 else { return nil }
        let indexPath = IndexPath(item: numItems - 2, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        return (cell: cell, indexPath: indexPath)
    }
    
    fileprivate var height: CGFloat {
        guard let collectionView = collectionView else {
            return 0.0
        }
        let insets = collectionView.contentInset
        return (collectionView.frame.height / 2) - (insets.top + insets.bottom)
    }
    
    fileprivate var width: CGFloat {
        guard let collectionView = collectionView else {
            return 0.0
        }
        let insets = collectionView.contentInset
        return collectionView.frame.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    override func prepare() {
        super.prepare()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(startDraging))
        collectionView?.addGestureRecognizer(panGestureRecognizer)
    }

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let indexPaths = indexPathsForElementsInRect(rect)
        let layoutAttributes = indexPaths
            .map { self.layoutAttributesForItem(at: $0) }
            .filter { $0 != nil }
            .map {$0!}
        
        return layoutAttributes
    }
    
    fileprivate func indexPathsForElementsInRect(_ rect: CGRect) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        
        if let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 0 {
            for i in 0...numItems-1 {
                indexPaths.append(IndexPath(item: i, section: 0))
            }
        }
        
        return indexPaths
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let screenWidth = UIScreen.main.bounds
        attributes.frame = CGRect(x: 16, y: 80, width: screenWidth.width - 32, height: screenWidth.height - 160)
        
        var isNotTop = false
        if let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 0 {
            isNotTop = indexPath.row != numItems - 1
        }
        
        attributes.alpha = isNotTop ? 0:1
        
        return attributes
    }
    
    
    
    @objc func startDraging(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: collectionView)
        
        let xOffset = translation.x
        let xMaxOffset = (collectionView?.frame.width ?? 0) * maxOffsetThresholdPercentage
        
        switch gestureRecognizer.state {
        case .changed:
            if let topCard = topCellWithIndexPath {
                let degree = translation.x / 20
                let angle = degree * .pi / 180
                let rotationTransfor = CGAffineTransform(rotationAngle: angle)
                topCard.cell.transform = rotationTransfor.translatedBy(x: translation.x, y: translation.y)
            }
            
            if let bottomCard = bottomCellWithIndexPath {
                let draggingScale = 0.5 + (abs(xOffset) / (collectionView?.frame.width ?? 1) * 0.7)
                let scale = draggingScale > 1 ? 1 : draggingScale
                bottomCard.cell.transform = CGAffineTransform(scaleX: scale, y: scale)
                bottomCard.cell.alpha = scale/2
            }
            
        case .ended:
            if abs(xOffset) > xMaxOffset {
                if let topCard = topCellWithIndexPath {
                    animateAndRemove(left: xOffset < 0, cell: topCard.cell, completion: { [weak self] in
                        guard let `self` = self else { return }
//                        if xOffset < 0 {
//                            self.delegate!.didDislike(topCard.cell, at: topCard.indexPath)
//                        }else {
//                            self.delegate!.didLike(topCard.cell, at: topCard.indexPath)
//                        }
                        
                    })
                }
                
                if let bottomCard = bottomCellWithIndexPath {
                    animateIntoPosition(cell: bottomCard.cell)
                }
                
            } else {
                if let topCard = topCellWithIndexPath {
                    animateIntoPosition(cell: topCard.cell)
                }
            }
        default:
            break
        }
    }

    
    private func animateIntoPosition(cell: UICollectionViewCell) {
        
        UIView.animate(withDuration: animationDuration) {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }
    }
    
    private func animateAndRemove(left: Bool, cell: UICollectionViewCell, completion:(()->())?) {
        
        let screenWidth = UIScreen.main.bounds.width
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            let xTranslateOffscreen = CGAffineTransform(translationX: left ? -screenWidth : screenWidth, y: 0)
            cell.transform = xTranslateOffscreen
        }) { (_) in
            completion?()
        }
    
    }
    
}
