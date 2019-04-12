//
//  BookListCell.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/4.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "BookListCell.h"

NSString *const BookListCellIdentifier = @"BookListCellIdentifier";

@interface BookListCell()
@property (nonatomic, strong) UIImageView *bookImage;
@end

@implementation BookListCell

#pragma mark - Public Methods
// Methods…(.h中声明)
#pragma mark - Life Cycle
- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
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
    [self addSubview:self.bookImage];
}
#pragma mark - Getters and Setters
- (UIImageView *)bookImage {
    if (!_bookImage) {
        _bookImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _bookImage.image = [UIImage imageNamed:@"book"];
        _bookImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bookImage;
}

@end
