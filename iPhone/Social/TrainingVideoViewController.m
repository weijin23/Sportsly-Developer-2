//
//  TrainingVideoViewController.m
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import "TrainingVideoViewController.h"
#import "AddVideoViewController.h"
#import "ShowVideoViewController.h"

@interface TrainingVideoViewController ()

@end

@implementation TrainingVideoViewController

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
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    self.viewBtn.layer.cornerRadius=4.0f;
    [self.viewBtn.layer setMasksToBounds:YES];
    
    self.addBtn.layer.cornerRadius=4.0f;
    [self.addBtn.layer setMasksToBounds:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
    
    
}


- (IBAction)showVideo:(id)sender {
    ShowVideoViewController *show=[[ShowVideoViewController alloc] initWithNibName:@"ShowVideoViewController" bundle:nil];
    [self.navigationController pushViewController:show animated:YES];
}

- (IBAction)addVideo:(id)sender {
    AddVideoViewController *add=[[AddVideoViewController alloc] initWithNibName:@"AddVideoViewController" bundle:nil];
    add.isCreated=YES;
    [self.navigationController pushViewController:add animated:YES];
}
@end
