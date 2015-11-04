//
//  MyTeamsViewController.m
//  Wall
//
//  Created by User on 11/06/15.
//
//

#import "MyTeamsViewController.h"
#import "TeamDetailsViewController.h"
#import "InvitePlayerListCell.h"
#import "TeamMaintenanceVC.h"
#import "HomeVC.h"
#import "CenterViewController.h"

@interface MyTeamsViewController (){
    NSArray *srchResults;
    
    NSMutableArray *srchArray;
}

@property (strong, nonatomic) NSMutableArray *filteredCandyArray;

@end

@implementation MyTeamsViewController
@synthesize notiCount,rowCount,filteredCandyArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //// AD...iAd
    self.adBanner.frame=CGRectMake(self.adBanner.frame.origin.x, self.adBanner.frame.origin.y, self.adBanner.frame.size.width, self.adBanner.frame.size.height);
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    
    srchResults=[[NSArray alloc]init];
    srchArray=[[NSMutableArray alloc]init];
    
    self.notiCount=0;
    self.filteredCandyArray=[[NSMutableArray alloc] init];
    
    /// AD july For Myteam
    
    self.navigationController.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERMYTEAMS object:nil];
    
    [self loadMyTeamData];
    
    //////////
    
    
    if ([self.appDelegate.JSONDATAarr count]>0) {
        self.noTeamView.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for(int ind=0;ind<self.appDelegate.JSONDATAarr.count;ind++)
    {
        [srchArray addObject:[[self.appDelegate.JSONDATAarr objectAtIndex:ind]objectForKey:@"team_name"]];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedCell:) name:TEAM_LOGO_NOTIFICATION1 object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAM_LOGO_NOTIFICATION1 object:nil];
}


////////  AD july For Myteams  //////



#pragma mark - NavigationControllerUpdate
-(void)showNavigationControllerUpdated:(id)sender
{
    
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            [self showNavigationBarButtons];
            
        }
        else
        {
            [[self.navigationController.viewControllers lastObject] showNavigationBarButtons];
        }
    }
    
    
}


-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        // self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if (self.isiPad) {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addTeams:)];
    }
    else{
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addTeams:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"My Teams";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    [self setRightBarButton];
    
    
    [self setStatusBarStyleOwnApp:1];
    
    //// AD...iAd
    
    self.adBanner.frame=CGRectMake(self.adBanner.frame.origin.x, self.adBanner.frame.origin.y, self.adBanner.frame.size.width, self.adBanner.frame.size.height);
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    for(int ind=0;ind<self.appDelegate.JSONDATAarr.count;ind++)
    {
        [srchArray addObject:[[self.appDelegate.JSONDATAarr objectAtIndex:ind]objectForKey:@"team_name"]];
        
    }
}

-(void)toggleLeftPanel:(id)sender
{
    
    [self.view endEditing:YES];
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
    /*[self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    
    self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineimasel;
    self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.themeCyanColor;*/
    
    ///////////////////////
}


-(void)setRightBarButton
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            
        }
    }
}


#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERMYTEAMS object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}






#pragma mark - UISearchDisplayController Delegate Methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope   //pradip.....june
{
    
    
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"Self contains[c] %@", searchText];
    
    //  srchResults = [self.appDelegate.JSONDATAarr  filteredArrayUsingPredicate:resultPredicate];
    srchResults = [srchArray  filteredArrayUsingPredicate:resultPredicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString      //search......june
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    
    return YES;
}

