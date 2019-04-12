//
//  BookModel.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

- (instancetype)initWithOriginalFrame:(CGRect)frame {
    if (self = [super init]) {
        self.originalSize = frame.size;
        self.originalPoint = frame.origin;
        self.originalFrame = frame;
    }
    return self;
}

@end
