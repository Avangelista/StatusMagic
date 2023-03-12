import SwiftUI
import Darwin

@main
struct StatusMagicApp: App {
    init() {
        registerDefaults()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                checkAndEscape()
                checkForUpdates()
            }
        }
    }
    
    func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            "ForceMDC": false,
            "UseAlternativeSetter": false,
            "ShowUnsupported": true
        ])
    }
    
    func checkAndEscape() {
#if targetEnvironment(simulator)
        StatusManager.sharedInstance().setIsMDCMode(false)
#else
        var supported = false
        var maybeSupported = false
        var needsTrollStore = false
        if #available(iOS 16.3, *) {
//            supported = false
        } else if #available(iOS 16.2, *) {
            if UserDefaults.standard.bool(forKey: "ShowUnsupported") {
                maybeSupported = true
            } else {
                supported = true
            }
        } else if #available(iOS 16.0, *) {
            supported = true
        } else if #available(iOS 15.7.2, *) {
//            supported = false
        } else if #available(iOS 15.0, *) {
            supported = true
        } else if #available(iOS 14.0, *) {
            supported = true
            needsTrollStore = true
        }
        
        if maybeSupported {
            UIApplication.shared.alert(title: NSLocalizedString("Not Supported", comment: ""), body: NSLocalizedString("This version of iOS is not supported. Please close the app.", comment: ""), withButton: false)
            UIApplication.shared.confirmAlert(title: NSLocalizedString("Not Supported", comment: ""), body: NSLocalizedString("This version of iOS is likely not supported. Unless you know for certain that it is, please close the app.\n\nAre you certain this version is supported? The app will relaunch.", comment: ""), onOK: {
                UserDefaults.standard.set(false, forKey: "ShowUnsupported")
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    exit(0)
                }
            })
        } else if !supported {
            UIApplication.shared.alert(title: NSLocalizedString("Not Supported", comment: ""), body: NSLocalizedString("This version of iOS is not supported. Please close the app.", comment: ""), withButton: false)
        } else {
            getRootFS(needsTrollStore: needsTrollStore)
        }
#endif
    }
    
    func getRootFS(needsTrollStore: Bool) {
        do {
            // Check if application is entitled
            try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
            if UserDefaults.standard.bool(forKey: "ForceMDC") {
                throw "Forced MDC"
            } else {
                StatusManager.sharedInstance().setIsMDCMode(false)
            }
        } catch {
            if needsTrollStore {
                UIApplication.shared.alert(title: NSLocalizedString("Use TrollStore", comment: ""), body: NSLocalizedString("You must install this app with TrollStore for it to work with this version of iOS. Please close the app.", comment: ""), withButton: false)
                return
            }
            // Use MacDirtyCOW to gain r/w
            grant_full_disk_access() { error in
                if (error != nil) {
                    UIApplication.shared.alert(body: String(format: NSLocalizedString("%@\nPlease close the app and retry.", comment: ""), String(describing: error?.localizedDescription)), withButton: false)
                    return
                }
                StatusManager.sharedInstance().setIsMDCMode(true)
            }
        }
        
        let fm = FileManager.default
        if fm.fileExists(atPath: "/var/mobile/Library/SpringBoard/statusBarOverridesEditing") {
            do {
                try fm.removeItem(at: URL(fileURLWithPath: "/var/mobile/Library/SpringBoard/statusBarOverridesEditing"))
            } catch {
                UIApplication.shared.alert(body: "\(error)")
            }
        }
    }
    
    func checkForUpdates() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/Avangelista/StatusMagic/releases/latest") {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if (json["tag_name"] as? String)?.compare(version, options: .numeric) == .orderedDescending {
                        UIApplication.shared.confirmAlert(title: NSLocalizedString("Update Available", comment: ""), body: NSLocalizedString("A new version of StatusMagic is available. It is recommended you update to avoid encountering bugs. Would you like to view the releases page?", comment: ""), onOK: {
                            UIApplication.shared.open(URL(string: "https://github.com/Avangelista/StatusMagic/releases/latest")!)
                        }, noCancel: false)
                    }
                }
            }
            task.resume()
        }
    }
}

