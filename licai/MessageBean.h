//
//  MessageBean.h
//  licai
//
//  Created by shuangqi on 15/2/8.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageBean : NSObject
//private String title;//消息标题
//private String content;
//private String memberId;
//private String ID;
//private String memberName;
//private String createUserName;
//private int createUserId;
//private int updateUserId;
//private String updateUserName;
//private String createTime;
//private Date updateTime;
//private int isRead;


@property (copy,nonatomic)NSString *ID;
@property int isRead;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *content;
@property (copy,nonatomic)NSString *create_time;


@end
