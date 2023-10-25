//
//  LocalNotificationBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 25/10/2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

final class NotificationManager {
    static let instance = NotificationManager()
    
    func request(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            else {
                print("Success")
            }
        }
    }
    
    func send(){
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This is so easy!"
        content.sound = .default
        content.badge = 1
        
        // time
        /*
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
         */
        
        // calender
        /*
         var components = DateComponents()
         components.hour = 15
         components.minute = 48
         components.weekday = 6
         
         let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
         */
        
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = false
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func clear(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 48){
            Button("Request\nPermission"){ NotificationManager.instance.request() }
            Button("Schedule\nNotification"){ NotificationManager.instance.send() }
            Button("Remove\nNotifications"){ NotificationManager.instance.clear() }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
