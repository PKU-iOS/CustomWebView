//
//  WKWebViewController.m
//  CustomWebView
//
//  Created by wangluting on 16/9/9.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "WKWebViewController.h"

#import <WebKit/WebKit.h>


@implementation WKWebViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
       self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    WKWebView *webView=[[WKWebView alloc]initWithFrame:self.view.bounds configuration:[[WKWebViewConfiguration alloc]init]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bbs.csdn.net/topics/391044716?page=1"]]];
    [self.view addSubview:webView];
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
