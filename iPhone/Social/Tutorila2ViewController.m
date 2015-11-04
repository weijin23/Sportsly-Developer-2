//
//  Tutorila2ViewController.m
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import "Tutorila2ViewController.h"
#import "Tutorila3ViewController.h"


@interface Tutorila2ViewController ()

@end

@implementation Tutorila2ViewController

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
            self.image2.image=[UIImage imageNamed:@"tutorila_team2_ipad.png"];
        }
        else{
            self.image2.image=[UIImage imageNamed:@"tutorila_notif2.png"];
        }
        
    }
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.image2 addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.image2 addGestureRecognizer:sgright];
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
    Tutorila3ViewController *Tutorila3=[[Tutorila3ViewController alloc] initWithNibName:@"Tutorila3ViewController" bundle:nil];
    [self.navigationController pushViewController:Tutorila3 animated:NO];
}

@end
