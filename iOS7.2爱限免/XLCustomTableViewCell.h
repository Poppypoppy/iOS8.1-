//
//  XLCustomTableViewCell.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLStarView.h"
@interface XLCustomTableViewCell : UITableViewCell

@property (nonatomic,retain) UIImageView * iconImageView;
@property (nonatomic,retain) UILabel * titleLbl;
@property (nonatomic,retain) UILabel * timeLbl;
@property (nonatomic,retain) XLStarView * starView;
@property (nonatomic,retain) UILabel * priceLbl;
@property (nonatomic,retain) UILabel * categoryLbl;
@property (nonatomic,retain) UILabel * infoLbl;

//将请求下来的数据显示在cell的视图上
//由于不同的视图控制上的显示的视图内容不同 所以需要判断
-(void)showInfoFromRequestDic:(NSDictionary *)dic andControllerName:(id)controller;

@end
