//
//  CarrierChanger++App.swift
//  CarrierChanger++
//
//  Created by Rory Madden on 31/1/2023.
//

import SwiftUI

@main
struct CarrierChangerPlusPlusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                print("???")
                checkVersion()
            }
        }
    }
    

    func checkVersion() {
        if __IPHONE_OS_VERSION_MIN_REQUIRED == __IPHONE_15_0 {
            // iOS 15 version
            if #available(iOS 16.0, *) {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                return
            } else if #available(iOS 15.0, *) {
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/Avangelista/CarrierChangerPlusPlus/releases/latest") {
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else { return }
                        
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            if (json["tag_name"] as? String)?.compare(version, options: .numeric) == .orderedDescending {
                                UIApplication.shared.confirmAlert(title: "Update Available", body: "A new version of CarrierChanger++ is available. It is recommended you update to avoid encountering bugs. Would you like to view the releases page?", onOK: {
                                    UIApplication.shared.open(URL(string: "https://github.com/Avangelista/CarrierChangerPlusPlus/releases/latest")!)
                                }, noCancel: false)
                            }
                        }
                    }
                    task.resume()
                }
            } else if #available(iOS 14.0, *) {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                UIApplication.shared.confirmAlert(body: "Please download the version for iOS 14. View the downloads page?", onOK: {
                    UIApplication.shared.open(URL(string: "https://github.com/Avangelista/CarrierChangerPlusPlus/releases/latest")!)
                })
                return
            } else {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                return
            }
        } else if __IPHONE_OS_VERSION_MIN_REQUIRED == __IPHONE_14_0 {
            // iOS 14 version
            if #available(iOS 16.0, *) {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                return
            } else if #available(iOS 15.0, *) {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                UIApplication.shared.confirmAlert(body: "Please download the version for iOS 15. View the downloads page?", onOK: {
                    UIApplication.shared.open(URL(string: "https://github.com/Avangelista/CarrierChangerPlusPlus/releases/latest")!)
                })
                return
            } else if #available(iOS 14.0, *) {
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/Avangelista/CarrierChangerPlusPlus/releases/latest") {
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else { return }
                        
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            if (json["tag_name"] as? String)?.compare(version, options: .numeric) == .orderedDescending {
                                UIApplication.shared.confirmAlert(title: "Update Available", body: "A new version of CarrierChanger++ is available. It is recommended you update to avoid encountering bugs. Would you like to view the releases page?", onOK: {
                                    UIApplication.shared.open(URL(string: "https://github.com/Avangelista/CarrierChangerPlusPlus/releases/latest")!)
                                }, noCancel: false)
                            }
                        }
                    }
                    task.resume()
                }
            } else {
                UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
                return
            }
        } else {
            UIApplication.shared.alert(body: "iOS version not supported. Please close the app.", withButton: false)
            return
        }
    }
}

