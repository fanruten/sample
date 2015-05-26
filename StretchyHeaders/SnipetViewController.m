//
//  RootViewController.m
//  StretchyHeaders
//
//  Created by Ruslan V. Gumennyy on 26/05/15.
//  Copyright (c) 2015 Nick Jensen. All rights reserved.
//

#import "SnipetViewController.h"

@interface SnipetViewController ()

@end

@implementation SnipetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    frame.origin.y = frame.size.height - self.snipetHeigth;
    frame.size.height = self.snipetHeigth;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.numberOfLines = 0;
    label.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    [view addSubview:label];
}

- (CGFloat)snipetHeigth
{
    return 200.0f;
}

@end
