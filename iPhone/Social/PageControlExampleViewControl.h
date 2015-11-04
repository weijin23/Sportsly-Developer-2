//
//  PageControlExampleViewControl.h
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageControlExampleViewControl : UIViewController {

	IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
    
    
}
@property (nonatomic, retain) NSString *sportsName;
//@property (nonatomic, retain) UILabel *pageNumberLabel;

@property (nonatomic, retain) IBOutlet UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

-(void)loadImage:(NSString*)imageName;
-(CGSize)getSizeOfText:(NSString*)textStr :(CGSize) constsize :(UIFont*)textFont;
	
@property (strong, nonatomic) IBOutlet UIImageView *sportImageVw;


@end
