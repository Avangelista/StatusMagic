#pragma once
#import <Foundation/Foundation.h>

typedef NS_OPTIONS(int, StatusManagerStyle) {
    StatusManagerStyleNone                   = 0,
    StatusManagerStylePhoneCalling           = (1 << 0),
    StatusManagerStyleMicrophoneRecording    = (1 << 2),
    StatusManagerStyleHotspot                = (1 << 3),
    StatusManagerStyleCameraCalling          = (1 << 4),
    StatusManagerStyleAirPlay                = (1 << 5),
    StatusManagerStyleNavigation             = (1 << 6),
    StatusManagerStylePurple                 = (1 << 8),  // Siri
    StatusManagerStyleWiredAdapter           = (1 << 9),
    StatusManagerStyleCarPlay                = (1 << 12),
    StatusManagerStyleSettings               = (1 << 13),
    StatusManagerStyleMirroring              = (1 << 14),
    StatusManagerStyleActivity               = (1 << 15),
    StatusManagerStyleSOS                    = (1 << 16),
    StatusManagerStyleCameraRecording        = (1 << 17),
    StatusManagerStyleAirPrint               = (1 << 18),
    StatusManagerStyleDiagnosis              = (1 << 19),
    StatusManagerStyleScreenRecording        = (1 << 20),
    StatusManagerStyleIncomingPhoneCalling   = (1 << 27),
    StatusManagerStyleIncomingCameraCalling  = (1 << 28),
};

@interface StatusManager : NSObject

+ (StatusManager *)sharedInstance;

- (bool) isMDCMode;
- (void) setIsMDCMode:(bool)mode;
- (bool) isCarrierOverridden;
- (NSString*) getCarrierOverride;
- (void) setCarrier:(NSString*)text;
- (void) unsetCarrier;
- (bool) isTimeOverridden;
- (NSString*) getTimeOverride;
- (void) setTime:(NSString*)text;
- (void) unsetTime;
- (bool) isCrumbOverridden;
- (NSString*) getCrumbOverride;
- (void) setCrumb:(NSString*)text;
- (void) unsetCrumb;
- (bool) isClockHidden;
- (void) hideClock:(bool)hidden;
- (bool) isDNDHidden;
- (void) hideDND:(bool)hidden;
- (bool) isAirplaneHidden;
- (void) hideAirplane:(bool)hidden;
- (bool) isCellHidden;
- (void) hideCell:(bool)hidden;
- (bool) isWiFiHidden;
- (void) hideWiFi:(bool)hidden;
- (bool) isBatteryHidden;
- (void) hideBattery:(bool)hidden;
- (bool) isBluetoothHidden;
- (void) hideBluetooth:(bool)hidden;
- (bool) isAlarmHidden;
- (void) hideAlarm:(bool)hidden;
- (bool) isLocationHidden;
- (void) hideLocation:(bool)hidden;
- (bool) isRotationHidden;
- (void) hideRotation:(bool)hidden;
- (bool) isAirPlayHidden;
- (void) hideAirPlay:(bool)hidden;
- (bool) isCarPlayHidden;
- (void) hideCarPlay:(bool)hidden;
- (bool) isVPNHidden;
- (void) hideVPN:(bool)hidden;
- (bool) isMicrophoneUseHidden;
- (void) hideMicrophoneUse:(bool)hidden;
- (bool) isCameraUseHidden;
- (void) hideCameraUse:(bool)hidden;

- (bool) hasStyleOverrides:(StatusManagerStyle)style;
- (void) addStyleOverrides:(StatusManagerStyle)style;
- (void) removeStyleOverrides:(StatusManagerStyle)style;

@end
