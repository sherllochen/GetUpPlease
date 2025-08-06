//
//  AlarmView.swift
//  GetUpPlease Watch App
//
//  This view handles the active alarm state with vibration and dismissal
//

import SwiftUI
import WatchKit

struct AlarmView: View {
    // MARK: - Properties
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    @State private var isVibrating = false
    @State private var vibrationTimer: Timer?
    
    var body: some View {
        ZStack {
            // MARK: - Background
            // Full screen background to prevent accidental dismissal
            Color.black
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                // MARK: - Visual Alarm Indicator
                // Pulsing animation provides visual feedback along with haptics
                Image(systemName: "alarm.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                    .scaleEffect(isVibrating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isVibrating)
                
                // MARK: - Alarm Message
                VStack(spacing: 8) {
                    Text("WAKE UP!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(Date(), style: .time)
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                // MARK: - Dismiss Button
                // Large, prominent button for easy tapping when drowsy
                Button("Dismiss Alarm") {
                    dismissAlarm()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .font(.headline)
                .frame(height: 50)
            }
            .padding()
        }
        .onAppear {
            startVibration()
        }
        .onDisappear {
            stopVibration()
        }
    }
    
    // MARK: - Vibration Management
    
    private func startVibration() {
        isVibrating = true
        
        // Start immediate vibration
        WKInterfaceDevice.current().play(.notification)
        
        // Set up repeating vibration timer
        // For MVP, we use simple repeating pattern every 2 seconds
        vibrationTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            WKInterfaceDevice.current().play(.notification)
        }
    }
    
    private func stopVibration() {
        isVibrating = false
        vibrationTimer?.invalidate()
        vibrationTimer = nil
    }
    
    private func dismissAlarm() {
        stopVibration()
        
        // Success haptic feedback
        WKInterfaceDevice.current().play(.success)
        
        // Call completion handler
        onDismiss?()
        
        // Dismiss the alarm view
        isPresented = false
    }
}

#Preview {
    AlarmView(isPresented: .constant(true), onDismiss: nil)
}