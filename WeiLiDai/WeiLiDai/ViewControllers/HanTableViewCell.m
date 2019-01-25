//
//  HanTableViewCell.m
//  WeiLiDai
//
//  Created by LONG on 2019/1/4.
//  Copyright © 2019年 j. All rights reserved.
//

#import "HanTableViewCell.h"

@implementation HanTableViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath withTabel:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        bgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bgView];
        UIBezierPath *path = [UIBezierPath bezierPath];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = bgView.bounds;
        bgView.layer.mask = maskLayer;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            path = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds cornerRadius:22];
        }
        else if (indexPath.row == 0)
        {
            path = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectEdgeLeft|UIRectEdgeTop cornerRadii:CGSizeMake(22, 22)];
        }
        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            path = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectEdgeRight|UIRectEdgeBottom cornerRadii:CGSizeMake(22, 22)];
        }
        else
        {
            path = [UIBezierPath bezierPathWithRect:bgView.bounds];
        }
        maskLayer.path = path.CGPath;
        [bgView.layer addSublayer:maskLayer];
        if (indexPath.row != [tableView numberOfRowsInSection:indexPath.section]-1  )
        {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.borderWidth = 1;
            lineLayer.borderColor = tableView.separatorColor.CGColor;
            lineLayer.frame = CGRectMake(20, 43, tableView.frame.size.width - 40, 1);
            [bgView.layer addSublayer:lineLayer];
        }
    }
    return self;
}

@end
