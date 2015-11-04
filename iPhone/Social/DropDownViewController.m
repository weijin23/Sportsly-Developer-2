//
//  DropDownViewController.m
//  Wall
//
//  Created by Sukhamoy on 18/12/13.
//
//

#import "DropDownViewController.h"
#import "CenterViewController.h"
@interface DropDownViewController ()

@end

@implementation DropDownViewController
@synthesize tableDataArr;

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
    
    [self.customTextField setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
   
    if ([self.type isEqualToString:@"Color"])
    {
        self.customTextField.placeholder=@"Enter custom color name HERE";
        self.titleLbl.text=@"Uniform Color";
        
    }
    else
    {
        self.customTextField.placeholder=@"Enter custom field name HERE";
        self.titleLbl.text=@"Home Field";

    }

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_modalTable release];
    [_customTextField release];
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}


- (IBAction)done:(id)sender {
    
    [self.customTextField resignFirstResponder];

    UITableViewCell *cell= [self.modalTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (_customTextField.text.length>0) {
        
        self.updateBlock(-1,_customTextField.text);
        
    }else{
        
        if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
            self.updateBlock(self.selectedIndex,@"");
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
        return 60;
    }
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableDataArr.count;
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
    
    if (self.isiPad) {
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:20.0];
    }
    else
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.text=[self.tableDataArr objectAtIndex:indexPath.row];
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
    
    self.updateBlock(-1,textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (theTextField.text.length<=0) {
        
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
