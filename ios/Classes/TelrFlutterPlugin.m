#import "TelrFlutterPlugin.h"
#if __has_include(<telr_flutter/telr_flutter-Swift.h>)
#import <telr_flutter/telr_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "telr_flutter-Swift.h"
#endif

@implementation TelrFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTelrFlutterPlugin registerWithRegistrar:registrar];
}
@end
