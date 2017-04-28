//
//  GLRNNavigator.h
//  CommunityReactNative
//
//  Created by Allen Hsu on 03/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface GLRNNavigator : NSObject <RCTBridgeModule>

+ (void)openURL:(NSString *)url options:(NSDictionary *)options;
+ (void)showURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options;
+ (void)pushURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options;
+ (void)presentURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options;
+ (void)pop;
+ (void)dismiss;
+ (void)popOrDismiss;

@end
