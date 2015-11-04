//
//  Tutorila3ViewController.m
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import "Tutorila3ViewController.h"
#import "Tutorila4ViewController.h"

@interface Tutorila3ViewController ()

@end

@implementation Tutorila3ViewController

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
    // Do any additional setup after loading the view from its nib.
    if ([appDelegate.aDef objectForKey:ISFIRSTTIME]) {
        if (self.isiPad) {
            self.image3.image=[UIImage imageNamed:@"tutorila_team3_ipad.png"];
        }
        else{
            self.image3.image=[UIImage imageNamed:@"tutorila_notif3.png"];
        }
        
    }
    
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.image3 addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.image3 addGestureRecognizer:sgright];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftSwipeDone
{
    [self.navigationController popViewControllerAnimated:NO];

}
-(void)rightSwipeDone
{
    Tutorila4ViewController *Tutorila4=[[Tutorila4ViewController alloc] initWithNibName:@"Tutorila4ViewController" bundle:nil];
    [self.navigationController pushViewController:Tutorila4 animated:NO];
}

@end
