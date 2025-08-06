//
//  ContentView.swift
//  GetUpPlease Watch App
//
//  Created by Junjie Chen on 6/8/2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    // MARK: - State Management
    // @State creates reactive properties that trigger UI updates when changed
    // This is essential for watchOS where UI must respond to data changes immediately
    @State private var selectedTime = Date()
    @State private var isAlarmSet = false
    @State private var showingTimePicker = false
    @State private var showingAlarm = false
    
    var body: some View {
        VStack(spacing: 12) {
            // MARK: - App Title & Status
            // Watch apps need clear, concise titles due to limited screen space
            VStack(spacing: 4) {
                Image(systemName: isAlarmSet ? "alarm.fill" : "alarm")
                    .font(.largeTitle)
                    .foregroundColor(isAlarmSet ? .orange : .gray)
                
                Text("GetUpPlease")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            // MARK: - Alarm Status Display
            // Critical information should be prominently displayed on watch
            if isAlarmSet {
                VStack(spacing: 2) {
                    Text("Alarm Set")
                        .font(.caption)
                        .foregroundColor(.orange)
                    
                    Text(selectedTime, style: .time)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            } else {
                Text("No Alarm Set")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // MARK: - Action Buttons
            // Watch apps should minimize the number of taps required
            VStack(spacing: 8) {
                if isAlarmSet {
                    Button("Cancel Alarm") {
                        cancelAlarm()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                } else {
                    Button("Set Alarm") {
                        showingTimePicker = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
            }
        }
        .padding()
        // MARK: - Time Picker Sheet
        // Sheets on watchOS should be used sparingly and for focused tasks
        .sheet(isPresented: $showingTimePicker) {
            TimePickerView(selectedTime: $selectedTime) { time in
                setAlarm(for: time)
                showingTimePicker = false
            }
        }
        // MARK: - Full Screen Alarm
        // Present alarm view when notification fires
        .fullScreenCover(isPresented: $showingAlarm) {
            AlarmView(isPresented: $showingAlarm) {
                // Reset alarm state when dismissed
                isAlarmSet = false
            }
        }
        // MARK: - App Lifecycle
        // Request notification permissions when app appears
        .onAppear {
            requestNotificationPermissions()
            // Set up notification delegate to handle when alarm fires
            UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
            NotificationDelegate.shared.onNotificationReceived = {
                showingAlarm = true
            }
        }
    }
    
    // MARK: - Alarm Management Functions
    
    private func setAlarm(for time: Date) {
        selectedTime = time
        scheduleNotification(for: time)
        isAlarmSet = true
        
        // Provide haptic feedback for user confirmation
        // Haptics are crucial on watchOS for user feedback
        WKInterfaceDevice.current().play(.success)
    }
    
    private func cancelAlarm() {
        // Remove all pending notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        isAlarmSet = false
        
        // Provide haptic feedback
        WKInterfaceDevice.current().play(.click)
    }
    
    private func scheduleNotification(for date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "GetUpPlease"
        content.body = "Time to wake up!"
        content.sound = nil // Silent - we'll use haptics only
        
        // Extract hour and minute from selected time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        // Create trigger for the specified time
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(
            identifier: "getupplease-alarm",
            content: content,
            trigger: trigger
        )
        
        // Schedule notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
}

// MARK: - Time Picker Component
// Separate view for time selection - keeps code organized
struct TimePickerView: View {
    @Binding var selectedTime: Date
    let onConfirm: (Date) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Set Alarm Time")
                .font(.headline)
            
            // DatePicker optimized for watchOS
            DatePicker(
                "Alarm Time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            
            Button("Set Alarm") {
                onConfirm(selectedTime)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
