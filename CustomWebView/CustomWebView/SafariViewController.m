//
//  SafariViewController.m
//  CustomWebView
//
//  Created by wangluting on 16/9/9.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "SafariViewController.h"
#import <SafariServices/SFSafariViewController.h>

@interface SafariViewController()<SFSafariViewControllerDelegate>

@property(nonatomic,strong)SFSafariViewController *sfVC;

@end

@implementation SafariViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
//       self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor=[UIColor grayColor];
    _sfVC= [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://bbs.csdn.net/topics/391044716?page=1"]];
    _sfVC.delegate=self;
    _sfVC.view.frame=self.view.bounds;
    _sfVC.view.userInteractionEnabled=NO;
    [self.view addSubview:_sfVC.view];
    
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    NSLog(@"%s",__func__);
}
-(NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(NSString *)title
{
      NSLog(@"%s",__func__);
    return @[];
}

@end
