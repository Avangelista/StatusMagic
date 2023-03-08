import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    @State private var carrierText: String = StatusManager.sharedInstance().getCarrierOverride()
    @State private var carrierTextEnabled: Bool = StatusManager.sharedInstance().isCarrierOverridden()
    @State private var timeText: String = StatusManager.sharedInstance().getTimeOverride()
    @State private var timeTextEnabled: Bool = StatusManager.sharedInstance().isTimeOverridden()
    @State private var crumbText: String = StatusManager.sharedInstance().getCrumbOverride()
    @State private var crumbTextEnabled: Bool = StatusManager.sharedInstance().isCrumbOverridden()
    @State private var clockHidden: Bool = StatusManager.sharedInstance().isClockHidden()
    @State private var DNDHidden: Bool = StatusManager.sharedInstance().isDNDHidden()
    @State private var airplaneHidden: Bool = StatusManager.sharedInstance().isAirplaneHidden()
    @State private var cellHidden: Bool = StatusManager.sharedInstance().isCellHidden()
    @State private var wiFiHidden: Bool = StatusManager.sharedInstance().isWiFiHidden()
    @State private var batteryHidden: Bool = StatusManager.sharedInstance().isBatteryHidden()
    @State private var bluetoothHidden: Bool = StatusManager.sharedInstance().isBluetoothHidden()
    @State private var alarmHidden: Bool = StatusManager.sharedInstance().isAlarmHidden()
    @State private var locationHidden: Bool = StatusManager.sharedInstance().isLocationHidden()
    @State private var rotationHidden: Bool = StatusManager.sharedInstance().isRotationHidden()
    @State private var airPlayHidden: Bool = StatusManager.sharedInstance().isAirPlayHidden()
    @State private var carPlayHidden: Bool = StatusManager.sharedInstance().isCarPlayHidden()
    @State private var VPNHidden: Bool = StatusManager.sharedInstance().isVPNHidden()
