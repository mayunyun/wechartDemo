//
//  SingleTon.h
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTon : NSObject

/**
 预设可借额度是否生效
 */
@property (nonatomic, assign) BOOL isOnYuShe;

/**
 是否显示需要填写用户名和银行可后四位的视图
 */
@property (nonatomic, assign) BOOL isNeedMessage;

/**
 预设可借额度
 */
@property (nonatomic, assign) CGFloat yuSheKeJieEDu;

/**
 借钱笔数
 */
@property (nonatomic, assign) NSUInteger jieQianBiShu;

/**
 日利率
 */
@property (nonatomic, assign) CGFloat riLiLv;

@property (nonatomic, assign) CGFloat yuECount;

/**
 降利值
 */
@property (nonatomic, assign) CGFloat downLi;

/**
 总额度
 */
@property (nonatomic, assign) NSUInteger borrowCount;

/**
 可借额度
 */
@property (nonatomic, assign) NSUInteger keBorrowCount;
//@property (nonatomic, assign) NSUInteger keBorrowCountTemp;

//[self.dataArray addObject:@{@"returnMoneyDate":cingleTon.bFirstBackMoneyDate,@"returnMoneyCount":cingleTon.bReturnCountMounthly,@"bankCardName":cingleTon.bBankName,@"bankCardNum":cingleTon.bBankCardNum}];

/**
 借款人姓
 */
@property (nonatomic, copy) NSString * bLastName;
/**
 借款人名
 */
@property (nonatomic, copy) NSString * bFirstName;

/**
 身份证号前4位 随机
 */
@property (nonatomic, copy) NSString * bIdCard1;
/**
 身份证号后4位 输入
 */
@property (nonatomic, copy) NSString * bIdCard2;
@property (nonatomic, copy) NSString * bIdCard2Temp;
/**
 借钱金额
 */
@property (nonatomic, copy) NSString * bBorrowCount;
@property (nonatomic, copy) NSString * bBorrowCountTemp;
/**
 银行名字
 */
@property (nonatomic, copy) NSString * bBankName;
@property (nonatomic, copy) NSString * bBankNameTemp;
/**
 银行标志下标
 */
@property (nonatomic, assign) NSUInteger bBankSignIndex;
/**
 银行卡号后四位
 */
@property (nonatomic, copy) NSString * bBankCardNum;
@property (nonatomic, copy) NSString * bBankCardNumTemp;
/**
 银行卡列表
 */
@property (nonatomic, copy) NSArray * bankCardModels;
/**
 开始日期 2018/01/23
 */
@property (nonatomic, copy) NSString * bFrondTime;
/**
 结束日期 2018/01/23
 */
@property (nonatomic, copy) NSString * bEndTime;
/**
 首次还款日 1月23日
 */
@property (nonatomic, copy) NSString * bFirstBackMoneyDate;
//@property (nonatomic, copy) NSString * bFirstBackMoneyDateTemp;
/**
 每月还款日期 23
 */
@property (nonatomic, copy) NSString * kouKuanRi;
/**
 每月应还金额
 */
@property (nonatomic, copy) NSString * bReturnCountMounthly;
//@property (nonatomic, copy) NSString * bReturnCountMounthlyTemp;
/**
 借款期限
 */
@property (nonatomic, copy) NSString * bQiXian;
/**
 手机号前3位
 */
@property (nonatomic, copy) NSString * bPhoneNum1;
/**
 手机号中间4位
 */
@property (nonatomic, copy) NSString * bPhoneNum2;
/**
 手机号后4位
 */
@property (nonatomic, copy) NSString * bPhoneNum3;

/**
 微信头像名
 */
@property (nonatomic, copy) NSString * userHeadImageName;
/**
 从相册中选择的微信头像实体
 */
@property (nonatomic, strong) UIImage * userHeadImage;

/**
 微信昵称
 */
@property (nonatomic, copy) NSString * userNick;

/**
 微信号
 */
@property (nonatomic, copy) NSString * userNum;

/**
 是否显示保险服务
 */
@property (nonatomic, copy) NSString * isShowEnsure;

/**
 是否显示微粒贷
 */
@property (nonatomic, copy) NSString * isShowWeiLiDai;

/**
 是否显示游戏微商店
 */
@property (nonatomic, copy) NSString * isShowGram;

/**
 是否显示喇叭
 */
@property (nonatomic, copy) NSString * isShowHorn;

/**
 喇叭播放内容
 */
@property (nonatomic, copy) NSString * hornContent;

/**
 是否显示降利
 */
@property (nonatomic, copy) NSString * isShowDownLi;

/**
 是否显示获取验证码页面
 */
@property (nonatomic, copy) NSString * isShowGetSMSCodeVC;

/**
 借钱成功的等待时间
 */
@property (nonatomic, copy) NSString * witeTime;

/**
 微信页未读消息数
 */
@property (nonatomic, copy) NSString * unreadHomeCount;
/**
 微信页是否有红点
 */
@property (nonatomic, assign) BOOL haveUnreadHomePoint;
/**
 通讯录页未读消息数
 */
@property (nonatomic, copy) NSString * unreadWealthCount;
/**
 通讯录页是否有红点
 */
@property (nonatomic, assign) BOOL haveUnreadWealthPoint;
/**
 发现页未读消息数
 */
@property (nonatomic, copy) NSString * unreadPraiseCount;
/**
 发现页是否有红点
 */
@property (nonatomic, assign) BOOL haveUnreadPraisePoint;
/**
 我页未读消息数
 */
@property (nonatomic, copy) NSString * unreadFriendCount;
/**
 我页是否有红点
 */
@property (nonatomic, assign) BOOL haveUnreadFriendPoint;


+(SingleTon *)sharedSingleTon;

+(NSArray*)readidcardFile;
@end
