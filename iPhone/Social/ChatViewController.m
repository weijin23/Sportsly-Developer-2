//
//  ChatViewController.m
//  Wall
//  Created by Sukhamoy on 06/01/14.

#import "ChatViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ChatCell.h"
#import "CenterViewController.h"
#import "ReciverCell.h"
@interface ChatViewController ()<UITextViewDelegate>

@end

@implementation ChatViewController

@synthesize isList;
@synthesize messageList,msgRightColor,emailId;

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
    
    //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    ////
    
    [self setStatusBarStyleOwnApp:0];

    self.titleLbl.text=self.reciverName;
    //self.chatTextView.inputAccessoryView =self.toolBar;
    if ([self.groupId isEqualToString:@""]) {
        self.btnReceiverContact.hidden=NO;
    }
    else{
        self.btnReceiverContact.hidden=YES;
    }

    self.sendBtn.userInteractionEnabled=NO;
    @autoreleasepool {
        
    
    self.msgRightColor= [UIColor colorWithRed:((float) 215.0 / 255.0f)
                    green:((float) 215.0 / 255.0f)
                     blue:((float) 215.0 / 255.0f)
                    alpha:1.0f];

    }
    
    
    self.isList=0;
    if (self.reciverUserId){
        
    
        [self getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:self.reciverUserId];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //[self.chatTextView becomeFirstResponder];
    
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.chatTextView resignFirstResponder];
  
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_chatTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (IBAction)back:(id)sender {
    
    [self.chatTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Call/Mail Receiver
- (IBAction)contactWithReceiver:(id)sender {
    
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:self.reciverName delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",nil];
    action.tag=101;
    [action showInView:self.view];
}

#pragma mark - GetMessageList
-(void)getMessageListforSender:(NSString *)senderId andReciver:(NSString *)reciverId{
    
    if (![self checkInternetConnection]){
        //[self.appDelegate.centerVC showAlertViewCustom:@"There IS NO internet connection"];
        [self showHudView:@"There IS NO internet connection"];
        
        [self performSelector:@selector(hideHudView) withObject:nil afterDelay:2.0];
        return;
    }
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"sender"];
    
    if ([self.groupId isEqualToString:@""]) {
        
         //NSArray *arr=[[NSArray alloc] initWithObjects:self.reciverUserId, nil];
         [command setObject:self.reciverUserId forKey:@"receiver"];
        
    }else{
        
        [command setObject:self.reciverUserId forKey:@"receiver"];
    }
 
    [command setObject:self.groupId forKey:@"group_id"];

 
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:MESSAGEURLLINK];
    
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



#pragma  mark - SendComment

- (IBAction)sendComent:(id)sender {
    
    [self checkInternetConnection];
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"sender"];
    
    if ([self.groupId isEqualToString:@""]) {
        
        NSArray *arr=[[NSArray alloc] initWithObjects:self.reciverUserId,nil];
        
        [command setObject:arr forKey:@"receiver"];
        
    }else{
        
        NSArray *arr=[self.reciverUserId componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@","]]];
        [command setObject:arr forKey:@"receiver"];
    }
    
    [command setObject:self.groupId forKey:@"group_id"];
    [command setObject:self.chatTextView.text forKey:@"message"];
    
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
    self.isList=0;
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
            self.chatTextView.text=@"";
            self.sendBtn.userInteractionEnabled=NO;
            [self.sendBtn setSelected:NO];

            NSDictionary *dict=(NSDictionary*)res;
            if ([[dict valueForKey:@"status"] integerValue] == 1) {
                
                if (self.isList==1) {
                    
                    
                    self.messageGroup=[[dict valueForKey:@"response"] valueForKey:@"message_details"];
                    NSLog(@"mesage Dict %@",self.messageGroup);
                    
                    NSArray *arr=[self.messageGroup allKeys];
                    NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                   NSMutableArray *dateKey=[[[NSMutableArray alloc] init] autorelease];
                    
                    for (NSString *str in arr) {
                        
                        [dateKey addObject:[dateFormatter dateFromString:str]];
                    }
                    
                    NSArray *sortedKey=[dateKey sortedArrayUsingSelector:@selector(compare:)];
                    
                    self.messageList=[[[NSMutableArray alloc] init] autorelease];
                    
                    for (NSDate *date in sortedKey) {
                        [self.messageList addObject:[dateFormatter stringFromDate:date]];
                    }
                    
                    NSLog(@"sorted key %@",self.messageList);
                    
                    if ( self.messageGroup.count>0){
                        
                        //[self messageGropubyDate];
                        [self.chatTableView reloadData];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[self.messageGroup objectForKey:[self.messageList objectAtIndex:[[self.messageGroup allKeys] count] - 1]] count]-1 inSection:[[self.messageGroup allKeys] count] - 1];
                        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                       
                        
                    }else{
                       
                        [self.chatTableView reloadData];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[self.messageGroup objectForKey:[self.messageList objectAtIndex:[[self.messageGroup allKeys] count] - 1]] count]-1 inSection:[[self.messageGroup allKeys] count] - 1];
                        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                    }
                  
                    
                }else{
                    
                    self.isList=1;
                    if (self.reciverUserId) {
                        [self getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:self.reciverUserId];
                        
                    }

                }
            } else{
                if (self.isList==1) {
                    
                    self.messageGroup=nil;
                    self.messageList=nil;
                    [self.chatTableView reloadData];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[self.messageGroup objectForKey:[self.messageList objectAtIndex:[[self.messageGroup allKeys] count] - 1]] count]-1 inSection:[[self.messageGroup allKeys] count] - 1];
                    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

                }

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


