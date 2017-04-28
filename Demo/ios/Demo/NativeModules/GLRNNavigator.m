//
//  GLRNNavigator.m
//  CommunityReactNative
//
//  Created by Allen Hsu on 03/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTRootView.h>
#import <SafariServices/SafariServices.h>

#import "GLNavigator.h"
#import "GLRNNavigator.h"
#import "GLRNViewController.h"
#import "GLRNNavigationController.h"

@implementation GLRNNavigator

RCT_EXPORT_MODULE(NativeNavigator);

+ (void)openURL:(NSString *)url options:(NSDictionary *)options {
    if (!url) {
        return;
    }
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [GLNavigator presentViewController:vc animated:YES completion:nil];
}

+ (void)showURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options {
    UIViewController *vc = [GLRNViewController rnViewControllerWithURL:url initialProps:initialProps options:options];
    UINavigationController *nav = [GLNavigator topNavigationViewController];
    if ([nav isKindOfClass:[GLRNNavigationController class]]) {
        [nav pushViewController:vc animated:YES];
    } else {
        GLRNNavigationController *nav = [[GLRNNavigationController alloc] initWithRootViewController:vc];
        [GLNavigator presentViewController:nav animated:YES completion:nil];
    }
}

+ (void)pushURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options {
    [self showURL:url initialProps:initialProps options:options];
}

+ (void)presentURL:(NSString *)url initialProps:(NSDictionary *)initialProps options:(NSDictionary *)options {
    UIViewController *vc = [GLRNViewController rnViewControllerWithURL:url initialProps:initialProps options:options];
    GLRNNavigationController *nav = [[GLRNNavigationController alloc] initWithRootViewController:vc];
    [GLNavigator presentViewController:nav animated:YES completion:nil];
}

+ (void)pop {
    UIViewController *vc = [GLNavigator topViewController];
    if (vc.navigationController.viewControllers.count > 1) {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

+ (void)dismiss {
    UIViewController *vc = [GLNavigator topViewController];
    if (vc.presentingViewController) {
        [vc.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (void)popOrDismiss {
    UIViewController *vc = [GLNavigator topViewController];
    if (vc.navigationController.viewControllers.count > 1) {
        [vc.navigationController popViewControllerAnimated:YES];
    } else if (vc.presentingViewController) {
        [vc.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(openURL:(NSString *)url
                  options:(NSDictionary *)options
                  )
{
    [self.class openURL:url options:options];
}

RCT_EXPORT_METHOD(showURL:(NSString *)url
                  initialProps:(NSDictionary *)initialProps
                  options:(NSDictionary *)options
                  )
{
    [self.class showURL:url initialProps:initialProps options:options];
}

RCT_EXPORT_METHOD(pushURL:(NSString *)url
                  initialProps:(NSDictionary *)initialProps
                  options:(NSDictionary *)options
                  )
{
    [self.class showURL:url initialProps:initialProps options:options];
}

RCT_EXPORT_METHOD(presentURL:(NSString *)url
                  initialProps:(NSDictionary *)initialProps
                  options:(NSDictionary *)options
                  )
{
    [self.class presentURL:url initialProps:initialProps options:options];
}

RCT_EXPORT_METHOD(pop)
{
    [self.class pop];
}

RCT_EXPORT_METHOD(dismiss)
{
    [self.class dismiss];
}

RCT_EXPORT_METHOD(popOrDismiss)
{
    [self.class popOrDismiss];
}

@end
