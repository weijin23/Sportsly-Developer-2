//
//  ImageInfo.m
//  ImageGrabber
//
//  Created by Ray Wenderlich on 7/3/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//
#import "LeftViewController.h"
#import "RightVCTableData.h"
#import "ImageInfo.h"
#import "ASIHTTPRequest.h"
#import "HomeVCTableData.h"
@implementation ImageInfo

@synthesize sourceURL;
@synthesize imageName;
@synthesize image,notifiedObject,notificationName,userInfo,imageView,myRequest,isProcessing,isSmall;

- (void)getImage
{
    
   /* NSLog(@"Getting %@...", sourceURL);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:sourceURL];
    self.myRequest=request;
    
    self.myRequest.delegate=self;*/
    
    
//    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:sourceURL];
//    [request setCompletionBlock:^
//    {
//        NSLog(@"Image downloaded.");
//        NSData *data = [request responseData];
//        self.image = [[[UIImage alloc] initWithData:data] autorelease];
//        
//        
//        if(self.image)
//        {
//        if([notifiedObject isMemberOfClass:[LeftViewController class]])
//        {
//            ((LeftViewController*)notifiedObject).orgImage=self.image;
//        }
//        
//        if(notificationName==nil)
//        {
//        [[NSNotificationCenter defaultCenter] postNotificationName:RIGHTCONTROLLERIMAGELOADED object:notifiedObject];
//        }
//        else if([notificationName isEqualToString:LEFTCONTROLLERIMAGELOADED])
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:LEFTCONTROLLERIMAGELOADED object:notifiedObject];
//        }
//        else if([notificationName isEqualToString:TEAM_LOGO_NOTIFICATION])
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:TEAM_LOGO_NOTIFICATION object:self];
//        }
//        else if([notificationName isEqualToString:TEAMLOGOIMAGELOADED])
//        {
//          [[NSNotificationCenter defaultCenter] postNotificationName:TEAMLOGOIMAGELOADED object:self];
//        }
//        else if([notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSER] || [notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST])
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
//        }
//        else
//        {
//        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:notifiedObject];
//        }
//            
//        }
//        
//    }];
//    
//    [request setFailedBlock:^
//    {
//        NSError *error = [request error];
//        NSLog(@"Error downloading image: %@", error.localizedDescription);
//    }];
    
 /*   [request startAsynchronous];*/
    
    
    
    
    isProcessing=1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
       __block NSData *data=[[NSData alloc] initWithContentsOfURL:sourceURL];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            @autoreleasepool {
                
            
            UIImage *im=[[UIImage alloc] initWithData:data];
               
                data=nil;
                
                if(isSmall)
            self.image = [self getImage:im isWidth:0 length:60  ] ;
                else
            self.image = [self getImage:im isWidth:1 length:280  ] ;
                
                /*NSLog(@"GettingImaInfoInCell= %@...", sourceURL);
                
                if([notifiedObject isMemberOfClass:[HomeVCTableData class]])
                {
                 NSLog(@"InCellImaInfo1=%f-%f-----%@",((HomeVCTableData*)notifiedObject).imageWidth,((HomeVCTableData*)notifiedObject).imageHeight,[NSValue valueWithCGSize:self.image.size]);
                      NSLog(@"InCellImaInfo2=-----%@",[NSValue valueWithCGSize:im.size]);
                }*/
                
            im=nil;
            
            
                im=[[UIImage alloc] initWithData:UIImageJPEGRepresentation(self.image, 1.0)];
                
                self.image=im;
                
               // NSLog(@"ImageSizeImaInfo=%@",[NSValue valueWithCGSize:self.image.size]);
                
                im=nil;
            }
            
            
            
            
            if(self.image)
            {
                if([notifiedObject isMemberOfClass:[LeftViewController class]])
                {
                    ((LeftViewController*)notifiedObject).orgImage=self.image;
                }
                
                if(notificationName==nil)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:RIGHTCONTROLLERIMAGELOADED object:notifiedObject];
                }
                else if([notificationName isEqualToString:LEFTCONTROLLERIMAGELOADED])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:LEFTCONTROLLERIMAGELOADED object:notifiedObject];
                }
                else if([notificationName isEqualToString:TEAM_LOGO_NOTIFICATION])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:TEAM_LOGO_NOTIFICATION object:self];
                }
                else if([notificationName isEqualToString:TEAMLOGOIMAGELOADED])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:TEAMLOGOIMAGELOADED object:self];
                }
                else if([notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSER] || [notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:notifiedObject];
                }
                
            }
            
            
            isProcessing=0;
        });
        
        data=nil;
    });
    

}


