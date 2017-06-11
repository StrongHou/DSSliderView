//
//  DSSliderView.m
//  MIDemo
//
//  Created by houxq on 2017/6/10.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSSliderView.h"


static NSString *const kDSSliderViewCellIdentifier = @"kDSSliderViewCellIdentifier";


@interface DSSliderView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *sliderView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy, readwrite) NSArray *attributs;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation DSSliderView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes
{
    self = [super initWithFrame:frame];
    if(self){
        _attributs = attributes;
        _infiniteScrolling = YES;
        _scrollEnabled = YES;
        _itemSize = frame.size;
        _space = 0;
        _pagingEnabled = YES;
        _autoScrollDuration = 5;
        _scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self addSubview:self.sliderView];
    }
    return self;
}

+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes
{
    return [[self alloc] initWithFrame:frame viewAttributes:attributes];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.flowLayout.itemSize = self.itemSize;
    self.flowLayout.scrollDirection = self.scrollDirection;
    self.flowLayout.minimumLineSpacing = self.space;
}


#pragma mark - private method
- (NSInteger)sectionCounts
{
    NSInteger count = 1;
    if(self.isInfiniteScrolling){
        count = self.isScrollEnabled?50:3;
    }
    return count;
}

- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollDuration target:self selector:@selector(autoScrollingNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)removeTimer
{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (NSIndexPath *)currentIndex
{
    self.sliderVi
}

#pragma mark - event response
- (void)autoScrollingNextPage
{
//    self.sliderView scrollToItemAtIndexPath:<#(nonnull NSIndexPath *)#> atScrollPosition:<#(UICollectionViewScrollPosition)#> animated:YES
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionCounts;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.attributs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSSliderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDSSliderViewCellIdentifier forIndexPath:indexPath];
    cell.cellData = self.attributs[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>



#pragma mark - getters and setters
- (UICollectionViewFlowLayout *)flowLayout
{
    if(_flowLayout == nil){
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


- (UICollectionView *)sliderView
{
    if(_sliderView == nil){
        _sliderView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
        [_sliderView registerClass:[DSSliderCollectionViewCell class] forCellWithReuseIdentifier:kDSSliderViewCellIdentifier];
        _sliderView.showsVerticalScrollIndicator = NO;
        _sliderView.showsHorizontalScrollIndicator = NO;
        _sliderView.pagingEnabled = _pagingEnabled;
        _sliderView.dataSource = self;
        _sliderView.delegate = self;
    }
    return _sliderView;
}


- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled = scrollEnabled;
    self.sliderView.scrollEnabled = scrollEnabled;
}

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.sliderView.pagingEnabled = pagingEnabled;
}
@end
