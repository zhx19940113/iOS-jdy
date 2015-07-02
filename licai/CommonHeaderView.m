//
//  CommonHeaderView.m
//  licai
//
//  Created by shuangqi on 15/2/7.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "CommonHeaderView.h"

@implementation CommonHeaderView
@synthesize countText,descText,unitText;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
        
    }
    
    return self;
}

-(id) init
{
    self = [super init];
    if (self) {
        // Initialization code
         [self initUI];
    }
    
    return self;
}

-(void) initUI
{
    self.backgroundColor = [UIColor colorWithRed:0.30 green:0.68 blue:0.99 alpha:1.0];
    countText=[[UILabel alloc] init];
    [countText setTextColor:[UIColor whiteColor]];
    [countText setTextAlignment:NSTextAlignmentCenter];
    
    
    
    
//    unitText=[[UILabel alloc] init];
//    [unitText setTextColor:[UIColor whiteColor]];
    
    descText=[[UILabel alloc] init];
    [descText setTextColor:[UIColor colorWithRed:14/255 green:14/255 blue:246/255 alpha:0.6]];
    [descText setTextAlignment:NSTextAlignmentCenter];
    [descText setFont:[UIFont systemFontOfSize:15.0]];
    
    [self addSubview:countText];
   // [self addSubview:unitText];
    [self addSubview:descText];
    
    [self setTextFrame];
    
}
-(void) setTextFrame
{
    countText.frame=CGRectMake(15,self.frame.size.height/4,self.frame.size.width-30,self.frame.size.height/2);
    descText.frame=CGRectMake(15,countText.frame.size.height+countText.frame.origin.y,self.frame.size.width-30,self.frame.size.height/8);
}

-(void) setLableText:(NSString*)count andDesc:(NSString*) desc
{
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:count];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FontWord size:(count.length>9)?50.0:70.0] range:NSMakeRange(0, count.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FontWord size:30] range:NSMakeRange(count.length-1,1)];
    
    countText.attributedText=str;
    
    
     descText.text=desc;
}

-(void) setCLableText:(NSString*)count
{
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:count];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FontWord size:(count.length>8)?50.0:70.0] range:NSMakeRange(0, count.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FontWord size:30] range:NSMakeRange(count.length-1,1)];
    
    countText.attributedText=str;
    
}

-(void) setDLableText:(NSString*)desc
{

    descText.text=desc;
    
}




-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setTextFrame];
    
}

@end
