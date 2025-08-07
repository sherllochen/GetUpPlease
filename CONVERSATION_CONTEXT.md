# Conversation Context & Learning Preferences

This file preserves important context from our development sessions to help future Claude Code instances continue seamlessly.

## User Profile & Preferences

### Learning Style
- **Preferred Approach**: Learning by doing - implement features with detailed explanations
- **Teaching Method**: Explain **why** decisions were made, not just what code to write
- **Concept Integration**: Connect each implementation to Apple Watch development concepts
- **Progress Tracking**: Update learning guide as concepts are mastered through practical application

### Communication Style
- Prefers concise but thorough explanations
- Values understanding the reasoning behind technical decisions
- Wants to learn Apple Watch development principles through building real features
- Appreciates being walked through each step with context

### Development Approach
- **Iterative Development**: Build in small, demoable increments
- **Documentation First**: Maintain comprehensive docs as we build
- **Git Discipline**: Commit after each iteration with detailed messages
- **Learning Integration**: Mark learning guide progress as concepts are applied

## Project Context

### Personal Use Case
- **Primary User**: Developer who sleeps with Apple Watch on
- **Core Problem**: Built-in watch alarm stops when covered → accidentally dismissed before fully awake
- **Technical Root Cause**: Apple Watch "Cover to Mute" feature mutes alarms when watch face is covered
- **Constraint**: Must be silent (vibration only) to avoid disturbing sleeping partner
- **Solution**: Persistent alarm requiring cognitive engagement (math problems) to dismiss

### Key Requirements Decisions Made
1. **MVP-First Approach**: Start simple, add advanced features iteratively
2. **Math Challenges**: Simple addition/subtraction, 5 consecutive correct answers required
3. **Emergency Escape**: Auto-dismiss after 10 consecutive failures
4. **Vibration Escalation**: Gentle → Medium → Strong over 2 minutes
5. **Fixed-Time Alarms**: Start with basic scheduling before smart features

### Git Workflow
- **Personal Account**: sherllochen@gmail.com (setup completed with SSH keys)
- **Branch Strategy**: Currently on iteration-1-basic-single-alarm
- **Commit Style**: Detailed messages explaining both implementation and learning concepts

## Development Progress

### Completed (Iteration 1)
- ✅ Basic single alarm with time picker
- ✅ Local notification scheduling
- ✅ Full-screen alarm interface with haptic feedback
- ✅ Tap-to-dismiss functionality
- ✅ Custom notification handling
- ✅ Apple Watch UI best practices implemented

### Apple Watch Concepts Mastered
1. **SwiftUI for watchOS** - State management, proper layouts, visual hierarchy
2. **Haptic Feedback** - Different vibration patterns for user feedback
3. **Local Notifications** - Calendar triggers and custom handling
4. **Modal Presentations** - Sheets vs fullScreenCover usage
5. **Watch App Lifecycle** - Notification delegates and foreground handling
6. **Digital Crown Integration** - Through DatePicker wheel style
7. **Watch UI Design** - Large fonts, clear states, battery considerations
8. **System Integration** - Proper notification interception and custom UI

### Next Steps (Iteration 2)
- Multiple alarms management
- Data persistence (UserDefaults or Core Data)
- List views optimized for watch
- Edit/delete functionality
- Enable/disable toggles

## Technical Decisions & Explanations Given

### Why We Built It This Way
1. **State Management**: Used @State and @Binding for reactive UI updates crucial on small screens
2. **Silent Operation**: Set notification sound to nil, rely on haptics for your use case
3. **Full-Screen Alarm**: Prevents accidental dismissal when watch is covered
4. **Custom Notification Delegate**: Override system notifications with persistent alarm UI
5. **Bypass "Cover to Mute"**: Custom haptic control ignores Apple's system mute behavior
6. **Haptic Patterns**: Used specific types (.success, .notification) rather than generic vibration
7. **Dark Background**: Black backgrounds conserve battery on OLED watch screens

### Learning Moments Highlighted
- Explained Digital Crown integration through DatePicker wheel style
- Showed how @Binding creates two-way data flow between views
- Demonstrated watch-specific UI constraints and solutions
- Connected each technical choice to real Apple Watch development principles
- Emphasized battery considerations in haptic feedback design

## Conversation Patterns

### Effective Teaching Moments
- When user asked "why did you do that?" → Led to detailed explanation session
- Code implementation followed by concept explanation worked well
- Connecting technical decisions to user's real-world use case was valuable
- Breaking down complex topics (like notification delegates) into clear steps

### User Responses & Preferences
- Appreciated step-by-step explanations with reasoning
- Valued understanding the "why" behind Apple Watch specific decisions
- Preferred seeing concepts applied practically rather than theoretical explanations
- Wanted documentation maintained as we built (good discipline)

## Future Claude Instructions

### How to Continue
1. **Read all project documentation** - especially REQUIREMENTS.md and ITERATION_PLAN.md
2. **Use learning-by-doing approach** - implement features with detailed explanations
3. **Explain the "why"** - connect each decision to Apple Watch development principles
4. **Update learning guide** - mark progress as concepts are applied
5. **Maintain documentation** - keep all docs current as you build
6. **Follow git workflow** - detailed commits, proper branch management

### Communication Style to Match
- Provide thorough explanations of technical decisions
- Connect implementation to Apple Watch development concepts
- Explain why certain approaches work better on watchOS
- Use practical examples related to the alarm use case
- Keep comprehensive documentation updated

### Key Context to Remember
- This is a learning project - education is as important as the final product
- User wants to understand Apple Watch development principles deeply
- Each iteration should teach specific watchOS concepts through practical application
- The personal use case (sleeping with watch, silent operation) drives many technical decisions

---

**Last Updated**: After completing Iteration 1
**Next Session Goal**: Continue with Iteration 2 - Multiple Alarms Management
**Learning Progress**: 8/24 steps completed in Apple Watch development guide