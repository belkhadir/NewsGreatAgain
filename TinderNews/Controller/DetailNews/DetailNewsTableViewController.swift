//
//  DetailNewsTableViewController.swift
//  TinderNews
//
//  Created by xxx on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class DetailNewsTableViewController: UITableViewController {

    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
