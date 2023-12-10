#import "ReceiveSharingIntentPlusPlugin.h"
#import <receive_sharing_intent_plus/receive_sharing_intent_plus-Swift.h>

@implementation ReceiveSharingIntentPlusPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftReceiveSharingIntentPlusPlugin registerWithRegistrar:registrar];
}

@end
