//
//  SeperatorStackView.swift
//  TinderNews
//
//  Created by xxx on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class SeperatorStackView: UIStackView {

    fileprivate let line1 = LineView()
    fileprivate let line2 = LineView()
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "OR", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray])
        return label
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        line1.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        line2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        [line1, label, line2].forEach { addArrangedSubview($0) }
        
        axis = .horizontal
        distribution = .equalCentering
        alignment = .center
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    

}
