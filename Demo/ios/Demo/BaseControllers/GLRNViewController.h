//
//  GLRNViewController.h
//  CommunityReactNative
//
//  Created by Allen Hsu on 07/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import "GLRNNavigationController.h"

@interface GLRNViewController : UIViewController

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDictionary *initialProps;
@property (strong, nonatomic) NSDictionary *options;

+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url;
+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url initialProps:(NSDictionary *)initialProps;
+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options;

@end
