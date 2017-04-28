//
//  GLNavigator.h
//  GLFoundation
//
//  Created by Allen Hsu on 8/25/16.
//  Copyright © 2016 Glow, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This protocol represents an intermediate view controller's behaviour.
 */
@protocol GLIntermediateViewController <NSObject>

/**
 *  Returns top view controller.
 *
 *  @return UIViewController instance as top view controller.
 */
- (UIViewController * _Nonnull)topViewControllerForNavigator;

@end

/**
 *  This class manages view controllers hierarchy on a global way.
 */
@interface GLNavigator : NSObject

///---------------------------------------------------------------------------------------
/// @name Access Top View Controllers
///---------------------------------------------------------------------------------------

/**
 *  Get top most UIViewController instance from current view hierarchy.
 *
 *  @return UIViewController instance at top.
 */
+ (UIViewController * _Nonnull)topViewController;
/**
 *  Get the navigation view controller of the top most view controller.
 *
 *  @return Navigation controller of the top most view controller.
 */
+ (UINavigationController * _Nonnull)topNavigationViewController;


///---------------------------------------------------------------------------------------
/// @name Present View Controllers
///---------------------------------------------------------------------------------------

/**
 *  Pushes view controller to current navigation controller's stack.
 *
 *  @param viewController Target view controller to be pushed.
 *  @param animated       Bool value to indicate if to animate the presentation.
 */
+ (void)pushViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated;
/**
 *  Present view controller on current top most view controller.
 *
 *  @param viewController Target view controller to present.
 *  @param animated       Bool value to indicate if to animate the presentation.
 *  @param completion     Callback block when presentation is done.
 */
+ (void)presentViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
/**
 *  Present view controller with nagivation controller for it.
 *
 *  @param viewController Target view controller to present, if it is a navigation controller, just present it. If it is not a navigation controller, initiate one and set viewcontroller as root view controller, then present the navigation controller.
 *  @param animated       Bool value to indicate if to animate the presentation.
 *  @param completion     Callback block when presentation is done.
 */
+ (void)presentNavigationViewControllerWithRootViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end
