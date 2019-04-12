//
//  PageCommon.h
//  PageAnimation
//
//  Created by WXQ on 2019/4/5.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PageCommon : NSObject

/**
 获取UICollectionView的cell在UIWindow上的原始frame
 
 @param   collectionView   collectionView
 @param   indexPath        所选cell的indexPath
 */
+ (CGRect)gainCellOriginalFrameInSuperView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
