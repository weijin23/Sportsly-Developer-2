//
//  WebViewController.h
//  AutismHelp
//
//  Created by Satish Kumar on 29/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface WebViewController : UIViewController<UIWebViewDelegate>{
 
    IBOutlet UIWebView *webview;
	NSString *urlstr;
	NSURLRequest *req;
	UIView *hudview;
	UILabel *loading;
	UIActivityIndicatorView *indicator;
    BOOL isRate;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong) NSString *websiteTitle;
- (IBAction)back:(id)sender;

-(void)setting:(NSString *)link;

-(void)back;
@property(nonatomic,weak) AppDelegate *appDelegate;
@property(nonatomic,assign) BOOL isRate;
@property(nonatomic,strong) UIWebView *webview;
@property(nonatomic,strong) NSString *urlstr;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,strong) NSURLRequest *req;
@property(nonatomic,strong) UIActivityIndicatorView *indicator;
@property(nonatomic,strong) UIView *hudview;
@property(nonatomic,strong) UILabel *loading;


@end
