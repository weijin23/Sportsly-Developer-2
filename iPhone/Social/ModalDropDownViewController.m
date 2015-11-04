//
//  ModalDropDownViewController.m
//  TestContact
//
//  Created by Sukhamoy on 18/11/13.
//  Copyright (c) 2013 Sukhamoy. All rights reserved.
//

#import "ModalDropDownViewController.h"

@interface ModalDropDownViewController ()

@end

@implementation ModalDropDownViewController
@synthesize emailIdArr,selectedIndex,updateBlock;
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
    self.emailIdArr=[[NSMutableArray alloc] initWithObjects:@"Player",nil];
   // self.nameText.enabled=NO;
    
    self.middlevw.backgroundColor=appDelegate.barGrayColor;
    self.topsecond.backgroundColor=appDelegate.barGrayColor;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    UITableViewCell *cell= [self.modalTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
          self.updateBlock(self.selectedIndex,@"");
    }else{
           self.updateBlock(-1,self.nameText.text);
    }

    
    
    
  
    [self  dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];
    
}

- (IBAction)cancel:(id)sender {
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];


}

- (IBAction)addCustom:(id)sender {
    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         CGRect frame = self.view.frame;
//                         frame.origin.y=-125;
//                         self.view.frame=frame;
//                     }
//                     completion:^(BOOL finished){
//                     }];
    
    self.modalTable.frame=CGRectMake(self.modalTable.frame.origin.x, self.modalTable.frame.origin.y, self.modalTable.frame.size.width, self.modalTable.frame.size.height -60);
    
    self.nameText.enabled=YES;

    [self.nameText becomeFirstResponder];
    
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
   UITableViewCell *cell= [self.modalTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
     cell.accessoryType=UITableViewCellAccessoryNone;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         CGRect frame = self.view.frame;
//                         frame.origin.y=0;
//                         self.view.frame=frame;
//                     }
//                     completion:^(BOOL finished){
//                     }];
    
    
    
    self.updateBlock(-1,textField.text);
  
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.emailIdArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         cell.accessoryType=UITableViewCellAccessoryCheckmark;
        
        }
    
    if (indexPath.row==self.selectedIndex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;

    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.text=[self.emailIdArr objectAtIndex:indexPath.row];
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
    self.updateBlock(self.selectedIndex,@"");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.appDelegate setHomeView];

}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_modalTable release];
    [self setNameText:nil];
    [self setMiddlevw:nil];
    [self setTopvw:nil];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNameText:nil];
    [self setMiddlevw:nil];
    [self setTopvw:nil];
    [self setTopsecond:nil];
    [super viewDidUnload];
}
@end
