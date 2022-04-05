import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    DistributedNotificationCenter.default.addObserver(
      forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
      object: nil, queue: nil, using: self.themeChanged(notification:)
    )

    Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
      print("cause sigpipe if nvim is gone")
      fflush(__stdoutp)
    }
  }

  func themeChanged(notification: Notification) {
    let dark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    print(dark ? "dark" : "light")
    fflush(__stdoutp)
  }
}

let app = NSApplication.shared
let del = AppDelegate()
app.delegate = del
app.run()
