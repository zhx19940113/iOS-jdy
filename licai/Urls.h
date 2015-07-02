//
//  Urls.h
//  iweight
//
//  Created by 钟惠雄 on 14-9-9.
//  Copyright (c) 2014年 shierlan. All rights reserved.
//

#import "APPConfig.h"
#ifndef iweight_Urls_h
#define iweight_Urls_h




#define URL_REGISTER                @"/member/register"                    //注册接口
#define URL_LOGIN                @"/member/login"                         //登陆接口
#define URL_CHECKCODE          @"/member/verifyCode"                     //获取验证码
#define URL_FORGET_CHECKCODE          @"/member/sendSmsChangPassword"                     //忘记密码获取验证码
#define URL_FORGET_VERCHECKCODE          @"/member/compareVerifyCode2"                     //忘记密码验证验证码
#define URL_FORGET_CHANGEPASSWORD         @"/member/updatePassword2"                     //忘记密码修改密码

//设置
#define URL_CHANGEPASSWORD         @"/member/updatePassword"                     //修改密码
#define URL_LOGINOUT         @"/member/loginOut"                     //注销登陆
#define URL_CHANGENAME         @"/member/updateName"                     //修改名称



//个人中心
#define URL_HEADUPLOAD         @"/fileUpload"                     //上传头像
#define URL_USERINFO         @"/member/memberList"                     //个人信息
#define URL_MSG_NUM         @"/member/sumMessage/"                     //获取消息数

//银行卡
#define URL_ADD_BANKCARD         @"/memberBank/save"                     //添加银行卡
#define URL_BANK_LIST         @"/memberBank/getMemBankList"                     //获取银行卡
#define URL_BANK_DELETE         @"/memberBank/delete/"                     //删除银行卡

//体现
#define URL_SUBMIT_CASH         @"/withdrawcash/save"                     //提取现金操作
#define URL_GET_CAN_CASH         @"/withdrawcash/getCanWithdCash/"                     //获取可用提现金额
#define URL_GET_MEMBANK         @"/memberBank/getMemBank/"                     //获取会员银行卡信息


/**
 * 获取我的订单的数据
 * 提交方式：post
 * 参数：memberId 用户的唯一id号
 */
#define URL_MY_ORDER  @"/member/orderList/"
/**
 * 提现记录
 * 提交方式：post
 * 参数：memberId 用户的唯一id号
 */
#define URL_MY_RECORD   @"/member/withcashrecordList/"

/**
 * 我的面子
 * 提交方式：get
 * 参数："memberId="+用户的唯一id号+ "&year="年份
 */
#define URL_MY_FACE   @"/member/face"
/**
 * 我的圈子
 * 提交方式：get
 * 参数："memberId="+用户的唯一id号+ "&year="年份
 */
#define URL_MY_COMMUNITY @"/member/community"


/**
 * 用户我的面值的数据
 * 提交方式：post
 * 参数：memberId 用户的唯一id号
 */
#define URL_USER_FACE_VALUE  @"/member/incomeExpendList"


#define URL_MY_MESSAGE  @"/member/messageList"

/**
 * 已读消息
 */
#define URL_READEDMSG_URL  @"/member/updateMessageRead"


/**
 * 微信保存链条
 * 提交方式：post
 * 参数：productId 产品ID
 *           memberId 用户ID
 * 返回数据类型：Json
 * 参数：ID t_jdy_share_link表的ID
 */
#define URL_WX_SHARE_URL  @"/share/saveShareLink"

/**
 * 更新分享次数 提交方式：post 参数：productId 产品ID memberId 用户ID
 */
#define URL_SHARE_COUNT_URL @"/share/updateShareCount"

/**
 * 组装分享链条的url(无需传参，只是用来组装url)
 */
#define URL_WX_SHARE_RESULT_URL   @"/product/getProductByProid/"



#define URL_PRODUCT_LIST            @"/product/getProductList3"           //产品列表
//参数：产品id号+"-"+产品类别code码
#define URL_PRODUCT_DETAILS         @"/product/getProductByTypeCodeAndId"  //产品详情
/**
 * 获取优惠码
 * 提交方式：post
 * 参数：productId 产品ID
 *           memberId 用户ID
 * 返回数据类型：Json
 * 参数：couponCode 优惠码
 */
#define URL_PRODUCT_CODE                 @"/share/getCoupon"      //优惠代码
#define URL_PRODUCT_MANAGER_LIST         @"/product/getCustManagerByprodId/"      //产品经理列表
//参数：产品ID
#define URL_PRODUCT_WEBVIEW              @"/product/getProductJsp/"      //产品webview
/**
 * 图片轮播下载地址
 * 提交方式：get
 * 参数：(此URL后加0为请求第一张图片，加1为请求第二张图片，加2为请求第三张图片)
 */
#define URL_PRODUCT_IMAGE        @"/carousel/findImage/"      //首页图片轮播


/**
 * 搜索按钮请求
 * 提交方式：post
 * 参数：keyword 用户搜索的文本
 *           pageNumber 分页的页数
 */
#define URL_SEARCH_BUTTON       @"/product/getProdFuzzySearch"
/**
 * 搜索列表请求
 * 提交方式：post
 * 参数：prodTypeName 点击的列表项文本
 *           pageNumber 分页的页数
 */
#define URL_SEARCH_KEY          @"/product/getProdTypeName"

/**
 * 获取收藏列表
 * 提交方式：post
 * 参数：memberId 会员ID
 *           pageNumber 分页的页数
 */
#define URL_SAVE_LIST                @"/product/queryMineProduct"

//APP升级
#define URL_UPDATE          @"/app/version.imybest"

/**
 * 换银行卡 提交方式：post 参数：ID 银行卡的id号
 */
#define URL_CHANGE_HAND_CARD   @"/memberBank/updateTime"



#endif
