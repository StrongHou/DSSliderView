//
//  DSPageControl.m
//  MIDemo
//
//  Created by houxq on 2017/6/12.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSPageControl.h"

static const CGFloat defaultLeftRightMargin = 15;

@implementation DSPageControl
- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if(self.currentPageIndicatorImage && self.pageIndicatorImage){
        [self setUpDots];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //self frame
    if(!self.superview) return;
    CGFloat pageControlX = self.superview.frame.size.width*0.5;
    CGFloat pageControlY = self.superview.frame.size.height *0.8;
    CGFloat pageControlW = [self pageControlWidth];
    CGFloat pageControlH = [self pageControlHeight];
    // offset
    CGFloat offsetX  = self.pageControlInsets.right - self.pageControlInsets.left;
    CGFloat offsetY = + self.pageControlInsets.bottom - self.pageControlInsets.top;
    switch (self.pageControlMode) {
        case DSPageControlModeBottomCenter:
        {
            self.frame = CGRectMake(0, pageControlY+offsetY, pageControlW, pageControlH);
            self.center = CGPointMake(pageControlX+offsetX, self.center.y);
            break;
        }
        case DSPageControlModeBottomRight:
        {
            self.frame = CGRectMake(self.superview.frame.size.width - pageControlW - defaultLeftRightMargin+offsetX, pageControlY+offsetY, pageControlW, pageControlH);
            break;
        }
        case DSPageControlModeBottomLeft:
        {
            self.frame = CGRectMake(defaultLeftRightMargin+offsetX, pageControlY+offsetY, pageControlW, pageControlH);
            break;
        }
            
        default:
            break;
    }
    // dot frame
    CGFloat dotViewW = [self dotViewWidth];
    CGFloat dotViewMargin = [self dotViewMargin];
    CGFloat dotViewX = 0;
    CGFloat dotViewY = 0;
    CGFloat dotViewH = [self dotViewHeight];
    
    for(int i =0 ; i < self.subviews.count; i++){
        UIView* dot = self.subviews[i];
        dotViewX = (dotViewW+dotViewMargin)*i;
        dot.frame = CGRectMake(dotViewX,dotViewY,dotViewW, dotViewH);
    }
}


#pragma mark - private method
- (void)setUpDots
{
    for (int i=0; i<self.subviews.count; i++) {
        UIView* dot = self.subviews[i];
        if (dot.subviews.count == 0) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self dotViewWidth], [self dotViewHeight])];
            [dot addSubview:imageView];
        };
        UIImageView *imageView = [dot.subviews firstObject];
        if (i == self.currentPage) {
            imageView.image=self.currentPageIndicatorImage;
            dot.backgroundColor = [UIColor clearColor];
        }else {
            imageView.image=self.pageIndicatorImage;
            dot.backgroundColor = [UIColor clearColor];
        }
    }
}

- (CGFloat)pageControlHeight
{
    CGFloat pageControlH = 7;
    if(self.dotViewSize.height > 0){
        pageControlH = self.dotViewSize.height;
    }
    return pageControlH;
}

- (CGFloat)pageControlWidth
{
    CGFloat pageControlWidth = self.frame.size.width;
    if(self.dotViewSize.width > 0){
        pageControlWidth = [self dotViewMargin] * (self.numberOfPages-1) + [self dotViewWidth]*self.numberOfPages;
    }
    return pageControlWidth;
}

- (CGFloat)dotViewWidth
{
    CGFloat dotViewWidth = 7;
    if(self.dotViewSize.width >0){
        dotViewWidth = self.dotViewSize.width;
    }
    return dotViewWidth;
}

- (CGFloat)dotViewHeight
{
    return [self pageControlHeight];
}

- (CGFloat)dotViewMargin
{
    if(_dotViewMargin) return _dotViewMargin;
    return 9;
}

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
