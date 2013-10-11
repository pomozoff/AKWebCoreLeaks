//
//  AKViewController.m
//  AKWebCoreLeaks
//
//  Created by Anton Pomozov on 11.10.13.
//  Copyright (c) 2013 Akademon Ltd. All rights reserved.
//

#import "AKViewController.h"

@interface AKViewController ()

@property (nonatomic, strong, readonly) UIWebView *webView;

@end

@implementation AKViewController

@synthesize webView = _webView;

#define MARGIN_WEB_VIEW_X 15.0f
#define MARGIN_WEB_VIEW_TOP 30.0f
#define MARGIN_WEB_VIEW_BOTTOM 25.0f

#pragma mark - Private methods

- (CGRect)makeRectForWebView {
    CGRect appFrame = UIScreen.mainScreen.applicationFrame;
    CGRect rectWebView = CGRectMake(MARGIN_WEB_VIEW_X,
                                    MARGIN_WEB_VIEW_TOP,
                                    appFrame.size.width - MARGIN_WEB_VIEW_X * 2,
                                    appFrame.size.height - MARGIN_WEB_VIEW_BOTTOM);
    
    return rectWebView;
}
- (void)removeSubviews {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (void)presentViews {
    [self removeSubviews];

    self.webView.frame = [self makeRectForWebView];
    [self.view addSubview:self.webView];
}
- (NSURLRequest *)makeLoginURLRequest {
    NSString *stringUrl = @"http://google.com/";
    NSURL *url = [NSURL URLWithString:[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    return request;
}

#pragma mark - Properties

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:UIScreen.mainScreen.applicationFrame];
        _webView.scalesPageToFit = YES;
    }
    
    return _webView;
}

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self presentViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.webView loadRequest:[self makeLoginURLRequest]];
}

@end
