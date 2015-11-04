//
//  SportViewController.m
//  Wall
//
//  Created by Sukhamoy on 11/12/13.
//
//

#import "SportViewController.h"

@interface SportViewController ()

@end

@implementation SportViewController

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
     // self.sportArr=[NSArray arrayWithObjects:@"Baseball",@"Basketball",@"Cricket",@"Football",@"Hockey",@"Lacrosse",@"Soccer",@"Volleyball", nil];
    self.selectedIndex=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    self.sportBlock([self.sportArr objectAtIndex:self.selectedIndex]);
    [self  dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];
    
}

- (IBAction)cancel:(id)sender {
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];
    
    
}

#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sportArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType=UITableViewCellAccessoryCheckmark;
        
    }
    
//    if (indexPath.row==self.selectedIndex) {
//        cell.accessoryType=UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType=UITableViewCellAccessoryNone;
//        
//    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.text=[self.sportArr objectAtIndex:indexPath.row];
    if (self.selectedTag==110) {
        
        UIImageView *sportimage=[[UIImageView alloc] initWithFrame:CGRectMake(270, 0, 44, 44)];
        sportimage.image=[self.sportsImageArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:sportimage];
    }
    return cell;
}
#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
//        cell.accessoryType=UITableViewCellAccessoryNone;
//    }else{
//        cell.accessoryType=UITableViewCellAccessoryCheckmark;
//        self.selectedIndex=indexPath.row;
//    }
    self.sportBlock([self.sportArr objectAtIndex:indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];
    
}

@end
