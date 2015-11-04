//
//  AddAdminViewController.m
//  Wall
//
//  Created by Sukhamoy on 12/04/14.
//
//

#import "AddAdminViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface AddAdminViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

int mode;
int pickerSelect;
@implementation AddAdminViewController
@synthesize pickerArrType;
@synthesize isBack;
@synthesize dictMemberAdmin;

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
    self.isBack=NO;
    [self setStatusBarStyleOwnApp:0];
    @autoreleasepool
    {
        if(self.appDelegate.alreadyRegisteredMember == YES)
        {
            [self.addMinNameText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.lastName setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.addMinEmailText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.addMinPhoneText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.adminTypeText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        }
        else
        {
            [self.addMinNameText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.lastName setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.addMinEmailText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.addMinPhoneText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            [self.adminTypeText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            
            self.addMinNameText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
            self.lastName.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
            self.addMinEmailText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
            self.addMinPhoneText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
            self.adminTypeText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
            
        }
        
        
        
    }
    self.firstEmail=nil;
    mode=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullNameLoaded:) name:GETFULLNAME object:nil];
    
    self.pickerArrType=[NSArray arrayWithObjects:@"Manager",@"Team Parent",@"Assistant",@"Admin",nil];
    if (!self.isAddAdmin) {
        
        [self.addminBtn setTitle:@"Update Admin" forState:UIControlStateNormal];
        
        if (self.selectedAddmin==0)
        {
            
            
            if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:@""])
            {
                self.addMinNameText.userInteractionEnabled=NO;
                self.lastName.userInteractionEnabled=NO;
                self.addMinEmailText.userInteractionEnabled=NO;
                //self.adminTypeText.userInteractionEnabled=NO;
                
                
                /////// Rakesh 10/07/15
                if(self.appDelegate.alreadyRegisteredMember == YES)
                {
                    self.addMinNameText.userInteractionEnabled=NO;
                    self.lastName.userInteractionEnabled=NO;
                    self.addMinEmailText.userInteractionEnabled=NO;
                    self.addMinPhoneText.userInteractionEnabled  = NO;
                }
                //////
            }
            else
            {
                self.addMinNameText.userInteractionEnabled=YES;
                self.lastName.userInteractionEnabled=YES;
                self.addMinEmailText.userInteractionEnabled=YES;
                //self.adminTypeText.userInteractionEnabled=YES;
                
                
                /////// Rakesh 10/07/15
                if(self.appDelegate.alreadyRegisteredMember == YES)
                {
                    self.addMinNameText.userInteractionEnabled=NO;
                    self.lastName.userInteractionEnabled=NO;
                    self.addMinEmailText.userInteractionEnabled=NO;
                    self.addMinPhoneText.userInteractionEnabled  = NO;
                }
                
                ////
            }
            self.addMinNameText.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] componentsSeparatedByString:@" "] objectAtIndex:0];
            
            if ([[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] componentsSeparatedByString:@" "] count]>1) {
                
                self.lastName.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] componentsSeparatedByString:@" "] objectAtIndex:1];
            }else{
                self.lastName.text=@"";
            }
            self.addMinEmailText.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"];
            
            
            
            self.addMinPhoneText.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"];
            self.adminTypeText.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type"];
           // [self.adminTypeText.text capitalizedString];
            
        }else{
            
            if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:@""])
            {
                self.addMinNameText.userInteractionEnabled=NO;
                self.lastName.userInteractionEnabled=NO;
                self.addMinEmailText.userInteractionEnabled=NO;
                //self.adminTypeText.userInteractionEnabled=NO;
                
                
                /////// Rakesh 10/07/15
                if(self.appDelegate.alreadyRegisteredMember == YES)
                {
                    self.addMinNameText.userInteractionEnabled=NO;
                    self.lastName.userInteractionEnabled=NO;
                    self.addMinEmailText.userInteractionEnabled=NO;
                    self.addMinPhoneText.userInteractionEnabled  = NO;
                }
                //////
            }
            else
            {
                self.addMinNameText.userInteractionEnabled=YES;
                self.lastName.userInteractionEnabled=YES;
                self.addMinEmailText.userInteractionEnabled=YES;
                //self.adminTypeText.userInteractionEnabled=YES;
                
                /////// Rakesh 10/07/15
                if(self.appDelegate.alreadyRegisteredMember == YES)
                {
                    self.addMinNameText.userInteractionEnabled=NO;
                    self.lastName.userInteractionEnabled=NO;
                    self.addMinEmailText.userInteractionEnabled=NO;
                    self.addMinPhoneText.userInteractionEnabled  = NO;
                }
                //////
            }

            
            self.addMinNameText.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] componentsSeparatedByString:@" "] objectAtIndex:0];
            
            if ([[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] componentsSeparatedByString:@" "] count]>1) {
                
                self.lastName.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] componentsSeparatedByString:@" "] objectAtIndex:1];
            }else{
                self.lastName.text=@"";
            }
            self.addMinEmailText.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email2"];
            self.addMinPhoneText.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"];
            NSString *str=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type2"];
            
            self.adminTypeText.text=[str capitalizedString];
            //[self.adminTypeText.text uppercaseString];
            
        }
        
        
        
        self.firstEmail=self.addMinEmailText.text;
        
    }else
    {
        [self.addminBtn setTitle:@"Add Admin" forState:UIControlStateNormal];
        self.addMinNameText.userInteractionEnabled=YES;
        self.lastName.userInteractionEnabled=YES;
        self.addMinEmailText.userInteractionEnabled=YES;
        //self.adminTypeText.userInteractionEnabled=YES;
        
        
        ///// Rakesh 10/07/15
        
        if(self.appDelegate.alreadyRegisteredMember == YES)
        {
            self.addMinNameText.userInteractionEnabled=NO;
            self.lastName.userInteractionEnabled=NO;
            self.addMinEmailText.userInteractionEnabled=NO;
            self.addMinPhoneText.userInteractionEnabled  = NO;
        }
        
        //////
        
        if (self.dictMemberAdmin)
        {
            self.addMinNameText.text=[self.dictMemberAdmin valueForKey:@"FirstName"];
            self.lastName.text=[self.dictMemberAdmin valueForKey:@"LastName"];
            self.addMinEmailText.text=[self.dictMemberAdmin valueForKey:@"Email"];
            self.addMinPhoneText.text=[self.dictMemberAdmin valueForKey:@"ContactNo"];
        }
        
    }
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETFULLNAME object:nil];
}

