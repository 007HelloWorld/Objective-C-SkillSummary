//
//  CUCFQuickUIMacrocDefine.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

/**
 *  UI相关的快速访问工具宏
 */

#import "CUCFQuickUIUitil.h"

/**
 *  将0-360的角度转换为圆角度表示
 *
 *  @param degree
 *
 *  @return 真实的角度表示
 */
#define CUCFDegreeToRadius(degree) (degree * M_PI / 180)
/**
 *  获取角度对应的NSNumber对象
 */
#define CUCFDegreeToRadiusValue(degree) @(CUCFDegreeToRadius(degree))


/**
 *  快速得到RGB颜色
 */
#define CUCFQuickRGBColor(redValue,greenValue,blueValue) [CUCFQuickUIUitil colorFromRed:redValue green:greenValue blue:blueValue]

/**
 *  快速获取随机颜色
 */
#define CUCFQuickAndomRGBColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

/**CUCFDegreeToRadiusValue
 *  获取带alpha值的RGB颜色
 */
#define CUCFQuickRGBColorAlpha(redValue,greenValue,blueValue,alpha) [CUCFQuickUIUitil colorFromRed:redValue green:greenValue blue:blueValue withAlpha:alpha]
/**
 *  设置字体大小
 */
#define CUCFQuickSetFont(fontSize) [CUCFQuickUIUitil fontWithSize:fontSize];
/**
 *  从16进制字符中得到颜色
 */
#define CUCFQuickHexColor(hexString) [CUCFQuickUIUitil colorFromHexString:hexString]
/**
 *  从16进制字符中得到颜色 可自定义透明度
 */
#define CUCFQuickHexColorWithAlpha(hexString,_alpha_) [CUCFQuickUIUitil colorFromHexString:hexString alpha:_alpha_]
/**
 *  从一个View获取翻转的文本绘制的图形上下文CGContextRef
 */
#define CUCFContextRefTextMatrixFromView(aView) [CUCFQuickUIUitil getTextCTMContextRefFromView:aView]

/**
 *  快速获取图片
 */
#define CUCFQuickImage(imageName) [CUCFQuickUIUitil imageWithName:imageName]

/**
 *  修正图片方向
 *
 */
#define CUCFFixOretationImage(aImage) [CUCFQuickUIUitil fixOretationImage:aImage]

/**
 *  创建圆角图片
 */
#define CUCFRoundCornerImage(aImage,cornerSize,boardSize) [CUCFQuickUIUitil createRoundCornerImage:aImage withCornerSize:cornerSize withBoardSize:boardSize]

/**
 *  组合图片
 */
#define CUCFQuickCombineImage(backgroundImage,maskImage) [CUCFQuickUIUitil combineImage:backgroundImage withMaskImage:maskImage]

/**
 *  返回圆形图片,默认用白色作为遮挡颜色
 */
#define CUCFCycleImage(aImage) [CUCFQuickUIUitil roundImage:aImage]

/**
 *  截取Rect部分的图片
 */
#define CUCFPartImage(aImage,rect) [CUCFQuickUIUitil partImage:aImage withRect:rect]

/**
 *  返回纠正方向后得图片
 */
#define CUCFCorrectOrientationImage(aImage) [CUCFQuickUIUitil correctImageOrientation:aImage]

/**
 *  返回一个纠正了方向并且进行了scale倍数缩放的图片
 */
#define CUCFCorrectOrientationImageWithScale(aImage,scale) [CUCFQuickUIUitil correctImageOrientation:aImage withScaleSize:scale]

/**
 *  返回ALAsset纠正方向后并且进行了scale倍数缩放的fullResolutionImage图片
 */
#define CUCFCorrectOrientationALAssetFullResolutionImageWithScale(aALAsset,scale) [CUCFQuickUIUitil  correctFullSolutionImageFromALAsset:aALAsset withScaleSize:scale]

/**
 *  返回ALAsset纠正方向后的fullResolutionImage图片
 */
