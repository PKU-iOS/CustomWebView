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
{
    WKWebView *_webView;
    CGFloat _currentOffSetY;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
       self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
        UIBarButtonItem *goBackItem=[[UIBarButtonItem alloc]initWithTitle:@"goBack" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
        UIBarButtonItem *goForwardItem=[[UIBarButtonItem alloc]initWithTitle:@"goForward" style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    
        UIBarButtonItem *reloadItem=[[UIBarButtonItem alloc]initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    
        UIBarButtonItem *stopLoadingItem=[[UIBarButtonItem alloc]initWithTitle:@"stopLoading" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
    
        self.toolbarItems=@[goBackItem,goForwardItem,reloadItem,stopLoadingItem];
        [self.navigationController setToolbarHidden:NO];
    
    
    _webView=[[WKWebView alloc]initWithFrame:self.view.bounds configuration:[[WKWebViewConfiguration alloc]init]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:_webView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addObserver:self forKeyPath:@"_webView.scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(_webView.scrollView)];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offsetY=((__bridge UIScrollView *)context).contentOffset.y;
    if(offsetY>_currentOffSetY){
        [self.navigationController setToolbarHidden:YES animated:YES];
    }else if(offsetY<_currentOffSetY){
        [self.navigationController setToolbarHidden:NO  animated:YES];
    }
    _currentOffSetY=offsetY;
    
}

-(void)goBack
{
    if(_webView.canGoBack)
    {
        [_webView goBack];
    }
}
-(void)goForward
{
    if(_webView.canGoForward)
    {
        [_webView goForward];
    }
}
-(void)reload
{
    [_webView reload];
}
-(void)stopLoading
{
    [_webView stopLoading];
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
