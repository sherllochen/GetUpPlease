//
//  NotificationDelegate.swift
//  GetUpPlease Watch App
//
//  Handles notification delivery and triggers alarm interface
//

import Foundation
import UserNotifications

// MARK: - Notification Delegate
// This class handles what happens when a notification is delivered while the app is active
// Essential for watchOS apps that need to respond to scheduled notifications immediately
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    // Singleton pattern - only one notification delegate should exist
    static let shared = NotificationDelegate()
    
    // Callback to trigger alarm display
    var onNotificationReceived: (() -> Void)?
    
    private override init() {
        super.init()
    }
    
    // MARK: - Notification Handling
    
    // Called when a notification is delivered while the app is in the foreground
    // This is crucial for our alarm - we want to show the alarm interface immediately
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Check if this is our alarm notification
        if notification.request.identifier == "getupplease-alarm" {
            // Trigger the alarm interface
            DispatchQueue.main.async {
                self.onNotificationReceived?()
            }
        }
        
        // Don't show the system notification banner - we handle it with our custom UI
        completionHandler([])
    }
    
    // Called when user taps a notification (when app is backgrounded)
    // This ensures we show the alarm even if the app wasn't active
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // Check if this is our alarm notification
        if response.notification.request.identifier == "getupplease-alarm" {
            // Trigger the alarm interface
            DispatchQueue.main.async {
                self.onNotificationReceived?()
            }
        }
        
        completionHandler()
    }
}