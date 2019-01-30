//
//  DetailLicensesViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/8/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class DetailLicensesViewController: UIViewController {

    fileprivate let textView = UITextView()
    var licenseString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addText()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(textView)
        if #available(iOS 11.0, *) {
            let safe = view.safeAreaLayoutGuide
            textView.autoLayout(topAnchor: safe.topAnchor, bottomAnchor: safe.bottomAnchor, leadingAnchor: safe.leadingAnchor, trailingAnchor: safe.trailingAnchor, inset: .init(top: 16, left: 16, bottom: 16, right: 16))
        }else {
            textView.autoLayout(topAnchor: view.topAnchor, bottomAnchor: view.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, inset: .init(top: 16, left: 16, bottom: 16, right: 16))
        }
        
        
    }
    
    func addText() {
        guard let licenseString = licenseString else { return }
        textView.text = licenseString
    }

}
