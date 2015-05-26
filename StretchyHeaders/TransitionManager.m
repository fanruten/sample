//
//  TransitionManager.m
//  StretchyHeaders
//
//  Created by Ruslan V. Gumennyy on 26/05/15.
//  Copyright (c) 2015 Nick Jensen. All rights reserved.
//

#import "TransitionManager.h"

#import "CardViewController.h"
#import "SnipetViewController.h"

@interface TransitionManager ()

@end



@implementation TransitionManager

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    CGFloat offset = 145;
    const CGFloat kAnimationTime = 0.4f;
    
    if ([fromVC isKindOfClass:[SnipetViewController class]] &&
        [toVC isKindOfClass:[CardViewController class]]
        && self.operation == UINavigationControllerOperationPush) {
        
        CGRect finalToFrame = toVC.view.frame;
        
        UIView *container = [transitionContext containerView];
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        fromVC.view.frame = sourceRect;
        
        CGRect frame = toVC.view.frame;
        frame.origin.y += offset;
        toVC.view.frame = frame;
        
        [UIView animateWithDuration:kAnimationTime
                         animations:^{
                             
                             CGRect frame = fromVC.view.frame;
                             frame.origin.y = -offset;
                             fromVC.view.frame = frame;
                             fromVC.view.alpha = 0.0f;
                             
                             toVC.view.frame = finalToFrame;
                             
                         } completion:^(BOOL finished) {
                             fromVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             
                         }];
    }
    else if ([fromVC isKindOfClass:[CardViewController class]] &&
        [toVC isKindOfClass:[SnipetViewController class]]
        && self.operation == UINavigationControllerOperationPop) {
        
        CGRect finalToFrame = toVC.view.frame;
        
        UIView *container = [transitionContext containerView];
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        fromVC.view.frame = sourceRect;
        
        CGRect frame = toVC.view.frame;
        frame.origin.y -= offset;
        toVC.view.frame = frame;
        
        // toVC.view.alpha = 0.0f;
        
        [UIView animateWithDuration:kAnimationTime
         //                              delay:0.0
         //             usingSpringWithDamping:0.8
         //              initialSpringVelocity:6.0
         //                            options:UIViewAnimationOptionCurveEaseIn
         
                         animations:^{
                             
                             fromVC.view.alpha = 0.0f;
                             
                             CGRect frame = fromVC.view.frame;
                             frame.origin.y += offset;
                             //                       fromVC.view.frame = frame;
                             
                             toVC.view.frame = finalToFrame;
                             toVC.view.alpha = 1.0f;
                             
                         } completion:^(BOOL finished) {
                             fromVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    else if (self.operation == UINavigationControllerOperationPush) {
        CGRect finalToFrame = toVC.view.frame;
        
        UIView *container = [transitionContext containerView];
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        fromVC.view.frame = sourceRect;
        
        CGRect frame = toVC.view.frame;
        frame.origin.x += frame.size.width;
        toVC.view.frame = frame;
        
        [UIView animateWithDuration:kAnimationTime
                         animations:^{
                             
                             CGRect frame = fromVC.view.frame;
                             frame.origin.x -= frame.size.width;
                             fromVC.view.frame = frame;
                             
                             toVC.view.frame = finalToFrame;
                             
                         } completion:^(BOOL finished) {
                             fromVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             
                         }];

    } else if (self.operation == UINavigationControllerOperationPop) {
        CGRect finalToFrame = toVC.view.frame;
        
        UIView *container = [transitionContext containerView];
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        fromVC.view.frame = sourceRect;
        
        CGRect frame = toVC.view.frame;
        frame.origin.x -= frame.size.width;
        toVC.view.frame = frame;
        
        
        [UIView animateWithDuration:kAnimationTime
         //                              delay:0.0
         //             usingSpringWithDamping:0.8
         //              initialSpringVelocity:6.0
         //                            options:UIViewAnimationOptionCurveEaseIn
         
                         animations:^{
                             
                             CGRect frame = fromVC.view.frame;
                             frame.origin.x += frame.size.width;
                             fromVC.view.frame = frame;
                             
                             toVC.view.frame = finalToFrame;
                             
                         } completion:^(BOOL finished) {
                             fromVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    
    
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (self.interactiveEnabled) {
        return self;
    } else {
        return nil;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    return self;
}

@end