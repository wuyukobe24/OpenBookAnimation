//
//  BookFadeView.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "BookFadeView.h"

#define kSelfWidth    self.frame.size.width
#define kSelfHeight   self.frame.size.height

@interface BookFadeView()
@property(nonatomic, strong)UIImageView *whitePaperRight;
@property(nonatomic, strong)UIImageView *grayPaperRight;
@property(nonatomic, strong)UIImageView *greenPaperRight;
@property(nonatomic, strong)UIImageView *whitePaperLeft;
@property(nonatomic, strong)UIImageView *grayPaperLeft;
@property(nonatomic, strong)UIImageView *greenPaperLeft;
@property(nonatomic, strong)UIImageView *coverImageView;
@property(nonatomic, strong)UIImageView *middleSeam;
@end

@implementation BookFadeView

#pragma mark - Public Methods
// Methods…(.h中声明)
/// 翻开动画
- (void)fadeInWithSuccessBlock:(dispatch_block_t)success {
    [UIView animateWithDuration:0.3 animations:^{
        self.greenPaperLeft.transform = CGAffineTransformMakeScale(0.01, 1.0);
        self.coverImageView.transform = CGAffineTransformMakeScale(0.01, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [self sendSubviewToBack:self.greenPaperLeft];
            self.coverImageView.hidden = YES;
            self.greenPaperLeft.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.grayPaperLeft.transform = CGAffineTransformMakeScale(0.01, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [self insertSubview:self.grayPaperLeft aboveSubview:self.greenPaperLeft];
            self.grayPaperLeft.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
    
    [UIView animateWithDuration:0.6 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.whitePaperLeft.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        success();
    }];
}
/// 关闭动画
- (void)fadeOut {
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.whitePaperLeft.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.grayPaperLeft.transform = CGAffineTransformMakeScale(-0.01, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [self insertSubview:self.grayPaperLeft aboveSubview:self.whitePaperLeft];
            self.grayPaperLeft.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }];
    }];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.greenPaperLeft.transform = CGAffineTransformMakeScale(-0.01, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.coverImageView.hidden = NO;
            [self insertSubview:self.greenPaperLeft belowSubview:self.coverImageView];
            self.greenPaperLeft.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            self.coverImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}
- (void)setCoverImage:(NSString *)image {
    [self.coverImageView setImage:[UIImage imageNamed:image]];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.coverImageView.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.coverImageView.layer.mask = maskLayer;
}
#pragma mark - Life Cycle
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}
#pragma mark - Private Methods
// Methods…(.m中声明)
- (void)setUpSubViews {
    [self addSubview:self.greenPaperRight];
    [self addSubview:self.grayPaperRight];
    [self addSubview:self.whitePaperRight];
    [self addSubview:self.middleSeam];
    [self addSubview:self.whitePaperLeft];
    [self addSubview:self.grayPaperLeft];
    [self addSubview:self.greenPaperLeft];
    [self addSubview:self.coverImageView];
}
#pragma mark - Getters and Setters
- (UIImageView *)greenPaperRight {
    if(!_greenPaperRight) {
        _greenPaperRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_green_right"]];
        _greenPaperRight.frame = CGRectMake(kSelfWidth/2, 0, kSelfWidth/2, kSelfHeight);
    }
    return _greenPaperRight;
}

- (UIImageView *)grayPaperRight {
    if(!_grayPaperRight) {
        _grayPaperRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_gray_right"]];
        _grayPaperRight.frame = CGRectMake(kSelfWidth/2, 0, kSelfWidth/2 - 5, kSelfHeight);
    }
    return _grayPaperRight;
}

- (UIImageView *)whitePaperRight {
    if(!_whitePaperRight) {
        _whitePaperRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_white_right"]];
        _whitePaperRight.frame = CGRectMake(kSelfWidth/2, 0, kSelfWidth/2 - 15, kSelfHeight);
    }
    return _whitePaperRight;
}

- (UIImageView *)middleSeam {
    if(!_middleSeam) {
        _middleSeam = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_middle"]];
        _middleSeam.frame = CGRectMake(kSelfWidth/2, 0, 128, kSelfHeight);
        _middleSeam.alpha = 0.4f;
    }
    return _middleSeam;
}

- (UIImageView *)greenPaperLeft {
    if(!_greenPaperLeft) {
        _greenPaperLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_green_left"]];
        _greenPaperLeft.layer.anchorPoint = CGPointMake(1, 0);
        _greenPaperLeft.frame = CGRectMake(0, 0, kSelfWidth/2, kSelfHeight);
        _greenPaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
    }
    return _greenPaperLeft;
}

- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _coverImageView.layer.anchorPoint = CGPointMake(0, 0);
        _coverImageView.frame = CGRectMake(kSelfWidth/2, 0, kSelfWidth/2, kSelfHeight);
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UIImageView *)grayPaperLeft {
    if(!_grayPaperLeft) {
        _grayPaperLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_gray_left"]];
        _grayPaperLeft.layer.anchorPoint = CGPointMake(1, 0);
        /** 手机端左边绿色图片切图问题导致加1 */
        _grayPaperLeft.frame = CGRectMake(5, 0, kSelfWidth/2 - 5, kSelfHeight + 1);
        _grayPaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
    }
    return _grayPaperLeft;
}

- (UIImageView *)whitePaperLeft {
    if(!_whitePaperLeft) {
        _whitePaperLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xch_picturebook_fade_white_left"]];
        _whitePaperLeft.layer.anchorPoint = CGPointMake(1, 0);
        /** 手机端左边绿色图片切图问题导致加1 */
        _whitePaperLeft.frame = CGRectMake(15, 0, kSelfWidth/2 - 15, kSelfHeight + 1);
        _whitePaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
    }
    return _whitePaperLeft;
}

@end
