# OpenBookAnimation
自定义翻书动画

### 动画效果：

![翻书动画](https://github.com/wuyukobe24/OpenBookAnimation/blob/master/fanshu.gif)

##### 主要的实现思路分成四部分动画：
#### 1、点击书本放大动画
首先获取书本在`UIWindow`上的原始frame，由于我是用`UICollectionView`创建的书本列表，所以利用下面的方法去获取点击书本的原始frame。
```
/**
 获取UICollectionView的cell在UIWindow上的原始frame
 
 @param   collectionView   collectionView
 @param   indexPath        所选cell的indexPath
 */
+ (CGRect)gainCellOriginalFrameInSuperView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section]];
    CGRect cellRect = attributes.frame;
    UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect cellFrameInSuperview = [collectionView convertRect:cellRect toView:originalKeyWindow];
    return cellFrameInSuperview;
}
```
然后设置书本的原始位置和原始缩放比例。
```
CGSize tempSize = self.model.originalSize;
CGFloat coverScaleWidth = tempSize.width*2/(kScreenWidth-100);
CGFloat coverScaleHeight = tempSize.height/(kScreenHeight-40);
self.fadeView.transform = CGAffineTransformMakeScale(coverScaleWidth, coverScaleHeight);
self.fadeView.center = CGPointMake(self.model.originalPoint.x + self.model.originalSize.width/2, self.model.originalPoint.y + self.model.originalSize.height/2);
```
最后利用`UIView`的`Animation`动画进行书本的放大和位置偏移。
```
[UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
    self.fadeView.transform = CGAffineTransformMakeScale(1, 1);
    self.fadeView.center = self.view.center;
} completion:^(BOOL finished) {
    
}];
```
其实整个翻书动画的动画效果只用到了`UIView`的`transform`中的缩放效果和`UIView`的`Animation`动画。其中`transform`属性是用来修改`UIView`对象的平移、缩放比例和旋转角度。
#### 2、书本翻开动画
书本翻开动画是通过改变左边图片的缩放比例来实现的。首先找到书本左右两边的一套图片（demo中左右两边各三张），并设置左边图片的`transform`缩放比例为`CGAffineTransformMakeScale(-1, 1)`，如下：
```
_greenPaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
_grayPaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
_whitePaperLeft.transform = CGAffineTransformMakeScale(-1, 1);
```
并将左边图片按照一定的顺序插入到右边图片的上面，实现效果如下：![](https://upload-images.jianshu.io/upload_images/4037795-71c9cbc6a441ee5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后利用`Animation`动画将左边每张图片的缩放比例按先后顺序从`CGAffineTransformMakeScale(-1.0, 1.0)`变成`CGAffineTransformMakeScale(0.01, 1.0)`，最后变成`CGAffineTransformMakeScale(1.0, 1.0)`，就实现了翻书的动画效果。翻开动画代码如下：
```
/**
 翻开动画
 */
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
```
#### 3、书本合上动画
书本合上动画是将书本翻开动画效果反过来执行，即利用`Animation`动画将左边每张图片的缩放比例按先后顺序从`(1.0, 1.0)`变为`(-0.01, 1.0)`，最后在变为`(-1.0, 1.0)`，这样就实现了书本合上动画。合上动画代码如下：
```
/**
 关闭动画
 */
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
```
#### 4、书本缩小回归原位动画
书本缩小回归原位的动画和点击放大的动画实现方式一样，利用`Animation`动画将书本返回到原来的位置和缩放比例。代码如下：
 ```
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
```
以上就是翻书动画的整个实现思路，由于是从项目中摘出代码做的demo，所以很多细节没有处理。

`注意`：运行demo时，记得将手机设置成横屏或者用快捷键`command + ->`将模拟器设置成横屏在运行，效果会和上面一样。