#define CUCFCorrectOrientationALAssetFullResolutionImage(aALAsset) [CUCFQuickUIUitil correctFullSolutionImageFromALAsset:aALAsset]

/**
 *  获取一个View的截图
 */
#define CUCFScreenShotFromView(aView) [CUCFQuickUIUitil viewScreenShot:aView]

/**
 *  获取一个Layer的截图
 */
#define CUCFScreenShotFromLayer(aLayer) [CUCFQuickUIUitil layerScreenShot:aLayer]

/**
 *  按照aColor颜色创建一张size大小的图片
 *
 */
#define CUCFQuickImageByColorWithSize(aColor,size) [CUCFQuickUIUitil imageForColor:aColor withSize:size]

/**
 *  创建一个线性渐变图片
 *
 *  @param colors    按顺序渐变颜色数组
 *  @param size      需要创建的图片的大小
 *
 *  最大只支持三种颜色，起始位置颜色，中间颜色，结束颜色
 *  依次位置为 0,0.5,1.0
 *  超过3种颜色也只取前三种颜色为渐变色
 *
 *  @return 返回渐变颜色图片
 */
#define CUCFLinearGradientImageByColorsWithSize(colors,size) [CUCFQuickUIUitil gradientLinearImageFromColors:colors withImageSize:size]

/**
 *  创建线性渐变图片
 *
 *  @param fromColor 起始发颜色
 *  @param toColor   中间颜色
 *  @param size      图片大小
 *
 *  @return 渐变图片
 */
#define CUCFLinearGradientImageFromColorToColor(fromColor,toColor,size) [CUCFQuickUIUitil gradientLinearImageFromColor:fromColor withToColor:toColor withImageSize:size]

/**
 *  创建球形渐变图片
 *
 *  @param fromColor 中心颜色
 *  @param toColor   外层颜色
 *  @param size      图片大小
 *
 *  @return 渐变图片
 */
#define CUCFRadialGradientImageFromColorToColor(fromColor,toColor,size) [CUCFQuickUIUitil gradientRadialImageFromColor:fromColor withToColor:toColor withImageSize:size]

/**
 *  创建球形渐变图片
 *
 *  @param colors 颜色值数组
 *  @param size 图片大小
 *
 *  @return 渐变图片
 */
#define CUCFRadialGradientImageByColorsWithSize(colors,size) [CUCFQuickUIUitil gradientRadialImageFromColors:colors withImageSize:size]

/**
 *  创建网格线图片
 *
 *  @param lineGap 格线距离
 *  @param color   格线颜色
 *  @param size    图片大小
 *
 *  @return 网格线图片
 */
#define CUCFGridImageByLineGapAndColorWithSize(lineGap,color,size) [CUCFQuickUIUitil gridImageByHoriLineGap:lineGap withVerticalLineGap:lineGap withLineColor:color withImageSize:size]

/**
 *  创建水平网格线图片
 *
 *  @param lineGap 格线距离
 *  @param color   格线颜色
 *  @param size    图片大小
 *
 *  @return 网格线图片
 */
#define CUCFGridImageHorizByLineGapAndColorWithSize(lineGap,color,size) [CUCFQuickUIUitil gridImageHorizonByLineGap:lineGap withLineColor:color withImageSize:size]

/**
 *  创建垂直网格线图片
 *
 *  @param lineGap 格线距离
 *  @param color   格线颜色
 *  @param size    图片大小
 *
 *  @return 网格线图片
 */
#define CUCFGridImageVerticalByLineGapAndColorWithSize(lineGap,color,size) [CUCFQuickUIUitil gridImageVerticalByLineGap:lineGap withLineColor:color withImageSize:size]

/**
 *  快速从文件夹读取图片
 */
#define CUCFQuickImageByFilePath(filePath) [CUCFQuickUIUitil imageWithFilePath:filePath]

/**
 *  快速从归档路径读取图片
 */
#define CUCFQuickUnArchievedImage(filePath) [CUCFQuickUIUitil imageUnArchievedFromFilePath:filePath]

