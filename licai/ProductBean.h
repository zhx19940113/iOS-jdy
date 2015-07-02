//
//  ProductBean.h
//  licai
//
//  Created by 钟惠雄 on 15/2/4.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface ProductBean : NSObject

/** 产品ID */
@property (copy,nonatomic)NSString *ID;

@property(copy,nonatomic)NSString *productId;
/** 产品名称 */
@property (copy,nonatomic)NSString *name;
/** 分享主题 */
@property (copy,nonatomic)NSString *shareSubject;
/** 发行方类型 */
@property (copy,nonatomic)NSString *issuerType;
/** 发行方 */
@property (copy,nonatomic)NSString *issuer;
/** 发行方logo */
@property (copy,nonatomic)NSString *issuerLogo;
/** 产品图片 */
@property (copy,nonatomic)NSString *prodImage;
/** 收益类型 */
@property (copy,nonatomic)NSString *profitType;
/** 币种 */
@property (copy,nonatomic)NSString *currencyType;
/** 产品状态 */
@property (copy,nonatomic)NSString *status;
/** 销售结束日期 */
@property (copy,nonatomic)NSString *saleEnd;
/** 销售开始日期 */
@property (copy,nonatomic)NSString *saleStart;
/** 收益结束日期 */
@property (copy,nonatomic)NSString *profitEnd;
/** 收益开始日期 */
@property (copy,nonatomic)NSString *profitStart;
/** 明细类型 */
@property (copy,nonatomic)NSString *detailType;
/** 最低认购金额&起购金额 */
@property float minSubsAmount;
/** 预期年化收益 */
@property float expeAnnuRevnue;
/** 产品详情 */
@property (copy,nonatomic)NSString *prodDetail;
/** 申购须知&风险提示 */
@property (copy,nonatomic)NSString *notice;
/** 机构介绍 */
@property (copy,nonatomic)NSString *orgIntro;
/** 期限 */
@property int period;
/** 项目主题，宣传语*/
@property (copy,nonatomic)NSString *productSubject;
/* 起购金额*/
@property (copy,nonatomic)NSString *entrustIncrease;
/* 续存期*/
@property (copy,nonatomic)NSString *duration;
/** 保险类型 */
@property (copy,nonatomic)NSString *insuranceType;
/* 期限*/
@property int ensurePeriod;
/* 管理人*/
@property (copy,nonatomic)NSString *manager;
/* 基金管理人*/
@property (copy,nonatomic)NSString *fundDirector;
/** 基金类型 */
@property (copy,nonatomic)NSString *fundType;
/** 库存 */
@property int stock;
/** 投资方向 */
@property (copy,nonatomic)NSString *investDirection;
/** 参考最高收益 */
@property float topGain;

/** 产品类型名称 */
@property (copy,nonatomic)NSString *prodTypeName;
/** 产品类型code */
@property (copy,nonatomic)NSString *prodTypeCode;
/**
 * 发布状态 0表示草稿状态可修改 1表示已发布状态不可修改只有当审核不通过才可修改
 * */
@property int publishState;
/**
 * 审核状态 0未审核状态 1审核通过 2审核不通过
 */
@property int checkState;
/**
 * 审核意见
 */
@property (copy,nonatomic)NSString *checkOpinion;
@end