#pragma mark -ClassMethod


#pragma mark - GETUSERFROM MAIL

-(void)getFullName:(NSString*)email
{
    self.addMinNameText.placeholder=@"Checking if the user already exists";
    self.lastName.placeholder=@"Checking if the user already exists";
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command1=[[NSMutableDictionary alloc] init];
    [command1 setObject:email forKey:@"Email"];
    NSString *jsonCommand = [writer stringWithObject:command1];
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:GETFULLNAMELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    sinReq.notificationName=GETFULLNAME;
    [sinReq startRequest];
}


-(void)fullNameLoaded:(id)sender
{
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
    NSLog(@"%@",sReq.responseString);
    
    if([sReq.notificationName isEqualToString:GETFULLNAME])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        self.addMinNameText.text=[aDict valueForKey:@"FirstName"];
                        self.lastName.text=[aDict valueForKey:@"LastName"];
                     
                        
                    }else
                    {
                        self.addMinEmailText.userInteractionEnabled=YES;
                        self.addMinNameText.userInteractionEnabled=YES;
                        self.lastName.userInteractionEnabled=YES;
                        self.addMinNameText.text=@"";
                        self.lastName.text=@"";
                        self.addMinNameText.placeholder=@"First Name";
                        self.lastName.placeholder=@"Last Name";
                    }
                }
            }
        }
    }
    
}


- (IBAction)contactList:(id)sender {
    
    [self ShowContactList:sender];
}

