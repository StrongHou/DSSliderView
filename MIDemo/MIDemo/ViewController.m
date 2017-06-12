//
//  ViewController.m
//  MIDemo
//
//  Created by houxq on 2017/6/11.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "ViewController.h"
#import "DSSliderView.h"
#import <objc/runtime.h>

@interface ViewController () <DSSliderViewdDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DSSliderView *demo = [DSSliderView sidlerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) viewAttributes:self.array];
//    demo.itemSize = CGSizeMake(self.view.frame.size.width, 50);
//    demo.infiniteScrolling = NO;
//    demo.hiddenPageControl = NO;
//    demo.autoScroll = NO;
    demo.delegate = self;
//    demo.pageControlMode = DSPageControlModeBottomRight;
    demo.titleLabelFont = [UIFont systemFontOfSize:15];
//    demo.pageControlInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    demo.pageIndicatorImage = [UIImage imageNamed:@"demo"];
    demo.currentPageIndicatorImage = [UIImage imageNamed:@"demo2"];
//    demo.dotViewMargin = 2;
//    demo.dotViewSize = CGSizeMake(50, 3);
    demo.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:demo];
    
   
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([UIPageControl class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"类型为 %s 的 %s ",type, name);
    }
    free(ivars);
   
    
}


- (void)sliderView:(DSSliderView *)sliderView didSelectedItemAtIndex:(NSUInteger)index
{

    NSLog(@"%lu",(unsigned long)index);
}


- (NSArray *)array
{
    NSDictionary *dict = @{
                           kCollectionViewCellImageNamed:@"demo",
                           kCollectionViewCellTitleLabelText:@"你好"
                           };
    
    return @[dict,dict.copy,dict.copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
