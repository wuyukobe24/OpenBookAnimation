//
//  PageAnimationController.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/4.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "PageAnimationController.h"
#import "BookFadeView.h"
#import "BookModel.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface PageAnimationController ()
@property (nonatomic, strong) BookFadeView *fadeView;
@property (nonatomic, strong) BookModel *model;
@property (nonatomic, assign, getter=isAnimationPlaying) BOOL animationPlaying; ///< 是否在播放翻书动画
@end

@implementation PageAnimationController

#pragma mark - Public Methods
// Methods…(.h中声明)
- (instancetype)initWithBookModel:(BookModel *)model {
    if (self = [super init]) {
        _model = model;
        [self.fadeView setCoverImage:@"book"];
    }
    return self;
}
#pragma mark - Life Cycle
- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addTapgestureRecognizer];
    [self setUpSubViews];
    [self startAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Private Methods
// Methods…(.m中声明)
- (void)setUpSubViews {
    [self.view addSubview:self.fadeView];
}
/// 添加点击手势
- (void)addTapgestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScreenGesture:)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark - 翻书动画
/// 开启翻书
- (void)startAnimation {
    CGSize tempSize = self.model.originalSize;
    CGFloat coverScaleWidth = tempSize.width*2/(kScreenWidth-100);
    CGFloat coverScaleHeight = tempSize.height/(kScreenHeight-40);
    self.fadeView.transform = CGAffineTransformMakeScale(coverScaleWidth, coverScaleHeight);
    self.fadeView.center = CGPointMake(self.model.originalPoint.x + self.model.originalSize.width/2, self.model.originalPoint.y + self.model.originalSize.height/2);
    [self bookFade:BookFadeStyle_In];
}

/// 翻书动画展开/关闭
- (void)bookFade:(BookFadeStyle)style {
    if(style == BookFadeStyle_In) {
        self.animationPlaying = YES;
        [UIView animateWithDuration:0.6 animations:^{
            self.view.alpha = 1.0f;
        }];
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
            self.fadeView.transform = CGAffineTransformMakeScale(1, 1);
            self.fadeView.center = self.view.center;
        } completion:^(BOOL finished) {
            [self.fadeView fadeInWithSuccessBlock:^{
                self.animationPlaying = NO;
            }];
        }];
        
    } else if(style == BookFadeStyle_Out && !self.animationPlaying) {
        self.animationPlaying = NO;
        CGSize tempSize = self.model.originalSize;
        CGFloat coverScaleWidth = tempSize.width*2/(kScreenWidth-100);
        CGFloat coverScaleHeight = tempSize.height/(kScreenHeight-40);
        [self.fadeView fadeOut];
        [UIView animateWithDuration:0.2 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            self.fadeView.alpha = 0.9;
        } completion:^(BOOL finished) {
            
        }];
        
        [UIView animateWithDuration:0.6 delay:0.6 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
            self.fadeView.center = CGPointMake(self.model.originalPoint.x, self.model.originalPoint.y + (self.model.originalSize.height)/2);
            self.fadeView.transform = CGAffineTransformMakeScale(coverScaleWidth, coverScaleHeight);
            self.view.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            /// 关闭页面
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }];
    }
}
#pragma mark - Event Response
- (void)touchScreenGesture:(UITapGestureRecognizer *)tap {
    [self bookFade:BookFadeStyle_Out];
}
#pragma mark - Notification
#pragma mark - CustomDelegate
#pragma mark - Getters and Setters
- (BookFadeView *)fadeView {
    if (!_fadeView) {
        _fadeView = [[BookFadeView alloc]initWithFrame:CGRectMake(50, 20, kScreenWidth-100, kScreenHeight-40)];
    }
    return _fadeView;
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

