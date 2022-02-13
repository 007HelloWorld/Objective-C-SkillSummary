//
//  SMCollectionViewFlowLayout.h
//  SMProject
//
//  Created by pjw on 2021/2/22.
//  Copyright © 2021 xuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMCollectionViewFlowLayout : UICollectionViewFlowLayout
///一页展示行数
@property (nonatomic, assign) NSInteger row;
///一页展示列数
@property (nonatomic, assign) NSInteger column;
///行间距
@property (nonatomic, assign) CGFloat rowSpacing;
///列间距
@property (nonatomic, assign) CGFloat columnSpacing;
///item大小
@property (nonatomic, assign) CGSize size;
///一页的宽度
@property (nonatomic, assign) CGFloat pageWidth;
@end

NS_ASSUME_NONNULL_END
