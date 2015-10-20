//
//  XLRootViewController.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLRootViewController.h"
#import "XLCustomTableViewCell.h"

#import "MJRefresh.h"
#import "XLDetailViewController.h"

@interface XLRootViewController ()

@end

@implementation XLRootViewController

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
    //<1>为导航条添加按钮
    
    NSLog(@"新的更新");
    NSArray * arr = @[@"分类",@"设置"];
    for(int i = 0;i<2;i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        if(btn.tag == 1)
        {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        }
    }
    //<2>添加表格视图
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    //<3>添加搜索框
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    searchBar.placeholder = @"60万应用供你选择";
    table.tableHeaderView = searchBar;
    
    //<4>初始化数据源
    dataSource = [[NSMutableArray alloc]init];
}
//实现协议中的方法
-(void)sendInfoFromRequest:(NSMutableData *)data andPath:(NSString *)path
{
    //防止刷新操作 在表格中追加相同的内容
    if(currentPage == 1)
    {
        [dataSource removeAllObjects];
    }
    
    
    //开始解析数据
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * array = [dic objectForKey:@"applications"];
    //获取数据源
    [dataSource addObjectsFromArray:array];
    //刷新表格视图
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"string";
    XLCustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[XLCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    //在单元格上添加内容
    NSDictionary * dic = nil;
    if(dataSource.count != 0)
    {
        dic = [dataSource objectAtIndex:indexPath.row];
        
        [cell showInfoFromRequestDic:dic andControllerName:self];
    }
    
    //为cell'添加背景图片
    NSString * imageName = nil;
    if(indexPath.row % 2 == 0)
    {
        imageName = @"cate_list_bg1.png";
    }
    else
    {
        imageName = @"cate_list_bg2.png";
    }
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    imageView.image = [UIImage imageNamed:imageName];
    cell.backgroundView = imageView;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//点击单元格跳转到详细界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLDetailViewController * detail = [[XLDetailViewController alloc]init];
    detail.appID = dataSource[indexPath.row][@"applicationId"];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)refreshAndLoding:(NSString *)path
{
 //刷新
    [table addHeaderWithCallback:^{
        if(isRefreshing)
        {
            return ;
        }
        isRefreshing = YES;
        currentPage = 1;
        
        //拼接请求数据的接口
        NSString * allPath = [NSString stringWithFormat:path,currentPage];
        //数据请求
        XLRequestModel * model = [[XLRequestModel alloc]init];
        model.path = allPath;
        model.delegate = self;//设置完代理 就会协议中的方法
        [model startRequestInfo];
        
        isRefreshing = NO;
        [table headerEndRefreshing];
    }];
    //加载
    [table addFooterWithCallback:^{
        if(isLoading)
        {
            return ;
        }
        isLoading = YES;
        currentPage ++;
        
        NSString * allPath = [NSString stringWithFormat:path,currentPage];
        XLRequestModel * model = [[XLRequestModel alloc]init];
        model.path = allPath;
        model.delegate = self;
        [model startRequestInfo];
        
        isLoading = NO;
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
