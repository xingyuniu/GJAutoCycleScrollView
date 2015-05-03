//
//  GJAutoCycleScrollView.m
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/3.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJAutoCycleScrollView.h"

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
    _imageUrl = [imageUrl copy];
    ((UIImageView *)self.backgroundView).image = [UIImage imageNamed:imageUrl];
}

@end

NSString * const itemID = @"itemID";

@interface GJAutoCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL timerIsStop;

@end

@implementation GJAutoCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeIntervalForAutoScroll = 3.0;
        [self configureImageView];
        [self configurePageControl];
        [self configureTimer];
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
//    NSTimer *timer =[NSTimer timerWithTimeInterval:_timeIntervalForAutoScroll target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeIntervalForAutoScroll target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
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
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = self.bounds.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [_dataSource numberOfPagesInAutoCycleScrollView:self];
    _itemCount = count * 100;
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJImageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    NSInteger index = indexPath.item % (_itemCount / 100);
    item.imageUrl = [_dataSource autoCycleScrollView:self imageUrlAtIndex:index];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(autoCycleScrollView:didSelectPageAtIndex:)]) {
        NSInteger index = indexPath.item % (_itemCount / 100);
        [_delegate autoCycleScrollView:self didSelectPageAtIndex:index];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_timerIsStop) {
        NSLog(@"关闭");
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_timerIsStop) {
        NSLog(@"开启");
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
        [_timer invalidate];
        _timer = nil;
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
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:desPage inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupInitLocation
{
    [self scrollToMiddle];
}

- (void)scrollToMiddle
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_itemCount * 0.5 inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)setDataSource:(id<GJAutoCycleScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

@end
