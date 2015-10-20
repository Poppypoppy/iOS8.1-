
//
//  XLTopicView.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLTopicView.h"

@implementation XLTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 45, 45)];
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 2, 125, 15)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.titleLabel];
        
        UIImageView * commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(55, 18, 16, 14)];
        commentImageView.image = [UIImage imageNamed:@"topic_Comment.png"];
        [self addSubview:commentImageView];
        
        UIImageView * downLoadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(113, 18, 16, 14)];
        downLoadImageView.image = [UIImage imageNamed:@"topic_Download.png"];
        [self addSubview:downLoadImageView];
        
        self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(74, 14, 43, 21)];
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.commentLabel];
        
        self.downLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(132, 14, 43, 21)];
        self.downLoadLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.downLoadLabel];
        
        self.starView = [[XLStarView alloc]initWithFrame:CGRectMake(55, 35, 90, 12)];
        [self addSubview:self.starView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
