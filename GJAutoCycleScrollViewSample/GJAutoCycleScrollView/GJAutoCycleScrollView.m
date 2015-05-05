//
//  GJAutoCycleScrollView.m
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/3.
//  Copyright (c) 2015年 devgj. All rights reserved.
//  问题一:如果只有一页，则不需要定时器，也不需要分页控制, 已解决
//  问题二:根据dataCount的范围确定itemCount的范围
//  问题三:网络图片

#import "GJAutoCycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface GJImageItem : UICollectionViewCell
@property (nonatomic, copy) NSString *imageUrl;
@end

@implementation GJImageItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    if (!(imageUrl && imageUrl.length > 0)) {
        return;
    }
    _imageUrl = [imageUrl copy];
    if ([imageUrl hasPrefix:@"http"]) {
        [((UIImageView *)self.backgroundView) sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:GJPlaceholderImageName]];
    } else {
        ((UIImageView *)self.backgroundView).image = [UIImage imageNamed:imageUrl];
    }
}

@end

NSString * const itemID = @"itemID";

@interface GJAutoCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL timerIsStop;

@end

@implementation GJAutoCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeIntervalForAutoScroll = 1.0;
        [self configureImageView];
        [self configurePageControl];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"挂了");
}

- (void)configurePageControl
{
    UIPageControl *pageControll = [[UIPageControl alloc] init];
    [self addSubview:pageControll];
    _pageControl = pageControll;
}

- (void)configureTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeIntervalForAutoScroll target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)deleteTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)configureImageView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [collectionView registerClass:[GJImageItem class] forCellWithReuseIdentifier:itemID];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = size;
    _pageControl.center = CGPointMake(size.width * 0.5, size.height - 15);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    _dataCount = [_dataSource numberOfPagesInAutoCycleScrollView:self];
#warning FIXME *100不科学，如果_dataCount过大，再*100结果太大了
    if (_dataCount == 1) {
        _itemCount = _dataCount;
    } else {
        _itemCount = _dataCount * 10;
    }
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJImageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    NSInteger index = indexPath.item % _dataCount;
    item.imageUrl = [_dataSource autoCycleScrollView:self imageUrlAtIndex:index];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(autoCycleScrollView:didSelectPageAtIndex:)]) {
        NSInteger index = indexPath.item % _dataCount;
        [_delegate autoCycleScrollView:self didSelectPageAtIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
    page %= _dataCount;
    if (_pageControl.currentPage != page) {
        _pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_timerIsStop) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_timerIsStop) {
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(activeTimer) object:nil];
        [self performSelector:@selector(activeTimer) withObject:nil afterDelay:_timeIntervalForAutoScroll];
    }
}

- (void)activeTimer
{
    _timerIsStop = NO;
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)stopTimer
{
    _timerIsStop = YES;
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        [self deleteTimer];
    }
}

- (void)reloadData
{
    [_collectionView reloadData];
    
    [self performSelector:@selector(setupInitLocation) withObject:self afterDelay:0.1];
}

- (void)scrollImage
{
    if (_itemCount == 0) {
        return;
    }
    NSInteger currentPage = _collectionView.contentOffset.x / _flowLayout.itemSize.width;
    NSInteger desPage = currentPage + 1;
    if (desPage == _itemCount) {
        [self scrollToMiddle];
    } else {
        [self scrollToItemAtIndex:desPage animated:YES];
    }
}

- (void)setupInitLocation
{
    // 设置pageControl的页数
    _pageControl.numberOfPages = _dataCount;
    [_pageControl sizeToFit];
    if (_dataCount > 1) {
        _pageControl.hidden = NO;
        [self configureTimer];
        [self scrollToMiddle];
    } else {
        [self deleteTimer];
        _pageControl.hidden = YES;
    }
}

- (void)scrollToMiddle
{
    [self scrollToItemAtIndex:_itemCount * 0.5 animated:NO];
}

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
}

- (void)setDataSource:(id<GJAutoCycleScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

@end
