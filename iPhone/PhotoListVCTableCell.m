//
//  PhotoMainVCTableCell.m
//  Social
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import "PhotoListVCTableCell.h"

@implementation PhotoListVCTableCell

@synthesize btn1,btn2,btn3,btn4,crossBtn1,crossBtn2,crossBtn3,crossBtn4,vw1,vw2,vw3,vw4,playimage1,playimage2,playimage3,playimage4;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CAAnimation*)getShakeAnimation
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.06f;
    
    NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.125;
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}

- (IBAction)longPressAction:(id)sender {
    //    NSLog(@"Inside Long Press Action for view 0");
    self.crossBtn1.hidden=NO;
    [self.vw1.layer addAnimation:[self getShakeAnimation] forKey:@"transform"];
}

- (IBAction)longPressAction1:(id)sender {
    //    NSLog(@"Inside Long Press Action for view 1");
    self.crossBtn2.hidden=NO;
    [self.vw2.layer addAnimation:[self getShakeAnimation] forKey:@"transform"];
}

- (IBAction)longPressAction2:(id)sender {
    //    NSLog(@"Inside Long Press Action for view 2");
    self.crossBtn3.hidden=NO;
    [self.vw3.layer addAnimation:[self getShakeAnimation] forKey:@"transform"];
}

- (IBAction)longPressAction3:(id)sender {
    //    NSLog(@"Inside Long Press Action for view 3");
    self.crossBtn4.hidden=NO;
    [self.vw4.layer addAnimation:[self getShakeAnimation] forKey:@"transform"];
}

//- (void)dealloc {
//    [btn1 release];
//    [btn2 release];
//    [btn3 release];
//    [btn4 release];
//    [crossBtn1 release];
//    [crossBtn2 release];
//    [crossBtn3 release];
//    [crossBtn4 release];
//    [vw1 release];
//    [vw2 release];
//    [vw3 release];
//    [vw4 release];
//    [super dealloc];
//}

@end
