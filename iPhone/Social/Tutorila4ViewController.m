//
//  Tutorila4ViewController.m
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import "Tutorila4ViewController.h"
#import "Tutorila5ViewController.h"


@interface Tutorila4ViewController ()

@end

@implementation Tutorila4ViewController

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
            self.image4.image=[UIImage imageNamed:@"tutorila_team4_ipad.png"];
        }
        else{
            self.image4.image=[UIImage imageNamed:@"tutorila_notif4.png"];
        }
        
    }
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.image4 addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.image4 addGestureRecognizer:sgright];
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
    Tutorila5ViewController *Tutorila5=[[Tutorila5ViewController alloc] initWithNibName:@"Tutorila5ViewController" bundle:nil];
    [self.navigationController pushViewController:Tutorila5 animated:NO];
}
@end
