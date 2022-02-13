//
//  CollectionView.m
//  Image
//
//  Created by pjw on 2021/2/22.
//

#import "CollectionView.h"
#import "SMNormalContentCell.h"
#import "SMCollectionViewFlowLayout.h"
#import <CPHelperTool/CPHelperTool.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import "MJRefresh.h"


static NSString *reuseCollectionViewID  = @"SMNormalContentCell";
#define CUCFSystemScreenWidth [CUCFSystemUitil deviceScreenSize].width
#define CUCFGeometricX(originalX) [CUCFSystemUitil geometricXOriginalX:originalX]

@interface CollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * headerImages;


@end

@implementation CollectionView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareRefresh];

    
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-30);
    }];
    

}

//自定义一个方法实现
- (void)prepareRefresh{
    self.headerImages = [NSMutableArray array];
    for (int i = 0; i < 21; i++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"kf_%d",i]];
    [self.headerImages addObject:image];
 }

}



//
//[_tableView.header endRefreshing];//下拉刷新数据完成时写上
//[_tableView.footer endRefreshing];//上拉加载数据完成时写上





#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMNormalContentCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCollectionViewID forIndexPath:indexPath];
    item.text.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    return item;
}



- (UICollectionView *)collectionView
{
    if (!_collectionView) {
 
        SMCollectionViewFlowLayout *layOut = [[SMCollectionViewFlowLayout alloc]init];
        layOut.minimumLineSpacing = CGFLOAT_MIN;
        layOut.minimumInteritemSpacing = CGFLOAT_MIN;
        layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layOut.row = 2;
        layOut.column = 3;
        layOut.rowSpacing = CGFLOAT_MIN;
        layOut.columnSpacing = CGFLOAT_MIN;
        layOut.pageWidth = CUCFSystemScreenWidth;
        CGFloat widht = (CUCFSystemScreenWidth - CUCFGeometricX(31)) / 3;
        CGFloat height = 120;
        layOut.size = CGSizeMake(widht, height);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layOut];
        
        _collectionView.collectionViewLayout = layOut;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        _collectionView.pagingEnabled = YES;
//        [_collectionView registerClass:[SMNormalContentCell class] forCellWithReuseIdentifier:reuseCollectionViewID];

        [_collectionView registerNib:[UINib nibWithNibName:@"SMNormalContentCell" bundle:nil] forCellWithReuseIdentifier:reuseCollectionViewID];
        
        
        // Set the callback（一Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // Set the ordinary state of animated images
        [header setImages:self.headerImages forState:MJRefreshStateIdle];
        // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
        [header setImages:self.headerImages forState:MJRefreshStatePulling];
        // Set the refreshing state of animated images
        [header setImages:self.headerImages forState:MJRefreshStateRefreshing];
        // Set header
        _collectionView.mj_header = header;
        
        
    }
    return _collectionView;
}


@end
