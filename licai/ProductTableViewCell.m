//
//  ProductTableViewCell.m
//  licai
//
//  Created by 钟惠雄 on 15/2/3.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

@synthesize msender;

@synthesize productDetailsLabel,productNameLable,pruductTypeImageView,number1Label,number2Label,number3Label,des1Label,des2Label,des3Label;
- (void)awakeFromNib {
    
   // line1.layer.borderWidth = 1;
    
    [self addLine:0 tox:SCREEN_WIDTH y:80 toY:80 lineColor:[UIColor blackColor] mview:self.contentView];
    
    [self addLine:SCREEN_WIDTH/3
              tox:SCREEN_WIDTH/3
                y:80
              toY:120 lineColor:[UIColor blackColor] mview:self.contentView];
    
    [self addLine:SCREEN_WIDTH/3*2
              tox:SCREEN_WIDTH/3*2
                y:80
              toY:120 lineColor:[UIColor blackColor] mview:self.contentView];
   // productNameLable.textColor = [UIColor colorWithRed:255 green:79 blue:85 alpha:1];
    

}

-(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.2f;
    lineShape.lineCap = kCALineCapRound;
    if(color==nil)
        lineShape.strokeColor = [UIColor whiteColor].CGColor;
    else lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [mview.layer addSublayer:lineShape];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
    }
 
    return self;
}




