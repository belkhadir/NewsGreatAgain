//
//  SettingsTableViewController.swift
//  TinderNews
//
//  Created by xxx on 1/8/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD
import MessageUI
import Firebase

class SettingsTableViewController: UITableViewController {
    static var  reuseIdentifier = "\(SettingsTableViewController.self)"
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    private let loading = JGProgressHUD(style: .dark)
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = UserDefaults.standard.string(forKey: UserDefaultKey.email.rawValue) {
            emailLabel.text = email
        }
        
        if let fullName = UserDefaults.standard.string(forKey: UserDefaultKey.fullName.rawValue) {
            fullNameLabel.text = fullName
        }
    }

    @IBAction func handleDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restorePurchase(_ sender: UIButton) {
        
    }
    
    @IBAction func shareNewsGreatAgain(_ sender: UIButton) {
        createLink()
    }
    
    @IBAction func getHelp(_ sender: UIButton) {
        let receipients = ["support@newsgreatagain.com"]
        let subject = "To The News Great Again Support"
        let messageBody = ""
        
        let configuredMailComposeViewController = configureMailComposeViewController(recepients: receipients, subject: subject, messageBody: messageBody)
        
        if canSendMail() {
            self.present(configuredMailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        loading.show(in: view)
        UserService.logout { (result) in
            DispatchQueue.main.async {
                self.loading.dismiss()
            }
            switch result {
            case .failure(let error):
                print(error)
            case .success:
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.email.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.token.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.fullName.rawValue)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.isLogged.rawValue)
                let vc = JoinViewController()
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func createLink() {
        guard let uid = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else { return }
        let link = URL(string: "https://newsgreatagain.com/referal?invitedby=\(uid)")
        let referralLink = DynamicLinkComponents(link: link!, domain: "newsgreatagain.page.link")
        
        referralLink.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.newsgreatagain.newsgreatagain")
        referralLink.iOSParameters?.minimumAppVersion = "1.0"
        referralLink.iOSParameters?.appStoreID = "1444359121"
        
        //        referralLink.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.android")
        //        referralLink.androidParameters?.minimumVersion = 125
        
        referralLink.shorten { (shortURL, warnings, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let shortURL = shortURL {
                print(shortURL)
                let activite = UIActivityViewController(activityItems: ["News great again, it's was never easy to read top sotries.\n Together we makes news great again. ",shortURL], applicationActivities: nil)
                guard let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else { return }
                Analytics.logEvent(AnalyticsEventCampaignDetails, parameters: [AnalyticsParameterSource: "userID-\(userID)"])
                
                DispatchQueue.main.async {
                    self.present(activite, animated: true, completion: nil)
                }
            }
        }
    }
}

extension SettingsTableViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func configureMailComposeViewController(recepients: [String], subject: String, messageBody: String) -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(recepients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        sendMailErrorAlert.addAction(cancelAction)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    
}