- (void)requestFinished:(ASIHTTPRequest *)request
{
            NSLog(@"Image downloaded.");
            NSData *data = [request responseData];
    
    
    UIImage *im=[[UIImage alloc] initWithData:data];
    self.image = im;
    
            if(self.image)
            {
            if([notifiedObject isMemberOfClass:[LeftViewController class]])
            {
                ((LeftViewController*)notifiedObject).orgImage=self.image;
            }
    
            if(notificationName==nil)
            {
            [[NSNotificationCenter defaultCenter] postNotificationName:RIGHTCONTROLLERIMAGELOADED object:notifiedObject];
            }
            else if([notificationName isEqualToString:LEFTCONTROLLERIMAGELOADED])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:LEFTCONTROLLERIMAGELOADED object:notifiedObject];
            }
            else if([notificationName isEqualToString:TEAM_LOGO_NOTIFICATION])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:TEAM_LOGO_NOTIFICATION object:self];
            }
            else if([notificationName isEqualToString:TEAMLOGOIMAGELOADED])
            {
              [[NSNotificationCenter defaultCenter] postNotificationName:TEAMLOGOIMAGELOADED object:self];
            }
            else if([notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSER] || [notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
            }
           else
            {
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:notifiedObject];
            }
                
            }
    
    
}



-(UIImage*)getImage:(UIImage*)image1 isWidth:(BOOL)isWidth length:(int)length
{
    UIImage *orgImage=nil;
    UIImage *thumbnailImage = image1;
    
    CGSize sz;
    
    
    if(isWidth)
        sz= CGSizeMake(length,((thumbnailImage.size.height/thumbnailImage.size.width)*length));
    else
        sz= CGSizeMake(((thumbnailImage.size.width/thumbnailImage.size.height)*length),length);
    
    
    UIGraphicsBeginImageContextWithOptions(sz, FALSE, 0.0);
    
    
    
    //[thumbnailImage drawInRect:CGRectMake( 0, 0, thumbnailImage.size.width, thumbnailImage.size.height)];
    if(isWidth)
        [thumbnailImage drawInRect:CGRectMake( 0, 0,length, ((thumbnailImage.size.height/thumbnailImage.size.width)*length))];
    else
        [thumbnailImage drawInRect:CGRectMake( 0, 0, ((thumbnailImage.size.width/thumbnailImage.size.height)*length),length)];
    
    //        UIImage *fgImage=[UIImage imageNamed:THUMBIMAGENAME];
    //
    //        CGPoint p= CGPointMake(((sz.width-fgImage.size.width)/2), ((sz.height-fgImage.size.height)/2));
    //
    //        [fgImage drawInRect:CGRectMake(p.x,p.y,fgImage.size.width, fgImage.size.height)];
    orgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return orgImage;
    
}




- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error downloading image: %@", error.localizedDescription);
}

- (id)initWithSourceURL:(NSURL *)URL {
    if ((self = [super init])) {
        sourceURL = URL;
        imageName = [URL lastPathComponent];
        image=nil;
        notifiedObject=nil;
        notificationName=nil;
        userInfo=nil;
      //  [self getImage];
        imageView=nil;
        myRequest=nil;
        isSmall=1;
    }
    return self;
}

- (id)initWithSourceURL:(NSURL *)URL imageName:(NSString *)name image:(UIImage *)i {
    if ((self = [super init])) {
        sourceURL = URL;
        imageName = name;
        image = i;
        isSmall=1;
    }
    return self;
}


@end
