//
//  XLStarView.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLStarView : UIView
{
    UIImageView * foreImageView;//显示橘色的星星
    UIImageView * backImageView;//显示白色的✨
}

//设置星级数
-(void)setStarLevel:(NSString *)level;

@end
