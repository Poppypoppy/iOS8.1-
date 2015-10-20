//
//  XLRootViewController.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLRequestModel.h"
#import "Header.h"

@interface XLRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    NSMutableArray * dataSource;
    UITableView * table;
    
    int currentPage;//记录当前的页码号
    
    //下拉刷新
    BOOL isRefreshing;
    //上拉加载
    BOOL isLoading;
    
    
    
}
//刷新加载视图
-(void)refreshAndLoding:(NSString *)path;



@end
