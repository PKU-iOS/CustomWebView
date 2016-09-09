//
//  CustomWebViewCotroller.m
//  CustomWebView
//
//  Created by wangluting on 16/9/9.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "CustomWebViewCotroller.h"

@interface CustomWebViewCotroller()<UIWebViewDelegate>

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation CustomWebViewCotroller
{
    CGFloat _currentOffSetY;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    NSURL *url=[NSURL URLWithString:@"http://bbs.csdn.net/topics/391044716?page=1"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    UIVisualEffectView   *statueBarbackgroundView=[[UIVisualEffectView alloc]initWithEffect:effect];
    statueBarbackgroundView.frame=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20);
    
    [self.navigationController.navigationBar.superview addSubview:statueBarbackgroundView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    //    UIBarButtonItem *goBackItem=[[UIBarButtonItem alloc]initWithTitle:@"goBack" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //
    //    UIBarButtonItem *goForwardItem=[[UIBarButtonItem alloc]initWithTitle:@"goForward" style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    //
    //    UIBarButtonItem *reloadItem=[[UIBarButtonItem alloc]initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    //
    //    UIBarButtonItem *stopLoadingItem=[[UIBarButtonItem alloc]initWithTitle:@"stopLoading" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
    //
    //    self.toolbarItems=@[goBackItem,goForwardItem,reloadItem,stopLoadingItem];
    //    [self.navigationController setToolbarHidden:NO];
}

//-(void)goBack
//{
//    if(_webView.canGoBack)
//    {
//        [_webView goBack];//无效
//    }
//}
//-(void)goForward
//{
//    if(_webView.canGoForward)
//    {
//        [_webView goForward];//无效
//    }
//}
//-(void)reload
//{
//    [_webView reload];//无效
//}
//-(void)stopLoading
//{
//    [_webView stopLoading];//无效
//}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addObserver:self forKeyPath:@"_webView.scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(_webView.scrollView)];
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


-(UIWebView *)webView
{
    if(!_webView)
    {
        _webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.scrollView.bounces=NO;
        _webView.allowsPictureInPictureMediaPlayback=YES;
        //    webView.gapBetweenPages=1000.0;
        //    webView.pageLength=[UIScreen mainScreen].bounds.size.width*0.5;
        _webView.dataDetectorTypes=UIDataDetectorTypePhoneNumber |UIDataDetectorTypeLink | UIDataDetectorTypeAddress |UIDataDetectorTypeCalendarEvent;
        _webView.delegate=self;
        _webView.scalesPageToFit=YES;
        _webView.paginationMode=UIWebPaginationModeUnpaginated;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offsetY=((__bridge UIScrollView *)context).contentOffset.y;
    if(offsetY>_currentOffSetY){
        [self.navigationController setNavigationBarHidden:YES  animated:YES];
    }else if(offsetY<_currentOffSetY){
        [self.navigationController setNavigationBarHidden:NO  animated:YES];
    }
    _currentOffSetY=offsetY;
    
}

-(void)keyboardWillShowNotification:(NSNotification *)noti
{
    [self.navigationController setNavigationBarHidden:YES  animated:YES];
}

-(void)keyboardWillHideNotification:(NSNotification *)noti
{
    [self.navigationController setNavigationBarHidden:NO  animated:YES];
}

#pragma mark delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return UIWebViewNavigationTypeBackForward |UIWebViewNavigationTypeReload |UIWebViewNavigationTypeFormResubmitted |
    UIWebViewNavigationTypeOther;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"_webView.scrollView.contentOffset"];
}


@end
