import SwiftUI

@main
struct StatusMagicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                checkAndEscape()
            }
        }
    }
    
    func checkAndEscape() {
#if targetEnvironment(simulator)
        StatusManager.sharedInstance().setIsMDCMode(false)
#else
        var supported = false
        var needsTrollStore = false
        if #available(iOS 16.2, *) {
//            supported = false
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
        
        if !supported {
            UIApplication.shared.alert(title: "Not Supported", body: "This version of iOS is not supported. Please close the app.", withButton: false)
            return
        }
            
        do {
            // Check if application is entitled
            try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
            StatusManager.sharedInstance().setIsMDCMode(false)
        } catch {
            if needsTrollStore {
                UIApplication.shared.alert(title: "Use TrollStore", body: "You must install this app with TrollStore for it to work with this version of iOS. Please close the app.", withButton: false)
                return
            }
            // Use MacDirtyCOW to gain r/w
            grant_full_disk_access() { error in
                if (error != nil) {
                    UIApplication.shared.alert(body: "\(String(describing: error?.localizedDescription))\nPlease close the app and retry.", withButton: false)
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
                print(error.localizedDescription)
            }
        }
        
        checkForUpdates()
#endif
    }
    
    func checkForUpdates() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/Avangelista/StatusMagic/releases/latest") {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if (json["tag_name"] as? String)?.compare(version, options: .numeric) == .orderedDescending {
                        UIApplication.shared.confirmAlert(title: "Update Available", body: "A new version of StatusMagic is available. It is recommended you update to avoid encountering bugs. Would you like to view the releases page?", onOK: {
                            UIApplication.shared.open(URL(string: "https://github.com/Avangelista/StatusMagic/releases/latest")!)
                        }, noCancel: false)
                    }
                }
            }
            task.resume()
        }
    }
}

