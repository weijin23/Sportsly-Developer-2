//
//  MessageVC.m
//  Wall
//
//  Created by Mindpace on 30/01/14.
//
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "UIImageView+AFNetworking.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
@interface MessageVC ()

@end

@implementation MessageVC

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
    self.nameSearchText.inputAccessoryView=self.toolBar;
    self.messageTxtView.inputAccessoryView=self.toolBar;
    [self.nameSearchText becomeFirstResponder];
    self.filterList=self.appDelegate.myFriendList;
    [self.tableVw reloadData];
    self.sendBtn.userInteractionEnabled=NO;
    self.isSearching=YES;

    [self.nameSearchText addTarget:self action:@selector(textFieldValueChane:) forControlEvents:UIControlEventEditingChanged];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setStatusBarStyleOwnApp:0];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [self setNameSearchText:nil];
    [self setTableVw:nil];
    [self setToolBar:nil];
    [self setMessageTxtView:nil];
    [self setSendBtn:nil];
    [super viewDidUnload];
}


- (IBAction)backf:(id)sender {
    
    [self.messageTxtView resignFirstResponder];
    [self.nameSearchText resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendMessage:(id)sender {
    
    
    if (!self.reciverId && !self.isSearching) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Recipient" message:@"Who would you like to send this message to?" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"sender"];
    [command setObject:self.reciverId forKey:@"receiver"];
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
                

//                ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//              
//                fVC.isList=1;
//                
//                fVC.reciverUserId=self.reciverId;
//                fVC.reciverName=self.nameSearchText.text;
//                fVC.reciverProfileImage=self.proFileImageLink;
//                [self.appDelegate.centerViewController presentViewControllerForModal:fVC];
                
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
    
    
    static NSString *CellIdentifier = @"MessageCell";
    MessageCell *cell = [self.tableVw dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil)
    {
        
        cell =[MessageCell messageCell];
        
    }
    
    
    if (self.isSearching) {
        
        cell.playerName.textColor=[UIColor blackColor];
        cell.userInteractionEnabled=YES;

    }else{
        
        cell.playerName.textColor=[UIColor lightGrayColor];
        cell.userInteractionEnabled=NO;
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
    self.nameSearchText.backgroundColor=[UIColor colorWithRed:52.0/255.0 green:152.0/255 blue:219.0/255.0 alpha:1.0];
    self.nameSearchText.text=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"player_name"];
    if (self.reciverId) {
       
        [self.reciverId removeAllObjects];
    }else{
       
        self.reciverId=[[NSMutableArray alloc] init];
    }
    [self.reciverId addObject:[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"UserID"]];
   // self.reciverId=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"UserID"];
    self.proFileImageLink=[[self.filterList objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"];
    self.isSearching=NO;
    [self.messageTxtView becomeFirstResponder];
    self.filterList=self.appDelegate.myFriendList;
    [self.tableVw reloadData];

    if (self.messageTxtView.text.length>0 && !self.isSearching) {
        
        self.sendBtn.userInteractionEnabled=YES;
        [self.sendBtn setSelected:YES];
        
    }else{
        
        self.sendBtn.userInteractionEnabled=NO;
        [self.sendBtn setSelected:NO];
        
    }

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
    self.isSearching=YES;
    
    if (!self.isSearching) {
        self.sendBtn.userInteractionEnabled=YES;
        [self.sendBtn setSelected:YES];
    }else{
        self.sendBtn.userInteractionEnabled=NO;
        [self.sendBtn setSelected:NO];
    }
   
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark - searchTextField

-(void)textFieldValueChane:(id)sender{
    
    [self search:self.nameSearchText.text];

}

-(void)search:(NSString*)searchTxt
{
    
    if (searchTxt.length>0) {
        
        self.reciverId=nil;
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"player_name like[cd] %@",[NSString stringWithFormat:@"*%@*",searchTxt]];
        
        if (self.filterList) {
            self.filterList=nil;
            self.filterList=[[NSArray alloc] init];
            
        }else{
            self.filterList=[[NSArray alloc] init];
            
        }
        
        self.filterList=[NSMutableArray arrayWithArray:[self.appDelegate.myFriendList
                                                        filteredArrayUsingPredicate:pre]];

    }else{
        
        self.filterList=self.appDelegate.myFriendList;

    }
    
    NSLog(@"filter list %@", self.filterList);
    if (self.filterList.count>0) {
        [self.tableVw reloadData];
    }else{
        [self.tableVw reloadData];
    }
    
    
}






#pragma mark - TextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
       
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>0 && !self.isSearching) {
        
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
            
            if (!self.isSearching) {
                 self.sendBtn.userInteractionEnabled=YES;
                 [self.sendBtn setSelected:YES];
            }else{
                self.sendBtn.userInteractionEnabled=NO;
                [self.sendBtn setSelected:NO];
            }
            
            return YES;
        }else{
            return  NO;
        }
    }
    return YES;
    
}


@end
