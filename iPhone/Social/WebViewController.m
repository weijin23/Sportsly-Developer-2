//
//  WebViewController.m
//  AutismHelp
//
//  Created by Satish Kumar on 29/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"


@implementation WebViewController
//@synthesize webView,loader,webUrl;
@synthesize webview,url,req,urlstr,indicator,hudview,loading,isRate,appDelegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     //   [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
      [super viewDidLoad];
     self.titleLbl.text=self.websiteTitle;
     self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBarHidden=YES;
    self.topView.backgroundColor=self.appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
	
	self.hudview=[[UIView alloc] init/*WithFrame:CGRectMake(75,155,170,170)*/];
	hudview.backgroundColor=[UIColor blackColor];
	hudview.clipsToBounds=NO;
	hudview.layer.cornerRadius=10.0;
	//hudview.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	//indicator.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[hudview addSubview:self.indicator];	
	[indicator startAnimating];
	
	self.loading=[[UILabel alloc] init/*WithFrame:CGRectMake(38,20,100,25)*/];
	//loading.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	loading.text=@"Loading...";

	loading.backgroundColor=[UIColor clearColor];
	loading.textColor=[UIColor whiteColor];
	loading.adjustsFontSizeToFitWidth=YES;
    
    if(appDelegate.systemVersion<6.0)
	loading.textAlignment=UITextAlignmentCenter;
    else
    loading.textAlignment=NSTextAlignmentCenter;
	
	[hudview addSubview:self.loading];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [indicator setCenter:CGPointMake(50,50)];
        [loading setFrame:CGRectMake(25,5,50,25)];
        [hudview setFrame:CGRectMake(100,125,100,100)];
    }
    else
    {
        [indicator setCenter:CGPointMake(85,95)];
        [loading setFrame:CGRectMake(38,20,50,25)];
        [hudview setFrame:CGRectMake(300,345,100,100)];
    }
        
    [self.webview setDelegate:self];
    [self.webview setMultipleTouchEnabled:YES];
    
     //NSURL *websiteUrl = [NSURL URLWithString:@"http://www.google.com"];
    
    NSURL *nsurl = [NSURL URLWithString:urlstr];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:nsurl];
    [self.webview loadRequest:requestObj];
    self.webview.scalesPageToFit=YES;
    [self.webview.scrollView setBouncesZoom: YES];
}

- (void)viewDidUnload
{
    [self setTitleLbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    if ([webview isLoading]) {
        [webview stopLoading];
    }
    self.webview=nil;
}

- (IBAction)back:(id)sender {
    
    [self.indicator stopAnimating];
    [self.hudview removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
  

}


#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.indicator startAnimating];
    [self.view addSubview:self.hudview];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.indicator stopAnimating];
    [self.hudview removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.indicator stopAnimating];
    [self.hudview removeFromSuperview];
}

- (void)dealloc {
    if ([webview isLoading]) {
        [webview stopLoading];
    }
	/*[webView release];
	[loader release];
    [webUrl release];*/
    self.appDelegate=nil;
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
}


@end
