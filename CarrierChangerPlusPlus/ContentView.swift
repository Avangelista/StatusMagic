//
//  ContentView.swift
//  CarrierChanger++
//
//  Created by Rory Madden on 31/1/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    @State private var carrierText: String = getCarrierOverride()
    @State private var carrierTextEnabled: Bool = isCarrierOverridden()
    @State private var timeText: String = getTimeOverride()
    @State private var timeTextEnabled: Bool = isTimeOverridden()
    @State private var DNDHidden: Bool = isDNDHidden()
    @State private var dateHidden: Bool = isDateHidden()
    @State private var airplaneHidden: Bool = isAirplaneHidden()
    @State private var cellHidden: Bool = isCellHidden()
    @State private var wiFiHidden: Bool = isWiFiHidden()
    @State private var batteryHidden: Bool = isBatteryHidden()
    @State private var bluetoothHidden: Bool = isBluetoothHidden()
    @State private var alarmHidden: Bool = isAlarmHidden()
    @State private var locationHidden: Bool = isLocationHidden()
    @State private var rotationHidden: Bool = isRotationHidden()
    @State private var airPlayHidden: Bool = isAirPlayHidden()
    @State private var carPlayHidden: Bool = isCarPlayHidden()
    @State private var VPNHidden: Bool = isVPNHidden()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Change Carrier Text", isOn: $carrierTextEnabled).onChange(of: carrierTextEnabled, perform: { nv in
                        if nv {
                            setCarrier(carrierText)
                        } else {
                            unsetCarrier()
                        }
                    })
                    TextField("Carrier Text", text: $carrierText).onChange(of: carrierText, perform: { nv in
                        if carrierTextEnabled {
                            setCarrier(nv)
                        }
                    })
                }
                
                Section (footer: Text("When set to blank on notched devices, this will display the carrier name.")) {
                    Toggle("Change Status Bar Time Text", isOn: $timeTextEnabled).onChange(of: timeTextEnabled, perform: { nv in
                        if nv {
                            setTime(timeText)
                        } else {
                            unsetTime()
                        }
                    })
                    TextField("Status Bar Time Text", text: $timeText).onChange(of: timeText, perform: { nv in
                        if timeTextEnabled {
                            setTime(nv)
                        }
                    })
                }
                
                Section (footer: Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")")) {
                    Group {
                        Toggle("Hide Do Not Disturb", isOn: $DNDHidden).onChange(of: DNDHidden, perform: { nv in
                            hideDND(nv)
                        })
                        Toggle("Hide Date (iPad)", isOn: $dateHidden).onChange(of: dateHidden, perform: { nv in
                            hideDate(nv)
                        })
                        Toggle("Hide Airplane Mode", isOn: $airplaneHidden).onChange(of: airplaneHidden, perform: { nv in
                            hideAirplane(nv)
                        })
                        Toggle("Hide Cell", isOn: $cellHidden).onChange(of: cellHidden, perform: { nv in
                            hideCell(nv)
                        })
                        Toggle("Hide Wi-Fi", isOn: $wiFiHidden).onChange(of: wiFiHidden, perform: { nv in
                            hideWiFi(nv)
                        })
                        Toggle("Hide Battery", isOn: $batteryHidden).onChange(of: batteryHidden, perform: { nv in
                            hideBattery(nv)
                        })
                        Toggle("Hide Bluetooth", isOn: $bluetoothHidden).onChange(of: bluetoothHidden, perform: { nv in
                            hideBluetooth(nv)
                        })
                        Toggle("Hide Alarm", isOn: $alarmHidden).onChange(of: alarmHidden, perform: { nv in
                            hideAlarm(nv)
                        })
                        Toggle("Hide Location", isOn: $locationHidden).onChange(of: locationHidden, perform: { nv in
                            hideLocation(nv)
                        })
                        Toggle("Hide Rotation Lock", isOn: $rotationHidden).onChange(of: rotationHidden, perform: { nv in
                            hideRotation(nv)
                        })
                    }
                    Toggle("Hide AirPlay", isOn: $airPlayHidden).onChange(of: airPlayHidden, perform: { nv in
                        hideAirPlay(nv)
                    })
                    Toggle("Hide CarPlay", isOn: $carPlayHidden).onChange(of: carPlayHidden, perform: { nv in
                        hideCarPlay(nv)
                    })
                    Toggle("Hide VPN", isOn: $VPNHidden).onChange(of: VPNHidden, perform: { nv in
                        hideVPN(nv)
                    })
                }
            }
            .navigationTitle("CarrierChanger++")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        openURL(URL(string: "https://github.com/Avangelista/CarrierChangerPlusPlus")!)
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