//    @State private var microphoneUseHidden: Bool = StatusManager.sharedInstance().isMicrophoneUseHidden()
//    @State private var cameraUseHidden: Bool = StatusManager.sharedInstance().isCameraUseHidden()
    
    @State private var hasPhoneCallingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.phoneCalling)
    @State private var hasMircophoneRecordingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.microphoneRecording)
    @State private var hasHotspotStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.hotspot)
    @State private var hasCameraCallingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.cameraCalling)
    @State private var hasAirPlayStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.airPlay)
    @State private var hasNavigationStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.navigation)
    @State private var hasPurpleStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.purple)
    @State private var hasWiredAdapterStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.wiredAdapter)
    @State private var hasCarPlayStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.carPlay)
    @State private var hasSettingsStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.settings)
    @State private var hasMirroringStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.mirroring)
    @State private var hasActivityStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.activity)
    @State private var hasSOSStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.SOS)
    @State private var hasCameraRecordingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.cameraRecording)
    @State private var hasAirPrintStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.airPrint)
    @State private var hasDiagnosisStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.diagnosis)
    @State private var hasScreenRecordingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.screenRecording)
    @State private var hasIncomingPhoneCallingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.incomingPhoneCalling)
    @State private var hasIncomingCameraCallingStyle: Bool = StatusManager.sharedInstance().hasStyleOverrides(.incomingCameraCalling)
    
    
    
    let fm = FileManager.default
    
    var body: some View {
        NavigationView {
            List {
                if (StatusManager.sharedInstance().isMDCMode()) {
                    Section (footer: Text("Your device will respring.")) {
                        Button("Apply") {
                            if fm.fileExists(atPath: "/var/mobile/Library/SpringBoard/statusBarOverridesEditing") {
                                do {
                                    _ = try fm.replaceItemAt(URL(fileURLWithPath: "/var/mobile/Library/SpringBoard/statusBarOverrides"), withItemAt: URL(fileURLWithPath: "/var/mobile/Library/SpringBoard/statusBarOverridesEditing"))
                                    respringFrontboard()
                                } catch {
                                    UIApplication.shared.alert(body: "\(error)")
                                }
                                
                            }
                        }
                    }
                }
                
                Section (header: Text("Customize Texts"), footer: Text("When set to blank on notched devices, this will display the carrier name.")) {
                    Toggle("Change Carrier Text", isOn: $carrierTextEnabled).onChange(of: carrierTextEnabled, perform: { nv in
                        if nv {
                            StatusManager.sharedInstance().setCarrier(carrierText)
                        } else {
                            StatusManager.sharedInstance().unsetCarrier()
                        }
                    })
                    TextField("Carrier Text", text: $carrierText).onChange(of: carrierText, perform: { nv in
                        // This is important.
                        // Make sure the UTF-8 representation of the string does not exceed 100
                        // Otherwise the struct will overflow
                        var safeNv = nv
                        while safeNv.utf8CString.count > 100 {
                            safeNv = String(safeNv.prefix(safeNv.count - 1))
                        }
                        carrierText = safeNv
                        if carrierTextEnabled {
                            StatusManager.sharedInstance().setCarrier(safeNv)
                        }
                    })
                    Toggle("Change Breadcrumb Text", isOn: $crumbTextEnabled).onChange(of: crumbTextEnabled, perform: { nv in
                        if nv {
                            StatusManager.sharedInstance().setCrumb(crumbText)
                        } else {
                            StatusManager.sharedInstance().unsetCrumb()
                        }
                    })
                    TextField("Breadcrumb Text", text: $crumbText).onChange(of: crumbText, perform: { nv in
                        // This is important.
                        // Make sure the UTF-8 representation of the string does not exceed 256
                        // Otherwise the struct will overflow
                        var safeNv = nv
                        while (safeNv + " ▶").utf8CString.count > 256 {
                            safeNv = String(safeNv.prefix(safeNv.count - 1))
                        }
                        crumbText = safeNv
                        if crumbTextEnabled {
                            StatusManager.sharedInstance().setCrumb(safeNv)
                        }
                    })
                    Toggle("Change Status Bar Time Text", isOn: $timeTextEnabled).onChange(of: timeTextEnabled, perform: { nv in
                        if nv {
                            StatusManager.sharedInstance().setTime(timeText)
                        } else {
                            StatusManager.sharedInstance().unsetTime()
                        }
                    })
                    TextField("Status Bar Time Text", text: $timeText).onChange(of: timeText, perform: { nv in
                        // This is important.
                        // Make sure the UTF-8 representation of the string does not exceed 64
                        // Otherwise the struct will overflow
                        var safeNv = nv
                        while safeNv.utf8CString.count > 64 {
                            safeNv = String(safeNv.prefix(safeNv.count - 1))
                        }
                        timeText = safeNv
                        if timeTextEnabled {
                            StatusManager.sharedInstance().setTime(safeNv)
                        }
                    })
                }

                Section (header: Text("Hide Items"), footer: Text("*Will also hide carrier name\n^Will also hide cellular data indicator")) {
                    // bruh I had to add a group cause SwiftUI won't let you add more than 10 things to a view?? ok
                    Group {
//                        Toggle("Hide Status Bar Time", isOn: $clockHidden).onChange(of: clockHidden, perform: { nv in
//                            StatusManager.sharedInstance().hideClock(nv)
//                        })
                        Toggle("Hide Do Not Disturb", isOn: $DNDHidden).onChange(of: DNDHidden, perform: { nv in
                            StatusManager.sharedInstance().hideDND(nv)
                        })
                        Toggle("Hide Airplane Mode", isOn: $airplaneHidden).onChange(of: airplaneHidden, perform: { nv in
                            StatusManager.sharedInstance().hideAirplane(nv)
                        })
                        Toggle("Hide Cellular*", isOn: $cellHidden).onChange(of: cellHidden, perform: { nv in
                            StatusManager.sharedInstance().hideCell(nv)
                        })
                        Toggle("Hide Wi-Fi^", isOn: $wiFiHidden).onChange(of: wiFiHidden, perform: { nv in
                            StatusManager.sharedInstance().hideWiFi(nv)
                        })
                        if UIDevice.current.userInterfaceIdiom != .pad {
                            Toggle("Hide Battery", isOn: $batteryHidden).onChange(of: batteryHidden, perform: { nv in
                                StatusManager.sharedInstance().hideBattery(nv)
                            })
                        }
                        Toggle("Hide Bluetooth", isOn: $bluetoothHidden).onChange(of: bluetoothHidden, perform: { nv in
                            StatusManager.sharedInstance().hideBluetooth(nv)
                        })
                        Toggle("Hide Alarm", isOn: $alarmHidden).onChange(of: alarmHidden, perform: { nv in
                            StatusManager.sharedInstance().hideAlarm(nv)
                        })
                        Toggle("Hide Location", isOn: $locationHidden).onChange(of: locationHidden, perform: { nv in
                            StatusManager.sharedInstance().hideLocation(nv)
                        })
                        Toggle("Hide Rotation Lock", isOn: $rotationHidden).onChange(of: rotationHidden, perform: { nv in
                            StatusManager.sharedInstance().hideRotation(nv)
                        })
                    }
                    Group {
                        Toggle("Hide AirPlay", isOn: $airPlayHidden).onChange(of: airPlayHidden, perform: { nv in
                            StatusManager.sharedInstance().hideAirPlay(nv)
                        })
                        Toggle("Hide CarPlay", isOn: $carPlayHidden).onChange(of: carPlayHidden, perform: { nv in
                            StatusManager.sharedInstance().hideCarPlay(nv)
                        })
                        Toggle("Hide VPN", isOn: $VPNHidden).onChange(of: VPNHidden, perform: { nv in
                            StatusManager.sharedInstance().hideVPN(nv)
                        })
//                        Toggle("Hide Microphone Usage Dot", isOn: $microphoneUseHidden).onChange(of: microphoneUseHidden, perform: { nv in
//                            StatusManager.sharedInstance().hideMicrophoneUse(nv)
//                        })
//                        Toggle("Hide Camera Usage Dot", isOn: $cameraUseHidden).onChange(of: cameraUseHidden, perform: { nv in
//                            StatusManager.sharedInstance().hideCameraUse(nv)
//                        })
                    }
                }
                
                Section (header: Text("Override Styles"), footer: Text("Will be restored when app quits.")) {
                    Group {
                        Toggle("Phone Calling", isOn: $hasPhoneCallingStyle).onChange(of: hasPhoneCallingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.phoneCalling)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.phoneCalling)
                            }
                        })
                        Toggle("Microphone Recording", isOn: $hasMircophoneRecordingStyle).onChange(of: hasMircophoneRecordingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.microphoneRecording)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.microphoneRecording)
                            }
                        })
                        Toggle("Personal Hotspot", isOn: $hasHotspotStyle).onChange(of: hasHotspotStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.hotspot)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.hotspot)
                            }
                        })
                        Toggle("Camera Calling", isOn: $hasCameraCallingStyle).onChange(of: hasCameraCallingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.cameraCalling)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.cameraCalling)
                            }
                        })
                        Toggle("AirPlay", isOn: $hasAirPlayStyle).onChange(of: hasAirPlayStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.airPlay)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.airPlay)
                            }
                        })
                        Toggle("Navigation", isOn: $hasNavigationStyle).onChange(of: hasNavigationStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.navigation)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.navigation)
                            }
                        })
                        Toggle("Siri", isOn: $hasPurpleStyle).onChange(of: hasPurpleStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.purple)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.purple)
                            }
                        })
                        Toggle("Wired Adapter", isOn: $hasWiredAdapterStyle).onChange(of: hasWiredAdapterStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.wiredAdapter)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.wiredAdapter)
                            }
                        })
                        Toggle("CarPlay", isOn: $hasCarPlayStyle).onChange(of: hasCarPlayStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.carPlay)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.carPlay)
                            }
                        })
                        Toggle("Settings", isOn: $hasSettingsStyle).onChange(of: hasSettingsStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.settings)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.settings)
                            }
                        })
                    }
                    Group {
                        Toggle("Mirroring", isOn: $hasMirroringStyle).onChange(of: hasMirroringStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.mirroring)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.mirroring)
                            }
                        })
                        Toggle("Activity", isOn: $hasActivityStyle).onChange(of: hasActivityStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.activity)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.activity)
                            }
                        })
                        Toggle("SOS", isOn: $hasSOSStyle).onChange(of: hasSOSStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.SOS)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.SOS)
                            }
                        })
                        Toggle("Camera Recording", isOn: $hasCameraRecordingStyle).onChange(of: hasCameraRecordingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.cameraRecording)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.cameraRecording)
                            }
                        })
                        Toggle("AirPrint", isOn: $hasAirPrintStyle).onChange(of: hasAirPrintStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.airPrint)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.airPrint)
                            }
                        })
                        Toggle("Diagnosis", isOn: $hasDiagnosisStyle).onChange(of: hasDiagnosisStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.diagnosis)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.diagnosis)
                            }
                        })
                        Toggle("Screen Recording", isOn: $hasScreenRecordingStyle).onChange(of: hasScreenRecordingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.screenRecording)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.screenRecording)
                            }
                        })
                        Toggle("Incoming Phone Calling", isOn: $hasIncomingPhoneCallingStyle).onChange(of: hasIncomingPhoneCallingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.incomingPhoneCalling)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.incomingPhoneCalling)
                            }
                        })
                        Toggle("Incoming Camera Calling", isOn: $hasIncomingCameraCallingStyle).onChange(of: hasIncomingCameraCallingStyle, perform: { nv in
                            if (nv) {
                                StatusManager.sharedInstance()
                                    .addStyleOverrides(.incomingCameraCalling)
                            } else {
                                StatusManager.sharedInstance()
                                    .removeStyleOverrides(.incomingCameraCalling)
                            }
                        })
                    }
                }
                
                if #available(iOS 15.0, *) {
                    Section (footer: Text("Go here if something isn't working correctly.")) {
                        NavigationLink(destination: SettingsView(), label: { Text("Settings") })
                    }
                }
                
                Section (footer: Text("Your device will respring.\n\n\nStatusMagic by Avangelista\nVersion \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")\nUsing \(StatusManager.sharedInstance().isMDCMode() ? "MacDirtyCOW" : "TrollStore")")) {
                    Button("Reset to Defaults") {
                        if fm.fileExists(atPath: "/var/mobile/Library/SpringBoard/statusBarOverrides") {
                            do {
                                try fm.removeItem(at: URL(fileURLWithPath: "/var/mobile/Library/SpringBoard/statusBarOverrides"))
                                respringFrontboard()
                            } catch {
                                UIApplication.shared.alert(body: "\(error)")
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("StatusMagic")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        openURL(URL(string: "https://github.com/Avangelista/StatusMagic")!)
                    }) {
                        Image("github")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        openURL(URL(string: "https://ko-fi.com/avangelista")!)
                    }) {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
