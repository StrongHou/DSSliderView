//
//  ViewController.m
//  MIDemo
//
//  Created by houxq on 2017/6/11.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "ViewController.h"
#import "DSSliderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DSSliderView *demo = [DSSliderView sidlerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) viewAttributes:self.array];
//    demo.itemSize = CGSizeMake(self.view.frame.size.width, 50);
    demo.infiniteScrolling = YES;
    
    [self.view addSubview:demo];
}


- (NSArray *)array
{
    NSDictionary *dict = @{
                           kCollectionViewCellImageNamed:@"demo"
                           };
    
    return @[dict,dict.copy,dict.copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
