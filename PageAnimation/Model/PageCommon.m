//
//  PageCommon.m
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "PageCommon.h"

@implementation PageCommon

/// 获取UICollectionView的cell在UIWindow上的原始frame
+ (CGRect)gainCellOriginalFrameInSuperView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section]];
    CGRect cellRect = attributes.frame;
    UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect cellFrameInSuperview = [collectionView convertRect:cellRect toView:originalKeyWindow];
    return cellFrameInSuperview;
}


@end