/**
 *  获取拉伸的图片
 *
 *  @param image      原图片
 *  @param leftOffset 左边起始位置
 *  @param topOffset  顶部起始位置
 *
 *  @return 返回拉伸后的图片
 */
#define CUCFImageStrecth(image,leftOffset,topOffset) [CUCFQuickUIUitil stretchImage:image withTopOffset:topOffset withLeftOffset:leftOffset]

/**
 *  获取重设大小拉伸后的图片
 *
 *  @param image  原图片
 *  @param top    顶部起始位置
 *  @param bottom 底部起始位置
 *  @param left   左边起始位置
 *  @param right  右边起始位置
 *
 *  @return 重设大小拉伸后后的图片
 */
#define CUCFImageResize(image,top,bottom,left,right) [CUCFQuickUIUitil resizeImage:image withEdgeTop:top withEdgeBottom:bottom withEdgeLeft:left withEdgeRight:right]

/**
 *  以duration持续时间执行一个UIView动画block
 */
#define CUCFAnimationWithDuration(duration,block) [CUCFQuickUIUitil animationDuration:duration action:block]

/**
 *  延迟second秒，以duration持续时间执行一个UIView动画block
 */
#define CUCFAnimationDelayWithDuration(second,duration,block) [CUCFQuickUIUitil animationDelay:second animationDuration:duration action:block]

/**
 *  默认隐藏显示视图动画
 */
#define CUCFAnimationHiddenShowView(view) [CUCFQuickUIUitil defaultHiddenShowView:view]

/**
 *  指定duration时长隐藏显示动画
 */
#define CUCFAnimationHiddenShowViewDuration(view,duration) [CUCFQuickUIUitil hiddenShowView:view withDuration:duration]

/**
 *  默认显示隐藏视图动画
 */
#define CUCFAnimationShowHiddenView(view) [CUCFQuickUIUitil defaultShowHiddenView:view]

/**
 *  指定duration时长显示隐藏动画
 */
#define CUCFAnimationShowHiddenViewDuration(view,duration) [CUCFQuickUIUitil showHiddenView:view withDuration:duration]

/**
 *  默认隐藏视图动画
 */
#define CUCFAnimationHiddenView(view) [CUCFQuickUIUitil defaultHiddenView:view]

/**
 *  指定duration时长隐藏动画
 */
#define CUCFAnimationHiddenViewDuration(view,duration) [CUCFQuickUIUitil hiddenView:view withDuration:duration]

/**
 *  默认显示视图动画
 */
#define CUCFAnimationShowView(view) [CUCFQuickUIUitil defaultShowView:view]

/**
 *  指定duration时长显示视图动画
 */
#define CUCFAnimationShowViewDuration(view,duration) [CUCFQuickUIUitil showView:view withDuration:duration]

/**
 *  指定duration时间长度，从当前视图alpha到目标alpha
 */
#define CUCFAnimationShowAlphaViewDuration(view,alpha,duration) [CUCFQuickUIUitil showView:view finalAlpha:alpha withDuration:duration]

/**
 *  移动当前视图到指定rect的动画,不支持便捷写法的CGRect  CGRect{20,20,20,20} 这种写法是不支持的需要使用CGRectMake
 */
#define CUCFAnimationMoveViewRect(view,rect,duration) [CUCFQuickUIUitil moveView:view newRect:rect withDuration:duration]

/**
 *  x轴增量移动动画
 */
#define CUCFAnimationMoveViewX(view,xDetal,duration) [CUCFQuickUIUitil moveViewX:view originXDetal:xDetal withDuration:duration]

/**
 *  y轴增量移动动画
 */
#define CUCFAnimationMoveViewY(view,yDetal,duration) [CUCFQuickUIUitil moveViewY:view originYDetal:yDetal withDuration:duration]

/**
 *  width增量变化动画
 */
#define CUCFAnimationMoveViewWidth(view,detal,duration) [CUCFQuickUIUitil moveViewWidth:view widthDetal:detal withDuration:duration]

/**
 *  height增量变化动画
 */
