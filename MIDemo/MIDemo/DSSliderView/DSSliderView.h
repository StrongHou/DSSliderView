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


@interface DSSliderView : UIView

+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes;

- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray <NSDictionary *>*)attributes;


//
@property (nonatomic, copy, readonly) NSArray *attributs;

//
@property (nonatomic) CGSize itemSize;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic) CGFloat space;
@property (nonatomic) NSTimeInterval autoScrollDuration;

//
@property (nonatomic, getter=isInfiniteScrolling) BOOL infiniteScrolling;
@property (nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;
@property (nonatomic, getter=isPagingEnabled) BOOL pagingEnabled;


@end



DS_EXTERN NSString * const kCollectionViewCellImageURL;  //imageURL or imageNamed   NSString
DS_EXTERN NSString * const kCollectionViewCellImageNamed; //imageNamed   NSString
DS_EXTERN NSString * const kCollectionViewCellTitleLabelText; //Title    NSString
DS_EXTERN NSString * const kCollectionViewCellClickEnable;  //cellEnabel BOOL
DS_EXTERN NSString * const kCollectionViewCellGOTO;   //NSString
DS_EXTERN NSString * const kCollectionViewCellImageGOTO; // NSString
DS_EXTERN NSString * const kCollectionViewCellTitleLabelGOTO; // NSString
DS_EXTERN NSString * const kCollectionViewCellPlaceholderImageNamed; // NSString
DS_EXTERN NSString * const kCollectionViewCellClickImageViewBlock;  //Block  typedef void(^SliderCollectionViewCellBlock)(DSSliderCollectionViewCell *collectionViewCell);
DS_EXTERN NSString * const kCollectionViewCellClickTitleLabelBlock; //Block  typedef void(^SliderCollectionViewCellBlock)(DSSliderCollectionViewCell *collectionViewCell);
