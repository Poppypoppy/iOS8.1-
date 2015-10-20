//
//  XLDetailViewController.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLDetailViewController.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface XLDetailViewController ()

@end

@implementation XLDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)createUI
{
    UIImageView * bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 301, 284)];
    bigImageView.image = [UIImage imageNamed:@"appdetail_background.png"];
    [self.view addSubview:bigImageView];
    
    
    UIImageView * smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 284, 300, 103)];
    smallImageView.image = [UIImage imageNamed:@"appdetail_recommend.png"];
    [self.view addSubview:smallImageView];
    
    //添加app图片
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(26, 10, 57, 57)];
    [self.view addSubview:self.iconImageView];
    
    self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(91, 10, 250, 21)];
    [self.view addSubview:self.titleLbl];
    
    UILabel * label1  = [[UILabel alloc]initWithFrame:CGRectMake(91, 28, 40, 21)];
    label1.text = @"原价:";
    label1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
    
    self.lastPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(131, 28, 43, 21)];
    self.lastPriceLbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.lastPriceLbl];
    
    self.stateLbl = [[UILabel alloc]initWithFrame:CGRectMake(184, 25, 42, 30)];
    self.stateLbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.stateLbl];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(91, 46, 42, 21)];
    label2.text = @"类型";
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    self.appKindLbl = [[UILabel alloc]initWithFrame:CGRectMake(133, 46, 50, 21)];
    self.appKindLbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.appKindLbl];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(190, 46, 50, 21)];
    label3.text = @"评分";
    [self.view addSubview:label3];
    label3.font = [UIFont systemFontOfSize:14];
    
    self.appScoreLbl = [[UILabel alloc]initWithFrame:CGRectMake(230, 46, 34, 21)];
    self.appScoreLbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.appScoreLbl];
    
    self.detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(14, 210, 293, 63)];
    self.detailTextView.editable = NO;
    self.detailTextView.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.detailTextView];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(14, 122, 290, 80)];
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    NSArray * btnNames = @[@"分享",@"收藏",@"下载"];
    NSArray * btnImages = @[[UIImage imageNamed:@"Detail_btn_left.png"],[UIImage imageNamed:@"Detail_btn_middle.png"],[UIImage imageNamed:@"Detail_btn_right.png"]];
    for(int i = 0;i<3;i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + 100 * i, 80, 100, 42);
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:btnImages[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self.view addSubview:btn];
    }
    
    UIScrollView * smallScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 315, 300, 103)];
    smallScroll.bounces = NO;
    smallScroll.showsVerticalScrollIndicator = NO;
    smallScroll.showsHorizontalScrollIndicator = NO;
    smallScroll.tag = 998;
    [self.view addSubview:smallScroll];
}
//请求数据
-(void)requestInfo
{
    //<1>获取详细信息
    XLRequestModel * model1 = [[XLRequestModel alloc]init];
    model1.path = [NSString stringWithFormat:DETAIL_URL,self.appID];
    model1.delegate = self;
    [model1 startRequestInfo];
    
    //<2>周边人使用的应用
    XLRequestModel * model2 = [[XLRequestModel alloc]init];
    model2.path = RECOMMEND_URL;
    model2.delegate = self;
    [model2 startRequestInfo];
}
//实现协议中的方法
-(void)sendInfoFromRequest:(NSMutableData *)data andPath:(NSString *)path
{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //获取详细信息
    if(![path isEqualToString:RECOMMEND_URL])
    {
        //获取图片的接口
        NSString * icon = dic[@"iconUrl"];
        [self.iconImageView setImageWithURL:[NSURL URLWithString:icon]];
        //app的标题
        NSString * title = dic[@"name"];
        self.titleLbl.text = title;
        
        self.lastPriceLbl.text = [NSString stringWithFormat:@"￥%@",dic[@"lastPrice"]];
        
        //状态
        NSString * state = dic[@"priceTrend"];
        if([state isEqualToString:@"limited"] || [state isEqualToString:@"free"])
        {
            self.stateLbl.text = @"免费";
        }
        else
        {
            self.stateLbl.text = @"付费";
        }
        self.appKindLbl.text = dic[@"categoryName"];
        self.appScoreLbl.text = dic[@"starCurrent"];
        self.detailTextView.text = dic[@"description_long"];
        
        //为了不影响获取的信息显示的结果 需要将滚动视图上的所有内容视图进行清空
        for(UIView * view in self.scrollView.subviews)
        {
            [view removeFromSuperview];
        }
        //在滚动视图上添加内容视图
        NSArray * smallImages = dic[@"photos"];
        for(int i = 0;i<smallImages.count;i++)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(65 * i, 0, 55, 80)];
            NSString * smallImageStr = smallImages[i][@"smallUrl"];
            [imageView setImageWithURL:[NSURL URLWithString:smallImageStr]];
            [self.scrollView addSubview:imageView];
        }
        self.scrollView.contentSize = CGSizeMake(65 * smallImages.count, 80);
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    else
    {
        //获取周边人使用的应用
        NSArray * array = dic[@"applications"];
        UIScrollView * scroll = (UIScrollView *)[self.view viewWithTag:998];
        for(UIView * view in scroll.subviews)
        {
            [view removeFromSuperview];
        }
        for(int i = 0;i<array.count;i++)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(55 * i + 20, 0, 47, 47)];
            [imageView setImageWithURL:[NSURL URLWithString:array[i][@"iconUrl"]]];
            [scroll addSubview:imageView];
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
            
            //为imageView添加tag tag值为appID的
            imageView.tag = [array[i][@"applicationId"] integerValue];
        }
        
        scroll.contentSize = CGSizeMake(55 * array.count, 47);
        scroll.contentOffset = CGPointMake(0, 0);
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    XLDetailViewController * detail = [[XLDetailViewController alloc]init];
    NSInteger index = ((UIImageView *)tap.view).tag;
    //向详细界面传递appId的值
    detail.appID = [NSString stringWithFormat:@"%d",index];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self requestInfo];
    self.view.backgroundColor = [UIColor whiteColor];
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