- (IBAction)back:(id)sender {
    self.isBack=YES;
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAdminToTeam:(id)sender {
    
    
    NSString* tmp=nil;
    NSString *errorstr=@"";
    
    tmp=[[self.addMinNameText text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([tmp  isEqualToString:@""] )
    {
        
        if(errorstr.length==0)
            errorstr=@"Please choose Admin Type";
        
    }
    
    tmp=[[self.addMinEmailText text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
            if (![tmp isEqualToString:@""])
            {
                if(![self validEmail:tmp])
                {
    
                    if(errorstr.length==0)
                        errorstr=@"The Email Id is invalid.";
                }

            }
            else
            {
    
                if(errorstr.length==0)
                    errorstr=@"One or more fields are missing.";
            
            }
    tmp=[[self.adminTypeText text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([tmp  isEqualToString:@""] )
    {
        
        if(errorstr.length==0)
            errorstr=@"Please choose Admin Type";
        
    }
    
        if([errorstr length]>INITIALERRORSTRINGLENGTH)
        {
        
            [self showAlertMessage:errorstr title:@""];
            return;
        }

    
   // NSString *combineCheckStr=[[NSString alloc] initWithFormat:@"%@%@",@"UPDATEADMIN",[appDelegate.aDef objectForKey:LoggedUserID]];
    
    
    if( self.isAddAdmin/*self.firstEmail && (![self.firstEmail isEqualToString:tmp])*/)
    {
       self.viewAlert.hidden=NO;   ///////    22/7/14
       
       self.viewAlertBack.hidden=NO;
    }
    else
    {
        [self doneAlert:nil];
    }
    
    /*if([appDelegate.aDef objectForKey:combineCheckStr])
    {
        [self doneAlert:nil];
    }
    else
    {
    self.viewAlert.hidden=NO;   ///////    22/7/14
    //[self.view bringSubviewToFront:self.viewAlert];
    self.viewAlertBack.hidden=NO;
        
        [appDelegate setUserDefaultValue:@"1" ForKey:combineCheckStr];
    }*/
   /*    ///////    22/7/14    ///////
    
    
    
    

    
    
    
    NSMutableDictionary *cludDict=[NSMutableDictionary dictionary];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
    [command setObject:@"N" forKey:@"delete_logo"];
    
    
    
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_name"] forKey:@"team_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_sport"] forKey:@"team_sport"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_id"] forKey:@"club_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_id"] forKey:@"league_id"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_zipcode"] forKey:@"team_zipcode"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"field_name"] forKey:@"field_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] forKey:@"age_group"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_gender"] forKey:@"team_gender"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] forKey:@"uniform_color"];
    [command setObject:[self.appDelegate.dateFormatM stringFromDate:[NSDate date]] forKey:@"adddate"];
    self.requestDic=command;
    
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_name"] forKey:@"club"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_name"] forKey:@"league"];
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_url"] forKey:@"club_url"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_url"] forKey:@"league_url"];
    
    //ADDMIN One Info
    
    if (self.selectedAddmin==0)
    {
        
        [command setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name"];
        [command setObject:self.addMinEmailText.text forKey:@"creator_email"];
        [command setObject:self.addMinPhoneText.text forKey:@"creator_phno"];

    }
    else
    {
        
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] forKey:@"creator_name"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"] forKey:@"creator_email"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"] forKey:@"creator_phno"];
        
        
    }
    
    
    if (self.selectedAddmin==1)
    {
        
        [command setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name2"];
        [command setObject:self.addMinEmailText.text forKey:@"creator_email2"];
        [command setObject:self.addMinPhoneText.text forKey:@"creator_phno2"];

    }
    else
    {
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] forKey:@"creator_name2"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email2"] forKey:@"creator_email2"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"] forKey:@"creator_phno2"];

         }
    
    //ADDMIN  Two Info
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    NSString *jsonClub=[writer stringWithObject:cludDict];
    
        
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];

      [appDelegate sendRequestFor:EDIT_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1", nil]];
    */
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1{
    
    [self hideHudView];
    [self hideNativeHudView];
    NSString *str=(NSString*)aData;
    NSLog(@"JSONData=%@",str);
    
    
    
    
    if (mode==0){
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            NSString *message=[aDict objectForKey:@"message"];
            NSLog(@"%@",message);
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"]){
                
                
                if (self.selectedAddmin==0) {
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:self.addMinEmailText.text forKey:@"creator_email"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:self.addMinPhoneText.text forKey:@"creator_phno"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.adminTypeText.text lowercaseString] forKey:@"type"];
                }
              
                if (self.selectedAddmin==1) {
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:self.addMinEmailText.text forKey:@"creator_email2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:self.addMinPhoneText.text forKey:@"creator_phno2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.adminTypeText.text lowercaseString] forKey:@"type2"];
                }
              
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
    
}


#pragma mark - TExtFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==self.addMinPhoneText) {
        if (self.isiPhone5)
        {
            
        }
        else
        {
            CGRect frame1=self.view.frame;
            frame1.origin.y=-40;
            self.view.frame=frame1;
        }

    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.addMinNameText || textField==self.lastName) {
        if (self.addMinEmailText.text.length==0) {
            // self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your Email id" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            //[cell.addMinEmailText becomeFirstResponder];
        }
        else if ([self validEmail:self.addMinEmailText.text]) {
            if (self.addMinNameText.text.length==0) {
                [self getFullName:textField.text];
            }
            
            
        }
        else{
            //self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    
    if (textField==self.adminTypeText) {
        self.viewPickerContainer.hidden=NO;
        return NO;
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.addMinEmailText) {
        
        if ([self validEmail:textField.text]) {
            
            [self getFullName:textField.text];
            
        }else{
            if (self.isBack==NO) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
            
                [textField becomeFirstResponder];
            }
            
        }
 
    }
   
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==self.addMinPhoneText) {
        if (self.isiPhone5)
        {
            
        }
        else
        {
            CGRect frame1=self.view.frame;
            frame1.origin.y=0;
            self.view.frame=frame1;
        }
        
    }

    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    int tag=[theTextField tag];
    
    if (tag==1002 ) {
        
        if (theTextField.text.length<=15) {
            
            NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:VALIDPHONENUMBER] invertedSet];
            NSString *filterString=[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            return [string isEqualToString:filterString];
            
        }else{
            return NO;
        }

    }
    
    
    if (theTextField==self.addMinNameText || theTextField==self.lastName ) {
        
        if (theTextField.text.length<=15) {
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
            {
                return YES;
            }  else  {
                return NO;
            }
            
        }else{
            return NO;
        }
        
    }

    
    return YES;
    
    
}

#pragma mark - ShowContactList
-(IBAction)ShowContactList:(UIButton*)sender{
    
    ABPeoplePickerNavigationController* contactPicker = [[ABPeoplePickerNavigationController alloc] init];
    contactPicker.peoplePickerDelegate = self;
    
    [self presentViewController:contactPicker animated:YES completion:^{
        
    }];
    
    
}

- (void)displayPerson:(ABRecordRef)person{
    
    NSString *name=nil;
    NSString* fName = (__bridge  NSString*)ABRecordCopyValue(person,
                                                    kABPersonFirstNameProperty);
    NSString* mName = (__bridge  NSString*)ABRecordCopyValue(person,
                                                    kABPersonMiddleNameProperty);
    NSString* lName = (__bridge  NSString*)ABRecordCopyValue(person,
                                                    
                                                    kABPersonLastNameProperty);
    if (fName) {
        
        name=[NSString stringWithFormat:@"%@",fName];
        
    }
    
    if (mName){
        
        name=[NSString stringWithFormat:@"%@%@",name,mName];
        
    }
    
    
  
    
    
    NSString* email = nil;
    ABMultiValueRef emailId = ABRecordCopyValue(person,
                                                kABPersonEmailProperty);
    
    
    
    if (ABMultiValueGetCount(emailId) > 0) {
        email = (__bridge  NSString*)
        ABMultiValueCopyValueAtIndex(emailId, 0);
        
        //        if(email)
        //            CFRelease(email);
    } else {
        email =@"";
    }
    
    
  //  CFRelease(emailId);
    
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge  NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        
        //        if(phone)
        //            CFRelease(phone);
    } else {
        phone = @"";
    }
    
    
    //CFRelease(phoneNumbers);
    
    
   
        
        if (name) {
            
            self.addMinNameText.text=name;
        }else{
             self.addMinNameText.text=@"";
        }
    
        if (email) {
            
            self.addMinEmailText.text=email;
            
        }else{
            self.addMinEmailText.text=@"";
        }
    
        if (phone) {
            
            self.addMinPhoneText.text=phone;
        }else{
            
            self.addMinPhoneText.text=@"";
            
        }
        
        if (lName) {
            
            self.lastName.text=lName;
        }else{
            
            self.lastName.text=@"";
            
        }

//    CFRelease(emailId);
//    CFRelease(phoneNumbers);
}


#pragma  mark - ABpeoplepickerDelegate
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.appDelegate setHomeView];
    }];
}

