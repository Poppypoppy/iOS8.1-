//
//  XLStarView.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLStarView.h"

@implementation XLStarView

-(void)createUI
{
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 23)];
    backImageView.image = [UIImage imageNamed:@"StarsBackground.png"];
    [self addSubview:backImageView];
    
    foreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 23)];
    foreImageView.image = [UIImage imageNamed:@"StarsForeground.png"];
    
    //对前面的imageView视图进行分割
    foreImageView.clipsToBounds = YES;
    //设置视图的停靠方向
    foreImageView.contentMode = UIViewContentModeLeft;
    
    [self addSubview:foreImageView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}
//在单元格上添加分割以后的图片视图 需要重写initWithCoder方法 在该方法中再次重新创建UI
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        [self createUI];
    }
    return self;
}
-(void)setStarLevel:(NSString *)level
{
    foreImageView.frame = CGRectMake(0, 0, backImageView.frame.size.width * ([level doubleValue] / 5), backImageView.frame.size.height);
}
@end