#pragma mark - SortMessageList

-(void)messageGropubyDate{
    
    NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
    
    self.messageGroup=[[[NSMutableDictionary alloc] init] autorelease];
    
    for (int i=0; i<self.messageList.count; i++) {
        
        if (i==0) {
            
            NSDate *datetime=[[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[self.messageList objectAtIndex:i] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime];
            NSString *key=[dateFormatter stringFromDate:datetime];
            NSMutableArray *arr=[[[NSMutableArray alloc] init] autorelease];
            [self.messageGroup setObject:arr forKey:key];
            [arr addObject:[self.messageList objectAtIndex:i]];
            
        }else{
            NSDate *datetime=[[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[self.messageList objectAtIndex:i] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime];
            NSString *key=[dateFormatter stringFromDate:datetime];
            if ([self.messageGroup objectForKey:key]) {
                
                [[self.messageGroup objectForKey:key] addObject:[self.messageList objectAtIndex:i]];
                
            }else{
                
                NSMutableArray *arr=[[[NSMutableArray alloc] init] autorelease];
                [self.messageGroup setObject:arr forKey:key];
                [arr addObject:[self.messageList objectAtIndex:i]];
            }

            
        }
        
    }
    
}

-(CGSize)messageSize:(NSString*)message {
    if (self.isiPad){
        return [message sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(550,9999) lineBreakMode:NSLineBreakByWordWrapping];
    }
    return [message sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(200,9999) lineBreakMode:NSLineBreakByWordWrapping];
}


#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==101) {
        if (buttonIndex==0) {
            [self calltoPlayer:nil];
            
        }else if (buttonIndex==1){
            
            [self mailtoPlayer:nil];
            
        }
        
    }
    
}

#pragma mark - Conversation To Player
-(IBAction)calltoPlayer:(UIButton*)sender{

    if (self.phoneNumber.length >0 && ![self.phoneNumber isEqualToString:@"0"]) {
        
        [self callNumber:self.phoneNumber];
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone numbers available – please contact team admin" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
    }
     /*   NSString *cleanNumber = [[[NSString stringWithFormat:@"%@",self.phoneNumber]componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet]]componentsJoinedByString:@""];
        //------use 'telprompt' instead 'tel' will show a alert before call and return to app after end call..
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",cleanNumber]]];*/
    
}



-(IBAction)mailtoPlayer:(UIButton*)sender{
    
    //[self sendMail:self.emailId :@""];
    
    NSString * recipient = self.emailId;
    NSArray *receiver=[NSArray arrayWithObject:recipient];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
        mail.mailComposeDelegate = self;
        [mail setToRecipients:receiver];
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else{}
    
    
}