#define CUCFAnimationMoveViewHeight(view,detal,duration) [CUCFQuickUIUitil moveViewHeight:view heightDetal:detal withDuration:duration]

/**
 *  移动到指定x轴点动画
 */
#define CUCFAnimationMoveViewToX(view,toX,duration) [CUCFQuickUIUitil moveViewToX:view toOriginX:toX withDuration:duration]

/**
 *  移动到指定y轴点动画
 */
#define CUCFAnimationMoveViewToY(view,toY,duration) [CUCFQuickUIUitil moveViewToY:view toOriginY:toY withDuration:duration]

/**
 *  指定视图width到目标宽度的动画
 */
#define CUCFAnimationMoveViewToWidth(view,width,duration) [CUCFQuickUIUitil moveViewToWidth:view toWidth:width withDuration:duration]

/**
 *  指定视图height到目标高度的动画
 */
#define CUCFAnimationMoveViewToHeight(view,height,duration) [CUCFQuickUIUitil moveViewToHeight:view toHeight:height withDuration:duration]

/**
 *  移动视图中心动画 不支持便捷写法的CGPoint  (CGPoint){20,20} 这种写法是不支持的需要使用CGPointMake
 */
#define CUCFAnimationMoveViewCenter(view,center,duration) [CUCFQuickUIUitil moveViewCenter:view newCenter:center withDuration:duration]

/**
 *  缩放视图大小动画,不支持便捷写法的CGSize  (CGSize){20,20} 这种写法是不支持的,需要使用CGSizeMake
 */
#define CUCFAnimationMoveViewSize(view,size,duration) [CUCFQuickUIUitil moveViewSize:view newSize:size withDuration:duration]

/**
 *  从左开始翻转视图动画
 */
#define CUCFAnimationLeftFlipView(view,duration,block,completion) [CUCFQuickUIUitil flipViewFromLeft:view withDuration:duration action:block completionBlock:completion]

/**
 *  从右开始翻转视图动画
 */
#define CUCFAnimationRightFlipView(view,duration,block,completion) [CUCFQuickUIUitil flipViewFromRight:view withDuration:duration action:block completionBlock:completion]

/**
 *  从顶部开始翻转视图动画
 */
#define CUCFAnimationTopFlipView(view,duration,block,completion) [CUCFQuickUIUitil flipViewFromTop:view withDuration:duration action:block completionBlock:completion]

/**
 *  从底部开始翻转视图动画
 */
#define CUCFAnimationBottomFlipView(view,duration,block,completion) [CUCFQuickUIUitil flipViewFromBottom:view withDuration:duration action:block completionBlock:completion]

/**
 *  向上翻页动画
 */
#define CUCFAnimationPageUpView(view,duration,block,completion) [CUCFQuickUIUitil pageUpViewFromBottom:view withDuration:duration action:block completionBlock:completion]

/**
 *  向下翻页动画
 */
#define CUCFAnimationPageDownView(view,duration,block,completion) [CUCFQuickUIUitil pageDownViewFromTop:view withDuration:duration action:block completionBlock:completion]

/**
 *  立体翻转动画
 */
#define CUCFAnimationCubeView(view,duration,block,completion) [CUCFQuickUIUitil cubeView:view withDuration:duration  action:block completionBlock:completion]

/**
 *  绕X轴倾斜视图degree角度  degree范围:0-360
 */
#define CUCFAnimationViewRotateX(view,degree,duration) [CUCFQuickUIUitil rotationViewX:view withDegree:degree withDuration:duration]

/**
 *  绕Y轴倾斜视图degree角度  degree范围:0-360
 */
#define CUCFAnimationViewRotateY(view,degree,duration) [CUCFQuickUIUitil rotationViewY:view withDegree:degree withDuration:duration]

/**
 *  绕Z轴倾斜视图degree角度  degree范围:0-360
 */
#define CUCFAnimationViewRotateZ(view,degree,duration) [CUCFQuickUIUitil rotationViewZ:view withDegree:degree withDuration:duration]

/**
 *  translationX动画
 */
