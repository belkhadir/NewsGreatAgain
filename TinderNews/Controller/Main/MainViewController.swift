//
//  MainViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class MainViewController: UIViewController {

    
    fileprivate let navigationStack = NavigationStackView()
    fileprivate let navigationView = UIView()
    
    fileprivate var leftAnchor: NSLayoutXAxisAnchor?
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.groupTableViewBackground
        let indexPath = IndexPath(item: 0, section: 1)
        collection.scrollToItem(at: indexPath, at: .left, animated: false)
        return collection
    }()
    
    private enum State: Int, CaseIterable {
        case settings
        case home
        case favorite
    }
    
    private var state = State.home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupLayout()
        addTarget()
        scheduleNotification()
        registerNotification()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleLogo()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overAllStackView = UIStackView(arrangedSubviews: [navigationStack, collectionView])
        view.addSubview(overAllStackView)
        overAllStackView.axis = .vertical
        overAllStackView.fillSuperView()
        
        overAllStackView.bringSubviewToFront(collectionView)
        
        
    }

    fileprivate func addTarget() {
        navigationStack.favoriteButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        navigationStack.logoButton.addTarget(self, action: #selector(handleLogo), for: .touchUpInside)
        navigationStack.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)

    }
    
    fileprivate func registerCollectionView() {
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.reuseIdentifier)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.reuseIdentifier)
    }
    
    @objc func handleFavorite() {
        state = State.favorite
        activeThenavigationStack(state: state)
        let indexPath = IndexPath(item: 0, section: 2)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    @objc func handleLogo() {
        state = State.home
        activeThenavigationStack(state: state)
        let indexPath = IndexPath(item: 0, section: 1)
        collectionView.scrollToItem(at: indexPath, at: state == State.settings ? .left: .right, animated: true)
    }
    
    @objc func handleSettings() {
        state = State.settings
        activeThenavigationStack(state: state)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        let halfWidth = view.frame.width/2
        tranlateStack(with: halfWidth, mode: .forwards)
    }
    
    func tranlateStack(with value: CGFloat, mode: CAMediaTimingFillMode) {
        let translateAnimation = CABasicAnimation(keyPath: "position.x")
        translateAnimation.toValue = value
        translateAnimation.duration = 0.5
        translateAnimation.fillMode =  mode
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        navigationStack.layer.add(translateAnimation, forKey: "tranlation")
    }
    
    private func activeThenavigationStack(state: State) {
        navigationStack.settingsButton.tintColor = state == .settings ?  #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1) :UIColor.lightGray
        navigationStack.logoButton.tintColor = state == .home ?  #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1) :UIColor.lightGray
        navigationStack.favoriteButton.tintColor =  state == .favorite ?  #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1) :UIColor.lightGray
        
    }
    
    func registerNotification() {
        Messaging.messaging().delegate = self
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)

            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        // [END register_for_notifications]
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return State.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch State(rawValue: indexPath.section)! {
        case .home:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
            cell.rootController = self
            return cell
        case .settings:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.reuseIdentifier, for: indexPath) as! SettingsCollectionViewCell
            cell.rootController = self
            return cell
        case .favorite:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoriteCollectionViewCell
            cell.rootController = self
            cell.fetchNewsFromCoreData()
            return cell
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - navigationStack.frame.height - 16)
    }
    
}


extension MainViewController: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
        // Print full message.
//        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        // Print full message.
//        print(userInfo)
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension MainViewController : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}


extension MainViewController {
    
    func unlock() {
        
    }
}
