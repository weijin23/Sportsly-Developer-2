//
//  ImageInfo.h
//  ImageGrabber
//
//  Created by Ray Wenderlich on 7/3/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASIHTTPRequest;
@interface ImageInfo : NSObject
{
    
}

- (id)initWithSourceURL:(NSURL *)URL;
- (id)initWithSourceURL:(NSURL *)URL imageName:(NSString *)name image:(UIImage *)i;

@property (strong) NSURL * sourceURL;
@property (strong) NSString * imageName;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) id notifiedObject;
@property (nonatomic, strong) NSString *notificationName;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ASIHTTPRequest *myRequest;
@property (nonatomic, assign) BOOL isProcessing;
@property (nonatomic, assign) BOOL isSmall;
-(UIImage*)getImage:(UIImage*)image1 isWidth:(BOOL)isWidth length:(int)length;
- (void)getImage;
@end
