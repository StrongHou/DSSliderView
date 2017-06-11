//
//  DSSliderCollectionViewCell.m
//  MIDemo
//
//  Created by houxq on 2017/6/10.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSSliderCollectionViewCell.h"

NSString * const kCollectionViewCellImageURL = @"kCollectionViewCellImageURL";
NSString * const kCollectionViewCellImageNamed = @"kCollectionViewCellImageName";
NSString * const kCollectionViewCellTitleLabelText = @"kCollectionViewCellTitleLabelText";
NSString * const kCollectionViewCellClickEnable = @"kCollectionViewCellClickEnable";
NSString * const kCollectionViewCellGOTO = @"kCollectionViewCellGOTO";
NSString * const kCollectionViewCellImageGOTO  = @"kCollectionViewCellImageGOTO";
NSString * const kCollectionViewCellTitleLabelGOTO = @"kCollectionViewCellTitleLabelGOTO";
NSString * const kCollectionViewCellPlaceholderImageNamed = @"kCollectionViewCellPlaceholderImage";
NSString * const kCollectionViewCellClickImageViewBlock = @"kCollectionViewCellClickImageViewBlock";
NSString * const kCollectionViewCellClickTitleLabelBlock = @"kCollectionViewCellClickTitleLabelBlock";

@interface DSSliderCollectionViewCell ()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, copy) SliderCollectionViewCellBlock imageViewClickedBlock;
@property (nonatomic, copy) SliderCollectionViewCellBlock titleLabelClickedBlock;
@end

@implementation DSSliderCollectionViewCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.imageView.hidden){
        self.titleLabel.frame = self.contentView.bounds;
    }else {
        self.imageView.frame = self.contentView.bounds;
        CGFloat titleLabelW = self.contentView.bounds.size.width;
        CGFloat titleLabelH = self.titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.contentView.bounds.size.height - titleLabelH;
        self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

#pragma mark - event response
- (void)imageViewDidClicked
{
    NSLog(@"%s",__func__);
    if(self.imageViewClickedBlock){
        self.imageViewClickedBlock(self);
    }
}
- (void)titleLabelDidClicked
{
    NSLog(@"%s",__func__);
    if(self.titleLabelClickedBlock){
        self.titleLabelClickedBlock(self);
    }
}

#pragma mark - private method
- (NSString *)imageNamed
{
    NSString *imageNamed = self.cellData[kCollectionViewCellImageNamed];
    NSString *imageURL = self.cellData[kCollectionViewCellImageURL];
    if(imageURL) return imageURL;
    return imageNamed;
}

- (NSString *)titleLabelText
{
    return self.cellData[kCollectionViewCellTitleLabelText];
}

- (BOOL)cellEnabel
{
    BOOL enabel = YES;
    if([self.cellData objectForKey:kCollectionViewCellClickEnable]){
        
        enabel = [self.cellData[kCollectionViewCellClickEnable] boolValue];
    }
    return enabel;
}

- (void)setUpCell
{
    self.userInteractionEnabled = [self cellEnabel];
    
}

- (void)setUpImage
{
    NSString *imageNamed = [self imageNamed];
    if(imageNamed){
        self.imageView.hidden = NO;
        if([imageNamed hasPrefix:@"http"]){
            // Network
        }else {
            // Local
            self.imageView.image = [UIImage imageNamed:imageNamed];
        }
    }else {
        self.imageView.hidden = YES;
    }
    
    if([self.cellData objectForKey:kCollectionViewCellClickImageViewBlock]){
        self.imageViewClickedBlock = self.cellData[kCollectionViewCellClickImageViewBlock];
        self.imageView.userInteractionEnabled = YES;
    }else {
        self.imageViewClickedBlock = nil;
        self.imageView.userInteractionEnabled = NO;
    }
}

- (void)setUpLabel
{
    NSString *titleLabelText = [self titleLabelText];
    if(titleLabelText){
        self.titleLabel.hidden = NO;
        self.titleLabel.text = titleLabelText;
    }else{
        self.titleLabel.hidden = YES;
    }
    
    if([self.cellData objectForKey:kCollectionViewCellClickTitleLabelBlock]){
        self.titleLabelClickedBlock = self.cellData[kCollectionViewCellClickTitleLabelBlock];
        self.titleLabel.userInteractionEnabled = YES;
    }else {
        self.titleLabelClickedBlock = nil;
        self.titleLabel.userInteractionEnabled = NO;
    }
}
#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
       UITapGestureRecognizer *imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClicked)];
        [_imageView addGestureRecognizer:imageTapGesture];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.userInteractionEnabled = YES;
       UITapGestureRecognizer *titleLabelTapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelDidClicked)];
        [_titleLabel addGestureRecognizer:titleLabelTapGuesture];
    }
    return _titleLabel;
}

- (CGFloat)titleLabelHeight
{
    if(_titleLabelHeight > 0) return _titleLabelHeight;
    [self.titleLabel sizeToFit];
    return self.titleLabel.frame.size.height;
}

- (void)setCellData:(NSDictionary *)cellData
{
    _cellData = [cellData copy];
    // set Cell
    [self setUpCell];
    // set Image
    [self setUpImage];
    // set Label
    [self setUpLabel];
}

@end
