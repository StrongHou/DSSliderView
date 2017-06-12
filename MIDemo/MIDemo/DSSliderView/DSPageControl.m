//
//  DSPageControl.m
//  MIDemo
//
//  Created by houxq on 2017/6/12.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSPageControl.h"

@implementation DSPageControl


 - (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    self.backgroundColor  =[UIColor blackColor];
//    if(self.currentPageIndicatorImage && self.pageIndicatorImage){
//        [self setUpDots];
//    }
}

- (void)setUpDots
{
    for (int i=0; i<self.subviews.count; i++) {
        UIView* dot = self.subviews[i];
       if (dot.subviews.count == 0) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.dotViewSize.width, self.dotViewSize.height)];
            [dot addSubview:imageView];
        };
        UIImageView *imageView = dot.subviews[0];
        if (i == self.currentPage) {
            imageView.image=self.currentPageIndicatorImage;
            dot.backgroundColor = [UIColor clearColor];
        }else {
            imageView.image=self.pageIndicatorImage;
            dot.backgroundColor = [UIColor clearColor];
        }
    }
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    for(int i =0 ; i < self.subviews.count; i++){
//        UIView* dot = self.subviews[i];
//        dot.frame = CGRectMake(dot.frame.origin.x-[self margin]*i, dot.frame.origin.y
//                               , self.dotViewSize.width, self.dotViewSize.height);
//    }
//    
//    self.backgroundColor  =[UIColor blackColor];
//}

- (CGSize)dotViewSize
{
    if(_dotViewSize.width == 0 || _dotViewSize.height ==0){
        _dotViewSize = CGSizeMake(7, 7);
    }
    return _dotViewSize;
}



- (CGFloat)margin
{
    CGFloat margin = self.dotViewMargin;
    if(self.currentPageIndicatorImage && self.pageIndicatorImage){
        margin = self.dotViewMargin + self.dotViewSize.width - 7;
    }
    return 9-margin;
}

@end
