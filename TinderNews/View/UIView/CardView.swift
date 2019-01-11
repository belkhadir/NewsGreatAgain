//
//  CardView.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class CardView: UIView {

    var nextCardView: CardView?
    internal var cornerRadius: CGFloat = 10
    fileprivate let maxOffsetThresholdPercentage: CGFloat = 0.3
    
    weak var delegate: CardViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        
    }

    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach{ $0.layer.removeAllAnimations() }
        case .changed:
            handleChange(gesture)
            
        case .ended:
            handleEnd(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChange(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: nil)
        let degree: CGFloat = translate.x / 20
        let angle = degree * CGFloat.pi / 180
        
        let rotation = CGAffineTransform(rotationAngle: angle)
        transform = rotation.translatedBy(x: translate.x, y: translate.y)

    }
    
    fileprivate func handleEnd(_ gesture: UIPanGestureRecognizer) {
        
        let translate = gesture.translation(in: nil)
        let xOffset = translate.x
        let xMaxOffset =  frame.width  * maxOffsetThresholdPercentage
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if abs(xOffset) > xMaxOffset {
                self.frame = CGRect(x: xOffset < 0 ? -1000:1000, y: 0, width: self.frame.width, height: self.frame.height)
                _ = xOffset < 0 ? self.delegate?.didDislike(self): self.delegate?.didLike(self)
            }else {
                self.transform = .identity
            }
            
        }){ _ in
            if abs(xOffset) > xMaxOffset {
                self.removeFromSuperview()
                self.delegate?.didRemoveCardView(cardView: self)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    internal func setupLayout() {
        layer.cornerRadius = cornerRadius
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }

    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: -1, height: 2)
    }


}