#pragma mark - TableViewDelegate Datasourace
#pragma mark - UITableViewDatasourace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[self.messageGroup allKeys] count];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [[self.messageGroup objectForKey:[self.messageList objectAtIndex:section]] count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // CGSize textSize = [[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(194,9999) lineBreakMode: NSLineBreakByWordWrapping];
    
    float heightToAdd=0.0;
    if (self.isiPad)
    {
        CGSize textSize = [self messageSize:[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"]];
        
        
        if(textSize.height > 55)  //recvMsgLbl height is 55.0
        {
            
            heightToAdd = MAX(textSize.height,73.0f);  //recvrbgVw height is 73.0
            heightToAdd = heightToAdd + 20;
            
        }else{
            heightToAdd=textSize.height + 25;  //date lbl height + extra
        }
    }
    else{
        
        CGSize textSize = [self messageSize:[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"]];
        
        
        if(textSize.height > 45)    //recvMsgLbl height is 45.0
        {
            
            heightToAdd = MAX(textSize.height,61.0f);   //recvrbgVw height is 61.0
            heightToAdd=heightToAdd + 35;//30;
            
        }else{
            heightToAdd=textSize.height + 35;  //date lbl height + extra
        }
    }
    NSLog(@"cell height %f",heightToAdd);
    return heightToAdd;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ReciverCellIdentifier = @"ReciverCell";
    
    ReciverCell *cell = [tableView dequeueReusableCellWithIdentifier:ReciverCellIdentifier];
    
    if (cell==nil) {
        
        cell=[ReciverCell ReciverCustomCell];
        cell.recvrbgVw.layer.cornerRadius=12.0f;
        [cell.recvrbgVw.layer setMasksToBounds:YES];
        
    }
    
    CGFloat aHeight = [tableView rectForRowAtIndexPath:indexPath].size.height;
    NSLog(@"height %f",aHeight);
    CGSize textOriganlSize = [self messageSize:[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"]];
    
    
    NSLog(@"original size %f %f",textOriganlSize.width,textOriganlSize.height);
    CGSize textSize;
    
    // set Text HEIGHT
    
    if (self.isiPad) {
        textSize=textOriganlSize;
    }
    else{
        textSize=textOriganlSize;
    }
    
    // set Text WIDTH

    if (self.isiPad) {
        if (textSize.width < cell.recvDateLbl.frame.size.width){
            
            textSize=CGSizeMake(cell.recvDateLbl.frame.size.width + 10, textSize.height);
        }else{
            textSize=CGSizeMake(textSize.width, textSize.height);
        }
    }
    else{
        if (textSize.width < cell.recvDateLbl.frame.size.width){
            
            textSize=CGSizeMake(cell.recvDateLbl.frame.size.width + 10, textSize.height);
        }else{
            textSize=CGSizeMake(textSize.width, textSize.height);
        }
    }
    
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString: [[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]  valueForKey:@"sender"]]) {
    
        ////////   BLUE SENDER   ///////
        cell.nameLbl.hidden=YES;
        if (self.isiPad) {

            cell.recvMsgLbl.frame=CGRectMake(cell.frame.size.width +433 - textSize.width, (aHeight - textSize.height)/2, textSize.width, textSize.height);
            cell.recvDateLbl.frame = CGRectMake(cell.recvMsgLbl.frame.origin.x, cell.recvMsgLbl.frame.origin.y + cell.recvMsgLbl.frame.size.height + 3, textSize.width, cell.recvDateLbl.frame.size.height);

            NSLog(@"Cell width:%f Text width:%f",cell.frame.size.width,textSize.width);
            NSLog(@"messlbl frame %@",NSStringFromCGRect(cell.recvMsgLbl.frame));
            
            cell.recvrbgVw.frame=CGRectMake(cell.frame.size.width + 433 - textSize.width - 8, (aHeight - textSize.height)/2-2 ,textSize.width + 8,textSize.height + cell.recvDateLbl.frame.size.height + 6);
            
            cell.revArrowImage.frame=CGRectMake(738, (aHeight - 16)/2, cell.revArrowImage.frame.size.width, cell.revArrowImage.frame.size.height);
            
            
        }
        else{
            cell.recvMsgLbl.frame=CGRectMake(cell.frame.size.width - 15 - textSize.width, (aHeight - textSize.height)/2, textSize.width, textSize.height);
            cell.recvDateLbl.frame = CGRectMake(cell.recvMsgLbl.frame.origin.x, cell.recvMsgLbl.frame.origin.y + cell.recvMsgLbl.frame.size.height + 3, textSize.width, cell.recvDateLbl.frame.size.height);
            
            NSLog(@"messlbl frame %@",NSStringFromCGRect(cell.recvMsgLbl.frame));
            
            cell.recvrbgVw.frame=CGRectMake(cell.frame.size.width - 25 - textSize.width, (aHeight - textSize.height)/2 -3,textSize.width + 15,textSize.height + cell.recvDateLbl.frame.size.height + 10);
            
            cell.revArrowImage.frame=CGRectMake(304, (aHeight - 16)/2, cell.revArrowImage.frame.size.width, cell.revArrowImage.frame.size.height);
        }
        cell.recvMsgLbl.textColor=[UIColor whiteColor];
        cell.recvDateLbl.textColor = [UIColor whiteColor];
        
        cell.recvrbgVw.backgroundColor=[self colorWithHexString:@"3498DB"];
        cell.revArrowImage.image=[UIImage imageNamed:@"chat_sender_arrow.png"];
        
        cell.recvMsgLbl.text=[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"];
        
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime] ;
        
        cell.recvDateLbl.text = [self getDateTimeForHistoryWithoutDate:datetime ];
        
        
        cell.profileImageVw.hidden=YES;
        
        
        
    }else {
        
        ////////   WHITE RECEIVER   ///////
        cell.nameLbl.hidden=NO;
        cell.recvMsgLbl.textColor=[UIColor blackColor];
        cell.recvDateLbl.textColor=[UIColor blackColor];
        
        if (self.isiPad) {
            cell.recvMsgLbl.frame=CGRectMake(cell.recvMsgLbl.frame.origin.x + 6,(aHeight - textSize.height)/2, textSize.width, textSize.height);
            cell.recvDateLbl.frame = CGRectMake(cell.recvMsgLbl.frame.origin.x+3, cell.recvMsgLbl.frame.origin.y + cell.recvMsgLbl.frame.size.height + 3, textSize.width, cell.recvDateLbl.frame.size.height);

            cell.recvrbgVw.frame=CGRectMake(cell.recvrbgVw.frame.origin.x, (aHeight - textSize.height)/2-2,textSize.width+3, textSize.height + cell.recvDateLbl.frame.size.height + 7);
            cell.recvrbgVw.backgroundColor=appDelegate.backGroundUnreadGray;
            cell.revArrowImage.frame=CGRectMake(cell.revArrowImage.frame.origin.x, (aHeight - 16)/2, cell.revArrowImage.frame.size.width, cell.revArrowImage.frame.size.height);
            
        }
        else{
            cell.recvMsgLbl.frame=CGRectMake(cell.recvMsgLbl.frame.origin.x + 8,(aHeight - textSize.height)/2, textSize.width , textSize.height);
            cell.recvDateLbl.frame = CGRectMake(cell.recvMsgLbl.frame.origin.x, cell.recvMsgLbl.frame.origin.y + cell.recvMsgLbl.frame.size.height + 3, textSize.width, cell.recvDateLbl.frame.size.height);

            cell.recvrbgVw.backgroundColor=appDelegate.backGroundUnreadGray;
        
            cell.recvrbgVw.frame=CGRectMake(cell.recvrbgVw.frame.origin.x, (aHeight - textSize.height)/2 -5,textSize.width+15, textSize.height + cell.recvDateLbl.frame.size.height + 10);
            
            cell.revArrowImage.frame=CGRectMake(cell.revArrowImage.frame.origin.x, (aHeight - 16)/2, cell.revArrowImage.frame.size.width, cell.revArrowImage.frame.size.height);
        }
        
        cell.revArrowImage.image=[UIImage imageNamed:@"chat_reciver_arrow.png"];
        
        cell.recvMsgLbl.text=[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"message"];
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime] ;
        
        cell.recvDateLbl.text = [self getDateTimeForHistoryWithoutDate:datetime ];
        cell.nameLbl.text=[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"sender_name"];
        
        cell.profileImageVw.frame=CGRectMake(cell.profileImageVw.frame.origin.x,(aHeight - cell.profileImageVw.frame.size.width)/2, cell.profileImageVw.frame.size.width, cell.profileImageVw.frame.size.height);
        
        if (self.isiPad) {
            cell.nameLbl.frame=CGRectMake(cell.nameLbl.frame.origin.x, CGRectGetMaxY(cell.profileImageVw.frame), cell.nameLbl.frame.size.width, cell.nameLbl.frame.size.height);
        }
        
        cell.profileImageVw.hidden=NO;
        if (![[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"] isEqualToString:@""]) {
            
            [cell.profileImageVw setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.messageGroup objectForKey:[self.messageList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]]] placeholderImage:self.noImage];
            
            [cell.profileImageVw applyPhotoFrame];
            
        }else{
            cell.profileImageVw.image=self.noImage;
            [cell.profileImageVw cleanPhotoFrame];
        }
        
        
        
    }
    return cell;
   
    
}

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark - TextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
-(void) textViewDidChange:(UITextView *)textView{
    
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
    }else if(textView==self.chatTextView){
        
        if (textView.text.length<144) {
            return YES;
        }else{
            return  NO;
        }
    }
    
    return YES;
}

-(NSString *)getDateTimeForHistoryWithoutDate:(NSDate *)cdate
{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:ctimezone];
    
    [formatter setDateFormat:@"dd MMM"];
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc] init];
    
    [formatter1 setTimeZone:ctimezone];
    
    [formatter1 setDateFormat:@"hh:mm a"];
    
    NSString *s=[[NSString alloc] initWithFormat:@"%@ %@",[formatter stringFromDate:cdate],[formatter1 stringFromDate:cdate]];
    
    [calender setTimeZone:ctimezone];
    /*NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
     NSInteger todayDayNum = [weekdayComponents weekday];
     
     NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];*/
    
    
    
    NSString *str=s;
    
    
    
    return str;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView   //.......june
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //_toolBar.frame = CGRectMake(_toolBar.frame.origin.x, (_toolBar.frame.origin.y - 220.0), _toolBar.frame.size.width, _toolBar.frame.size.height);
    
   // _adBanner.frame = CGRectMake(_adBanner.frame.origin.x, (_adBanner.frame.origin.y - 220.0), _adBanner.frame.size.width, _adBanner.frame.size.height);
    
   // _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, (_chatTableView.frame.origin.y ), _chatTableView.frame.size.width, _chatTableView.frame.size.height-220);
    
    //    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, (_bottomView.frame.origin.y - 250.0), _bottomView.frame.size.width, _bottomView.frame.size.height);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView           //........june
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //_toolBar.frame = CGRectMake(_toolBar.frame.origin.x, (_toolBar.frame.origin.y + 220.0), _toolBar.frame.size.width, _toolBar.frame.size.height);
    
    
   // _adBanner.frame = CGRectMake(_adBanner.frame.origin.x, (_adBanner.frame.origin.y + 220.0), _adBanner.frame.size.width, _adBanner.frame.size.height);
    
    
    //_chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, (_chatTableView.frame.origin.y ), _chatTableView.frame.size.width, _chatTableView.frame.size.height+220);
    
    //    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, (_bottomView.frame.origin.y + 250.0), _bottomView.frame.size.width, _bottomView.frame.size.height);
    [UIView commitAnimations];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField                  //.......june
{
    [textField resignFirstResponder];
    
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
    
    CGFloat newChatTableHeight = _toolBar.frame.origin.y - _chatTableView.frame.origin.y;
    _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, _chatTableView.frame.origin.y, _chatTableView.frame.size.width, newChatTableHeight);
    
//    NSIndexPath* ipath = [NSIndexPath indexPathForRow:[[self.messageGroup objectForKey:[self.messageList objectAtIndex:0]] count] inSection: 0];  // last IndexPath.row
//    [_chatTableView scrollToRowAtIndexPath:ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
    
    [UIView commitAnimations];
}



#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
    
    _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, (_chatTableView.frame.origin.y ), _chatTableView.frame.size.width, _chatTableView.frame.size.height-50);
    
    isBannerLoaded=YES;
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
    
    if(isBannerLoaded==NO){
        
        _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, (_chatTableView.frame.origin.y ), _chatTableView.frame.size.width, _chatTableView.frame.size.height-50);
        
        isBannerLoaded=YES;
        
    }
    
    
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    //self.pauseTimeCounting = YES;
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
    //self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
    
    if(isBannerLoaded==YES){
        
        _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, (_chatTableView.frame.origin.y ), _chatTableView.frame.size.width, _chatTableView.frame.size.height+50);
        
        isBannerLoaded=NO;
        
    }
    
}



@end