#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.searchDisplayController.searchResultsTableView)     //search...........june
    {
        return [srchResults count];
    }
    
    else
        
        return [self.appDelegate.JSONDATAarr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isiPad) {
        return 70;
    }
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InvitePlayerCell";
    
    InvitePlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[InvitePlayerListCell inviteCell];
        
    }
    cell.imgVwBig.hidden=YES;
    cell.callBtn.hidden=YES;
    cell.cancelBtn.hidden=YES;
    cell.callBtn.tag=indexPath.row;
    cell.lblNumber.text=[NSString stringWithFormat:@"%ld.",indexPath.row+1];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //search...june
        
        // cell.playerNameLbl.text= [[srchResults objectAtIndex:indexPath.row]objectForKey:@"team_name"];
        
        
        cell.playerNameLbl.text= [srchResults objectAtIndex:indexPath.row];
    }
    
    else
        
        cell.playerNameLbl.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_name"];
    
    [cell.profileImageVw cleanPhotoFrame];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        
        if ((![[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"] isEqualToString:@""]) && [[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"]) {
            
            
            NSInteger i;
            for(int ind=0;ind<srchArray.count;ind++)
            {
                
                if([cell.playerNameLbl.text isEqualToString:[srchArray objectAtIndex:ind]] )
                {
                    i=ind;
                    
                    
                }
                
                
            }
            
            
            
            ImageInfo *imainfo = [self.appDelegate.JSONDATAImages objectAtIndex:i];
            
            if(!imainfo.image)
            {
                
                ImageInfo *userImainfo=imainfo;
                userImainfo.notifiedObject=cell;
                userImainfo.notificationName=TEAM_LOGO_NOTIFICATION1;
                
                if(!userImainfo.isProcessing)
                    [userImainfo getImage];
                // isSelectedImage=1;
                
            }
            else
            {
                cell.profileImageVw.image=imainfo.image;
                [cell.profileImageVw applyPhotoFrame];
            }
            
        }else{
            
            [cell.profileImageVw setImage:self.noImage];
            
        }
        
    }
    
    else{
        
        if ((![[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"] isEqualToString:@""]) && [[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"]) {
            
            
            
            ImageInfo *imainfo = [self.appDelegate.JSONDATAImages objectAtIndex:indexPath.row];
            
            
            //
            //        if (tableView == self.searchDisplayController.searchResultsTableView) {   //pradip..june
            //
            //
            //            NSInteger i=[self.appDelegate.JSONDATAarr indexOfObject:cell.playerNameLbl.text];
            //
            //            cell.profileImageVw.image=[self.appDelegate.JSONDATAImages objectAtIndex:i];
            //
            //        }
            //
            //        else
            //        {
            if(!imainfo.image)
            {
                
                ImageInfo *userImainfo=imainfo;
                userImainfo.notifiedObject=cell;
                userImainfo.notificationName=TEAM_LOGO_NOTIFICATION1;
                
                if(!userImainfo.isProcessing)
                    [userImainfo getImage];
                // isSelectedImage=1;
                
            }
            else
            {
                cell.profileImageVw.image=imainfo.image;
                [cell.profileImageVw applyPhotoFrame];
            }
            
            //}
            
        }
        else{
            
            [cell.profileImageVw setImage:self.noImage];
            
        }
        
        
    }
    
    return cell;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yVelocity = [scrollView.panGestureRecognizer velocityInView:scrollView].y;
    if (yVelocity > 0)
    {
        //NSLog(@"Up");
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             //IMP: 180.0 is mingleRequestHeaderVw.frame.size.height & -125.0 works perfect for 5s
                             
                             // self.searchDisplayController.searchBar
                             
                             // self.searchBarTeam         //pradip....june
                             
                             [self.searchDisplayController.searchBar setFrame:CGRectMake(0, self.searchDisplayController.searchBar.frame.size.height/44 * 0, self.searchDisplayController.searchBar.frame.size.width, self.searchDisplayController.searchBar.frame.size.height)];
                             
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.4
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  CGFloat tblNewY = self.searchDisplayController.searchBar.frame.size.height;
                                                  CGFloat tblNewHeight = self.tableTeam.frame.size.height + (self.tableTeam.frame.origin.y - tblNewY);
                                                  [self.tableTeam setFrame:CGRectMake(0, tblNewY, self.tableTeam.frame.size.width, tblNewHeight)];
                                              }
                                              completion:^(BOOL finished){
                                                  // whatever you need to do when animations are complete
                                              }];
                         }];
        
    }
    else if (yVelocity < 0)
    {
        //NSLog(@"Down");
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self.searchDisplayController.searchBar setFrame:CGRectMake(0, -44, self.searchDisplayController.searchBar.frame.size.width, self.searchDisplayController.searchBar.frame.size.height)];
                             
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.4
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  
                                                  CGFloat tblNewY = fabs(self.searchDisplayController.searchBar.frame.origin.y) - self.searchDisplayController.searchBar.frame.size.height;
                                                  CGFloat tblNewHeight = self.tableTeam.frame.size.height - (tblNewY - self.tableTeam.frame.origin.y);
                                                  [self.tableTeam setFrame:CGRectMake(0, tblNewY, self.tableTeam.frame.size.width, tblNewHeight)];
                                              }
                                              completion:^(BOOL finished){
                                                  // whatever you need to do when animations are complete
                                                  
                                              }];
                         }];
        
    }
    else {
        NSLog(@"Can't determine direction as velocity is 0");
        
    }
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.selectedIndex=indexPath.row;
    
    if ([self.appDelegate.JSONDATAarr count]>0) {
        
        //self.rowCount may not necessary any more ..Subhasish..10th July
        
//        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Timeline",@"Team Stuff",nil];
//        action.tag=1001;
        
       // action.backgroundColor = [UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0];
       /* [[[action valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"timelinetab.png"] forState:UIControlStateNormal];
        
        [[[action valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"teamRosterWall.png"] forState:UIControlStateNormal];*/
        
        //[action showInView:self.view];
        
        [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
        [appDelegate.centerViewController setTabBar:0 :5];
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] getFromMyTeams:(int)indexPath.row-1];
        
        //[appDelegate.centerVC getFromMyTeams:(int)indexPath.row-1];
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            for (int i=0; i<[self.appDelegate.JSONDATAarr count]; i++) {
                
                if ([[[self.appDelegate.JSONDATAarr objectAtIndex:i] objectForKey:@"team_name"] isEqualToString:[srchResults objectAtIndex:indexPath.row]]) {
                    self.rowCount=i;
                    break;
                }
            }
        }
        else{
            self.rowCount=(int)indexPath.row;
        }
        

        
        
        
        
       // self.rowCount=(int)indexPath.row;
        
    
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    actionSheet.layer.backgroundColor = [UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    //this method will not work as actionSheet.tag==1001 is blocked on didSelectRowAtIndexPath. Subhasish..10th July
    
    if (actionSheet.tag==1001){
        
        if (buttonIndex==0) {
            [appDelegate.centerViewController showNavController:appDelegate.navigationController];
            [appDelegate.centerVC getFromMyTeams:self.rowCount-1];
        }
        
        else if (buttonIndex==1){
            
            [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
            [appDelegate.centerViewController setTabBar:0 :5];
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] getFromMyTeams:self.rowCount-1];
            
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)addTeams:(id)sender {
    
//    self.appDelegate.isTeamCreate=YES;
   /* [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
    [appDelegate.centerViewController setTabBar:0 :6];
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:sender];
    */
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:sender];
    
  /*  TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    addTeam.selectedTeamIndex=-1;
    addTeam.editBtn.hidden=YES;
    addTeam.isAddTeam=YES;
    addTeam.isMyTeam=YES;
    [self.appDelegate.centerViewController presentViewControllerForModal:addTeam];*/
    
    
}

