//
//  GLRNManager.m
//  Pods
//
//  Created by Allen Hsu on 01/04/2017.
//
//

#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridge+Private.h>
#import <React/RCTAssert.h>
#import "GLRNManager.h"

NSString * const GLRNNotificationBundleWillUpdate   = @"GLRNNotificationBundleWillUpdate";
NSString * const GLRNNotificationBundleDidUpdate    = @"GLRNNotificationBundleDidUpdate";
NSString * const GLRNNotificationBundleFailedUpdate = @"GLRNNotificationBundleFailedUpdate";

RCTFatalHandler fatalHandler = ^(NSError *error) {
    if (error) {
        [[GLRNManager defaultManager] reportError:error];
    }
};

@interface GLRNManager()

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

@end

@implementation GLRNManager

@synthesize sharedBridge=_sharedBridge;

+ (GLRNManager *)defaultManager {
    static GLRNManager *sManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sManager = [[GLRNManager alloc] init];
        [sManager setupRCT];
    });
    return sManager;
}


- (void)reportError:(NSError *)error {
    if (error && [self.delegate respondsToSelector:@selector(rn_reportError:)]) {
        [self.delegate rn_reportError:error];
    }
}

- (void)setupRCT {
    RCTSetFatalHandler(fatalHandler);
}

- (BOOL)isDevMode {
    if ([self.delegate respondsToSelector:@selector(rn_devMode)]) {
        return [self.delegate rn_devMode];
    }
    return NO;
}

- (NSURL *)devJSBundleURL {
    if ([self.delegate respondsToSelector:@selector(rn_devJSBUndleURL)]) {
        return [self.delegate rn_devJSBUndleURL];
    }
    return nil;
}

- (RCTBridge *)sharedBridge {
    @synchronized (self) {
        if (!_sharedBridge) {
            NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"main" fallbackResource:@"main"];
            _sharedBridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation moduleProvider:nil launchOptions:nil];
        }
        return _sharedBridge;
    }
}

- (void)resetSharedBridge {
    @synchronized (self) {
        _sharedBridge = nil;
    }
}

- (nullable RCTRootView *)rootViewForURLString:(nonnull NSString *)urlString props:(NSDictionary *)props {
    RCTBridge *bridge = self.sharedBridge;
    NSString *module = @"main";
    if (!bridge || !module) {
        return nil;
    }
    NSLog(@"Loading RN view with bundle: %@, props: %@", bridge.bundleURL.absoluteString, props);
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:module initialProperties:props];
    return rootView;
}

@end
