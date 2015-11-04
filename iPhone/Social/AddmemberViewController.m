//
//  AddmemberViewController.m
//  Wall
//
//  Created by Mindpace on 30/06/15.
//
//

#import "AddmemberViewController.h"
#import "AddmemberCell.h"
#import "SingleRequest.h"
#import "TeamMaintenanceVC.h"

@interface AddmemberViewController ()
{
    NSArray *mainArray,*srchResults,*mainArray2;
    AddmemberCell *cell;
}

@end

@implementation AddmemberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchAllRegisteredUsers:) name:ALLREGISTEREDUSERS object:nil];
    
    
    //[self showAllSporstlyUsers];
    self.allRegUserArr = self.appDelegate.JSONDATAMemberarr;
    
    srchResults = [[NSArray alloc]init];
    self.selectedMemberDetailsDict = [[NSMutableDictionary alloc] init];
    
    self.tablvw.tableFooterView = [[UIView alloc] init];
    
    /////// Rakesh 13/07/15
    UITextField *txtSearchField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
    [txtSearchField becomeFirstResponder];
    [txtSearchField setTextColor:[UIColor lightGrayColor]];
    ////////
    //////// Rakesh 13/07/15
    
    /*[self.searchDisplayController.searchBar setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UITextField *searchTextField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
    UILabel *placeholderLabel = [searchTextField valueForKey:@"_placeholderLabel"];
    [placeholderLabel setTextAlignment:NSTextAlignmentLeft];*/
    
    //////
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALLREGISTEREDUSERS object:nil];
}


#pragma mark - All Users from Contacts

- (void)importUsersFromContacts
{
    CFErrorRef *error = nil;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL)
    { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else
    { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted)
    {
        
#ifdef DEBUG
        NSLog(@"Fetching contact info ----> ");
#endif
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        
        NSMutableArray *arrFriend = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < nPeople; i++)
        {
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name and Last Name
            
            NSString *firstName = @"";
            if (ABRecordCopyValue(person, kABPersonFirstNameProperty))
            {
                firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            }
            
            NSString *lastName  =  @"";
            if (ABRecordCopyValue(person, kABPersonFirstNameProperty))
            {
                lastName  =  (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            }
            else
            {
                continue;
            }
            
            NSString *fullName = @"";
            
            if(!firstName && !lastName)
            {
                continue;
            }
            
            if(!firstName && lastName)
            {
                fullName = lastName;
            }
            if(firstName && !lastName)
            {
                fullName = firstName;
            }
            if (firstName && lastName)
            {
                fullName = [firstName stringByAppendingFormat:@" %@",lastName];
            }
            
            
            // get contacts picture, if pic doesn't exists, show standard one
            
            NSData *imageData = (__bridge NSData *)ABPersonCopyImageData(person);
            UIImage *image  = [UIImage imageWithData:imageData];
            if (!image)
            {
                image = [UIImage imageNamed:@"profile_image.png"];
            }
            
            //get Contact email
            
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            CFIndex emailCount = ABMultiValueGetCount(multiEmails);
            if(emailCount == 0)
            {
                [contactEmails addObject:@""];
            }
            
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++)
            {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                NSString *contactEmail = (__bridge NSString *)contactEmailRef;
                
                if(contactEmail.length > 0 && [self NSStringIsValidEmail:contactEmail])
                {
                    [contactEmails addObject:contactEmail];
                }
                else
                {
                    continue;
                }
            }
            
            //get Contact phone
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            CFIndex phoneNumCount = ABMultiValueGetCount(multiPhones);
            if(phoneNumCount == 0)
            {
                [phoneNumbers addObject:@"0"];
            }
            
            for(CFIndex i=0; i<ABMultiValueGetCount(multiPhones); i++)
            {
                
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
                
                if(phoneNumber.length > 0)
                {
                    [phoneNumbers addObject:phoneNumber];
                }
                else
                {
                    continue;
                }
            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            
            
            [dict setObject:image forKey:@"ProfileImage"];
            
            NSArray *fullNameSeparator = [fullName componentsSeparatedByString:@" "];
            if (fullNameSeparator.count>0) {
                [dict setObject:[fullNameSeparator objectAtIndex:0] forKey:@"FirstName"];
                [dict setObject:@"" forKey:@"LastName"];
            }
            if (fullNameSeparator.count>1) {
                [dict setObject:[fullNameSeparator objectAtIndex:1] forKey:@"LastName"];
            }
            if (fullNameSeparator.count==0) {
                [dict setObject:@"" forKey:@"FirstName"];
                [dict setObject:@"" forKey:@"LastName"];
            }
            //[dict setObject:fullName forKey:@"name"];
            [dict setObject:@"" forKey:@"UserID"];
            [dict setObject:@"" forKey:@"FacebookID"];
            [dict setObject:@"PhoneContacts" forKey:@"type"];
            
            
            /*if(ABMultiValueGetCount(multiEmails) > 0)
            {
                [dict setObject:contactEmails forKey:@"Email"];
            }
            if(ABMultiValueGetCount(multiPhones) > 0)
            {
                [dict setObject:phoneNumbers forKey:@"ContactNo"];
            }*/
            
            [dict setObject:contactEmails forKey:@"Email"];
            [dict setObject:phoneNumbers forKey:@"ContactNo"];
            
            [self.allRegUserArr addObject:dict];
            
        }
        
        NSSortDescriptor *sortNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"FirstName" ascending:YES selector:@selector(compare:)];
        [self.allRegUserArr sortUsingDescriptors:[NSArray arrayWithObjects:sortNameDescriptor,nil]];
        
        
        NSLog(@"My Sorted contact list :: %@",self.allRegUserArr);
        
        [self.tablvw reloadData];
        
        
        /////// Rakesh 13/07/15
        UITextField *txtSearchField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
        [txtSearchField becomeFirstResponder];
        [txtSearchField setTextColor:[UIColor lightGrayColor]];
        ////////
        
        /*self.contactDict = [arrFriend objectAtIndex:0];
        NSLog(@"My contact dictionary :: %@",self.contactDict);
        
        [self.allRegUserArr addObject:self.contactDict];*/
        
    }
}

