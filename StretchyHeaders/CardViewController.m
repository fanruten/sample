//
//  ViewController.m
//  StretchyHeaders
//
//  Created by Nick Jensen on 12/26/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "CardViewController.h"
#import "StretchyHeaderCollectionViewLayout.h"

NSString * const kCellIdent = @"Cell";
NSString * const kHeaderIdent = @"Header";

@interface CardViewController ()

@property (nonatomic, assign) BOOL canelationBegin;
@property (nonatomic, assign) BOOL dragging;

@end

@implementation CardViewController {
     const char kKvoContext;
}

@synthesize collectionView, header;

- (void)loadView
{    
    [super loadView];
    
    CGRect bounds;
    bounds = [[self view] bounds];
    
    StretchyHeaderCollectionViewLayout *stretchyLayout;
    stretchyLayout = [[StretchyHeaderCollectionViewLayout alloc] init];
    [stretchyLayout setSectionInset:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [stretchyLayout setItemSize:CGSizeMake(300.0, 494.0)];
    [stretchyLayout setHeaderReferenceSize:CGSizeMake(320.0, self.headerHeight)];
    
    collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:stretchyLayout];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView setAlwaysBounceVertical:YES];
    [collectionView setShowsVerticalScrollIndicator:NO];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [[self view] addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:kCellIdent];
    
    [collectionView registerClass:[UICollectionReusableView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:kHeaderIdent];
    
    [collectionView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                         context:(void *)&kKvoContext];
}

- (void)dealloc
{
    [collectionView removeObserver:self forKeyPath:@"contentOffset" context:(void *)&kKvoContext];
}

- (CGFloat)headerHeight
{
    return 150.0f;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)cv {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (!header) {
        
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:kHeaderIdent
                                                           forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        //
        //        CGRect bounds;
        //        bounds = [header bounds];
        //
        //        UIImageView *imageView;
        //        imageView = [[UIImageView alloc] initWithFrame:bounds];
        //        [imageView setImage:[UIImage imageNamed:@"header-background"]];
        //        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        //        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        //        [imageView setClipsToBounds:YES];
        //        [header addSubview:imageView];
        //        [imageView release];
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdent
                                                     forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                (id)[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0f], NSFontAttributeName,
                                (id)[UIColor lightGrayColor], NSForegroundColorAttributeName, nil];
    
    NSAttributedString *attrText;
    attrText = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                                               attributes:attributes];
    UILabel *label = [[UILabel alloc] init];
    [label setNumberOfLines:0];
    [label setAttributedText:attrText];
    [cell addSubview:label];
    
    CGRect textRect = CGRectZero;
    textRect.size = [label sizeThatFits:[cell bounds].size];
    [label setFrame:textRect];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [button setTitle:@"Next" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextTapped) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:button];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextTapped
{
    CardViewController *modalController = [[CardViewController alloc] init];
    modalController.transitionManager = self.transitionManager;
    [self.navigationController pushViewController:modalController animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == (void *)&kKvoContext) {
        if ([keyPath isEqual:@"contentOffset"]) {
            NSValue *codedOldPoint = change[NSKeyValueChangeOldKey];
            CGPoint oldPoint = [codedOldPoint CGPointValue];
            
            NSValue *codedNewPoint = change[NSKeyValueChangeNewKey];
            CGPoint newPoint = [codedNewPoint CGPointValue];
            
            CGFloat pointY = -self.header.frame.origin.y;
            CGFloat progress = pointY / 150;
            if (progress < 0) progress = 0.0f;
            if (progress > 1) progress = 1.0f;
          //  NSLog(@"pr3: %f", progress);
            
//            NSLog(@"y== %@", NSStringFromCGRect(self.header.frame));
//            
//            // /
//            CGFloat progress = -(newPoint.y + 64) / self.collectionView.frame.size.height;
//            if (progress < 0) progress = 0.0f;
//            if (progress > 1) progress = 1.0f;
//            NSLog(@"pr3: %f pr4: %f", progress, progress2);
//            
            
      
            //  NSLog(@"%@ %@ %f", NSStringFromCGPoint(point), NSStringFromCGPoint(newPoint), point.y - newPoint.y);
            
            
            if (self.dragging) {
                if (!self.canelationBegin) {
                    if (progress > 0.01f) {
                        self.canelationBegin = YES;
                        self.transitionManager.interactiveEnabled = YES;
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } else {
                    [self.transitionManager updateInteractiveTransition:progress];
                }
            }
           
        }
    }
    else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    self.dragging = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.dragging = NO;
    
    CGPoint newPoint = scrollView.contentOffset;
    CGFloat pointY = -self.header.frame.origin.y;
    CGFloat progress = pointY / 145;
    if (progress < 0) progress = 0.0f;
    if (progress > 1) progress = 1.0f;
    NSLog(@"pr3 on end: %f", progress);
    
    if (self.canelationBegin) {
        if (progress > 0.2f) {
            [self.transitionManager finishInteractiveTransition];
            *targetContentOffset = CGPointMake(0, scrollView.contentOffset.y);
        } else {
            [self.transitionManager cancelInteractiveTransition];
        }
        
        self.transitionManager.interactiveEnabled = NO;
        
        self.canelationBegin = NO;
    }
}

@end