//
//   FrameworksTableViewController.swift
//   TinderNews
//
//   Created by Belkhadir Anas on 1/8/19.
//   Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class FrameworksTableViewController: UITableViewController {

    enum Frameworks: String, CaseIterable {
        case SDWebImage
        case FirebaseCore
        case FirebaseAdMob
        case FacebookCore
        case FacebookLogin
        case FirebaseUIGoogle
        case JGProgressHUD
        case FirebaseDynamicLinks
        
        var license: String {
            switch self {
            case .JGProgressHUD:
                return """
                The MIT License (MIT)
                
                Copyright (c) 2014-2018 Jonas Gessner
                
                Permission is hereby granted, free of charge, to any person obtaining a copy of
                this software and associated documentation files (the "Software"), to deal in
                the Software without restriction, including without limitation the rights to
                use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
                the Software, and to permit persons to whom the Software is furnished to do so,
                subject to the following conditions:
                
                The above copyright notice and this permission notice shall be included in all
                copies or substantial portions of the Software.
                
                THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
                FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
                COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
                IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
                CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                """
            case .SDWebImage:
                return """
                Copyright (c) 2009-2017 Olivier Poitrey rs@dailymotion.com
                
                Permission is hereby granted, free of charge, to any person obtaining a copy
                of this software and associated documentation files (the "Software"), to deal
                in the Software without restriction, including without limitation the rights
                to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
                copies of the Software, and to permit persons to whom the Software is furnished
                to do so, subject to the following conditions:
                
                The above copyright notice and this permission notice shall be included in all
                copies or substantial portions of the Software.
                
                THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
                FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
                AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
                LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
                OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
                THE SOFTWARE.
                """
            case .FirebaseCore, .FirebaseDynamicLinks, .FirebaseAdMob, .FirebaseUIGoogle:
                return """
                  Copyright 2018 Google
                
                  Licensed under the Apache License, Version 2.0 (the "License");
                  you may not use this file except in compliance with the License.
                  You may obtain a copy of the License at
                
                       http: www.apache.org/licenses/LICENSE-2.0
                
                  Unless required by applicable law or agreed to in writing, software
                  distributed under the License is distributed on an "AS IS" BASIS,
                  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                  See the License for the specific language governing permissions and
                  limitations under the License.
                """
            case .FacebookCore, .FacebookLogin:
                return """
                  Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
                
                  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
                  copy, modify, and distribute this software in source code or binary form for use
                  in connection with the web services and APIs provided by Facebook.
                
                  As with any software that integrates with the Facebook platform, your use of
                  this software is subject to the Facebook Developer Principles and Policies
                  [http: developers.facebook.com/policy/]. This copyright notice shall be
                  included in all copies or substantial portions of the software.
                
                  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
                  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
                  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
                  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
                  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                """
            default: return ""
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
    }

//      MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Frameworks.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        let frameWork = Frameworks.allCases[indexPath.item]
        cell.textLabel?.text = frameWork.rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frameWork = Frameworks.allCases[indexPath.item]
        let detaiL = DetailLicensesViewController()
        detaiL.licenseString = frameWork.license
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detaiL, animated: true)
        }
    }
}
