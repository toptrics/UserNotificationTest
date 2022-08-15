//
//  SceneDelegate.swift
//  UserNotificationTest
//
//  Created by Sunil Sharma on 12/08/22.
//

import UIKit
import UserNotifications
class SceneDelegate: UIResponder, UIWindowSceneDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let notificationCentre = UNUserNotificationCenter.current()
      
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        notificationCentre.delegate = self
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["My First Notification"])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "My First Notification"
        content.title = "Let's Catch Up"
        content.body = "Its been some time you haven't did any activity"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // Setting a trigger time
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        
        // creating a request
        let request = UNNotificationRequest.init(identifier: content.categoryIdentifier, content: content, trigger: trigger)
        
        // Adding request to  notification centre
        notificationCentre.add(request) { (error) in
                   print("\(String(describing: error?.localizedDescription))")
               }
        // Adding Action in notification
        let action1 = UNNotificationAction.init(identifier: "Snooze", title: "Snooze", options: .foreground)
        let action2 = UNNotificationAction.init(identifier: "Delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [action1,action2], intentIdentifiers: [], options: [])
        notificationCentre.setNotificationCategories([category])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner , .sound , .badge])
    }


}