-(void)setBean:(ProductBean *)mBean
{
    productNameLable.text = mBean.name;
    productDetailsLabel.text = mBean.shareSubject;
    if([mBean.prodTypeName isEqualToString:@"银行类"] || [mBean.prodTypeName isEqualToString:@""])
    {
      des1Label.text = @"起购金额";
      des2Label.text = @"收益率";
      des3Label.text = @"存续期";
        
       // number1Label.text = mBean.minSubsAmount==nil ?@"" : ;
        
        if(mBean.minSubsAmount >0)
        {
            if(mBean.minSubsAmount>10000)
                number1Label.text = [NSString stringWithFormat:@"%0.2f万", mBean.minSubsAmount/10000];
            else
                number1Label.text = [NSString stringWithFormat:@"%0.2f", mBean.minSubsAmount];
        }
        
        if(mBean.expeAnnuRevnue >0)
        {
                  number2Label.text = [NSString stringWithFormat:@"%0.2f", mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            
                number3Label.text = [NSString stringWithFormat:@"%0.2d", mBean.period];
        }
        
        
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"保险类"])
    {
        
        des1Label.text = @"保险类型";
        des2Label.text = @"期限";
        des3Label.text = @"发行公司";
        
        if(mBean.insuranceType !=nil)
        {
            number1Label.text = mBean.insuranceType;
        }
        
        if(mBean.period >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2d", mBean.period];
        }
        
        if(mBean.issuer !=nil)
        {
            number3Label.text = mBean.issuer;
        }

    }
    
    if([mBean.prodTypeName isEqualToString:@"公募基金类"])
    {
        des1Label.text = @"认购最低限额";
        des2Label.text = @"基金管理人";
        des3Label.text = @"基金类型";
        
    
        if(mBean.minSubsAmount >0)
        {
             if(mBean.minSubsAmount>10000)
                 number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
            else
                 number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
        }
        
        if(mBean.fundDirector !=nil)
        {
            number2Label.text = mBean.fundDirector;
        }
        
        if(mBean.issuer !=nil)
        {
            number3Label.text = mBean.issuer;
        }

        
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"私募基金类"])
    {
        NSString *fundType = mBean.fundType;
        if([fundType isEqualToString:@"equity"])
        {
            des1Label.text = @"最低认购金额";
            des2Label.text = @"存续期";
            des3Label.text = @"管理人";
            
            if(mBean.minSubsAmount >0)
            {
                 if(mBean.minSubsAmount>10000)
                     number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                     number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];
            }
            
            if(mBean.period >0)
            {
                number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
            }
            
            if(mBean.fundDirector !=nil)
            {
                number3Label.text = mBean.fundDirector;
            }
        }else if([fundType isEqualToString:@"claim"]){
            des1Label.text = @"预期收益";
            des2Label.text = @"存续期";
            des3Label.text = @"投资方向";
            
            if(mBean.expeAnnuRevnue >0)
            {
                number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
            
            if(mBean.period >0)
            {
                number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
            }
            
            if(mBean.investDirection !=nil)
            {
                number3Label.text = mBean.investDirection;
            }
        }else if([fundType isEqualToString:@"stock"]){
            des1Label.text = @"认购金额";
            des2Label.text = @"管理人";
            des3Label.text = @"最高收益";
            
            if(mBean.minSubsAmount >0)
            {
                if(mBean.minSubsAmount>10000)
                    number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                    number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];

            }
            
            if(mBean.fundDirector !=nil)
            {
                number2Label.text = mBean.fundDirector;
            }
            
            if(mBean.expeAnnuRevnue >0)
            {
                number3Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
        }else if([fundType isEqualToString:@"exchange"] || [fundType isEqualToString:@"bond"] || [fundType isEqualToString:@"derivative"]){
            des1Label.text = @"认购金额";
            des2Label.text = @"管理人";
            des3Label.text = @"最高收益";
            
            if(mBean.minSubsAmount >0)
            {
                if(mBean.minSubsAmount>10000)
                    number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
                else
                    number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];

            }
            
            if(mBean.fundDirector !=nil)
            {
                number2Label.text = mBean.fundDirector;
            }
            
            if(mBean.expeAnnuRevnue >0)
            {
                number3Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
            }
        }
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"信托类"] || [mBean.prodTypeName isEqualToString:@"资管类"])
    {
        des1Label.text = @"投资方向";
        des2Label.text = @"预期收益";
        des3Label.text = @"存续期";
        
        if(mBean.investDirection !=nil)
        {
            number1Label.text = mBean.investDirection;
        }
        
        if(mBean.expeAnnuRevnue >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            number3Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
        }
        
    }
    
    if([mBean.prodTypeName isEqualToString:@"债权众筹类"])
    {
//        textView5.setText("预期收益");
//        
//        textView2.setText(String.valueOf(listViewProductEntitiesList
//                                         .get(position).getExpeAnnuRevnue()) == "null" ? ""
//                          : String.valueOf(listViewProductEntitiesList.get(
//                                                                           position).getExpeAnnuRevnue()));
//        
//        textView6.setText("存续期");
//        
//        textView3.setText(String.valueOf(listViewProductEntitiesList
//                                         .get(position).getPeriod()) == "null" ? "" : String
//                          .valueOf(listViewProductEntitiesList.get(position)
//                                   .getPeriod()));
//        
//        textView7.setText("管理人");
//        
//        textView4.setText(String.valueOf(listViewProductEntitiesList
//                                         .get(position).getFundDirector()) == "null" ? ""
//                          : String.valueOf(listViewProductEntitiesList.get(
//                                                                           position).getFundDirector()));
        
        des1Label.text = @"预期收益";
        des2Label.text = @"存续期";
        des3Label.text = @"管理人";
        
        if(mBean.expeAnnuRevnue >0)
        {
            number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.expeAnnuRevnue];
        }
        
        if(mBean.period >0)
        {
            number2Label.text = [NSString stringWithFormat:@"%0.2d",mBean.period];
        }
        
        if(mBean.fundDirector !=nil)
        {
            number3Label.text = mBean.fundDirector;
        }
    }
    
    if([mBean.prodTypeName isEqualToString:@"股权众筹类"])
    {
        des1Label.text = @"管理人";
        des2Label.text = @"投资方向";
        des3Label.text = @"认购金额";
        
        if(mBean.fundDirector !=nil)
        {
            number1Label.text = mBean.fundDirector;
        }
        
        if(mBean.investDirection !=nil)
        {
            number2Label.text = mBean.investDirection;
        }
        
        if(mBean.minSubsAmount >0)
        {
            if(mBean.minSubsAmount>10000)
                number1Label.text = [NSString stringWithFormat:@"%0.2f万",mBean.minSubsAmount/10000];
            else
                number1Label.text = [NSString stringWithFormat:@"%0.2f",mBean.minSubsAmount];

        }
    }
    
    
    
    
    
    
}











@end
