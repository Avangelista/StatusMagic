//
//  SDStatusBarOverriderPost14_0.m
//  SimulatorStatusMagic
//
//  Created by Chris Vasselli on 10/14/20.
//  Copyright © 2020 Shiny Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusSetter14.h"

typedef NS_ENUM(int, StatusBarItem) {
  TimeStatusBarItem = 0,
  DateStatusBarItem = 1,
  QuietModeStatusBarItem = 2,
  AirplaneModeStatusBarItem = 3,
  CellularSignalStrengthStatusBarItem = 4,
  SecondaryCellularSignalStrengthStatusBarItem = 5,
  CellularServiceStatusBarItem = 6,
  SecondaryCellularServiceStatusBarItem = 7,
  // 8
  CellularDataNetworkStatusBarItem = 9,
  SecondaryCellularDataNetworkStatusBarItem = 10,
  // 11
  MainBatteryStatusBarItem = 12,
  ProminentlyShowBatteryDetailStatusBarItem = 13,
  // 14
  // 15
  BluetoothStatusBarItem = 16,
  TTYStatusBarItem = 17,
  AlarmStatusBarItem = 18,
  // 19
  // 20
  LocationStatusBarItem = 21,
  RotationLockStatusBarItem = 22,
  // 23
  AirPlayStatusBarItem = 24,
  AssistantStatusBarItem = 25,
  CarPlayStatusBarItem = 26,
  StudentStatusBarItem = 27,
  VPNStatusBarItem = 28,
  // 29
  // 30
  // 31
  // 32
  // 33
  // 34
  // 35
  // 36
  // 37
  LiquidDetectionStatusBarItem = 38,
  VoiceControlStatusBarItem = 39,
  // 40
  // 41
};

typedef NS_ENUM(unsigned int, BatteryState) {
  BatteryStateUnplugged = 0
};

typedef struct {
  bool itemIsEnabled[43];
  char timeString[64];
  char shortTimeString[64];
  char dateString[256];
  int gsmSignalStrengthRaw;
  int secondaryGsmSignalStrengthRaw;
  int gsmSignalStrengthBars;
  int secondaryGsmSignalStrengthBars;
  char serviceString[100];
  char secondaryServiceString[100];
  char serviceCrossfadeString[100];
  char secondaryServiceCrossfadeString[100];
  char serviceImages[2][100];
  char operatorDirectory[1024];
  unsigned int serviceContentType;
  unsigned int secondaryServiceContentType;
  unsigned int cellLowDataModeActive:1;
  unsigned int secondaryCellLowDataModeActive:1;
  int wifiSignalStrengthRaw;
  int wifiSignalStrengthBars;
  unsigned int wifiLowDataModeActive:1;
  unsigned int dataNetworkType;
  unsigned int secondaryDataNetworkType;
  int batteryCapacity;
  unsigned int batteryState;
  char batteryDetailString[150];
  int bluetoothBatteryCapacity;
  int thermalColor;
  unsigned int thermalSunlightMode : 1;
  unsigned int slowActivity : 1;
  unsigned int syncActivity : 1;
  char activityDisplayId[256];
  unsigned int bluetoothConnected : 1;
  unsigned int displayRawGSMSignal : 1;
  unsigned int displayRawWifiSignal : 1;
  unsigned int locationIconType : 1;
  unsigned int voiceControlIconType:2;
  unsigned int quietModeInactive : 1;
  unsigned int tetheringConnectionCount;
  unsigned int batterySaverModeActive : 1;
  unsigned int deviceIsRTL : 1;
  unsigned int lock : 1;
  char breadcrumbTitle[256];
  char breadcrumbSecondaryTitle[256];
  char personName[100];
  unsigned int electronicTollCollectionAvailable : 1;
  unsigned int radarAvailable : 1;
  unsigned int wifiLinkWarning : 1;
  unsigned int wifiSearching : 1;
  double backgroundActivityDisplayStartDate;
  unsigned int shouldShowEmergencyOnlyStatus : 1;
  unsigned int secondaryCellularConfigured : 1;
  char primaryServiceBadgeString[100];
  char secondaryServiceBadgeString[100];
} StatusBarRawData;

typedef struct {
  bool overrideItemIsEnabled[43];
  unsigned int overrideTimeString : 1;
  unsigned int overrideDateString : 1;
  unsigned int overrideGsmSignalStrengthRaw : 1;
  unsigned int overrideSecondaryGsmSignalStrengthRaw : 1;
  unsigned int overrideGsmSignalStrengthBars : 1;
  unsigned int overrideSecondaryGsmSignalStrengthBars : 1;
  unsigned int overrideServiceString : 1;
  unsigned int overrideSecondaryServiceString : 1;
  unsigned int overrideServiceImages : 2;
  unsigned int overrideOperatorDirectory : 1;
  unsigned int overrideServiceContentType : 1;
  unsigned int overrideSecondaryServiceContentType : 1;
  unsigned int overrideWifiSignalStrengthRaw : 1;
  unsigned int overrideWifiSignalStrengthBars : 1;
  unsigned int overrideDataNetworkType : 1;
  unsigned int overrideSecondaryDataNetworkType : 1;
  unsigned int disallowsCellularDataNetworkTypes : 1;
  unsigned int overrideBatteryCapacity : 1;
  unsigned int overrideBatteryState : 1;
  unsigned int overrideBatteryDetailString : 1;
  unsigned int overrideBluetoothBatteryCapacity : 1;
  unsigned int overrideThermalColor : 1;
  unsigned int overrideSlowActivity : 1;
  unsigned int overrideActivityDisplayId : 1;
  unsigned int overrideBluetoothConnected : 1;
  unsigned int overrideBreadcrumb : 1;
  unsigned int overrideLock;
  unsigned int overrideDisplayRawGSMSignal : 1;
  unsigned int overrideDisplayRawWifiSignal : 1;
  unsigned int overridePersonName : 1;
  unsigned int overrideWifiLinkWarning : 1;
  unsigned int overrideSecondaryCellularConfigured : 1;
  unsigned int overridePrimaryServiceBadgeString : 1;
  unsigned int overrideSecondaryServiceBadgeString : 1;
  StatusBarRawData values;
} StatusBarOverrideData;

@class UIStatusBarServer;

@protocol UIStatusBarServerClient

@required

- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveDoubleHeightStatusString:(NSString *)arg2 forStyle:(long long)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveGlowAnimationState:(bool)arg2 forStyle:(long long)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveStatusBarData:(const StatusBarRawData *)arg2 withActions:(int)arg3;
- (void)statusBarServer:(UIStatusBarServer *)arg1 didReceiveStyleOverrides:(int)arg2;

@end

@interface UIStatusBarServer : NSObject

@property (nonatomic, strong) id<UIStatusBarServerClient> statusBar;

+ (void)postStatusBarOverrideData:(StatusBarOverrideData *)arg1;
+ (void)permanentizeStatusBarOverrideData;
+ (StatusBarOverrideData *)getStatusBarOverrideData;

@end
