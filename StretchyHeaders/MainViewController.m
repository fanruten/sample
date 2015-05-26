//
//  MainViewController.m
//  StretchyHeaders
//
//  Created by Ruslan V. Gumennyy on 26/05/15.
//  Copyright (c) 2015 Nick Jensen. All rights reserved.
//

#import "MainViewController.h"
#import "CardViewController.h"
#import "SnipetViewController.h"
#import "TransitionManager.h"

@interface MainViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) TransitionManager *transitionManager;
@property (nonatomic, strong) SnipetViewController *snipetController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitionManager = [[TransitionManager alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"header-background"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    self.snipetController= [[SnipetViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.snipetController];
    self.navigationController.delegate = self.transitionManager;

    self.navigationController.view.frame = self.view.frame;
    [self.view addSubview:self.navigationController.view];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandler:)];
    [self.snipetController.view.subviews[0] addGestureRecognizer:panGesture];
}

- (void)panGestureHandler:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.navigationController.view];
    static CGPoint startLocation;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startLocation = location;
    }
    CGFloat progress = (startLocation.y - location.y) / (self.snipetController.view.frame.size.height - self.snipetController.snipetHeigth);
    if (progress < 0) progress = 0;
    if (progress > 1) progress = 1;
    NSLog(@"pr1: %f", progress);
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CardViewController *modalController = [[CardViewController alloc] init];
        modalController.transitionManager = self.transitionManager;
        modalController.transitionManager.interactiveEnabled = YES;
        [self.navigationController pushViewController:modalController animated:YES];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.30f) {
            [self.transitionManager finishInteractiveTransition];
        } else {
            [self.transitionManager cancelInteractiveTransition];
        }
        self.transitionManager.interactiveEnabled = NO;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self.transitionManager updateInteractiveTransition:progress];
    }
}

@end





