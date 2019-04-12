//
//  BookFadeView.h
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookFadeView : UIView

/**
 翻开动画
 */
- (void)fadeInWithSuccessBlock:(dispatch_block_t)success;
/**
 关闭动画
 */
- (void)fadeOut;
/**
 设置封面
 */
- (void)setCoverImage:(NSString *)image;


@end
