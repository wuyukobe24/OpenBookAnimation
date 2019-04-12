//
//  BookModel.h
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BookModel : NSObject
@property (nonatomic, assign)CGPoint originalPoint; /// 原始起点
@property (nonatomic, assign)CGSize originalSize; /// 原始尺寸
@property (nonatomic, assign)CGRect originalFrame; /// 原始frame

- (instancetype)initWithOriginalFrame:(CGRect)frame;

@end
