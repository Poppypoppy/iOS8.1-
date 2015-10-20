//
//  XLTopicView.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLStarView.h"
@interface XLTopicView : UIView

@property (nonatomic,retain) UIImageView * iconImageView;
@property (nonatomic,retain) UILabel * titleLabel;
@property (nonatomic,retain) UILabel * commentLabel;
@property (nonatomic,retain) UILabel * downLoadLabel;
@property (nonatomic,retain) XLStarView * starView;

@end
