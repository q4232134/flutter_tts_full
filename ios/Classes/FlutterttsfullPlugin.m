#import "FlutterttsfullPlugin.h"
#if __has_include(<flutterttsfull/flutterttsfull-Swift.h>)
#import <flutterttsfull/flutterttsfull-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterttsfull-Swift.h"
#endif

@implementation FlutterttsfullPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterttsfullPlugin registerWithRegistrar:registrar];
}
@end