#define CUCFAnimationViewTranslationX(view,originX,duration) [CUCFQuickUIUitil translationViewX:view withOriginX:originX withDuration:duration]

/**
 *  translationY动画
 */
#define CUCFAnimationViewTranslationY(view,originY,duration) [CUCFQuickUIUitil translationViewY:view withOriginY:originY withDuration:duration]

/**
 *  translationZ动画
 */
#define CUCFAnimationViewTranslationZ(view,originZ,duration) [CUCFQuickUIUitil translationViewZ:view withOriginZ:originZ withDuration:duration]

/**
 *  scaleX动画
 */
#define CUCFAnimationViewScaleX(view,size,duration) [CUCFQuickUIUitil scaleViewX:view withScaleSize:size withDuration:duration]

/**
 *  scaleY动画
 */
#define CUCFAnimationViewScaleY(view,size,duration) [CUCFQuickUIUitil scaleViewY:view withScaleSize:size withDuration:duration]

/**
 *  scaleZ动画
 */
#define CUCFAnimationViewScaleZ(view,size,duration) [CUCFQuickUIUitil scaleViewZ:view withScaleSize:size withDuration:duration]

/**
 *  将视图绕X轴倾斜degree角度，degree范围 -360到360
 */
#define CUCFView3DRotateX(view,degree) [CUCFQuickUIUitil view3DRotateX:view withDegree:degree]

/**
 *  将视图绕Y轴倾斜degree角度，degree范围 -360到360
 */
#define CUCFView3DRotateY(view,degree) [CUCFQuickUIUitil view3DRotateY:view withDegree:degree]

/**
 *  将视图绕Z轴倾斜degree角度，degree范围 -360到360
 */
#define CUCFView3DRotateZ(view,degree) [CUCFQuickUIUitil view3DRotateZ:view withDegree:degree]

/**
 *  X轴变换
 */
#define CUCFView3DTranslateX(view,value) [CUCFQuickUIUitil view3DTranslateX:view withValue:value]

/**
 *  Y轴变换
 */
#define CUCFView3DTranslateY(view,value) [CUCFQuickUIUitil view3DTranslateY:view withValue:value]

/**
 *  Z轴变换
 */
#define CUCFView3DTranslateZ(view,value) [CUCFQuickUIUitil view3DTranslateZ:view withValue:value]

/**
 *  X轴方向缩放,代表一个缩放比例，一般都是 0 --- 1 之间的数字
 */
#define CUCFView3DScaleX(view,value) [CUCFQuickUIUitil view3DScaleX:view withValue:value]

/**
 *  Y轴方向缩放,代表一个缩放比例，一般都是 0 --- 1 之间的数字
 */
#define CUCFView3DScaleY(view,value) [CUCFQuickUIUitil view3DScaleY:view withValue:value]

/**
 *  Z轴方向缩放,整体比例变换时，也就是m11（sx）== m22（sy）时，若m33（sz）>1，图形整体缩小，若0<1，
 *  图形整体放大，若m33（sz）<0，发生关于原点的对称等比变换
 */
#define CUCFView3DScaleZ(view,value) [CUCFQuickUIUitil view3DScaleZ:view withValue:value]

/**
 *  重复某个block
 */
#define CUCFRepeatAction(repeatBlock) [CUCFQuickUIUitil repeatDoAction:repeatBlock]

/**
 *  延迟second秒开始重复某个动作
 */
#define CUCFRepeatActionDelay(second,repeatBlock) [CUCFQuickUIUitil repeatDoAction:repeatBlock withDelay:second]

/**
 *  重复某个动作duration时长
 */
#define CUCFRepeatActionDuration(duration,repeatBlock) [CUCFQuickUIUitil repeatDoAction:repeatBlock withRepeatDuration:duration]

/**
 *  延迟某个动作second秒，并且只执行duration时长
 */
#define CUCFRepeatActionDelayDuration(second,duration,repeatBlock) [CUCFQuickUIUitil repeatDoAction:repeatBlock withDelay:second withRepeatDuration:duration]

