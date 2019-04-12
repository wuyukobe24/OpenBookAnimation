//
//  ViewController.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/4.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "ViewController.h"
#import "BookListCell.h"
#import "PageAnimationController.h"
#import "PageCommon.h"
#import "BookModel.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) PageAnimationController *page;
@end

@implementation ViewController

#pragma mark - Public Methods
// Methods…(.h中声明)
#pragma mark - Life Cycle
// Methods…(.m中声明)
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Private Methods
- (void)setUpSubViews {
    [self.view addSubview:self.collectionView];
}
#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BookListCellIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect originalFrame = [PageCommon gainCellOriginalFrameInSuperView:collectionView indexPath:indexPath];
    BookModel *model = [[BookModel alloc]initWithOriginalFrame:originalFrame];
    self.page = [[PageAnimationController alloc]initWithBookModel:model];
    UIViewController *homevc = [self parentViewController];
    [homevc addChildViewController:self.page];
    [homevc.view addSubview:self.page.view];
    __weak typeof(self) weakSelf = self;
    self.page.dismissBlock = ^{
        [weakSelf.page.view removeFromSuperview];
        [weakSelf.page removeFromParentViewController];
    };
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(170, 210);
}
/// cell行与cell行之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 40.f;
}
/// cell与cell之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}
#pragma mark - Getters and Setters
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.collectionViewLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.backgroundView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[BookListCell class] forCellWithReuseIdentifier:BookListCellIdentifier];
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        /* 设置滚动方向*/
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        /** 同一个Section中,相邻行数据之间的间距 */
        _collectionViewLayout.minimumLineSpacing = 0;
        /** 同一个Section中,同一布局方向相邻item数据之间的间距 */
        _collectionViewLayout.minimumInteritemSpacing = 0;
        /** 设置每一个item的大小 */
//        _collectionViewLayout.itemSize = CGSizeMake(150, 210);
        /** 设置header和footer */
        _collectionViewLayout.headerReferenceSize = CGSizeZero;
        _collectionViewLayout.footerReferenceSize = CGSizeZero;
        /** 设置每一个Section的Inset,上左下右 */
        _collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    }
    return _collectionViewLayout;
}
#pragma mark - 设置横屏
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [super preferredInterfaceOrientationForPresentation];
}

@end
