//
//  DSPageControl.h
//  MIDemo
//
//  Created by houxq on 2017/6/12.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSPageControl : UIPageControl

@property (nonatomic, strong) UIImage *pageIndicatorImage;
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;

@property (nonatomic) CGFloat dotViewMargin;
@property (nonatomic) CGSize dotViewSize;

@end
