/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#import "GLRNViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *rootViewController = [[UITabBarController alloc] init];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        GLRNViewController *vc = [GLRNViewController rnViewControllerWithURL:@"/"];
        GLRNNavigationController *nav = [[GLRNNavigationController alloc] initWithRootViewController:vc];
        NSString *title = [NSString stringWithFormat:@"Tab #%d", i];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:i];
        [vcs addObject:nav];
    }
    rootViewController.viewControllers = vcs;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