- (void)imageUpdatedCell:(NSNotification *)notif
{
    self.notiCount++;
    NSLog(@"AAAAAA%@",[notif object]);
    
    
    
    ImageInfo *info=[notif object];
    
    if ([self.appDelegate.JSONDATAarr count]==notiCount) {
        [self.tableTeam reloadData];
    }
    
   /* self.avatarimavw.image=info.image;
    isLoadImage=1;
    self.originalImage=info.image;
    [self.avatarimavw applyPhotoFrame];*/
    
}

/////  AD july For Myteam   //////

-(void)loadMyTeamData
{
    
    
    if((!appDelegate.JSONDATAarr.count) || (!appDelegate.JSONDATAarr))
    {
        int flag=1;
        
        if(flag)
        {
           // mode=0;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            //  [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
            [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"1" forKey:@"case"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonCommand = [writer stringWithObject:command];
            [self showNativeHudView];
            [self sendRequestForTeamData:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
    }
    
}



-(void)sendRequestForTeamData:(NSDictionary*)dic
{
    
    NSURL* url = [NSURL URLWithString:TEAMROSTERLINK];
    
    //NSURL* url = [NSURL URLWithString:TEAM_LISTING_LINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc ] initWithURL:url];
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    if([[dic allKeys] count]>0)
    {
        
        
        for(int i=0;i<[[dic allKeys] count];i++)
        {
            NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
            if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
            {
                [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                
                
                if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user" andContentType:@"video/*" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:i]];
                    
                }
            }
            else
            {
                NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                
                
            }
            
            
        }
        
        
    }
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    if(str)
        
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]  ])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            
            
            self.appDelegate.JSONDATAarr=[NSMutableArray arrayWithArray:[[[aDict objectForKey:@"response"] objectForKey:@"users_team"] objectForKey:@"team_list"]];
            
            
            // [self.appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:self.appDelegate.centerVC.lastSelectedTeam];
            
            NSLog(@"user team list maintenance %@",self.appDelegate.JSONDATAarr);
            
            
            ////////////////////////////////////////
            
            NSMutableArray *marr=[[NSMutableArray alloc] init];
            self.appDelegate.JSONDATAImages=marr;
            for(NSDictionary *dic in  self.appDelegate.JSONDATAarr)
            {
                ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[dic objectForKey:@"team_logo"]]]];
                [ self.appDelegate.JSONDATAImages addObject:userImainfo];
                
            }
            
            
            if ([self.appDelegate.JSONDATAarr count]>0 || appDelegate.centerVC.dataArrayUpButtonsIds.count>0) {
                
                self.noTeamView.hidden=YES;
                
                [appDelegate setUserDefaultValue:@"1" ForKey:ISEXISTOWNTEAM];
                
                [self.tableTeam reloadData]; 
                
                
              //  [self createTeamScroll];
                
                
//                if([self.teamNavController.view.superview isEqual:self.view])
//                    [self.teamNavController.view removeFromSuperview];
                
               /* TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
                addTeam.selectedTeamIndex=0;
                
                UINavigationController *aNav=[[UINavigationController alloc] initWithRootViewController:addTeam];*/
                
                
                
                
              /*  self.teamNavController=aNav;
                aNav=nil;
                self.teamNavController.navigationBarHidden=YES;
                
                if (self.isiPad) {
                    self.teamNavController.view.frame=CGRectMake(0,54,768,(appDelegate.commonHeight - 54));
                    
                }
                else{
                    if(appDelegate.isIphone5)
                        self.teamNavController.view.frame=CGRectMake(0,44,320,(appDelegate.commonHeight+ 88 - 44));
                    else
                        self.teamNavController.view.frame=CGRectMake(0,44,320,appDelegate.commonHeight - 44);
                }
                
                [self.view addSubview:self.teamNavController.view];
                [self.view bringSubviewToFront:self.teamNavController.view];
                NSLog(@"frame %@ ",NSStringFromCGRect(self.teamNavController.view.bounds));
                [self upBtappedNew:self.buttonfirstinscroll.tag];  */
                
                
            }else{
                
                self.noTeamView.hidden=NO;
//                [self showRightButton:1];
                if([appDelegate.aDef objectForKey:ISEXISTOWNTEAM])
                    [appDelegate removeUserDefaultValueForKey:ISEXISTOWNTEAM];
                
                UIButton *btn=nil;
                [appDelegate.centerViewController setTabBar:0 :6];
                [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:btn];
            }
            
            
            
        }else if ([res isKindOfClass:[NSArray class]  ]){
            
            self.noTeamView.hidden=NO;
//            [self showRightButton:1];
            
        }else{
            self.noTeamView.hidden=NO;
//            [self showRightButton:1];
            
        }
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
    NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
    //[self showAlertMessage:CONNFAILMSG];ChAfter
    
}


///////////////


#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
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
}



@end
