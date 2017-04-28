//
//  GLRNManager.h
//  Pods
//
//  Created by Allen Hsu on 01/04/2017.
//
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTRootView.h>

extern NSString * __nonnull const GLRNNotificationBundleWillUpdate;
extern NSString * __nonnull const GLRNNotificationBundleDidUpdate;
extern NSString * __nonnull const GLRNNotificationBundleFailedUpdate;

@protocol GLRNManagerDelegate <NSObject>

@required

@optional
- (BOOL)rn_devMode;
- (nullable NSURL *)rn_devJSBUndleURL;
- (void)rn_reportError:(nonnull NSError *)error;

@end

@interface GLRNManager : NSObject

@property (readonly, atomic, nullable) RCTBridge *sharedBridge;
@property (nonatomic, weak, nullable) id <GLRNManagerDelegate>delegate;

+ (nonnull GLRNManager *)defaultManager;
- (nullable RCTRootView *)rootViewForURLString:(nonnull NSString *)urlString props:(nullable NSDictionary *)props;

- (void)reportError:(nonnull NSError *)error;

@end
