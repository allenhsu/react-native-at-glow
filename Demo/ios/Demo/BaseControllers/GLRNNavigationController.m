//
//  GLRNNavigationController.m
//  CommunityReactNative
//
//  Created by Allen Hsu on 07/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "GLRNNavigationController.h"
#import <React/RCTLog.h>
#import <React/RCTTouchHandler.h>
#import "GLRNManager.h"
#import "GLRNViewController.h"

@interface GLRNNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation GLRNNavigationController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.interactivePopGestureRecognizer.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsbundleDidUpdate:) name:GLRNNotificationBundleDidUpdate object:nil];
}

- (void)jsbundleDidUpdate:(NSNotification *)notification {
    NSMutableArray *newViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    UIViewController *vc = [self.viewControllers firstObject];
    if ([vc isKindOfClass:[GLRNViewController class]]) {
        GLRNViewController *rnvc = (GLRNViewController *)vc;
        GLRNViewController *newVc = [GLRNViewController rnViewControllerWithURL:rnvc.url initialProps:rnvc.initialProps options:rnvc.options];
        [newViewControllers replaceObjectAtIndex:0 withObject:newVc];
        [self setViewControllers:newViewControllers];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
