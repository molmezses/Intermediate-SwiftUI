//
//  LocalNotificationBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 16.02.2025.
//

import SwiftUI
import UserNotifications

/*
 
 Bu bildirim uygulamasu kullanıcı uygulama içerinde ibr etkelişmee girdiyse ve ugyulamadan çıkış yatpıysa belirli bir süreden sonra bildirim gelmesini sağlar
 
 */

class NotificationManager{
    static let instance = NotificationManager()
    
    //Kullanıcnın bildirimleri izin vermesi olayı
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success,error in
            if let error = error{
                print("Error: \(error)")
            }else{
                print("Success")
            }
        }
    }
    
    //scheduleNotifiacation -> Takvim bildirimi -> zamanlayıcı bildirim
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "This is mu first Notification"
        content.subtitle =  "This is a subtitle"
        content.sound = .default
        content.badge = 1
        
        /// timer
        /// timeInterval -> gecikmesi süresi
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        
        //calender
        var dateComponents = DateComponents()
        dateComponents.hour = 11
        dateComponents.minute = 46
        dateComponents.weekday = 2
        //Her pazartesi saat 11.46 da kullanıcı uygulaamda deil ise bildirim gönderecek
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger:trigger2)
        //trigger bildirim gönderilmesini istediğimiz zamandır
        UNUserNotificationCenter.current().add(request)
    }
}


struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing:40){
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Request permission") {
                NotificationManager.instance.scheduleNotification()
            }
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
