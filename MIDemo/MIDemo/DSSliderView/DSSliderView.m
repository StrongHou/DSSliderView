//
//  DSSliderView.m
//  MIDemo
//
//  Created by houxq on 2017/6/10.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "DSSliderView.h"
#import "NSDictionary+Extend.h"
#import "DSPageControl.h"




static NSString *const kDSSliderViewCellIdentifier = @"kDSSliderViewCellIdentifier";


@interface DSSliderView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *sliderView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy, readwrite) NSArray *attributs;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) DSPageControl *pageControl;
@property (nonatomic, strong) UIImage *placeholderImage;

@end

@implementation DSSliderView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes
{
    return [self initWithFrame:frame viewAttributes:attributes placeholderImage:nil];
}

- (instancetype)initWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes placeholderImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if(self){
        _attributs = attributes;
        _itemSize = frame.size;
        _placeholderImage = image;
        [self initialize];
        [self addSubview:self.sliderView];
    }
    return self;
}

+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes
{
    return [[self alloc] initWithFrame:frame viewAttributes:attributes placeholderImage:nil];
}

+ (instancetype)sidlerViewWithFrame:(CGRect)frame viewAttributes:(NSArray<NSDictionary *> *)attributes placeholderImage:(UIImage *)image
{
     return [[self alloc] initWithFrame:frame viewAttributes:attributes placeholderImage:image];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.flowLayout.itemSize = self.itemSize;
    self.flowLayout.scrollDirection = [self collectionDirection];
    self.flowLayout.minimumLineSpacing = self.space;
    [self setUpPagControl];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview == nil){
        [self removeTimer];
    }else {
        [self setUpTimer];
    }
    [super willMoveToSuperview:newSuperview];
}

- (void)dealloc
{
    _sliderView.delegate = nil;
    _sliderView.dataSource = nil;
}

#pragma mark - private method
- (void)initialize
{
    _infiniteScrolling = YES;
    _scrollEnabled = YES;
    _space = 0;
    _pagingEnabled = YES;
    _autoScroll = YES;
    _autoScrollDuration = 5;
    _scrollDirection = DSScrollDirectionHorizontal;
    _pageControlMode = DSPageControlModeBottomCenter;
}

- (NSDictionary *)configDict
{
    NSMutableDictionary *dict  = [NSMutableDictionary dictionary];
    dict[kCollectionViewCellPlaceholderImageNamed] = self.placeholderImage;
    dict[kCollectionViewCellTitleLabelTextFont] = self.titleLabelFont;
    dict[kCollectionViewCellTitleLabelTextColor] = self.titleLabelColor;
    dict[kCollectionViewCellTitleLabelTBackgroundColor] = self.backgroundColor;
    return [dict copy];
}

- (void)setUpPagControl
{
    switch (self.pageControlMode) {
        case DSPageControlModeNone:
            self.pageControl.hidden = YES;
            break;
            
        default:
            [self insertSubview:self.pageControl aboveSubview:self.sliderView];
            self.pageControl.pageControlMode = self.pageControlMode;
            self.pageControl.hidden = NO;
            break;
    }
}
- (NSDictionary *)cellItemDataAtIndex:(NSInteger)index
{
    NSDictionary *dict = self.attributs[index];
    dict = [[self configDict] ds_dictionaryWithReplenishDictionary:dict];
    return dict;
}

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

- (void)setUpTimer
{
    [self removeTimer];
    if(self.isAutoScroll && self.autoScrollDuration > 0){
        [self addTimer];
    }
}

- (NSUInteger)currentPageIndex
{
    NSUInteger currentPageIndex = 0;
    if([self itemCounts] == 0) return currentPageIndex;
    switch (self.scrollDirection) {
        case DSScrollDirectionHorizontal:
            currentPageIndex = (NSUInteger)(self.sliderView.contentOffset.x/self.flowLayout.itemSize.width +0.5)%[self itemCounts];
            break;
        case DSScrollDirectionVertical:
            currentPageIndex = (NSUInteger)(self.sliderView.contentOffset.y/self.flowLayout.itemSize.height+0.5)%[self itemCounts];
            break;
        default:
            break;
    }
    return currentPageIndex;
}
- (NSIndexPath *)resetIndexPath
{
    NSIndexPath *currentIndexPath = [[self.sliderView indexPathsForVisibleItems] lastObject];
    NSIndexPath *resetPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:self.sectionCounts * 0.5];
    [self.sliderView scrollToItemAtIndexPath:resetPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    return resetPath;
}
- (NSIndexPath *)nextIndexPathWithRestIndexPath:(NSIndexPath *)resetPath
{
    NSInteger nextItem = resetPath.item + 1;
    NSInteger section = resetPath.section;
    if(nextItem == [self itemCounts]) {
        nextItem = 0;
        section++;
    }
    NSIndexPath *nextPath = [NSIndexPath indexPathForItem:nextItem inSection:section];
    return nextPath;
}
- (UICollectionViewScrollDirection )collectionDirection
{
    UICollectionViewScrollDirection direction;
    switch (self.scrollDirection) {
        case DSScrollDirectionHorizontal:
            direction = UICollectionViewScrollDirectionHorizontal;
            break;
        case DSScrollDirectionVertical:
            direction = UICollectionViewScrollDirectionVertical;
            break;
        default:
            break;
    }
    return direction;
}
- (NSUInteger)itemCounts
{
    return self.attributs.count;
}
#pragma mark - event response
- (void)autoScrollingNextPage
{
    NSIndexPath *resetPath = [self resetIndexPath];
    NSIndexPath *nextPath =  [self nextIndexPathWithRestIndexPath:resetPath];
    [self.sliderView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = [self currentPageIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setUpTimer];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionCounts;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self itemCounts];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSSliderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDSSliderViewCellIdentifier forIndexPath:indexPath];
    cell.cellData = [self cellItemDataAtIndex:indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(sliderView:didSelectedItemAtIndex:)]){
        [self.delegate sliderView:self didSelectedItemAtIndex:[self currentPageIndex]];
    }
}


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
        _sliderView.bounces = NO;
    }
    return _sliderView;
}
- (DSPageControl *)pageControl
{
    if(_pageControl == nil){
        _pageControl = [[DSPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = [self itemCounts];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageControlMode = self.pageControlMode;
    }
    return _pageControl;
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

- (void)setAutoScrollDuration:(NSTimeInterval)autoScrollDuration
{
    _autoScrollDuration = autoScrollDuration;
    [self setUpTimer];
}
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [self setUpTimer];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage
{
    _pageIndicatorImage = pageIndicatorImage;
    self.pageControl.pageIndicatorImage = pageIndicatorImage;
}
- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage
{
    _currentPageIndicatorImage = currentPageIndicatorImage;
    self.pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
}
- (void)setDotViewMargin:(CGFloat)dotViewMargin
{
    _dotViewMargin = dotViewMargin;
    self.pageControl.dotViewMargin = dotViewMargin;
}
- (void)setDotViewSize:(CGSize)dotViewSize
{
    _dotViewSize = dotViewSize;
    self.pageControl.dotViewSize = dotViewSize;
}
- (void)setPageControlInsets:(UIEdgeInsets)pageControlInsets
{
    _pageControlInsets = pageControlInsets;
    self.pageControl.pageControlInsets = pageControlInsets;
}

@end
