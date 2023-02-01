//
//  SDStatusBarOverriderPost15_0.h
//  SimulatorStatusMagic
//
//  Created by Chris Vasselli on 10/14/20.
//  Copyright © 2020 Shiny Development. All rights reserved.
//
/*
 The MIT License (MIT)

 Copyright (c) 2014 Shiny Development

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

#import <Foundation/Foundation.h>

bool isCarrierOverridden(void);
NSString* getCarrierOverride(void);
void setCarrier(NSString* text);
void unsetCarrier(void);
bool isTimeOverridden(void);
NSString* getTimeOverride(void);
void setTime(NSString* text);
void unsetTime(void);
bool isDNDHidden(void);
void hideDND(bool hidden);
bool isDateHidden(void);
void hideDate(bool hidden);
bool isAirplaneHidden(void);
void hideAirplane(bool hidden);
bool isCellHidden(void);
void hideCell(bool hidden);
bool isWiFiHidden(void);
void hideWiFi(bool hidden);
bool isBatteryHidden(void);
void hideBattery(bool hidden);
bool isBluetoothHidden(void);
void hideBluetooth(bool hidden);
bool isAlarmHidden(void);
void hideAlarm(bool hidden);
bool isLocationHidden(void);
void hideLocation(bool hidden);
bool isRotationHidden(void);
void hideRotation(bool hidden);
bool isAirPlayHidden(void);
void hideAirPlay(bool hidden);
bool isCarPlayHidden(void);
void hideCarPlay(bool hidden);
bool isVPNHidden(void);
void hideVPN(bool hidden);
