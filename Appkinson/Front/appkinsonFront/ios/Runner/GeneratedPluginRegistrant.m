//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<animated_theme_switcher/AnimatedThemeSwitcherPlugin.h>)
#import <animated_theme_switcher/AnimatedThemeSwitcherPlugin.h>
#else
@import animated_theme_switcher;
#endif

#if __has_include(<image_cropper/FLTImageCropperPlugin.h>)
#import <image_cropper/FLTImageCropperPlugin.h>
#else
@import image_cropper;
#endif

#if __has_include(<image_picker/FLTImagePickerPlugin.h>)
#import <image_picker/FLTImagePickerPlugin.h>
#else
@import image_picker;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AnimatedThemeSwitcherPlugin registerWithRegistrar:[registry registrarForPlugin:@"AnimatedThemeSwitcherPlugin"]];
  [FLTImageCropperPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImageCropperPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
}

@end
