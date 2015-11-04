//
//  PageControlExampleViewControl.m
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#import "PageControlExampleViewControl.h"


static NSArray *__pageControlColorList = nil;

@implementation PageControlExampleViewControl

@synthesize pageNumberLabel,sportsName;

// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"PageControllerExample" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}

- (void)dealloc
{
   
}

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad
{
    pageNumberLabel.text = sportsName;//[[NSString alloc] initWithFormat:@"Page %d", pageNumber + 1];
   // self.view.backgroundColor = [PageControlExampleViewControl pageControlColorWithIndex:pageNumber];
}

-(void)loadImage:(NSString*)imageName
{
    
    
    CGSize reqFr=[self getSizeOfText:imageName :CGSizeMake(100, 20) :pageNumberLabel.font];
    
    
    int x=  (self.view.frame.size.width-reqFr.width)/2;
    float width=reqFr.width;
    
    CGRect  reqFrame=  pageNumberLabel.frame;
    reqFrame.origin.x=(x-5);
    reqFrame.size.width=width;
    pageNumberLabel.frame=reqFrame;
    
    reqFrame=  self.sportImageVw.frame;
    reqFrame.origin.x=pageNumberLabel.frame.origin.x+pageNumberLabel.frame.size.width+5;
    
    self.sportImageVw.frame=reqFrame;
    
    NSLog(@"image name %@",[NSString stringWithFormat:@"%@.png",pageNumberLabel.text]);
    @autoreleasepool {
         self.sportImageVw.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",pageNumberLabel.text]];
    }
   
    
}


-(CGSize)getSizeOfText:(NSString*)textStr :(CGSize) constsize :(UIFont*)textFont
{
    CGRect expectedFrame ;
    
    CGSize expectedSize ;
    
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    if(appDelegate.isIos7)
    {
        NSDictionary *fdic=[[NSDictionary alloc] initWithObjectsAndKeys:
                            textFont, NSFontAttributeName,
                            nil];
        
        
        /*NSAttributedString *attributedText=[[NSAttributedString alloc]
         initWithString:textStr
         attributes:fdic];*/
        
        
        
        
        
        
        expectedFrame=[textStr boundingRectWithSize:constsize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:fdic context:nil];
        
        fdic=nil;
        
        
        CGFloat height = ceilf( expectedFrame.size.height);
        CGFloat width  = ceilf(expectedFrame.size.width);
        
        expectedSize = CGSizeMake(width,height);
    }
    else
    {
        expectedSize= [textStr sizeWithFont:textFont constrainedToSize:constsize lineBreakMode: NSLineBreakByWordWrapping];
    }
    
    
    NSLog(@"%f %f",expectedSize.width,expectedSize.height);
    
    return expectedSize;
    
}

@end
