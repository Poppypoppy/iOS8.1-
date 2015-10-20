//
//  XLRequestModel.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <Foundation/Foundation.h>

//该类进行工程所有的数据请求 请求下来的数据要显示在不同视图控制器的视图上
@protocol sendInfoToCtr <NSObject>

-(void)sendInfoFromRequest:(NSMutableData *)data andPath:(NSString *)path;
//由于一个界面上请求数据的接口 可能不止一个 为了区分请求的数据属于哪个接口 所以我们传递接口信息作为区分

@end

@interface XLRequestModel : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData * myData;
}
@property (nonatomic,retain) NSString * path;//请求数据的接口

@property (nonatomic,assign) id<sendInfoToCtr> delegate;


//开始请求数据
-(void)startRequestInfo;

@end
