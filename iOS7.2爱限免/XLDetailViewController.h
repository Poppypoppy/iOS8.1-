//
//  XLDetailViewController.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLRequestModel.h"
@interface XLDetailViewController : UIViewController<sendInfoToCtr>


@property (nonatomic,retain) NSString * appID;//接收上一个界面传递的applicationId的值
@property (nonatomic,retain) UIImageView * iconImageView;
@property (nonatomic,retain) UILabel * titleLbl;
@property (nonatomic,retain) UILabel * lastPriceLbl;
@property (nonatomic,retain) UILabel * appKindLbl;
@property (nonatomic,retain) UILabel * appScoreLbl;
@property (nonatomic,retain) UITextView * detailTextView;
@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,retain) UILabel * stateLbl;


@end
