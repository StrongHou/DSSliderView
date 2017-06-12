//
//  DSSliderView.h
//  MIDemo
//
//  Created by houxq on 2017/6/10.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSSliderCollectionViewCell.h"

#ifdef __cplusplus
#define DS_EXTERN   extern "C" __attribute__((visibility ("default")))
#else
#define DS_EXTERN	extern __attribute__((visibility ("default")))
#endif

@class DSSliderView;

@protocol DSSliderViewdDelegate <NSObject>

@optional
- (void)sliderView:(DSSliderView *)sliderView didSelectedItemAtIndex:(NSUInteger)index;

@end


typedef NS_ENUM(NSUInteger, DSScrollDirection) {

    DSScrollDirectionVertical,
    DSScrollDirectionHorizontal

};

typedef NS_ENUM(NSUInteger, DSPageControlMode) {
    
    DSPageControlModeNone,
    DSPageControlModeBottomCenter,
    DSPageControlModeBottomLeft,
    DSPageControlModeBottomRight
};

@interface DSSliderView : UIView

+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes;
+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes placeholderImage:(UIImage *)image;

- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes;
- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes placeholderImage:(UIImage *)image;


//
@property (nonatomic, copy, readonly) NSArray *attributs;
@property (nonatomic, weak) id<DSSliderViewdDelegate>delegate;

//
@property (nonatomic) CGSize itemSize;
@property (nonatomic) DSScrollDirection scrollDirection;
@property (nonatomic) DSPageControlMode pageControlMode;
@property (nonatomic) CGFloat space;
@property (nonatomic) NSTimeInterval autoScrollDuration;
@property (nonatomic) UIEdgeInsets pageControlInsets;   // offset

//
@property (nonatomic, getter=isInfiniteScrolling) BOOL infiniteScrolling; // default is YES
@property (nonatomic, getter=isScrollEnabled) BOOL scrollEnabled; //default is YES
@property (nonatomic, getter=isPagingEnabled) BOOL pagingEnabled; //default is YES
@property (nonatomic, getter=isAutoScroll) BOOL autoScroll;  //default is YES


//
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) UIImage *pageIndicatorImage;
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;
@property (nonatomic) CGFloat dotViewMargin;
@property (nonatomic) CGSize dotViewSize;

@property (nonatomic, strong) UIFont *titleLabelFont;
@property (nonatomic, strong) UIColor *titleLabelColor;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@end



DS_EXTERN NSString * const kCollectionViewCellImageURL;  //imageURL or imageNamed   NSString
DS_EXTERN NSString * const kCollectionViewCellImageNamed; //imageNamed   NSString
DS_EXTERN NSString * const kCollectionViewCellTitleLabelText; //Title    NSString
DS_EXTERN NSString * const kCollectionViewCellTitleLabelTextColor;//UIColor
DS_EXTERN NSString * const kCollectionViewCellTitleLabelTextFont; //UIFont
DS_EXTERN NSString * const kCollectionViewCellTitleLabelTBackgroundColor; //UIColor
DS_EXTERN NSString * const kCollectionViewCellClickEnable;  //cellEnabel BOOL
DS_EXTERN NSString * const kCollectionViewCellGOTO;   //NSString
DS_EXTERN NSString * const kCollectionViewCellImageGOTO; // NSString
DS_EXTERN NSString * const kCollectionViewCellTitleLabelGOTO; // NSString
DS_EXTERN NSString * const kCollectionViewCellPlaceholderImageNamed; // NSString
DS_EXTERN NSString * const kCollectionViewCellClickImageViewBlock;  //Block  typedef void(^SliderCollectionViewCellBlock)(DSSliderCollectionViewCell *collectionViewCell);
DS_EXTERN NSString * const kCollectionViewCellClickTitleLabelBlock; //Block  typedef void(^SliderCollectionViewCellBlock)(DSSliderCollectionViewCell *collectionViewCell);
