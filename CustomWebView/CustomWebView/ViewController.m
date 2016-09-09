//
//  ViewController.m
//  CustomWebView
//
//  Created by wangluting on 16/9/9.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "ViewController.h"

#import "CustomWebViewCotroller.h"
#import "SafariViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation ViewController
{
    CGFloat _currentOffSetY;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=[UIColor grayColor];
    
    [self btnWithTitle:@"CustomWebView" tag:1000 frame:CGRectMake(self.view.center.x-50, 100, 100, 50)];
    [self btnWithTitle:@"SafariView" tag:1001 frame:CGRectMake(self.view.center.x-50, 200, 100, 50)];
    [self btnWithTitle:@"WKWebView" tag:1000 frame:CGRectMake(self.view.center.x-50, 300, 100, 50)];
    
}

-(void)btnWithTitle:(NSString *)title tag:(NSInteger)tag frame:(CGRect)frame
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchDown|UIControlEventTouchDownRepeat];
    btn.frame=frame;
    btn.tag=tag;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:btn];
}

-(void)action:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
            [self.navigationController pushViewController:[[CustomWebViewCotroller alloc]init] animated:YES];
            break;
        case 1001:
            [self.navigationController pushViewController:[[SafariViewController alloc]init] animated:YES];
            break;
        case 1002:
            [self.navigationController pushViewController:[[WKWebViewController alloc]init] animated:YES];
            break;
        default:
            break;
    }
}

@end
