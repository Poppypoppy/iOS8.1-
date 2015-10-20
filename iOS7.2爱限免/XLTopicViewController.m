//
//  XLTopicViewController.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLTopicViewController.h"
#import "Header.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "XLDetailViewController.h"
#import "XLTopicTableViewCell.h"
#import "XLTopicView.h"

@interface XLTopicViewController ()

@end

@implementation XLTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //<1>
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    //<2>
    dataSource = [[NSMutableArray alloc]init];
    
    //<3>
    XLRequestModel * requestModel = [[XLRequestModel alloc]init];
    currentPage = 1;
    requestModel.path = [NSString stringWithFormat:SUBJECT_URL,currentPage];
    requestModel.delegate = self;
    [requestModel startRequestInfo];
    
    //<4>
    [self refreshAndLoding];
    
}
//实现协议中的方法
-(void)sendInfoFromRequest:(NSMutableData *)data andPath:(NSString *)path
{
    if(currentPage == 1)
    {
        [dataSource removeAllObjects];
    }
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [dataSource addObjectsFromArray:array];
    //刷新表格
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"custom";
    XLTopicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XLTopicTableViewCell" owner:self options:nil] lastObject];
    }
    NSString * bigImage = dataSource[indexPath.row][@"img"];
    [cell.bigImageView setImageWithURL:[NSURL URLWithString:bigImage]];
    
    NSString * smallImage = dataSource[indexPath.row][@"desc_img"];
    [cell.smallImageView setImageWithURL:[NSURL URLWithString:smallImage]];
    cell.titleLabel.text = dataSource[indexPath.row][@"title"];
    cell.desTextView.text = dataSource[indexPath.row][@"desc"];
    
    //防止单元格复用的时候上面的topicView视图 没有复用出现文字、图片重叠的情况
    for(UIView * view in cell.contentView.subviews)
    {
        if(view.tag >= 100)
        {
            [view removeFromSuperview];
        }
    }
    
    NSArray * arr = dataSource[indexPath.row][@"applications"];
    for(int i = 0;i<arr.count;i++)
    {
        XLTopicView * topic = [[XLTopicView alloc]initWithFrame:CGRectMake(140, 35 + 55 * i, 175, 55)];
        topic.tag = 100 + i;
        
        topic.titleLabel.text = arr[i][@"name"];
        
        NSString * imageStr = arr[i][@"iconUrl"];
        [topic.iconImageView setImageWithURL:[NSURL URLWithString:imageStr]];
        
        //添加点击事件
        topic.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [topic.iconImageView addGestureRecognizer:tap];
        topic.iconImageView.tag = [arr[i][@"applicationId"] integerValue];
        
        
        topic.commentLabel.text = arr[i][@"ratingOverall"];
        topic.downLoadLabel.text = arr[i][@"downloads"];
        [topic.starView setStarLevel:arr[i][@"starOverall"]];
        
        [cell.contentView addSubview:topic];
    }
    return cell;
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag;
    //imageView的tag值就是appId的值
    XLDetailViewController * detail = [[XLDetailViewController alloc]init];
    detail.appID = [NSString stringWithFormat:@"%d",index];
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 308;
}
-(void)refreshAndLoding
{
    //刷新
    [table addHeaderWithCallback:^{
        if(isRefreshing)
        {
            return ;
        }
        isRefreshing = YES;
        currentPage = 1;
        NSString * string = [NSString stringWithFormat:SUBJECT_URL,currentPage];
        XLRequestModel * model = [[XLRequestModel alloc]init];
        model.path = string;
        model.delegate = self;
        [model startRequestInfo];
        
        isRefreshing = NO;
        [table headerEndRefreshing];
    }];
    //加载
    [table addFooterWithCallback:^{
        if(isLoding)
        {
            return ;
        }
        isLoding = YES;
        currentPage ++;
        
        NSString * path = [NSString stringWithFormat:SUBJECT_URL,currentPage];
        XLRequestModel * model = [[XLRequestModel alloc]init];
        model.path = path;
        model.delegate = self;
        [model startRequestInfo];
        isLoding = NO;
        [table footerEndRefreshing];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
