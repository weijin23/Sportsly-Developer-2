//
//  GroupMessageViewController.m
//  Wall
//
//  Created by Sukhamoy on 26/05/14.
//
//

#import "GroupMessageViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
#import "GroupChatCell.h"

@interface GroupMessageViewController ()

@end

@implementation GroupMessageViewController

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
   // self.nameSearchText.inputAccessoryView=self.toolBar;
   // self.messageTxtView.inputAccessoryView=self.toolBar;
    self.filterList=self.appDelegate.myFriendList;
    self.reciverId=[[NSMutableArray alloc] init];
    for (int i=0; i<self.filterList.count; i++) {
        
        [self.reciverId addObject:@"0"];
    }
    
    [self.tableVw reloadData];
    self.sendBtn.userInteractionEnabled=NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setStatusBarStyleOwnApp:0];
    //[self.messageTxtView becomeFirstResponder];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backf:(id)sender {
    
    [self.messageTxtView resignFirstResponder];
    [self.nameSearchText resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendMessage:(id)sender {
    
    
    if (self.selectedreciverId.count==0 ) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Recipient" message:@"Who would you like to send this message to?" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"sender"];
    [command setObject:self.selectedreciverId forKey:@"receiver"];
    [command setObject:self.messageTxtView.text forKey:@"message"];
    [command setObject:@"" forKey:@"group_id"];

    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:CHATURLLINK];
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:jsonCommand forKey:@"requestParam"];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    [aRequest startAsynchronous];
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    NSLog(@"Data=%@",str);
    
    
    
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary *dict=(NSDictionary*)res;
            if ([[dict valueForKey:@"status"] integerValue] == 1) {
                
                
             
                
                [self.messageTxtView resignFirstResponder];
                [self.nameSearchText resignFirstResponder];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
            } else{
                
                
            }
        }
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    [self hideHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}
#pragma mark - TableViewDelegate && DataSorce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return   self.filterList.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isiPad) {
        return 90.0;
    }
    return 50.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"GroupChatCell";
    GroupChatCell *cell = [self.tableVw dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil)
    {
        
        cell =[GroupChatCell messageCell];
        
    }
    
    
    cell.playerName.textColor=[UIColor lightGrayColor];
    cell.userInteractionEnabled=YES;

    if ([[self.reciverId objectAtIndex:indexPath.row] integerValue]) {
        
        [cell.userSlectedBtn setSelected:YES];
        
    }else{
       
        [cell.userSlectedBtn setSelected:NO];

    }
    cell.playerName.text=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"player_name"];
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]];
    [cell.profilePicture cleanPhotoFrame];
    
    if ((![[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"] isEqualToString:@""]) && [[self.filterList objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]) {
        
        [cell.profilePicture applyPhotoFrame];
        [cell.profilePicture setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        
    }else{
        [cell.profilePicture setImage:self.noImage];
    }
    
    
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect labelRect = [[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"player_name"]
                        boundingRectWithSize:CGSizeMake(255, 30)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                     }
                        context:nil];
    self.nameSearchText.textColor=[UIColor whiteColor];
    self.nameSearchText.textAlignment=NSTextAlignmentCenter;
    self.nameSearchText.frame=CGRectMake(self.nameSearchText.frame.origin.x, self.nameSearchText.frame.origin.y, labelRect.size.width, self.nameSearchText.frame.size.height);
    self.nameSearchText.textColor=[UIColor colorWithRed:52.0/255.0 green:152.0/255 blue:219.0/255.0 alpha:1.0];
    self.useListLbl.textColor=[UIColor colorWithRed:52.0/255.0 green:152.0/255 blue:219.0/255.0 alpha:1.0];
    //self.nameSearchText.text=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"player_name"];
   // self.reciverId=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"UserID"];
    if ([[self.reciverId objectAtIndex:indexPath.row] integerValue]) {
        
        [self.reciverId replaceObjectAtIndex:indexPath.row withObject:@"0"];
        
    }else{
        
         [self.reciverId replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
   
    self.proFileImageLink=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"];
   // [self.messageTxtView becomeFirstResponder];
    [self.tableVw reloadData];
    
    if (self.messageTxtView.text.length>0 ) {
        
        self.sendBtn.userInteractionEnabled=YES;
        [self.sendBtn setSelected:YES];
        
    }else{
        
        self.sendBtn.userInteractionEnabled=NO;
        [self.sendBtn setSelected:NO];
        
    }
    
    [self upadetedUserList];
}

#pragma mark - GroupUserTitle
-(void)upadetedUserList{
    
    NSString *str=nil;
    if (self.selectedreciverId) {
       
        [self.selectedreciverId removeAllObjects];
    }else{
       
        self.selectedreciverId=[[NSMutableArray alloc] init];
    }
    
    for (int i=0; i<self.reciverId.count; i++) {
        
        if ([[self.reciverId objectAtIndex:i] integerValue]) {
            
            if (!str){
                
                str=[NSString stringWithFormat:@"%@",[[self.filterList objectAtIndex:i] valueForKey:@"player_name"]];
            }else{
                str=[NSString stringWithFormat:@"%@, %@",str,[[self.filterList objectAtIndex:i] valueForKey:@"player_name"]];
            }
            
            [self.selectedreciverId addObject:[[self.filterList objectAtIndex:i] valueForKey:@"UserID"]];
           
        }else{
            
        }
    }
    //self.nameSearchText.text=str;
    self.useListLbl.text=str;
}

#pragma mark - TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.textAlignment=NSTextAlignmentLeft;
    textField.textColor=[UIColor blackColor];
    textField.backgroundColor=[UIColor clearColor];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.textAlignment=NSTextAlignmentLeft;
    textField.textColor=[UIColor blackColor];
    textField.backgroundColor=[UIColor clearColor];
    
        self.sendBtn.userInteractionEnabled=NO;
        [self.sendBtn setSelected:NO];
    
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

//#pragma mark - searchTextField
//
//-(void)textFieldValueChane:(id)sender{
//    
//    [self search:self.nameSearchText.text];
//    
//}
//
//-(void)search:(NSString*)searchTxt
//{
//    
//    if (searchTxt.length>0) {
//        
//        self.reciverId=nil;
//        NSPredicate *pre=[NSPredicate predicateWithFormat:@"player_name like[cd] %@",[NSString stringWithFormat:@"*%@*",searchTxt]];
//        
//        if (self.filterList) {
//            self.filterList=nil;
//            self.filterList=[[NSArray alloc] init];
//            
//        }else{
//            self.filterList=[[NSArray alloc] init];
//            
//        }
//        
//        self.filterList=[NSMutableArray arrayWithArray:[self.appDelegate.myFriendList
//                                                        filteredArrayUsingPredicate:pre]];
//        
//    }else{
//        
//        self.filterList=self.appDelegate.myFriendList;
//        
//    }
//    
//    NSLog(@"filter list %@", self.filterList);
//    if (self.filterList.count>0) {
//        [self.tableVw reloadData];
//    }else{
//        [self.tableVw reloadData];
//    }
//    
//    
//}
//

#pragma mark - TextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
 
    if (self.isiPad) {
        self.tableVw.frame=CGRectMake(0, self.tableVw.frame.origin.y, self.tableVw.frame.size.width, self.tableVw.frame.size.height - 187);
        self.toolBar.frame=CGRectMake(0, self.tableVw.frame.size.height + 100, self.toolBar.frame.size.width,self.toolBar.frame.size.height);
    }
    /*else{
        self.tableVw.frame=CGRectMake(0, self.tableVw.frame.origin.y, 320, self.tableVw.frame.size.height - 220);
        self.toolBar.frame=CGRectMake(0, self.tableVw.frame.size.height + 105, self.toolBar.frame.size.width,self.toolBar.frame.size.height);
    }*/
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"called");
    if (self.isiPad) {
        self.tableVw.frame=CGRectMake(0, self.tableVw.frame.origin.y, self.tableVw.frame.size.width, self.tableVw.frame.size.height + 187);
        self.toolBar.frame=CGRectMake(0, self.view.bounds.size.height - self.toolBar.frame.size.height, self.toolBar.frame.size.width,self.toolBar.frame.size.height);
    }
   /* else{
        self.tableVw.frame=CGRectMake(0, self.tableVw.frame.origin.y, 320, self.tableVw.frame.size.height + 220);
        self.toolBar.frame=CGRectMake(0, self.view.bounds.size.height - self.toolBar.frame.size.height, self.toolBar.frame.size.width,self.toolBar.frame.size.height);
    }*/
    return YES;
    //return NO;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>0 ) {
        
        self.sendBtn.userInteractionEnabled=YES;
        [self.sendBtn setSelected:YES];
        
    }else{
        
        self.sendBtn.userInteractionEnabled=NO;
        [self.sendBtn setSelected:NO];
        
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""]) {
        return YES;
    }else if(textView==self.messageTxtView){
        
        if (textView.text.length<144) {
            
          
            self.sendBtn.userInteractionEnabled=YES;
            [self.sendBtn setSelected:YES];
           
            
            return YES;
        }else{
            return  NO;
        }
    }
    return YES;
    
}


#pragma mark - Keyboard Notificaion

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrameBeginRect = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardFrameEndRect = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat heightChange = (keyboardFrameEndRect.size.height - keyboardFrameBeginRect.size.height);
    // Manage your other frame changes
    if (heightChange == 0) {
        // keyboard height with QuickType is 253.0 in 5s
        [self setViewMovedUp:keyboardFrameEndRect.size.height :1];
    }
    else{
        [self setViewMovedUp:heightChange :1];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    // (self.view.frame.origin.y - 0) is the height to move down
    [self setViewMovedUp:-[[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height :0];  // will be a -ve value
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(float)movedUp :(int)direction
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    
    _toolBar.frame = CGRectMake(_toolBar.frame.origin.x, (_toolBar.frame.origin.y - movedUp), _toolBar.frame.size.width, _toolBar.frame.size.height);
    
    CGFloat newChatTableHeight = _toolBar.frame.origin.y - self.tableVw.frame.origin.y;
    self.tableVw.frame = CGRectMake(self.tableVw.frame.origin.x, self.tableVw.frame.origin.y, self.tableVw.frame.size.width, newChatTableHeight);
    
    
    [UIView commitAnimations];
}


@end
