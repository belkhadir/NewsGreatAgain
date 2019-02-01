//
//  WebViewController.swift
//  TinderNews
//
//  Created by xxx on 2/1/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD

class WebViewController: UIViewController {

    var urlString = ""
    
    fileprivate let webView = UIWebView(frame: .zero)
    fileprivate let load = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addButtonToNavigationItem()
        loadRequest()
    }

    
    fileprivate func addButtonToNavigationItem() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.setRightBarButton(buttonItem, animated: true)
    }

    @objc func handleDone() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupLayout() {
        view.addSubview(webView)
        
        webView.fillSuperView()
        
    }
    
    fileprivate func loadRequest() {
        webView.delegate = self
        load.show(in: view)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        load.dismiss()
    }
}
