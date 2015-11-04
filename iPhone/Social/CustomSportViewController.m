//
//  CustomSportViewController.m
//  Wall
//
//  Created by Mindpace on 20/05/14.
//
//

#import "CustomSportViewController.h"
#import "CustomSportCell.h"

@interface CustomSportViewController ()


@end


@implementation CustomSportViewController
@synthesize sportsImageArr;

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setStatusBarStyleOwnApp:0];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)done:(id)sender {
    
    [self.customTextField resignFirstResponder];
    
    UITableViewCell *cell= [self.modalTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (_customTextField.text.length>0) {
        
        self.customSport(-1,_customTextField.text);
        
    }else{
        
        if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
            self.customSport(self.selectedIndex,@"");
        }
    }
    
    
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel:(id)sender {
    
    [self.customTextField resignFirstResponder];
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - TableViewDataSourace

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isiPad) {
        return 75;
    }
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CustomCell";
    
    CustomSportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[CustomSportCell customCell];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        
    }
    
    if (indexPath.row==self.selectedIndex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    
    
    //cell.sportLbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    cell.sportLbl.textColor=[UIColor darkGrayColor];
    cell.sportLbl.text=[self.tableDataArr objectAtIndex:indexPath.row];
    
    if (self.sportsImageArr.count>indexPath.row) {
         cell.sportImage.image=[self.sportsImageArr objectAtIndex:indexPath.row];
    }
  
    return cell;
}

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        self.selectedIndex=indexPath.row;
    }
    self.customSport(self.selectedIndex,@"");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect frame = self.animatedView.frame;
                         if(self.isiPhone5)
                             frame.origin.y=-170;
                         else
                             frame.origin.y=-200;
                         self.animatedView.frame=frame;
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length==0) {
        return NO;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect frame = self.animatedView.frame;
                         if(self.isiPhone5)
                             frame.origin.y=+170;
                         else
                             frame.origin.y=+200;
                         self.animatedView.frame=frame;
                         
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    self.customSport(-1,textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (theTextField.text.length==0) {
        
        NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
        NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
        if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    
    return YES;
}

@end
