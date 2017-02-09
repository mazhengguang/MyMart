//
//  CategoryViewController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "CategoryViewController.h"
#import "UIView+Extension.h"
#import "CategoryHeadView.h"
#import "TNCustomSegment.h"
//#import "WebViewJavascriptBridge.h"
//#import "WKWebViewJavascriptBridge.h"
#import "GoodWebView.h"
#import "MBProgressHUD.h"


@interface CategoryViewController()<TNCustomSegmentDelegate,GoodWebViewDelegate>
@property (nonatomic, assign) NSInteger selectIndex;

//@property WKWebViewJavascriptBridge *bridge;

@end
@implementation CategoryViewController{
    NSString * urlStr;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CategoryHeadView * view = [CategoryHeadView viewFromXib];
    view.frame = CGRectMake(0, 64,self.view.width, 40);
    NSArray *items = @[@"物品",@"房产",@"服务",@"需求"];
    TNCustomSegment *segment = [[TNCustomSegment alloc] initWithItems:items withFrame:CGRectMake(10, 64,self.view.frame.size.width-20, 30) withSelectedColor:nil withNormolColor:nil withFont:nil];
    segment.delegate = self;
    segment.selectedIndex = 0;
    [self.view addSubview:segment];
    
    self.title = @"分类";
    GoodWebView * webView = [[GoodWebView alloc]initWithFrame:CGRectMake(0, 64+40,self.view.width, self.view.height-64-40)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    urlStr = @"http://baidu.com";
//    NSURL * url = [NSURL URLWithString:urlStr];
//    //[NSURL URLWithString:@"http://app.sg.mymart.com/categories"];
//    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
//    [webView loadRequest:request];
    
    
    
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[urlStr hash]]];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if (!(htmlString ==nil || [htmlString isEqualToString:@""])) {
        [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:urlStr]];
    }else{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request =[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];

        [webView loadRequest:request];
        [self writeToCache];
    }
    
}

/**
 * 网页缓存写入文件
 */
- (void)writeToCache
{
    NSString * htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:Nil];
    //创建文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //获取document路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];

    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES attributes:nil error:nil];
    //写入路径
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[urlStr hash]]];
    
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)webViewDidStartLoad:(GoodWebView *)webView{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
}

- (void)webViewDidFinishLoad:(GoodWebView *)webView{

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

}


- (void)webView:(GoodWebView *)webView didFailLoadWithError:(NSError *)error{

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    CategoryHeadView * view = [CategoryHeadView viewFromXib];
//    return view;
//}
//

//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return section ==0 ?0:10;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}
//#pragma mark - TableViewCell 代理方法
//// 每组多少行
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.selectIndex == 0) {
//        return section==0?2:10;
//    }else if (self.selectIndex == 1){
//        return section==0?2:15;
//
//    }else{
//        return section==0?2:5;
//
//    }
//
//}
//
//// cell定制
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld_____%ld",self.selectIndex,indexPath.row];
//    return cell;
//}
//
//// 选中每一行
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
#pragma mark - TNCustomsegmentDelegate
- (void)segment:(TNCustomSegment *)segment didSelectedIndex:(NSInteger)selectIndex{
    
    self.selectIndex = selectIndex;
    
}




@end
