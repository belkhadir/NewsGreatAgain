//
//  HomebottomStackView.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class HomebottomStackView: UIStackView {

    let likeButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        dislikeButton.setImage(UIImage(named: "dissLike")?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage( UIImage(named: "like")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        [dislikeButton, likeButton].forEach { addArrangedSubview($0) }
        
        isLayoutMarginsRelativeArrangement = true
       
        
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}
