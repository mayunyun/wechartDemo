//
//  HomeIconsCollectionView.m
//  EveryDayBenefit
//
//  Created by 邱 德政 on 16/10/21.
//  Copyright © 2016年 济南联祥技术有限公司. All rights reserved.
//

#import "HomeIconsCollectionView.h"
#import "XZJMyWalletCollectionViewCell.h"


@interface HomeIconsCollectionView ()
{
    CGFloat _width;
    CGFloat _height;
}
@end

@implementation HomeIconsCollectionView

- (id)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 1; //列间距
    flowLayout.minimumLineSpacing = 1;//行间距
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //隐藏滑块
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //设置背景颜色（默认黑色）
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        //注册单元格
        _width = self.frame.size.width;
        _height = self.frame.size.height;
        //3.注册collectionViewCell
        [self registerClass:[XZJMyWalletCollectionViewCell class] forCellWithReuseIdentifier:@"XZJMyWalletCollectionViewCell"];
    }
    
    return self;
}

//协议中的方法，用于返回分区中的单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{//UICollectionViewCell里的属性非常少，实际做项目的时候几乎必须以其为基类定制自己的Cell
    XZJMyWalletCollectionViewCell *cell = (XZJMyWalletCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"XZJMyWalletCollectionViewCell" forIndexPath:indexPath];
    NSDictionary * dic = _dataArr[indexPath.item];
    [cell.headImageView setImage:[UIImage imageNamed:[dic objectForKey:@"cellImage"]]];
    cell.nameLabel.text = [dic objectForKey:@"cellTitle"];
    cell.nameLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    return cell;
}






@end