- (BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL) NSStringIsValidPhone: (NSString *)checkString
{
    NSString *phoneRegex2 = @"^(\\([0-9]{3})\\) [0-9]{3}-[0-9]{4}$";
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
    
    return [phoneTest2 evaluateWithObject:checkString];
}

#pragma mark - Fetch All Registered Users of Sporstly

- (void)showAllSporstlyUsers
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command1 = [[NSMutableDictionary alloc] init];
    [command1 setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    NSString *jsonCommand = [writer stringWithObject:command1];
    
    
    SingleRequest *sinReq = [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ALLREGISTEREDUSERLISTLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4 = sinReq;
    sinReq.notificationName = ALLREGISTEREDUSERS;
    [sinReq startRequest];
}

- (void)fetchAllRegisteredUsers:(id)sender
{
    SingleRequest *sReq = (SingleRequest *)[sender object];
    
    NSLog(@"ALL REGISTERED USER LISTING :: %@",sReq.responseString);
    
    if([sReq.notificationName isEqualToString:ALLREGISTEREDUSERS])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSArray class]])
                {
                    self.allRegUserArr = [(NSMutableArray *) res mutableCopy];
                    [self importUsersFromContacts];
                    
                }
            }
        }
    }
}

//// facebook sdk change 8th july
/*
#pragma mark - Facebook Users

- (void)importUsersFromFacebook
{
    if (![[FBSession activeSession] isOpen])
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] openSessionWithAllowLoginUI:YES];
    }
    else
    {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"id,name,picture,email",@"fields",nil];
        
        [FBRequestConnection startWithGraphPath:@"me/friends"
                                     parameters:params
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  
                                  //[MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                                  if(error == nil)
                                  {
                                      FBGraphObject *jsonResponseDict = (FBGraphObject *)result;
                                      NSLog(@"All Friends: %@",[jsonResponseDict objectForKey:@"data"]);
                                      
                                      self.fbUserArr = [[NSMutableArray alloc] init];
                                      
                                      for (int i=0; i<[[jsonResponseDict objectForKey:@"data"] count]; i++)
                                      {
                                          NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                                          if ([[[[[jsonResponseDict valueForKey:@"data"] objectAtIndex:i] valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"])
                                          {
                                              [dict setObject:[[[[[jsonResponseDict valueForKey:@"data"] objectAtIndex:i] valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:@"imgUrl"];
                                          }
                                          [dict setObject:[[[jsonResponseDict valueForKey:@"data"] objectAtIndex:i] valueForKey:@"name"] forKey:@"name"];
                                          [dict setObject:[[[jsonResponseDict valueForKey:@"data"] objectAtIndex:i] valueForKey:@"id"] forKey:@"id"];
                                          [dict setObject:@"" forKey:@"email"];
                                          
                                          [self.fbUserArr addObject:dict];
                                      }
                                      
                                  }
                              }];
        
        
    }
}*/

