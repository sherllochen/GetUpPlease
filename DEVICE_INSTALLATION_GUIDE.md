# Device Installation Guide - GetUpPlease Apple Watch App

This guide walks you through installing GetUpPlease on your physical Apple Watch for real-world testing of alarm functionality and "Cover to Mute" behavior.

## Prerequisites ✅

### Required Setup
- **Xcode 16.2** or later (confirmed working version)
- **Apple ID** for development (sherllochen@gmail.com)
- **iPhone** paired with your Apple Watch
- **Apple Watch** with watchOS 11.x or later
- **USB cable** to connect iPhone to Mac

### Why Physical Device Testing is Essential
**You CANNOT test these features in simulator:**
- ❌ "Cover to Mute" gesture detection (no proximity sensor)
- ❌ Real haptic feedback patterns (simulated vibration ≠ real vibration)
- ❌ Actual notification behavior during sleep
- ❌ Battery impact of persistent vibration
- ❌ True watch performance and responsiveness

**You CAN test these in simulator:**
- ✅ Basic app UI and navigation
- ✅ Time picker and alarm creation  
- ✅ SwiftUI layouts and state management
- ✅ Basic code logic and flow

---

## Installation Methods

### Option A: Xcode GUI Installation (Recommended) 🎯

**Step 1: Physical Setup**
1. **Connect iPhone to Mac** via USB cable
2. **Trust the computer** on iPhone when prompted ("Trust This Computer?")
3. **Ensure Apple Watch is paired** and connected to iPhone
4. **Keep both iPhone and Watch unlocked** during installation
5. **Wear the Apple Watch** (required for installation)

**Step 2: Open Project**
```bash
# Navigate to project directory
cd /Users/junjiechen/dev/GetUpPlease

# Open project in Xcode
open GetUpPlease.xcodeproj
```

**Step 3: Configure Xcode**
1. **Select Device Destination:**
   - Click device dropdown (top left, next to play/stop buttons)
   - Choose your iPhone from "iOS Device" section
   - Should show your iPhone model name

2. **Set Up Code Signing:**
   - Click project name "GetUpPlease" in navigator (left panel)
   - Select "GetUpPlease" target (iOS app)
   - Go to "Signing & Capabilities" tab
   - Set "Team" to your Apple ID (should auto-detect)
   - Repeat for "GetUpPlease Watch App" target

3. **Verify Bundle Identifiers:**
   - iOS app: `com.jj.GetUpPlease`
   - Watch app: `com.jj.GetUpPlease.watchkitapp`

**Step 4: Build and Install**
1. **Press ⌘+R** or click the Play button (▶️)
2. **Wait for build** to complete (may take 2-3 minutes)
3. **Installation process:**
   - iPhone app installs first
   - Watch app installs automatically (be patient - can take 2-3 minutes)
   - Both apps will appear on respective devices

### Option B: Command Line Installation 🖥️

**Check Connected Devices:**
```bash
# List connected devices
xcrun devicectl list devices

# Alternative method
xcrun xctrace list devices
```

**Build for Device:**
```bash
# Build and install to connected iPhone (Watch app installs automatically)
xcodebuild -project GetUpPlease.xcodeproj -scheme GetUpPlease -destination 'generic/platform=iOS' -configuration Debug build

# If you want to specify exact device, use device ID from devicectl list
xcodebuild -project GetUpPlease.xcodeproj -scheme GetUpPlease -destination 'platform=iOS,id=YOUR_DEVICE_ID' build
```

---

## Post-Installation Testing 🧪

### Step 1: Basic Functionality Test

**Open GetUpPlease on Apple Watch:**
1. Look for orange alarm icon on watch home screen
2. Tap to open the app
3. Verify UI appears correctly with "Set Alarm" button

**Create and Test Alarm:**
1. Tap "Set Alarm" button
2. Use Digital Crown to set time (2 minutes from now for testing)
3. Tap "Set Alarm" to confirm
4. Verify "Alarm Set" status appears with time display
5. Wait for alarm to trigger

### Step 2: Core Feature Testing ("Cover to Mute" Bypass)

**Test Our Custom Alarm vs Built-in Alarm:**

1. **Set GetUpPlease alarm** for 30 seconds from now
2. When alarm starts vibrating:
   - **Cover watch face with palm** for 3+ seconds
   - **Observe**: Our alarm should CONTINUE vibrating
   - **Dismiss**: Tap "Dismiss Alarm" button

3. **Compare with built-in alarm** (for reference):
   - Set built-in Timer or Alarm
   - When it vibrates, cover with palm
   - **Observe**: Built-in alarm will STOP (this is the problem we solve)

### Step 3: Real-World Sleep Testing

**Controlled Sleep Test:**
1. **Set alarm** for actual wake-up time
2. **Wear watch to bed** normally
3. **Sleep naturally** 
4. **When alarm fires:**
   - Note if it wakes you effectively
   - Try covering watch accidentally
   - Observe persistence of vibration
   - Test tap-to-dismiss functionality when groggy

