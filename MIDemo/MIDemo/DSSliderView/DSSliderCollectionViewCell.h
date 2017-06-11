//
//  DSSliderCollectionViewCell.h
//  MIDemo
//
//  Created by houxq on 2017/6/10.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSSliderCollectionViewCell;

typedef void(^SliderCollectionViewCellBlock)(DSSliderCollectionViewCell *collectionViewCell);

@interface DSSliderCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic) CGFloat titleLabelHeight;


@property (nonatomic, copy) NSDictionary *cellData;

@end
