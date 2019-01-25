//
//  HanTableViewCell.h
//  WeiLiDai
//
//  Created by LONG on 2019/1/4.
//  Copyright © 2019年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HanTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath withTabel:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
