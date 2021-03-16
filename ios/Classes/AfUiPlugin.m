#import "AfUiPlugin.h"
#if __has_include(<af_ui/af_ui-Swift.h>)
#import <af_ui/af_ui-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "af_ui-Swift.h"
#endif

@implementation AfUiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAfUiPlugin registerWithRegistrar:registrar];
}
@end
