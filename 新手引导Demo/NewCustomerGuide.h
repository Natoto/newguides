//
//  NewCustomerGuide.h
//  PENG
//
//  Created by zeno on 16/2/23.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NG_FIND,//发现
    NG_SQUARE,//广场
    NG_CAMERA,//拍照
    NG_CROWNDFUNDING,//众筹
    NG_ACTIVITY,//活动
    NG_ADDFRIENDS,//添加好友
    NG_PB,//P币
    NG_COMMENT,//评论
} NewGuideType;

typedef void(^NEWGUIDETAPTAPBLOCK)();
@interface NewCustomerGuide : UIView
@property(nonatomic,copy) NEWGUIDETAPTAPBLOCK tapblock;
@property(nonatomic,assign) NewGuideType  currentType;

+(id)guide;
//-(void)showTipsWithView:(UIView *)view;
//-(void)showNewGuideWithView:(UIView *)view type:(NewGuideType)type;

-(NewCustomerGuide *)showNewGuideWithView:(UIView *)view type:(NewGuideType)type tapblock:(NEWGUIDETAPTAPBLOCK)block;

-(void)setisshownewguidewith:(NewGuideType)type shown:(BOOL)show;
-(BOOL)isshowguidewith:(NewGuideType)type;

-(NewCustomerGuide *)with;
-(void)addToAppWindow;
@end