// iOS 8

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier

{
    
    // [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
    
    [self displayPerson:person];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

// iOS 7
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.appDelegate setHomeView];
    }];
    
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
}



- (IBAction)doneAlert:(id)sender {   ///////    22/7/14   /////////
    
    self.viewAlert.hidden=YES;
    self.viewAlertBack.hidden=YES;
    NSMutableDictionary *cludDict=[NSMutableDictionary dictionary];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
    [command setObject:@"N" forKey:@"delete_logo"];
    
    
    
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_name"] forKey:@"team_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_sport"] forKey:@"team_sport"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_id"] forKey:@"club_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_id"] forKey:@"league_id"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_zipcode"] forKey:@"team_zipcode"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"field_name"] forKey:@"field_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] forKey:@"age_group"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_gender"] forKey:@"team_gender"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] forKey:@"uniform_color"];
    [command setObject:[self.appDelegate.dateFormatM stringFromDate:[NSDate date]] forKey:@"adddate"];
    self.requestDic=command;
    
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_name"] forKey:@"club"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_name"] forKey:@"league"];
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_url"] forKey:@"club_url"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_url"] forKey:@"league_url"];
    
    //ADDMIN One Info
    
    if (self.selectedAddmin==0)
    {
        
        [command setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name"];
        [command setObject:self.addMinEmailText.text forKey:@"creator_email"];
        [command setObject:self.addMinPhoneText.text forKey:@"creator_phno"];
        [command setObject:[self.adminTypeText.text lowercaseString] forKey:@"type"];
        
    }
    else
    {
        
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] forKey:@"creator_name"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"] forKey:@"creator_email"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"] forKey:@"creator_phno"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type"] forKey:@"type"];
        
    }
    
    
    if (self.selectedAddmin==1)
    {
        
        [command setObject:[NSString stringWithFormat:@"%@ %@",self.addMinNameText.text,self.lastName.text] forKey:@"creator_name2"];
        [command setObject:self.addMinEmailText.text forKey:@"creator_email2"];
        [command setObject:self.addMinPhoneText.text forKey:@"creator_phno2"];
        [command setObject:[self.adminTypeText.text lowercaseString] forKey:@"type2"];
        
    }
    else
    {
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] forKey:@"creator_name2"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email2"] forKey:@"creator_email2"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"] forKey:@"creator_phno2"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type2"] forKey:@"type2"];
    }
    
    //ADDMIN  Two Info
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    NSString *jsonClub=[writer stringWithObject:cludDict];
    
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    [appDelegate sendRequestFor:EDIT_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1", nil]];
    
    
    
}

- (IBAction)cancelAlert:(id)sender {      ///////    22/7/14   /////////
    
    self.viewAlert.hidden=YES;
    self.viewAlertBack.hidden=YES;
}


#pragma mark - PickerDelegate

/*-(IBAction)HidePicker:(UIBarButtonItem*)sender
{
    self.pickerContainer.hidden=YES;
}*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerSelect=row;
    
//    self.adminTypeText.text=[self.pickerArrType objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return self.pickerArrType.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
 
    return [self.pickerArrType objectAtIndex:row];
}

/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
        
    if(pickerSelectTag==1)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [label release];
            [flagView release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:[self.sportsImageArr objectAtIndex:row]];
        return view;
    }
}*/


- (IBAction)donePicker:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
        
        self.adminTypeText.text=[self.pickerArrType objectAtIndex:pickerSelect];
    }
    self.viewPickerContainer.hidden=YES;
    
    
}
@end
