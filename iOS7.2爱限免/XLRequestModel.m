//
//  XLRequestModel.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLRequestModel.h"
#import "MMProgressHUD.h"

@implementation XLRequestModel

-(void)startRequestInfo
{
    //<1>获取请求路径
    NSString * requestPath = self.path;
    //<2>转换成NSURl
    NSURL * url = [NSURL URLWithString:requestPath];
    //<3>封装成请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //<4>开始异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    //添加动态活动指示器
    //<1>设置活动指示器的样式
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    //<2>设置标题
    [MMProgressHUD showDeterminateProgressWithTitle:nil status:@"正在加载☺️"];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(myData == nil)
    {
        myData = [[NSMutableData alloc]init];
    }
    else
    {
        myData.length = 0;
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [myData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //数据请求结束 反馈给视图控制器上的UI
    if([self.delegate respondsToSelector:@selector(sendInfoFromRequest:andPath:)])
    {
        [self.delegate sendInfoFromRequest:myData andPath:self.path];
    }
    else
    {
        NSLog(@"被动方没有实现协议中的方法");
    }
    
    [MMProgressHUD dismissWithSuccess:@"加载完成☺️"];
}
@end