#pragma mark - UISearchDisplayController Delegate Methods

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope   //pradip.....june
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(Self.FirstName contains[c] %@) OR (Self.LastName contains[c] %@)", searchText,searchText];
    self.nonMemberEmailId = searchText;
    srchResults = [self.allRegUserArr filteredArrayUsingPredicate:resultPredicate];
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString      //search......june
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    [self.tablvw reloadData];
    return YES;
}


//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    if ([srchResults count] == 0) {
//        
//        for (UILabel *label in self.searchDisplayController.searchResultsTableView.subviews) {
//            if ([label.text isEqualToString: @"No Results"]) {
//                label.text = @"";
//            }
//        }
//    }
//}


#pragma mark- tablevwDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)     //search...........june
    {
         if(srchResults.count > 0)
         {
             return [srchResults count];
         }
        else
        {
            return 1;
        }
    }
    else
    {
        return [self.allRegUserArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell = (AddmemberCell *)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
        
        if (cell==nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddmemberCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        if(srchResults.count > 0)
        {
            NSArray *allEmails = [[srchResults objectAtIndex:indexPath.row] objectForKey:@"Email"];
            NSArray *allPhoneNumbers = [[srchResults objectAtIndex:indexPath.row] objectForKey:@"ContactNo"];
            
            NSString *emailStr = nil;
            if (allEmails.count==0) {
                emailStr = @"";
            }
            else if([[allEmails objectAtIndex:0] isEqualToString:@""])
            {
                emailStr = @"";
            }
            else
            {
                emailStr = [allEmails componentsJoinedByString:@", "];
            }
            
            NSString *phoneStr = nil;
            if (allPhoneNumbers.count==0) {
                phoneStr = @"";
            }
            else if([[allPhoneNumbers objectAtIndex:0] isEqualToString:@"0"])
            {
                phoneStr = @"";
            }
            else
            {
                phoneStr = [allPhoneNumbers componentsJoinedByString:@", "];
            }
            
            
            cell.namelbl.text = [NSString stringWithFormat:@"%@ %@",[[srchResults objectAtIndex:indexPath.row] objectForKey:@"FirstName"],[[srchResults objectAtIndex:indexPath.row] objectForKey:@"LastName"]];
            
            //NSInteger i = [self.allRegUserArr indexOfObject:cell.namelbl.text];
            
            if(![phoneStr isEqualToString:@""])
            {
                if([emailStr isEqualToString:@""])
                {
                    cell.desclbl.text = [NSString stringWithFormat:@"%@",phoneStr];
                }
                else
                {
                    cell.desclbl.text = [NSString stringWithFormat:@"%@, %@",emailStr,phoneStr];
                }
                
            }
            else
            {
                cell.desclbl.text = [NSString stringWithFormat:@"%@",emailStr];
            }
            
            if([[[srchResults objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"PhoneContacts"])
            {
                /*UIImage *contactProfilePic = [[srchResults objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"];
                [cell.imageView setImage:contactProfilePic];
                [cell.imgvw applyPhotoFrame];*/
                
                NSString *imgUrl = [NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[srchResults objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"]];
                [cell.imgvw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
                [cell.imgvw applyPhotoFrame];
                
                cell.memberTypeImgVw.image = [UIImage imageNamed:@"contact_member.png"];
                
            }
            else
            {
                NSString *imgUrl = [NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[srchResults objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"]];
                [cell.imgvw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
                [cell.imgvw applyPhotoFrame];
                
                cell.memberTypeImgVw.image = [UIImage imageNamed:@"reg_user.png"];
            }
            
            
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 15, 15)];
        }
        else if([self.nonMemberEmailId length] > 0)
        {
            cell = (AddmemberCell *)[tableView dequeueReusableCellWithIdentifier:@"cellID2"];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddmemberCell" owner:self options:nil];
                cell = [nib objectAtIndex:1];
            }
            
            NSString *srchName = [NSString stringWithFormat:@"%@",self.nonMemberEmailId];
            
            NSMutableAttributedString *hintText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ not found. Tap New to create a new user.",srchName]];
            
            int length = (int)srchName.length;
            
            //Blue
            [hintText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:15.0f], NSForegroundColorAttributeName:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0]} range:NSMakeRange(length + 16, 3)];
            
            //Rest of text
            [hintText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:15.0f]} range:NSMakeRange(length + 19, hintText.length - length - 19)];
            
            [cell.namelbl setAttributedText:hintText];
            
            //cell.namelbl.text = [NSString stringWithFormat:@"%@ not found. Tap new to create a new user.",self.nonMemberEmailId];
            
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
        else
        {
            
        }
    }
    else
    {
        cell = (AddmemberCell *)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddmemberCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSArray *allEmails = [[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"Email"];
        NSArray *allPhoneNumbers = [[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"ContactNo"];
        
        NSString *emailStr = nil;
        if (allEmails.count==0) {
            emailStr = @"";
        }
        else if([[allEmails objectAtIndex:0] isEqualToString:@""])
        {
            emailStr = @"";
        }
        else
        {
            emailStr = [allEmails componentsJoinedByString:@", "];
        }
        
        NSString *phoneStr = nil;
        
        if (allPhoneNumbers.count==0) {
            phoneStr = @"";
        }
        else if([[allPhoneNumbers objectAtIndex:0] isEqualToString:@"0"])
        {
            phoneStr = @"";
        }
        else
        {
            phoneStr = [allPhoneNumbers componentsJoinedByString:@", "];
        }
        
        
        cell.namelbl.text = [NSString stringWithFormat:@"%@ %@",[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"FirstName"],[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"LastName"]];
        
        if(![phoneStr isEqualToString:@""])
        {
            if([emailStr isEqualToString:@""])
            {
                cell.desclbl.text = [NSString stringWithFormat:@"%@",phoneStr];
            }
            else
            {
                cell.desclbl.text = [NSString stringWithFormat:@"%@, %@",emailStr,phoneStr];
            }
        }
        else
        {
            cell.desclbl.text = [NSString stringWithFormat:@"%@",emailStr];
        }
        
        if([[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"PhoneContacts"])
        {
            /*UIImage *contactProfilePic = [[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"];
            [cell.imageView setImage:contactProfilePic];
            [cell.imgvw applyPhotoFrame];*/
            
            NSString *imgUrl = [NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"]];
            [cell.imgvw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            [cell.imgvw applyPhotoFrame];
            
            cell.memberTypeImgVw.image = [UIImage imageNamed:@"contact_member.png"];
        }
        else
        {
            NSString *imgUrl = [NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"ProfileImage"]];
            [cell.imgvw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            [cell.imgvw applyPhotoFrame];
            
            cell.memberTypeImgVw.image = [UIImage imageNamed:@"reg_user.png"];
        }
        
    }
    
    return cell;
    
}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 80;
    }
    else
    {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddmemberCell *selectedMemberCell = (AddmemberCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if([selectedMemberCell.reuseIdentifier isEqualToString:@"cellID"])
    {
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            [self.selectedMemberDetailsDict setObject:[[srchResults objectAtIndex:indexPath.row] objectForKey:@"FirstName"] forKey:@"FirstName"];
            [self.selectedMemberDetailsDict setObject:[[srchResults objectAtIndex:indexPath.row] objectForKey:@"LastName"] forKey:@"LastName"];
            self.memberEmailArr = [[srchResults objectAtIndex:indexPath.row] objectForKey:@"Email"];
            self.memberPhoneNumArr = [[srchResults objectAtIndex:indexPath.row] objectForKey:@"ContactNo"];
            
            if([[[srchResults objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"main_db"])
            {
                self.appDelegate.alreadyRegisteredMember = YES;
            }
            else
            {
                self.appDelegate.alreadyRegisteredMember = NO;
            }
        }
        else
        {
            [self.selectedMemberDetailsDict setObject:[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"FirstName"] forKey:@"FirstName"];
            [self.selectedMemberDetailsDict setObject:[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"LastName"] forKey:@"LastName"];
            self.memberEmailArr = [[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"Email"];
            self.memberPhoneNumArr = [[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"ContactNo"];
            
            if([[[self.allRegUserArr objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"main_db"])
            {
                self.appDelegate.alreadyRegisteredMember = YES;
            }
            else
            {
                self.appDelegate.alreadyRegisteredMember = NO;
            }
        }
        
        if([self.memberEmailArr count] > 1 && [self.memberPhoneNumArr count] > 1)
        {
            self.singleDetailPresent = 1;
            
            UIActionSheet *ACEmail = nil;
            ACEmail = [[UIActionSheet alloc]initWithTitle:@"Select your Email Id" delegate:self cancelButtonTitle:@"Cancel"
                                   destructiveButtonTitle:nil otherButtonTitles:nil];
            
            
            ACEmail.actionSheetStyle = UIActionSheetStyleAutomatic;
            ACEmail.tag = 100;
            
            for (int i=0; i<[self.memberEmailArr count]; i++)
            {
                [ACEmail addButtonWithTitle:[self.memberEmailArr objectAtIndex:i]];
            }
            [ACEmail showInView:self.view];
        }
        
        if([self.memberEmailArr count] == 0 && [self.memberPhoneNumArr count] == 0)
        {
            self.singleDetailPresent = 0;
            
            self.selectedEmail = nil;
            self.selectedPhoneNum = nil;
            
            [self.selectedMemberDetailsDict setObject:@"" forKey:@"Email"];
            [self.selectedMemberDetailsDict setObject:@"" forKey:@"ContactNo"];
            
        }
        
        if([self.memberEmailArr count] == 1 && [self.memberPhoneNumArr count] == 1)
        {
            self.singleDetailPresent = 0;
            
            self.selectedEmail = [NSString stringWithFormat:@"%@",[self.memberEmailArr objectAtIndex:0]];
            self.selectedPhoneNum = [NSString stringWithFormat:@"%@",[self.memberPhoneNumArr objectAtIndex:0]];
            
            
            if([self.selectedEmail isEqualToString:@""])
            {
                [self.selectedMemberDetailsDict setObject:@"" forKey:@"Email"];
            }
            else
            {
                [self.selectedMemberDetailsDict setObject:self.selectedEmail forKey:@"Email"];
            }
            
            if([self.selectedPhoneNum isEqualToString:@"0"])
            {
                [self.selectedMemberDetailsDict setObject:@"" forKey:@"ContactNo"];
            }
            else
            {
                [self.selectedMemberDetailsDict setObject:self.selectedPhoneNum forKey:@"ContactNo"];
            }
            
        }
        
        if([self.memberEmailArr count] > 1 && [self.memberPhoneNumArr count] == 1)
        {
            self.singleDetailPresent = 2;
            
            self.selectedPhoneNum = [NSString stringWithFormat:@"%@",[self.memberPhoneNumArr objectAtIndex:0]];
            
            UIActionSheet *ACEmail = nil;
            ACEmail = [[UIActionSheet alloc]initWithTitle:@"Select your Email Id" delegate:self cancelButtonTitle:@"Cancel"
                                   destructiveButtonTitle:nil otherButtonTitles:nil];
            
            
            ACEmail.actionSheetStyle = UIActionSheetStyleAutomatic;
            ACEmail.tag = 200;
            
            for (int i=0; i<[self.memberEmailArr count]; i++)
            {
                [ACEmail addButtonWithTitle:[self.memberEmailArr objectAtIndex:i]];
            }
            [ACEmail showInView:self.view];
        }
        
        if([self.memberEmailArr count] == 1 && [self.memberPhoneNumArr count] > 1)
        {
            self.singleDetailPresent = 3;
            
            self.selectedEmail = [NSString stringWithFormat:@"%@",[self.memberEmailArr objectAtIndex:0]];
            
            UIActionSheet *ACPhoneNum = nil;
            ACPhoneNum = [[UIActionSheet alloc]initWithTitle:@"Select your Phone Number" delegate:self cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil otherButtonTitles:nil];
            
            
            ACPhoneNum.actionSheetStyle = UIActionSheetStyleAutomatic;
            ACPhoneNum.tag = 300;
            
            for (int i=0; i<[self.memberPhoneNumArr count]; i++)
            {
                [ACPhoneNum addButtonWithTitle:[self.memberPhoneNumArr objectAtIndex:i]];
            }
            [ACPhoneNum showInView:self.view];
        }
    
        
        if(self.singleDetailPresent == 0)
        {
           // [self.teamMaintenanceMemberDetailsVC manageMemberDetails:self.selectedMemberDetailsDict];
            [self dismissViewControllerAnimated:YES completion:nil];
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] selectProperClassForSegmentTap:self.selectedMemberDetailsDict];
        }
    }
    else
    {
        if([self NSStringIsValidEmail:self.nonMemberEmailId] == YES)
        {
            [self.selectedMemberDetailsDict setObject:self.nonMemberEmailId forKey:@"Email"];
            [self.selectedMemberDetailsDict setObject:@"" forKey:@"ContactNo"];
            [self.selectedMemberDetailsDict setObject:@"" forKey:@"FirstName"];
            [self.selectedMemberDetailsDict setObject:@"" forKey:@"LastName"];
            
            //[self.teamMaintenanceMemberDetailsVC manageMemberDetails:self.selectedMemberDetailsDict];
            [self dismissViewControllerAnimated:YES completion:nil];
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] selectProperClassForSegmentTap:self.selectedMemberDetailsDict];
        }
        else
        {
            //[selectedMemberCell setUserInteractionEnabled:NO];
            //selectedMemberCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [self skipBtnAction:nil];
        }
        
    }
    
}

#pragma mark - ActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 100)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            self.selectedEmail = [NSString stringWithFormat:@"%@",[self.memberEmailArr objectAtIndex:buttonIndex - 1]];
            
            UIActionSheet *ACPhoneNum = nil;
            ACPhoneNum = [[UIActionSheet alloc]initWithTitle:@"Select your Phone Number" delegate:self cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil otherButtonTitles:nil];
            
            
            ACPhoneNum.actionSheetStyle = UIActionSheetStyleAutomatic;
            ACPhoneNum.tag = 400;
            
            for (int i=0; i<[self.memberPhoneNumArr count]; i++)
            {
                [ACPhoneNum addButtonWithTitle:[self.memberPhoneNumArr objectAtIndex:i]];
            }
            [ACPhoneNum showInView:self.view];
            
        }
    }
    else if (actionSheet.tag == 200)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            self.selectedEmail = [NSString stringWithFormat:@"%@",[self.memberEmailArr objectAtIndex:buttonIndex - 1]];
        }
    }
    else if (actionSheet.tag == 300)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            self.selectedPhoneNum = [NSString stringWithFormat:@"%@",[self.memberPhoneNumArr objectAtIndex:buttonIndex - 1]];
        }
    }
    else
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            self.selectedPhoneNum = [NSString stringWithFormat:@"%@",[self.memberPhoneNumArr objectAtIndex:buttonIndex - 1]];
        }
    }
    
    [self.selectedMemberDetailsDict setObject:self.selectedEmail forKey:@"Email"];
    [self.selectedMemberDetailsDict setObject:self.selectedPhoneNum forKey:@"ContactNo"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] selectProperClassForSegmentTap:self.selectedMemberDetailsDict];
  //  [self.teamMaintenanceMemberDetailsVC manageMemberDetails:self.selectedMemberDetailsDict];
}


- (IBAction)cancelBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)skipBtnAction:(id)sender
{
    
    self.selectedMemberDetailsDict=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.appDelegate.alreadyRegisteredMember = NO;
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] selectProperClassForSegmentTap:self.selectedMemberDetailsDict];
    
}

@end
