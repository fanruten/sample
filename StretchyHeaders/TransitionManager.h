//
//  TransitionManager.h
//  StretchyHeaders
//
//  Created by Ruslan V. Gumennyy on 26/05/15.
//  Copyright (c) 2015 Nick Jensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionManager : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

@property (nonatomic, assign) UINavigationControllerOperation operation;

@property (nonatomic, assign) BOOL interactiveEnabled;

@end


