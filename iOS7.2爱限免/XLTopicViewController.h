//
//  XLTopicViewController.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLRequestModel.h"
@interface XLTopicViewController : UIViewController<sendInfoToCtr,UITableViewDataSource,UITableViewDelegate>
{
    BOOL isRefreshing;
    BOOL isLoding;
    
    int currentPage;
    
    NSMutableArray * dataSource;
    UITableView * table;
}
-(void)refreshAndLoding;

@end
