//
//  XLCustomTableViewCell.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLCustomTableViewCell.h"

#import "XLLimitViewController.h"
#import "XLFreeViewController.h"
#import "XLReduceViewController.h"
#import "UIImageView+WebCache.h"


@implementation XLCustomTableViewCell

-(void)createUI
{
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(14, 10, 60, 60)];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(81, 5, 229, 21)];
    [self.contentView addSubview:self.titleLbl];
    
    
    self.timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(82, 29, 170, 21)];
    self.timeLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLbl];
    
    
    self.priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(246, 21, 54, 21)];
    self.priceLbl.font = [UIFont systemFontOfSize:14];
    self.priceLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.priceLbl];
    
    
    self.categoryLbl = [[UILabel alloc]initWithFrame:CGRectMake(246, 49, 54, 21)];
    [self.contentView addSubview:self.categoryLbl];
    
    //在价钱的label添加横线视图
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.priceLbl.frame.size.height / 2, self.priceLbl.frame.size.width, 1)];
    view.backgroundColor = [UIColor blackColor];
    [self.priceLbl addSubview:view];
    
    self.starView = [[XLStarView alloc]initWithFrame:CGRectMake(82, 49, 117, 21)];
    [self.contentView addSubview:self.starView];
    
    self.infoLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 72, 245, 21)];
    self.infoLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.infoLbl];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createUI];
    }
    return self;
}
-(void)showInfoFromRequestDic:(NSDictionary *)dic andControllerName:(id)controller
{
    //判断视图控制器的类型 如果不是降价 都显示剩余时间 如果是降价显示的是现价
    if(![controller isKindOfClass:[XLReduceViewController class]])
    {
        //到期的时间
        NSString * expireDatetime = dic[@"expireDatetime"];
        //判断时间是否是null值
        if([expireDatetime isKindOfClass:[NSNull class]])
        {
            self.timeLbl.text = @"剩余:00:00:00";
        }
        else
        {
            //剩余时间是属于哪一个类
            //定义时间戳类 设置时间的显示样式
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            
            if([controller isKindOfClass:[XLLimitViewController class]])
            {
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
            }
            else
            {
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            }
            
            //将字符串转化成时间
            NSDate * endDate = [formatter dateFromString:expireDatetime];
            
            //获取结束时间距离当前时间的剩余时间
            //剩余时间的单位是秒
            NSTimeInterval timeInterval = [endDate timeIntervalSinceNow];
            
            //时分秒
            int HH = (int)timeInterval / 3600;
            int MM = (int)timeInterval / 60 % 60;
            int SS = (int)timeInterval % 60;
            
            if(HH < 0 || MM < 0 || SS < 0)
            {
                HH = 0;
                MM = 0;
                SS = 0;
            }
            
            self.timeLbl.text = [NSString stringWithFormat:@"剩余:%.2d:%.2d:%.2d",HH,MM,SS];
        }
        
    }
    else
    {
        NSString * currentPrice = dic[@"currentPrice"];
        self.timeLbl.text = [NSString stringWithFormat:@"现价:￥%@",currentPrice];
    }
    
    self.titleLbl.text = dic[@"name"];
    
    self.categoryLbl.text = dic[@"categoryName"];
    
    self.priceLbl.text = [NSString stringWithFormat:@"￥%@",dic[@"lastPrice"]];
    
    self.infoLbl.text = [NSString stringWithFormat:@"收藏:%@ 下载:%@ 分享:%@",dic[@"favorites"],dic[@"downloads"],dic[@"shares"]];
    
    NSString * starLevel = dic[@"starCurrent"];
    [self.starView setStarLevel:starLevel];
    
    
    NSString * imagePath = dic[@"iconUrl"];
    NSURL * url = [NSURL URLWithString:imagePath];
    [self.iconImageView setImageWithURL:url];
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
