//
//  Tutorila5ViewController.m
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import "Tutorila5ViewController.h"
#import "Tutorila6ViewController.h"


@interface Tutorila5ViewController ()

@end

@implementation Tutorila5ViewController

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
            self.image5.image=[UIImage imageNamed:@"tutorila_team5_ipad.png"];
        }
        else{
            self.image5.image=[UIImage imageNamed:@"tutorila_notif5.png"];
        }
        
    }
    
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.image5 addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.image5 addGestureRecognizer:sgright];
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
    Tutorila6ViewController *Tutorila6=[[Tutorila6ViewController alloc] initWithNibName:@"Tutorila6ViewController" bundle:nil];
    [self.navigationController pushViewController:Tutorila6 animated:NO];
}
@end
