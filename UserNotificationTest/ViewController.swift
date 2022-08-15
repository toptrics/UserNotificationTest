//
//  ViewController.swift
//  UserNotificationTest
//
//  Created by Sunil Sharma on 12/08/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    let notificationCentre = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCentre.delegate = self
        // Do any additional setup after loading the view.
        notificationCentre.requestAuthorization(options: [.alert , .badge,.sound]) { success, error in
            
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        //content of Notification
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "My First Notification"
        content.title = "Let's Catch Up"
        content.body = "Its been some time you haven't did any activity"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // Setting a trigger time
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 900, repeats: false)
        
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

