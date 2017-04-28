//
//  GLRNViewController.m
//  CommunityReactNative
//
//  Created by Allen Hsu on 07/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTRootView.h>
#import "GLRNViewController.h"
#import "GLRNManager.h"

@interface GLRNViewController ()

@property (strong, nonatomic) NSNumber *originalNavigationBarHidden;

@end

@implementation GLRNViewController

+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url {
    return [self rnViewControllerWithURL:url initialProps:nil options:nil];
}

+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url initialProps:(NSDictionary *)initialProps {
    return [self rnViewControllerWithURL:url initialProps:initialProps options:nil];
}

+ (GLRNViewController *)rnViewControllerWithURL:(NSString *)url
                                   initialProps:(NSDictionary *)initialProps
                                        options:(NSDictionary *)options
{
    NSMutableDictionary *props = [NSMutableDictionary dictionaryWithDictionary:initialProps];
    if (url) {
        props[@"url"] = url;
    }
    
    GLRNViewController *rootViewController = [GLRNViewController new];
    rootViewController.url = url;
    rootViewController.initialProps = props;
    rootViewController.options = options;
    return rootViewController;
}

- (void)loadView {
    RCTRootView *rootView = [[GLRNManager defaultManager] rootViewForURLString:self.url props:self.initialProps];
    if (rootView) {
        rootView.backgroundColor = [UIColor whiteColor];
        self.view = rootView;
    } else {
        UIView *v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        v.backgroundColor = [UIColor whiteColor];
        self.view = v;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.originalNavigationBarHidden) {
        if (self.navigationController.viewControllers.count < 2) {
            self.originalNavigationBarHidden = @(YES);
        } else {
            self.originalNavigationBarHidden = @(self.navigationController.navigationBarHidden);
        }
    }
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:[self.originalNavigationBarHidden boolValue] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed {
    return self.navigationController.viewControllers.count > 1;
}

- (BOOL)prefersStatusBarHidden {
    NSNumber *val = self.options[@"prefersStatusBarHidden"];
    if (val) {
        return [val boolValue];
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    NSNumber *val = self.options[@"preferredStatusBarStyle"];
    if (val) {
        NSInteger intVal = [val integerValue];
        if (intVal == UIStatusBarStyleLightContent) {
            return UIStatusBarStyleLightContent;
        } else {
            return UIStatusBarStyleDefault;
        }
    }
    return UIStatusBarStyleDefault;
}

@end
