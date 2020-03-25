# Deployment (Side Loading)
1. Sign up for a free apple developer account if you haven't already
    a. Go to developer.apple.com 
    b. Navigate to ‘Account’ on the top bar 
    c. Sign in with Apple Id 
    d. Agree to Terms and Conditions 
    e. Done.
2. If you don’t have Cocoa Pods, Open Terminal: 
    a. `sudo gem install cocoapods` 
    b. Type in computer password 
    c. Navigate to project directory
    d. `pod install` 
    e. Check it has completed without errors 
3. Download X-Code from App Store if you haven't already
4. From the project directory, open GapdarMyPages, and double click GapdarMyPages.xcworkspace to open with Xcode. 
5. Go to the left top of the navigator and double click the top Project navigator icon, then 'GapdarMyPages'. It will display a page in your main window.
6. Go to the 'Signing' section under 'Signing & Capabilities' tab and tick the 'Automatically manage signing' option. In 'Team', select your Apple developer account.
7. Go to signing and capabilities and select your developer account 
8. Change the bundle identifier to something unique eg. com.example.GapdarMyPages
9. Update your iPhone to iOS 13 if it isn't already
10. Connect your iPhone to your Mac's USB port with a Lightning Connector
11. Keep your iPhone unlocked, and select 'trust this computer' in the dialogue that pops up.
12. Click the "Set the active scheme" menu near the top left of X-code, next to "Build" and "Stop Running" buttons, and select your iPhone in the dropdown menu
13. Click the 'Build and Run' button at top left of X-code
14. On your iPhone, go to Settings -> General -> Device Management -> Select your App Development -> Trust App Developer
15. Close Settings, and click the GapdarMyPages Icon to start the App.