**Document Results:**
- How effective is the vibration?
- Does covering stop the alarm? (It shouldn't!)
- Is dismissal too easy or appropriately challenging?
- Battery impact overnight?

---

## Troubleshooting Common Issues 🔧

### Installation Problems

**"No devices found" Error:**
```bash
# Check if iPhone is connected and trusted
xcrun devicectl list devices

# If no devices, check:
# 1. USB cable connection
# 2. "Trust This Computer" on iPhone
# 3. iPhone is unlocked
```

**Code Signing Issues:**
- Go to Xcode → Preferences → Accounts → Add Apple ID
- Select project → Signing & Capabilities → Choose correct team
- Enable "Automatically manage signing"

**Watch App Doesn't Install:**
- Ensure Apple Watch is paired and unlocked
- Keep watch on wrist during installation
- Wait 2-5 minutes - watch installations are slow
- Try restarting Watch app installation from iPhone

### Runtime Issues

**Notifications Don't Work:**
- Check iPhone Settings → Notifications → GetUpPlease → Allow Notifications
- Check Watch app permissions in iPhone Watch app → Notifications

**Haptic Feedback Not Working:**
- Verify watch is unlocked and on wrist
- Check Watch Settings → Sounds & Haptics → Haptic Strength
- Our app uses `WKInterfaceDevice.current().play(.notification)`

**App Crashes on Device:**
- Check Xcode console for crash logs
- Verify watchOS version compatibility (requires 11.2+)
- Test individual features to isolate problem

### Performance Issues

**Slow Performance:**
- Watch apps have limited memory - our app should be efficient
- Monitor battery usage in Watch Settings → Battery
- Check for memory leaks in Xcode Instruments

**Battery Drain:**
- Our alarm only vibrates when active, not continuously
- Haptic feedback is optimized for battery life
- Monitor usage patterns and adjust if needed

---

## Development Workflow 🔄

### Iterative Testing Approach

**For UI Changes (Iterations 1-3):**
- Test in Simulator first for quick iterations
- Deploy to device for final validation

**For Core Functionality (Iterations 4-7):**
- MUST test on physical device
- Simulator cannot replicate key behaviors

**Recommended Testing Schedule:**
1. **Daily testing**: Basic functionality and new features
2. **Weekly testing**: Real sleep scenarios
3. **Before each iteration**: Comprehensive feature validation

### Debugging on Device

**View Console Logs:**
```bash
# View device logs in real-time
xcrun devicectl log stream --device YOUR_DEVICE_ID

# Filter for GetUpPlease app logs
xcrun devicectl log stream --device YOUR_DEVICE_ID --predicate 'processImagePath CONTAINS "GetUpPlease"'
```

**Xcode Debugging:**
- Set breakpoints in Xcode
- Run with debugger attached (⌘+R with device selected)
- Use Instruments for performance profiling

---

## Next Steps After Installation ✅

### Iteration 1 Validation Checklist
- [ ] App installs successfully on both iPhone and Watch
- [ ] Time picker works with Digital Crown
- [ ] Alarm scheduling creates proper notifications
- [ ] Custom alarm UI appears when notification fires
- [ ] Haptic feedback provides appropriate vibration
- [ ] "Cover to Mute" does NOT stop our alarm (key test!)
- [ ] Tap-to-dismiss works reliably
- [ ] App state management works correctly

### Feedback Collection
**Document your testing experience:**
- Which features work well?
- What feels awkward or unreliable?
- How does real vibration compare to expectations?
- Is the current dismiss method too easy? (We'll add math challenges later)
- Any performance or battery concerns?

### Ready for Iteration 2
Once basic functionality is validated on device:
- Multiple alarm management (can be developed in simulator)
- Data persistence testing
- List navigation and watch-optimized UI

---

## Important Notes 📝

### Apple Watch Development Constraints
- **Installation Time**: Watch apps take 2-5 minutes to install
- **Memory Limits**: Watch apps have strict memory constraints  
- **Battery Awareness**: Haptic feedback and persistent timers drain battery
- **User Context**: Users interact with watch apps very briefly and while distracted

### Our App's Technical Advantages
- **Custom Notification Handling**: Bypasses system "Cover to Mute" behavior
- **Direct Haptic Control**: Uses WKInterfaceDevice for precise feedback
- **Persistent UI**: fullScreenCover prevents accidental dismissal
- **Cognitive Dismissal**: Future math challenges ensure user is awake

### Development Best Practices
- **Test Early**: Don't wait until final iteration to test on device
- **Real-World Usage**: Test in actual sleep scenarios, not just desk testing
- **Battery Monitoring**: Watch for power consumption patterns
- **User Feedback**: Note what feels natural vs. awkward in practice

**Remember**: The goal is solving a real-world problem, not just building a technically perfect app!