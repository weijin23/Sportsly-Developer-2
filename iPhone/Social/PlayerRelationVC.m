//
//  PlayerRelationVC.m
//  Wall
//
//  Created by Mindpace on 13/12/13.
//
//

#import "PlayerRelationVC.h"

@interface PlayerRelationVC ()

@end

@implementation PlayerRelationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(CGSize)setData:(NSString*)name :(NSString*)relation :(int)isSelf
{
    CGSize m = CGSizeMake(270,90);
    
    
    @autoreleasepool
    {
        
        self.namelab.text=@"No Information.";
        
        
        if(name && (![name isEqualToString:@""]))
        {
            
        }
        else
        {
            name=@"Unknown.";
        }
       
        if(isSelf==2)
        {
            self.namelab.text=[NSString stringWithFormat:@"Friend of %@",name];
        }
        else if(isSelf==1)
        {
            self.namelab.text=[NSString stringWithFormat:@"Friend of %@",name];
        }
        else
        {
             self.namelab.text=[NSString stringWithFormat:@"%@ %@",name,relation];
        }
        
        
        
        m=[self.namelab.text sizeWithFont:self.namelab.font constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        self.namelab.frame=CGRectMakeWithSize(self.namelab.frame.origin.x, self.namelab.frame.origin.y, m);
        
        m.width+=40;
        m.height+=40;
        self.namelab.superview.frame=CGRectMakeWithSize(self.namelab.superview.frame.origin.x, self.namelab.superview.frame.origin.y, m);

        
    }
    
    
    return m;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setNamelab:nil];
    [self setRelationlab:nil];
    [super viewDidUnload];
}
@end
