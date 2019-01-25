//
//  SingleTon.m
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "SingleTon.h"
#import "BankCardModel.h"

@implementation SingleTon

+(SingleTon *)sharedSingleTon{
    static SingleTon * singleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [[SingleTon alloc] init];
        singleTon.yuECount = 0;
        singleTon.borrowCount = 0;
        singleTon.keBorrowCount = 0;
        singleTon.bBorrowCount = @"0";
        NSArray * lastNames = @[@"王",@"李",@"张",@"刘",@"陈",@"杨",@"黄",@"赵",@"吴",@"周",@"徐",@"孙",@"马",@"朱",@"胡",@"郭",@"何",@"高",@"林",@"罗",@"郑",@"梁",@"谢",@"宋",@"唐",@"许",@"韩",@"冯",@"邓",@"曹",@"彭",@"曾",@"萧",@"田",@"董",@"潘",@"袁",@"于",@"蒋",@"蔡",@"余",@"杜",@"叶",@"程",@"苏",@"魏",@"吕",@"丁",@"任",@"沈",@"姚",@"卢",@"姜",@"崔",@"钟",@"谭",@"陆",@"汪",@"范",@"金",@"石",@"廖",@"贾",@"夏",@"韦",@"傅",@"方",@"白",@"邹",@"孟",@"熊",@"秦",@"邱",@"江",@"尹",@"薛",@"阎",@"段",@"雷",@"侯",@"龙",@"史",@"陶",@"黎",@"贺",@"顾",@"毛",@"郝",@"龚",@"邵",@"万",@"钱",@"严",@"覃",@"武",@"戴",@"莫",@"孔",@"向",@"汤"];
        NSString * lastName = lastNames[arc4random() % lastNames.count];
        singleTon.bLastName = lastName;
//        NSString * num4 = [NSString stringWithFormat:@"%04d",arc4random() % 9999];
        
        NSArray * idcardarr = [self readidcardFile];
        singleTon.bIdCard1 = [NSString stringWithFormat:@"%@",idcardarr[arc4random()%idcardarr.count]];
//        NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
//        singleTon.bIdCard1 = [NSString stringWithFormat:@"%@%@",areasArray[arc4random()%areasArray.count],[NSString stringWithFormat:@"%02d",arc4random() % 99]];
//        singleTon.bIdCard1 = num4;
        singleTon.userNum = @"点我修改";
        singleTon.userNick = @"独孤求败";
        singleTon.userHeadImageName = [NSString stringWithFormat:@"%u",arc4random() % 900 + 100000];
//        NSLog(@" userHeadImageName %@",singleTon.userHeadImageName);
        singleTon.userHeadImage = nil;
        NSArray * phone3Array = @[@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"187",@"188",@"130",@"131",@"132",@"155",@"156",@"170",@"176",@"185",@"186",@"133",@"153",@"180",@"189"];
        NSString * num1 = [NSString stringWithFormat:@"%@",phone3Array[(NSUInteger)(arc4random() % phone3Array.count)] ];
        NSString * num2 = [NSString stringWithFormat:@"%04d",arc4random() % 9999];
        NSString * num3 = [NSString stringWithFormat:@"%04d",arc4random() % 9999];
        singleTon.bPhoneNum1 = num1;
        singleTon.bPhoneNum2 = num2;
        singleTon.bPhoneNum3 = num3;
        
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 2; i++) {
            NSInteger index = arc4random() % bankCards.count;
            NSDictionary * dic = bankCards[index];
            BankCardModel * model = [[BankCardModel alloc] init];
            model.bBankName = dic[@"bankName"];
            model.bBankCardNum = [NSString stringWithFormat:@"%04d",arc4random() % 9999];
            model.bBankSignImageName = dic[@"imageName"];
            model.bBankSignIndex = index;
            [arr addObject:model];
        }
        singleTon.bankCardModels = arr;
        singleTon.isShowEnsure = @"是";
        singleTon.isShowGram = @"否";
        singleTon.isShowWeiLiDai = @"是";
        singleTon.isShowDownLi = @"否";
        singleTon.isShowHorn = @"否";
        singleTon.hornContent = @"";
        singleTon.isShowGetSMSCodeVC = @"否";
        singleTon.witeTime = @"15";
        singleTon.yuSheKeJieEDu = 5000;
        singleTon.isOnYuShe = NO;
        singleTon.isNeedMessage = YES;
        
        singleTon.unreadHomeCount = nil;
        singleTon.unreadWealthCount = nil;
        singleTon.unreadPraiseCount = nil;
        singleTon.unreadFriendCount = nil;
        
        singleTon.haveUnreadHomePoint = YES;
        singleTon.haveUnreadWealthPoint = NO;
        singleTon.haveUnreadPraisePoint = NO;
        singleTon.haveUnreadFriendPoint = NO;
//        NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//        NSString* oldValue = [userdefault objectForKey:DownLi];
//        NSString* newValue = [userdefault objectForKey:DownLiNew];
//        if (!IsEmptyValue(newValue)) {
//            singleTon.riLiLv = [newValue floatValue];
//        }else{
//            if (!IsEmptyValue(oldValue)) {
//                singleTon.riLiLv = [oldValue floatValue];
//            }else{
//                singleTon.riLiLv = 0.05;
//            }
//        }
        singleTon.riLiLv = 0.045;
        singleTon.downLi = 0;
        singleTon.jieQianBiShu = 1;
    });
    return singleTon;
}

+ (NSArray*)readidcardFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cardid" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [content componentsSeparatedByString:@"\n"]; //从字符A中分隔成2个元素的数组
    NSMutableArray* newarr = [[NSMutableArray alloc]init];
    for (NSString* str1 in array) {
        NSString *str = str1;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [newarr addObject:str];
    }
//    NSLog(@"身份证。。。%@",newarr);
    return newarr;
}

@end
