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
    BOOL _isShowKeyBoard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self __configNav];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)__configNav
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView   *statueBarbackgroundView=[[UIVisualEffectView alloc]initWithEffect:effect];
    statueBarbackgroundView.frame=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20);
    [self.navigationController.navigationBar.superview addSubview:statueBarbackgroundView];
    
    
    UIBarButtonItem *goBackItem=[[UIBarButtonItem alloc]initWithTitle:@"goBack" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *goForwardItem=[[UIBarButtonItem alloc]initWithTitle:@"goForward" style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    UIBarButtonItem *reloadItem=[[UIBarButtonItem alloc]initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    UIBarButtonItem *stopLoadingItem=[[UIBarButtonItem alloc]initWithTitle:@"stopLoading" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
    self.toolbarItems=@[goBackItem,goForwardItem,reloadItem,stopLoadingItem];
    [self.navigationController setToolbarHidden:NO];    
}

-(void)goBack
{
    if(_webView.canGoBack)
        [_webView goBack];
}
-(void)goForward
{
    if(_webView.canGoForward)
        [_webView goForward];
}
-(void)reload
{
    [_webView reload];
}
-(void)stopLoading
{
    [_webView stopLoading];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.automaticallyAdjustsScrollViewInsets=NO;
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
        _webView.dataDetectorTypes=UIDataDetectorTypePhoneNumber |UIDataDetectorTypeLink | UIDataDetectorTypeAddress |UIDataDetectorTypeCalendarEvent;
        _webView.delegate=self;
        _webView.allowsInlineMediaPlayback=YES;
        _webView.allowsLinkPreview=YES;
        _webView.allowsPictureInPictureMediaPlayback=YES;
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
    if (_isShowKeyBoard)
        return;
    
    CGFloat offsetY=((__bridge UIScrollView *)context).contentOffset.y;
    if(offsetY>_currentOffSetY){
        [self.navigationController setNavigationBarHidden:YES  animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
    } else if(offsetY<_currentOffSetY) {
        [self.navigationController setNavigationBarHidden:NO  animated:YES];
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
    _currentOffSetY=offsetY;
}


-(void)keyboardWillShowNotification:(NSNotification *)noti
{
    NSNumber *during=noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:[during floatValue] animations:^{
    } completion:^(BOOL finished) {
        _isShowKeyBoard=YES;
        CGPoint offset=_webView.scrollView.contentOffset;
        [_webView.scrollView setContentOffset:CGPointMake(offset.x, offset.y-12) animated:YES];
        [self.navigationController setNavigationBarHidden:YES  animated:YES];
    }];
}

-(void)keyboardWillHideNotification:(NSNotification *)noti
{
    _isShowKeyBoard=NO;
    NSNumber *during=noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:[during floatValue] animations:^{
        [self.navigationController setNavigationBarHidden:NO  animated:YES];
        CGPoint offset=_webView.scrollView.contentOffset;
        [_webView.scrollView setContentOffset:CGPointMake(offset.x, offset.y-64) animated:YES];
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"_webView.scrollView.contentOffset"];
}
#pragma mark delegate

//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//
//}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return UIWebViewNavigationTypeBackForward |UIWebViewNavigationTypeReload |UIWebViewNavigationTypeFormResubmitted |
//    UIWebViewNavigationTypeOther;
//}
//加载结束
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//}



@end
