//
//  PageAnimationController.h
//  PageAnimation
//
//  Created by WXQ on 2019/4/4.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BookFadeStyle) {
    BookFadeStyle_In = 0, // 进入
    BookFadeStyle_Out // 退出
};

@class BookModel;
@interface PageAnimationController : UIViewController
@property (nonatomic, copy) dispatch_block_t dismissBlock;
- (instancetype)initWithBookModel:(BookModel *)model;

@end
