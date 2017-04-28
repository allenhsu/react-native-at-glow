//
//  GLNavigator.m
//  GLFoundation
//
//  Created by Allen Hsu on 8/25/16.
//  Copyright © 2016 Glow, Inc. All rights reserved.
//

#import "GLNavigator.h"

@implementation GLNavigator

+ (UIViewController *)topViewController {
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    return [self topViewControllerFromViewController:rootViewController];
}

+ (UINavigationController *)topNavigationViewController{
    return [[self topViewController] navigationController];
}

/**
 *  Get top view controller in view hierarchy that given viewcontroller is in.
 *
 *  @param viewController Given view controller instance, used to search in the view hierarchy it is in.
 *
 *  @return Top most UIViewController instance.
 */
+ (UIViewController *)topViewControllerFromViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self topViewControllerFromViewController:[navigationController topViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self topViewControllerFromViewController:tabBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil && !viewController.presentedViewController.isBeingDismissed) {
        return [self topViewControllerFromViewController:viewController.presentedViewController];
    } else if ([viewController conformsToProtocol:@protocol(GLIntermediateViewController)] && [viewController respondsToSelector:@selector(topViewControllerForNavigator)]) {
        id<GLIntermediateViewController> vc = (id<GLIntermediateViewController>)viewController;
        return [self topViewControllerFromViewController:[vc topViewControllerForNavigator]];
    }
    return viewController;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) {
        return;
    }
    UINavigationController *navigationController = [self topNavigationViewController];
    [navigationController pushViewController:viewController animated:animated];
}

+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    if (!viewController) {
        return;
    }
    UIViewController *topViewController = [self topViewController];
    [topViewController presentViewController:viewController animated:animated completion:completion];
}

+ (void)presentNavigationViewControllerWithRootViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if (!viewController) {
        return;
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self presentViewController:viewController animated:animated completion:completion];
    } else {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentViewController:navigationController animated:animated completion:completion];
    }
}

@end
