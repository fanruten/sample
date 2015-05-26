//
//  ViewController.h
//  StretchyHeaders
//
//  Created by Nick Jensen on 12/26/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "TransitionManager.h"

extern NSString * const kCellIdent;
extern NSString * const kHeaderIdent;

@interface CardViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    BOOL isScrolled;
}

@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UICollectionReusableView *header;

@property (nonatomic, readonly) CGFloat headerHeight;

@property (nonatomic, strong) TransitionManager *transitionManager;

@end