/**
 *  根据blockIdentifier停止某个block重复动作
 */
#define CUCFStopRepeatAction(blockIdentifier) [CUCFQuickUIUitil stopRepeatAction:blockIdentifier]

/**
 *  X轴上以moveXDetal偏移量一个来回,moveXDetal > 0
 */
#define CUCFAnimationViewXCycle(view,moveXDetal,duration) [CUCFQuickUIUitil animationViewXCycle:view withXMoveDetal:moveXDetal withDuration:duration]

/**
 *  Y轴上以moveYDetal偏移量一个来回,moveYDetal > 0
 */
#define CUCFAnimationViewYCycle(view,moveYDetal,duration) [CUCFQuickUIUitil animationViewYCycle:view withYMoveDetal:moveYDetal withDuration:duration]

/**
 *  Z轴上以moveZDetal偏移量一个来回,moveZDetal > 0
 */
#define CUCFAnimationViewZCycle(view,moveZDetal,duration) [CUCFQuickUIUitil animationViewZCycle:view withZMoveDetal:moveZDetal withDuration:duration]

/**
 *  绕X轴上以degree角度为偏移量一个来回,degree: 0-360
 */
#define CUCFAnimationViewRotateXCycle(view,degree,duration) [CUCFQuickUIUitil animationViewRotateXCycle:view withXRotateDetal:degree withDuration:duration]

/**
 *  绕Y轴上以degree角度为偏移量一个来回,degree: 0-360
 */
#define CUCFAnimationViewRotateYCycle(view,degree,duration) [CUCFQuickUIUitil animationViewRotateYCycle:view withYRotateDetal:degree withDuration:duration]

/**
 *  绕Z轴上以degree角度为偏移量一个来回,degree: 0-360
 */
#define CUCFAnimationViewRotateZCycle(view,degree,duration) [CUCFQuickUIUitil animationViewRotateZCycle:view withZRotateDetal:degree withDuration:duration]

/**
 *  fromValue到toValue的position移动CAAnimation
 *  animationKey 为 @"cucf_animation_position"
 *
 */
#define CUCFCAAnimationPosition(aLayer,fromValue,toValue,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionCenterWithFromValue:fromValue withToValue:toValue withRepeatCount:repeatCount  withDuration:duration]

/**
 *  fromValue到toValue的position.x移动CAAnimation
 *  animationKey 为 @"cucf_animation_position.x"
 */
#define CUCFCAAnimationPositionX(aLayer,fromValue,toValue,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionXWithFromValue:fromValue withToValue:toValue withRepeatCount:repeatCount withDuration:duration]

/**
 *  fromValue到toValue的position.y移动CAAnimation
 *  animationKey 为 @"cucf_animation_position.y"
 */
#define CUCFCAAnimationPositionY(aLayer,fromValue,toValue,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionYWithFromValue:fromValue withToValue:toValue withRepeatCount:repeatCount withDuration:duration]

/**
 *  按照value移动postion的CAAnimation
 *  animationKey 为 @"cucf_animation_by_position"
 */
#define CUCFCAAnimationPositionByValue(aLayer,value,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionCenterByValue:value  withRepeatCount:repeatCount  withDuration:duration]

/**
 *  按照value移动postion.x的CAAnimation
 *  animationKey 为 @"cucf_animation_by_position.x"
 */
#define CUCFCAAnimationPositionXByValue(aLayer,value,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionXByValue:value withRepeatCount:repeatCount withDuration:duration]

/**
 *  按照value移动postion.y的CAAnimation
 *  animationKey 为 @"cucf_animation_by_position.y"
 */
#define CUCFCAAnimationPositionYByValue(aLayer,value,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer positionYByValue:value withRepeatCount:repeatCount withDuration:duration]

/**
 *  按照指定路径做动画
 */
#define CUCFAnimationPathByValue(aLayer,aPath,value,repeatCount,duration) [CUCFQuickUIUitil animationLayer:aLayer path:aPath ByValue:value  withRepeatCount:repeatCount  withDuration:duration]
