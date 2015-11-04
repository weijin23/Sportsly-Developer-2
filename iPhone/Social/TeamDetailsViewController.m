//
//  TeamDetailsViewController.m
//  Social
//
//  Created by Mindpace on 21/08/13.
//
//
#import "HomeVC.h"
#import "TeamDetailsViewController.h"
#import "ClubViewController.h"
#import "InvitePlayerListViewController.h"
#import "DropDownCell.h"
#import "DropDownViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "EventEditViewController.h"
#import "CenterViewController.h"
#import "EventCalendarViewController.h"
#import "ToDoByEventsVC.h"
#import "CenterViewController.h"
#import "TeamMaintenanceVC.h"
#import "TeamAdminVCViewController.h"
#import "CustomSportViewController.h"
#import "SpectatorViewController.h"

@interface TeamDetailsViewController ()<UITextFieldDelegate>
{
    int isCancel;
}
@end

@implementation TeamDetailsViewController 
@synthesize saveTeamVC,isSelectedImage,avatarimavw;
@synthesize teamScroll,teamEditView,teamDetailsBtn,playerDetailsBtn,picker;
@synthesize teamFirstView,teamSecondView,teamThirdView,pickerContainer,pickerArr;
@synthesize teamNameTxt,sportTxt,clubTxt,leagueTxt,zipCodeTxt;
@synthesize ageGrpTxt,genderTxt,uniformColorTxt;
@synthesize creatorNameTxt,emailTxt,phoneTxt;
@synthesize teamForm;
@synthesize btnTapped,selRow1,selRow2,selRow3,selRow4,selRow5,selRow6,selRow7,selRow8,pickerSelectTag,pickerArr2,pickerArr3,pickerArr4,pickerArr5,pickerArr6,pickerArr7;
@synthesize lastSelectedAddress,geocoder,selectedLocation,arrPickerItems4,selectedFiledIndex,firstTimeDefaultCurrentAddress,addTeamId,cludId,leagueId;
@synthesize selectedTeamIndex;
@synthesize isLoadImage,noImage,originalImage;
@synthesize addMin1Info,addMin2Info,isAddminOne;
@synthesize teamVc,isFieldTap,isLoadingLocations;

@synthesize isTapp,isAddTeam,isMyTeam;

int mode,pickerSelect,isUpdateTeamLogo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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
    
    if(!self.isAddTeam){
        self.adBanner.frame=CGRectMake(self.adBanner.frame.origin.x, self.adBanner.frame.origin.y+50, self.adBanner.frame.size.width, self.adBanner.frame.size.height);
    }
    
    isTapp=NO;
    
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmentCtrl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapRosterSegControl:) name:NOTIFYROSTERTAPSEGCONTROL object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapAdminSegControl:) name:NOTIFYADMINTAPSEGCONTROL object:nil];
    
    @autoreleasepool {
        [self.sportTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.teamNameTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.zipCodeTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.fieldNameTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.genderTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.uniformColorTxt setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.teamColorText2 setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    
    
    
    [appDelegate createLocationManager];
    self.fieldnameindicator.hidden=YES;
    self.emailTxt.enabled=NO;
    

    NSLog(@"%@",[appDelegate.aDef objectForKey:EMAIL]);
    self.emailTxt.text=[appDelegate.aDef objectForKey:EMAIL];
    self.
    selRow1=0;
    selRow2=0;
    selRow3=0;
    selRow4=0;
    selRow5=0;
    selRow6=0;
    selRow7=0;
    selRow8=0;
    pickerSelectTag=0;
    selectedFiledIndex=0;
    
    self.ageGrpTxt.enabled=NO;
    btnTapped=TRUE;
    pickerSelect=0;
    
    NSMutableArray *arr=[[NSMutableArray alloc] init];
      NSMutableArray *arr1=[[NSMutableArray alloc] init];
    
    for(int i=0;i<=100;i++)
    {
        NSString *s=[[NSString alloc] initWithFormat:@"%i",i];
        [arr addObject:s];
        [arr1 addObject:s];
        [s release];
    }
    
    self.pickerArr2=arr;
    self.pickerArr3=arr1;
    [arr release];
    [arr1 release];
    
    self.addMin1Info=[[[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]],[appDelegate.aDef objectForKey:EMAIL],@"",@"coach", nil] autorelease];
    self.addMin2Info=[[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"other", nil] autorelease];
    self.pickerArr4=[NSArray arrayWithObjects:@"Other",nil];
    self.pickerArr5=[NSArray arrayWithObjects:@"Other",nil];
    
    self.pickerArr=[NSArray arrayWithObjects:@"Badminton",@"Baseball",@"Basketball",@"Bicycling",@"Chess",@"Cricket",@"Field hockey",@"Fishing",@"Football",@"Ice hockey",@"Kayaking",@"Lacrosse",@"Picnic",@"Reunion",@"Rowing",@"Running",@"Skiing",@"Soccer",@"Table Tennis",@"Tennis",@"Volleyball",@"Walking",nil];
    
    self.pickerArr6=[NSArray arrayWithObjects:@"Male",@"Female",@"Co-ed",nil];

     self.pickerArr7=[NSArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Yellow",@"White",@"Black",@"Gray", nil];
    
    self.teamForm=[[NSMutableDictionary alloc]init];
    [teamForm release];
    [self.teamFirstView.layer setCornerRadius:3.0f];
    [self.teamFirstView.layer setMasksToBounds:YES];
    
    [self.teamSecondView.layer setCornerRadius:3.0f];
    [self.teamSecondView.layer setMasksToBounds:YES];
    
    [self.teamThirdView.layer setCornerRadius:3.0f];
    [self.teamThirdView.layer setMasksToBounds:YES];
    
       
    self.teamNameTxt.text=@"";
    self.sportTxt.text=@"";
    self.clubTxt.text=@"";
    self.leagueTxt.text=@"";
    self.zipCodeTxt.text=@"";
    
    self.ageGrpTxt.text=@"";
    self.genderTxt.text=@"";
    self.uniformColorTxt.text=@"";
    self.teamColorText2.text=@"";
    
    self.creatorNameTxt.text=@"";
    self.emailTxt.text=@"";
    self.phoneTxt.text=@"";
    self.cludId=@"0";
    self.leagueId=@"0";
    mode=0;
    self.teamScroll.contentSize=CGSizeMake(self.teamEditView.frame.size.width, self.teamEditView.frame.size.height);
    self.teamScroll.scrollEnabled=YES;
    self.teamEditView.hidden=NO;
    
    [self.teamDetailsBtn setBackgroundImage:[UIImage imageNamed:@"team-select.png"] forState:UIControlStateNormal];
    
    [self.playerDetailsBtn setBackgroundImage:[UIImage imageNamed:@"player-nonselect.png"] forState:UIControlStateNormal];
    
    [self.teamDetailsBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.playerDetailsBtn.titleLabel setTextColor:[UIColor blackColor]];
    
    
      af=[[UIScreen mainScreen] applicationFrame];
    
    self.emailTxt.text=[appDelegate.aDef objectForKey:EMAIL];
    //self.sportTxt.text=@"";
    //self.sportTxt.text=[pickerArr objectAtIndex:selRow6];
  
    
    self.clubTxt.enabled=NO;
    self.leagueTxt.enabled=NO;
    
    
    if (appDelegate.JSONDATAarr.count){
        
        self.backImageView.hidden=NO;
        self.backBtn.hidden=NO;
        
    }else{
        
        self.backImageView.hidden=YES;
        self.backBtn.hidden=YES;

    }
    
    if (self.selectedTeamIndex>=0)
    {
        isUpdateTeamLogo=0;
        isLoadImage=0;
        
        self.avatarimavw.image=[UIImage imageNamed:@"no_image.png"];
        [self.avatarimavw cleanPhotoFrame];
        isSelectedImage=0;
        self.toggleView.hidden=NO;
        //self.deleteView.hidden=NO;
        self.topview.hidden=YES;
        self.view.frame=self.navigationController.view.bounds;
        if (self.isiPad) {
            self.teamScroll.frame=CGRectMake(0, 105, self.teamScroll.frame.size.width, self.teamScroll.frame.size.height);
            self.teamScroll.contentSize=CGSizeMake(self.teamEditView.frame.size.width, self.teamEditView.frame.size.height + 180);
        }
        else{
            self.teamScroll.frame=CGRectMake(0, 45, self.teamScroll.frame.size.width, self.teamScroll.frame.size.height);
        
            self.teamScroll.contentSize=CGSizeMake(self.teamEditView.frame.size.width, self.teamEditView.frame.size.height + 110);
        }
        
        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"]]) {
            
            //[self.addBtn setTitle:@"Edit Team" forState:UIControlStateNormal];
            [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
            self.addBtn.hidden=YES;  //// 30/01/15
            self.editBtn.hidden=NO;
              self.ownerLbl.hidden=NO;
              self.teamFirstView.userInteractionEnabled=NO;
            self.deletebtn.hidden=NO;
            
        }else{
            
            //[self.addBtn setTitle:@"Edit Team" forState:UIControlStateNormal];
            [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
            self.addBtn.hidden=YES;   //// 30/01/15
            self.editBtn.hidden=YES;
            self.addBtn.hidden=YES;
            self.ownerLbl.hidden=YES;
            self.teamFirstView.userInteractionEnabled=NO;

             self.deletebtn.hidden=YES;
        }
        
        for (UIImageView *imgVw in self.dropDownArroImage){
            
            imgVw.hidden=YES;
        }
        
        [self updateTeamView];
        
    }else{
        isUpdateTeamLogo=1;
        if (self.isiPad) {
            self.teamScroll.frame=CGRectMake(0, 125, self.teamScroll.frame.size.width, self.teamScroll.frame.size.height);
            self.teamScroll.contentSize=CGSizeMake(self.teamEditView.frame.size.width, self.teamEditView.frame.size.height + 135);
            self.addBtn.frame=CGRectMake(self.addBtn.frame.origin.x, self.addBtn.frame.origin.y+40, self.addBtn.frame.size.width, self.addBtn.frame.size.height);
        }
        else{
            self.teamScroll.frame=CGRectMake(0,61, self.teamScroll.frame.size.width, self.teamScroll.frame.size.height);
            self.teamScroll.contentSize=CGSizeMake(self.teamEditView.frame.size.width, self.teamEditView.frame.size.height + 65);
        }
      
        self.deleteView.hidden=YES;
        self.editBtn.hidden=YES;
       self.toggleView.hidden=YES;
       self.topview.hidden=NO;
       
        self.addBtn.hidden=NO;
        self.teamEditView.userInteractionEnabled=YES;
        [self.addBtn setTitle:@"Add Team" forState:UIControlStateNormal];

        self.ownerLbl.hidden=YES;
        svos= self.teamScroll.contentSize;

    }
}


-(void)goToTimeLine:(NSString*)msg
{
    //[appDelegate.centerViewController showNavController:appDelegate.navigationController];
    
    if(appDelegate.centerVC.dataArrayUpButtonsIds.count==1)
    {
        [appDelegate.centerVC showAlertViewCustom:msg];
    }
    else if(appDelegate.centerVC.dataArrayUpButtonsIds.count==2)
    {
        [appDelegate.centerVC showAlertViewCustom:@"Congrats, you now belong to multiple Timelines. Scroll through them by swiping left/right"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] showRightButton:1];
    [self.segmentCtrl setSelectedSegmentIndex:0];
    NSLog(@"Segment Details :%d",self.segmentCtrl.selectedSegmentIndex);
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentCtrl.selectedSegmentIndex adminCount:0 isAdmin:YES];
    
    self.teaamLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
   //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findLocation) name:kLatLongFound object:nil];
    if (self.selectedTeamIndex>=0) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:TEAM_LOGO_NOTIFICATION object:nil];
        
        if(!isLoadImage)
        {
            if( ! [[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_logo"] isEqualToString:@""])
            {
                
                ImageInfo *imainfo = [self.appDelegate.JSONDATAImages objectAtIndex:self.selectedTeamIndex];
                
                if(!imainfo.image)
                {
                    
                    ImageInfo *userImainfo=imainfo;
                    userImainfo.notifiedObject=nil;
                    userImainfo.notificationName=TEAM_LOGO_NOTIFICATION;
                    
                   if(!userImainfo.isProcessing)
                    [userImainfo getImage];
                   // isSelectedImage=1;

                }
                else
                {
                    self.avatarimavw.image=imainfo.image;
                    isLoadImage=1;
                    self.originalImage=imainfo.image;
                    //isSelectedImage=0;

                    [self.avatarimavw applyPhotoFrame];
                }
            }
        }
        
        
    }
       
    if (self.selectedTeamIndex>=0) {
        
        if (!isUpdateTeamLogo) {
            
            [self updateTeamView];

        }else{
            isUpdateTeamLogo=0;
        }
        
    }
    else
    {
//        self.addBtn.frame=CGRectMake(self.addBtn.frame.origin.x, self.addBtn.frame.origin.y+40, self.addBtn.frame.size.width, self.addBtn.frame.size.height);
        [self setStatusBarStyleOwnApp:0];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:kLatLongFound object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAM_LOGO_NOTIFICATION object:nil];

    
     if (self.selectedTeamIndex>=0) {
         
         isUpdateTeamLogo=1;

     }
    else
    {
         [self setStatusBarStyleOwnApp:1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    self.firstTimeDefaultCurrentAddress=nil;
    self.pickerArr2=nil;
    self.pickerArr3=nil;
    self.pickerArr4=nil;
    self.pickerArr5=nil;
    self.pickerArr6=nil;
    self.pickerArr7=nil;
    self.picker=nil;
    self.pickerContainer=nil;
    self.teamScroll=nil;
    self.teamEditView=nil;
    self.teamDetailsBtn=nil;
    self.playerDetailsBtn=nil;
    self.teamFirstView=nil;
    self.teamSecondView=nil;
    self.teamThirdView=nil;
    self.teamNameTxt=nil;
    self.sportTxt=nil;
    self.clubTxt=nil;
    self.leagueTxt=nil;
    self.zipCodeTxt=nil;
    self.ageGrpTxt=nil;
    self.genderTxt=nil;
    self.uniformColorTxt=nil;
    self.creatorNameTxt=nil;
    self.emailTxt=nil;
    self.phoneTxt=nil;
   
    self.keyboardToolbarView=nil;
   
    self.avatarimavw=nil;
    
    self.teamForm=nil;
    self.saveTeamVC=nil;
    self.pickerArr=nil;
    
    [_fdashlab release];
    [_betweenfbt release];
    [_andlab release];
    [_sdashlab release];
    [_sportbt release];
    [_fieldNameTxt release];
    [_fieldnameindicator release];
    [_teamColorText2 release];
   
    [_email2Txt release];
    [_clubNameTxt release];
    [_leagueNameTxt release];
  
    [_titleLbl release];
    [_addMinView release];
    [_backImageView release];
    [_backBtn release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.picker=nil;
    self.pickerContainer=nil;
    self.teamScroll=nil;
    self.teamEditView=nil;
    self.teamDetailsBtn=nil;
    self.playerDetailsBtn=nil;
    self.teamFirstView=nil;
    self.teamSecondView=nil;
    self.teamThirdView=nil;
    self.teamNameTxt=nil;
    self.sportTxt=nil;
    self.clubTxt=nil;
    self.leagueTxt=nil;
    self.zipCodeTxt=nil;
    self.ageGrpTxt=nil;
    self.genderTxt=nil;
    self.uniformColorTxt=nil;
    self.creatorNameTxt=nil;
    self.emailTxt=nil;
    self.phoneTxt=nil;
    self.keyboardToolbarView=nil;
    self.avatarimavw=nil;
    [self setToggleView:nil];
    [self setTeaamLbl:nil];
    [self setPlayerLbl:nil];
    [super viewDidUnload];
}

#pragma mark - UPdateTeamView

-(void)updateTeamView{
    
    self.teamNameTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_name"];
    self.sportTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_sport"];
    
    self.cludId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_id"];
    self.leagueId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_id"];
    
    if ([self.cludId isEqualToString:@"0"]) {
        self.cludId=@"1";
    }
    if ([self.leagueId isEqualToString:@"0"]) {
        self.leagueId=@"1";
    }
    self.clubNameTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_name"];
    self.leagueNameTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_name"];
    
    self.clubTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_url"];
    self.leagueTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_url"];
    
    self.zipCodeTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_zipcode"];
    self.fieldNameTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"field_name"];
    
    self.arrPickerItems4=[[NSArray alloc] initWithObjects:self.fieldNameTxt.text, nil];
    
      
    
    
     if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] componentsSeparatedByString:@","] objectAtIndex:0] length]>0 ) {
         
         self.fdashlab.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] componentsSeparatedByString:@","] objectAtIndex:0];

     }
    
     if ([[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] componentsSeparatedByString:@","] count]>1) {
         
          self.sdashlab.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] componentsSeparatedByString:@","] objectAtIndex:1];
     }
      
    self.genderTxt.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_gender"];
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] componentsSeparatedByString:@","] objectAtIndex:0] length]>0 ) {
        
        self.uniformColorTxt.text=[NSString stringWithFormat:@"%@ (Home)",[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] componentsSeparatedByString:@","] objectAtIndex:0]];
        if ([[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] componentsSeparatedByString:@","] count]>1) {
            self.teamColorText2.text=[NSString stringWithFormat:@"%@ (Away)",[[[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] componentsSeparatedByString:@","] objectAtIndex:1]];
        }
        

    }
      
    
    selRow1=0;
    selRow2=0;
    selRow3=0;
    selRow4=0;
    selRow5=0;
    selRow6=0;
    selRow7=0;
    selRow8=0;
    int i=0;
    for(NSString* str in pickerArr)
    {
        if([str isEqualToString:self.sportTxt.text])
            selRow1=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr2)
    {
        if([str isEqualToString:self.fdashlab.text])
            selRow2=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr3)
    {
        if([str isEqualToString:self.sdashlab.text])
            selRow3=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr4)
    {
        if([str isEqualToString:self.leagueTxt.text])
            selRow4=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr5)
    {
        if([str isEqualToString:self.clubTxt.text])
            selRow5=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr6)
    {
        if([str isEqualToString:self.genderTxt.text])
            selRow6=i;
        
        i++;
    }
    
    i=0;
    for(NSString* str in pickerArr7)
    {
        if([str isEqualToString:[[self.uniformColorTxt.text componentsSeparatedByString:@" "] objectAtIndex:0]])
            selRow7=i;
        
        i++;
    }
    
    for(NSString* str in pickerArr7)
    {
        if([str isEqualToString:[[self.teamColorText2.text componentsSeparatedByString:@" "] objectAtIndex:0]])
            selRow8=i;
        
        i++;
    }
    
    
    if(isLoadImage)
    {
        self.avatarimavw.image=self.originalImage;
        [self.avatarimavw applyPhotoFrame];

    }
    else
    {
        if( ! [[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_logo"] isEqualToString:@""])
        {
            
            ImageInfo *userImainfo= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_logo"] ]]];
            userImainfo.notifiedObject=nil;
            userImainfo.notificationName=TEAM_LOGO_NOTIFICATION;
            
            if(!userImainfo.isProcessing)
            [userImainfo getImage];
            [self.appDelegate.JSONDATAImages replaceObjectAtIndex:self.selectedTeamIndex withObject:userImainfo];
            [userImainfo release];
            
        }
        else
        {
            
            self.avatarimavw.image=[UIImage imageNamed:@"no_image.png"];
            [self.avatarimavw cleanPhotoFrame];

            
        }
    }
        
    self.clubTxt.enabled=FALSE;
    self.leagueTxt.enabled=FALSE;
    svos= self.teamScroll.contentSize;
    
    
    //ADDMIN One Info
    
    [self.addMin1Info replaceObjectAtIndex:0 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"]];
    [self.addMin1Info replaceObjectAtIndex:1 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"]];
    [self.addMin1Info replaceObjectAtIndex:2 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"]];
    //[self.addMin1Info replaceObjectAtIndex:2 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type"]];
    
    //ADDMIN  Two Info
    
    [self.addMin2Info replaceObjectAtIndex:0 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"]];
    [self.addMin2Info replaceObjectAtIndex:1 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email2"]];
    [self.addMin2Info replaceObjectAtIndex:2 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"]];
    //[self.addMin2Info replaceObjectAtIndex:2 withObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type2"]];
    
}

- (void)imageUpdated:(NSNotification *)notif
{
    
    
    ImageInfo *info=[notif object];
    self.avatarimavw.image=info.image;
    isLoadImage=1;
    self.originalImage=info.image;
    [self.avatarimavw applyPhotoFrame];
    
}

- (IBAction)playerDetails:(id)sender {
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SaveTeamViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }
    
    SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
    teamView.itemno=self.selectedTeamIndex;
    teamView.editMode=YES;
    teamView.isInvite=0;
    teamView.selectedTeamIndex=self.selectedTeamIndex;
    teamView.isTeamView=NO;
    [self.navigationController pushViewController:teamView animated:NO];
    
}

- (IBAction)teamDetailsTaped:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(IBAction)AddminTapp:(id)sender{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[TeamAdminVCViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }

    TeamAdminVCViewController *adminVC=[[TeamAdminVCViewController alloc] initWithNibName:@"TeamAdminVCViewController" bundle:nil];
    adminVC.selectedTeamIndex=self.selectedTeamIndex;
    [self.navigationController pushViewController:adminVC animated:NO];
    
    
}

-(void)spectorDetails:(id)sender{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SpectatorViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }
    
    SpectatorViewController *teamView=[[SpectatorViewController alloc]initWithNibName:@"SpectatorViewController" bundle:nil];
    //    teamView.itemno=self.selectedTeamIndex;
    //    teamView.editMode=YES;
    //    teamView.isInvite=0;
    //    teamView.selectedTeamIndex=self.selectedTeamIndex;
    //    teamView.isTeamView=NO;
    [self.navigationController pushViewController:teamView animated:NO];
}

- (IBAction)segmentValueChange:(id)sender {
    
    //UISegmentedControl *seg=(UISegmentedControl *)sender;
    //self.segmentCtrl.selectedSegmentIndex
    
    NSLog(@"Segment Details :%d",self.segmentCtrl.selectedSegmentIndex);
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentCtrl.selectedSegmentIndex adminCount:0 isAdmin:YES];
    
    
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        
        [self teamDetailsTaped:sender];
        
    }else if (segment.selectedSegmentIndex==1){
        
        [self playerDetails:sender];
        
    }else if (segment.selectedSegmentIndex==2){
          [self AddminTapp:sender];
    }
    else{
        [self spectorDetails:sender];
    }
}

- (void)tapRosterSegControl:(id)sender
{
    if(self.segmentCtrl.selectedSegmentIndex==1)
    {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SaveTeamViewController class]]) {
           
            return;
        }
    }
    }
    
    [self.segmentCtrl setSelectedSegmentIndex:1];
    NSLog(@"Segment RosterTeam :%d",self.segmentCtrl.selectedSegmentIndex);
}
- (void)tapAdminSegControl:(id)sender
{
    if(self.segmentCtrl.selectedSegmentIndex==2)
    {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[TeamAdminVCViewController class]]) {
            
            return;
        }
    }
    }
    
    [self.segmentCtrl setSelectedSegmentIndex:2];
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentCtrl.selectedSegmentIndex adminCount:0 isAdmin:YES];
    
    NSLog(@"Segment Details :%d",self.segmentCtrl.selectedSegmentIndex);
    
}
#pragma mark - PlayGround - 25/7/14 
-(void)showPlayField{
    
    DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
    
    [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
        
        if (upatedIndex<0) {
            selectedFiledIndex=0;
            self.fieldNameTxt.text=name;
        }else{
            selectedFiledIndex=upatedIndex;
            self.fieldNameTxt.text=[self.arrPickerItems4 objectAtIndex:selectedFiledIndex];
        }
        
        
    }];
    [appDelegate setTeamMaintenanceViewToUp];
    dropDown.tableDataArr=self.arrPickerItems4;
    dropDown.selectedIndex=selectedFiledIndex;
    dropDown.type=@"Field";
    if (self.selectedTeamIndex>=0)
        [self.appDelegate.centerViewController presentViewControllerForModal:dropDown];
    else
        [self presentViewController:dropDown animated:YES completion:nil];
    // [self.navigationController presentViewController:dropDown animated:YES completion:nil];

}


#pragma mark - Geocode
#pragma mark - GeoCode Address
- (void)geocodeAddress
{
    
     
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        __block CLLocationCoordinate2D myLocation;
        
        NSLog(@"respone %@",self.lastSelectedAddress);
        
        
        NSString *combineAddress=self.lastSelectedAddress;
        
        @autoreleasepool {
            
            
            combineAddress =[combineAddress stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" /&,-\""]];
            
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"\"" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@" " withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"-" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"," withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            
            
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"/" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"&" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
            
            
            [combineAddress retain];
        }
        NSLog(@"combine address %@",combineAddress);
        
        NSString *unescaped=[[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",combineAddress];
        
        [combineAddress release];
        NSURL* apiUrl = [[NSURL alloc] initWithString:unescaped];
        NSString *aResponse = [[NSString alloc] initWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"respone %@",aResponse);
        __block  NSError *error;
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            if (aResponse) {
                
                isLoadingLocations=0;
                @autoreleasepool {
                    
                    
                    NSMutableDictionary *jsonResponeDict= [NSJSONSerialization JSONObjectWithData: [aResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
                    
                    
                    
                    if([[jsonResponeDict objectForKey:@"status"] isEqualToString:@"OK"])
                    {
                        isLoadingLocations=0;
                        
                        for (int i=0; i<[[jsonResponeDict valueForKey:@"results"] count]; i++) {
                            
                            if ([[jsonResponeDict valueForKey:@"results"] objectAtIndex:i]){
                                myLocation.latitude=[[[[[[jsonResponeDict valueForKey:@"results"] objectAtIndex:i] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] doubleValue];
                                myLocation.longitude=[[[[[[jsonResponeDict valueForKey:@"results"]  objectAtIndex:i]valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] doubleValue];
                                
                            }
                            
                        }
                        ////////
                        
                        
                        CLLocation *location=[[CLLocation alloc] initWithLatitude:myLocation.latitude longitude:myLocation.longitude];
                        
                        if(![self.lastSelectedAddress isEqualToString:self.firstTimeDefaultCurrentAddress])
                        {
                            self.selectedLocation=location;
                            self.appDelegate.locationLatPlayground=location.coordinate.latitude;
                            self.appDelegate.locationLongPlayground=location.coordinate.longitude;
                            
                            /* NSLog(@"\"%@-%@-%@-%@\"", placemark.postalCode,placemark.name,placemark.country,[placemark addressDictionary]);
                             NSLog(@"%f %f", self.appDelegate.locationLatPlayground,self.appDelegate.locationLongPlayground);*/
                        }
                        [self showNativeHudView];
                        
                       
                        
                        
                        
                        selectedFiledIndex=0;

                        self.fieldNameTxt.placeholder=@"getting field name...";
                        self.fieldnameindicator.hidden=NO;
                        [self.fieldnameindicator startAnimating];
                        mode=1;

                        
                        [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
                        
                        
                    }
                    else
                    {
                        NSLog(@"error");
                        isLoadingLocations=0;
                        self.selectedLocation=nil;
                        self.appDelegate.locationLatPlayground=0.0;
                        self.appDelegate.locationLongPlayground=0.0;
                        NSString *message=LOCATIONNOTDETERMINEDERROR;
                        // [self showHudAlert:message];
                        // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                        [self showAlertMessage:message title:@""];
                        
                    }
                    ////////
                }
            }else{
                
                
                NSLog(@"error");
                isLoadingLocations=0;
                self.selectedLocation=nil;
                self.appDelegate.locationLatPlayground=0.0;
                self.appDelegate.locationLongPlayground=0.0;
                NSString *message=LOCATIONNOTDETERMINEDERROR;
                // [self showHudAlert:message];
                // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                [self showAlertMessage:message title:@""];
                
                
            }
            
            
            
            
            
        });
        
        
        
        
        
        
    });
    
    
    

}


-(void)hideHudViewHere
{
    [self hideHudView];
       
}


-(void)findLocation
{
    
    self.selectedLocation=appDelegate.currentLocation;
    self.appDelegate.locationLatPlayground=self.selectedLocation.coordinate.latitude;
    self.appDelegate.locationLongPlayground=self.selectedLocation.coordinate.longitude;
    
   // [self reverseGeocodeAddress];
}

- (void)reverseGeocodeAddress
{
  
    
    NSString *latstring=[[NSString alloc] initWithFormat:@"%.5lf",self.selectedLocation.coordinate.latitude];
    NSString *lonstring=[[NSString alloc] initWithFormat:@"%.5lf",self.selectedLocation.coordinate.longitude];
    
    
    
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString *urlStr= [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",latstring,lonstring];
        
        
        NSURL* apiUrl = [[NSURL alloc] initWithString:urlStr];
        NSString *aResponse = [[NSString alloc] initWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"respone %@",aResponse);
        __block  NSError *error;
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            if (aResponse)
            {
                @autoreleasepool {
                    
                    
                    NSMutableDictionary *jsonResponeDict= [NSJSONSerialization JSONObjectWithData: [aResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
                    
                    
                    if([[jsonResponeDict objectForKey:@"status"] isEqualToString:@"OK"])
                    {
                        
                        NSArray *results=[jsonResponeDict objectForKey:@"results"];
                        NSLog(@"resultsArray=%@",results);
                        
                        
                        if(results.count>0)
                        {
                            NSDictionary *dictionary = [results objectAtIndex:0];//[[placemarks objectAtIndex:0] addressDictionary];
                            
                            NSLog(@"addressDictionary=%@",dictionary);
                            
                            NSMutableString *locStr=[[NSMutableString alloc] initWithFormat:@"%@",[dictionary valueForKey:@"formatted_address"]];
                            
                            
                            
                            
                            self.firstTimeDefaultCurrentAddress=[[[locStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                           
                            self.lastSelectedAddress= [self.firstTimeDefaultCurrentAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                         
                            self.zipCodeTxt.text=self.lastSelectedAddress;
                            
                            [(UIButton*)[self.teamFirstView viewWithTag:4002]  setTitle:@"" forState:UIControlStateNormal];
                            
                            [self showNativeHudView];
                            
                            self.fieldnameindicator.hidden=NO;
                            [self.fieldnameindicator startAnimating];
                            mode=1;
                            [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
                            
                            [locStr release];

                            
                        }
                    }
                    else
                    {
                        NSLog(@"error");
                         self.zipCodeTxt.placeholder=@"Zip Code/City";
                        
                        self.selectedLocation=nil;
                        self.appDelegate.locationLatPlayground=0.0;
                        self.appDelegate.locationLongPlayground=0.0;
                        NSString *message=LOCATIONNOTDETERMINEDERROR;
                        
                        [self showAlertMessage:message title:@""];
                    }
                    
                }
                
            }
            else
            {
                NSLog(@"error");
                
                 self.zipCodeTxt.placeholder=@"Zip Code/City";
                
                self.selectedLocation=nil;
                self.appDelegate.locationLatPlayground=0.0;
                self.appDelegate.locationLongPlayground=0.0;
                NSString *message=LOCATIONNOTDETERMINEDERROR;
                
                [self showAlertMessage:message title:@""];
                
                
            }
            
            
            
            
        }
                );
        
        
        
        
        
        
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}



-(IBAction)DonePicker:(UIBarButtonItem*)sender
{
    
    if(pickerSelectTag==1)
    {
        selRow1=pickerSelect;
        self.sportTxt.text=[pickerArr objectAtIndex:selRow1];

    }
    else if(pickerSelectTag==2)
    {
        if (selRow3!=0) {
            if(([self.sdashlab.text integerValue]>=[[pickerArr2 objectAtIndex:pickerSelect] integerValue]) || [self.sdashlab.text isEqualToString:@"__"])
            {
                selRow2=pickerSelect;
                self.fdashlab.text=[pickerArr2 objectAtIndex:selRow2];
            }
            else
            {
              [ self showAlertMessage:@"Enter correct age range" title:@""];
            }

        }else{
            selRow2=pickerSelect;
            self.fdashlab.text=[pickerArr2 objectAtIndex:selRow2];
        }
    }
    else if(pickerSelectTag==3)
    {
         if(([[pickerArr3 objectAtIndex:pickerSelect] integerValue]>=[self.fdashlab.text integerValue])|| [self.fdashlab.text isEqualToString:@"__"])
        {
         selRow3=pickerSelect;
          self.sdashlab.text=[pickerArr3 objectAtIndex:selRow3];
        }
        else
        {
            [self showAlertMessage:@"Please enter correct age range" title:@""];
        }
    }
    else if(pickerSelectTag==4)
    {
        selRow4=pickerSelect;
         self.leagueTxt.text=[pickerArr4 objectAtIndex:selRow4];
    }
    else if(pickerSelectTag==5)
    {
         selRow5=pickerSelect;
         self.clubTxt.text=[pickerArr5 objectAtIndex:selRow5];
    }
    else if(pickerSelectTag==6)
    {
         selRow6=pickerSelect;
         self.genderTxt.text=[pickerArr6 objectAtIndex:selRow6];
    }
    else if(pickerSelectTag==7)
    {
        selRow7=pickerSelect;
        self.uniformColorTxt.text=[NSString stringWithFormat:@"%@ (Home)",[pickerArr7 objectAtIndex:selRow7]];

    }
    else if(pickerSelectTag==8)
    {
        selRow8=pickerSelect;
        self.teamColorText2.text=[NSString stringWithFormat:@"%@ (Away)",[pickerArr7 objectAtIndex:selRow8]];

    }

    else if (pickerSelectTag==4002){
        
        selectedFiledIndex=pickerSelect;
        self.fieldNameTxt.text=[self.arrPickerItems4 objectAtIndex:selectedFiledIndex];
    }
    self.pickerContainer.hidden=YES;
}

-(IBAction)ShowPicker:(int)tag
{
    self.pickerContainer.hidden=NO;
    [self.view bringSubviewToFront:self.pickerContainer];
    [self.picker reloadAllComponents];
    
    if(tag==1)
    {
        pickerSelect=selRow1;
    [self.picker selectRow:selRow1 inComponent:0 animated:NO];
    }
    else if(tag==2)
    {
        pickerSelect=selRow2;
     [self.picker selectRow:selRow2 inComponent:0 animated:NO];
    }
    else if(tag==3)
    {
         pickerSelect=selRow3;
        [self.picker selectRow:selRow3 inComponent:0 animated:NO];
    }
    else if(tag==4)
    {
         pickerSelect=selRow4;
        [self.picker selectRow:selRow4 inComponent:0 animated:NO];
    }
    else if(tag==5)
    {
         pickerSelect=selRow5;
        [self.picker selectRow:selRow5 inComponent:0 animated:NO];
    }
    else if(tag==6)
    {
         pickerSelect=selRow6;
        [self.picker selectRow:selRow6 inComponent:0 animated:NO];
    }
    else if(tag==7)
    {
         pickerSelect=selRow7;
        [self.picker selectRow:selRow7 inComponent:0 animated:NO];
    }
    else if(tag==8)
    {
        pickerSelect=selRow8;
        [self.picker selectRow:selRow8 inComponent:0 animated:NO];
    }
    else if (tag==4002){
        pickerSelect=selectedFiledIndex;
        [self.picker selectRow:selectedFiledIndex inComponent:0 animated:NO];
    }
    
    
    UITextField *tf=  (UITextField*)[self.teamFirstView viewWithTag:100];
    [tf resignFirstResponder];
    
    tf=  (UITextField*)[self.teamFirstView viewWithTag:1];
    [tf resignFirstResponder];
    
    tf=  (UITextField*)[self.teamFirstView viewWithTag:2];
    [tf resignFirstResponder];
    
    tf=  (UITextField*)[self.teamFirstView viewWithTag:3];
    [tf resignFirstResponder];
    
    tf=  (UITextField*)[self.teamFirstView viewWithTag:4];
    [tf resignFirstResponder];
    
    
    tf=  (UITextField*)[self.teamSecondView viewWithTag:5];
    [tf resignFirstResponder];
    tf=  (UITextField*)[self.teamSecondView viewWithTag:6];
    [tf resignFirstResponder];
    tf=  (UITextField*)[self.teamSecondView viewWithTag:7];
    [tf resignFirstResponder];
    
    
    tf=  (UITextField*)[self.teamThirdView viewWithTag:8];
    [tf resignFirstResponder];
    tf=  (UITextField*)[self.teamThirdView viewWithTag:9];
    [tf resignFirstResponder];
    tf=  (UITextField*)[self.teamThirdView viewWithTag:10];
    [tf resignFirstResponder];
    
    //self.teamScroll.contentSize=svos;
   // self.teamScroll.contentOffset=point;
}

#pragma mark - PickerDelegate

-(IBAction)HidePicker:(UIBarButtonItem*)sender
{
    self.pickerContainer.hidden=YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerSelect=row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(pickerSelectTag==1)
    {
       return [self.pickerArr count];
    }
    else if(pickerSelectTag==2)
    {
        return  [self.pickerArr2 count];
    }
    else if(pickerSelectTag==3)
    {
         return [self.pickerArr3 count];
    }
    else if(pickerSelectTag==4)
    {
         return [self.pickerArr4 count];
    }
    else if(pickerSelectTag==5)
    {
        return  [self.pickerArr5 count];
    }  else if(pickerSelectTag==6)
    {
        return  [self.pickerArr6 count];
    }
    else if(pickerSelectTag==7)
    {
       return [self.pickerArr7 count];
        
    } else if(pickerSelectTag==8)
    {
        return [self.pickerArr7 count];
        
    }else if (pickerSelectTag==4002){
        
        return [self.arrPickerItems4 count];
    }
    
    return 0;
    
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
//{
//    if(pickerSelectTag==1)
//    {
//       return [self.pickerArr objectAtIndex:row];
//    }
//    else if(pickerSelectTag==2)
//    {
//      return [self.pickerArr2 objectAtIndex:row];
//    }
//    else if(pickerSelectTag==3)
//    {
//      return [self.pickerArr3 objectAtIndex:row];
//    }
//    else if(pickerSelectTag==4)
//    {
//      return [self.pickerArr4 objectAtIndex:row];
//    }
//    else if(pickerSelectTag==5)
//    {
//      return [self.pickerArr5 objectAtIndex:row];
//    }  else if(pickerSelectTag==6)
//    {
//       return [self.pickerArr6 objectAtIndex:row];
//    }
//    else if(pickerSelectTag==7)
//    {
//       return [self.pickerArr7 objectAtIndex:row];
//    } else if(pickerSelectTag==8)
//    {
//        return [self.pickerArr7 objectAtIndex:row];
//    }
//    else if (pickerSelectTag==4002){
//        
//        return [self.arrPickerItems4 objectAtIndex:row];
//    }
//    return @"";
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    
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
    else if(pickerSelectTag==2)
    {
        
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            [flagView release];
                       
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr2 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

    }
    else if(pickerSelectTag == 3)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            [flagView release];
            
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr3 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

    }
    else if(pickerSelectTag == 4)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr4 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

    }
    else if(pickerSelectTag==5)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr5 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

    }  else if(pickerSelectTag==6)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr6 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

    }
    else if(pickerSelectTag==7)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr7 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

        
    } else if(pickerSelectTag==8)
    {
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.pickerArr7 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

        
    }else if (pickerSelectTag==4002){
        
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 0, 0)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [flagView release];
            [label release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[self.arrPickerItems4 objectAtIndex:row]];
        [(UIImageView *)(view.subviews)[1] setImage:nil];

        return view;

        
      
    }else{
        
        return nil;
    }
    
}



- (IBAction)cancelBtn:(id)sender
{
    if (isTapp==YES) {
        
        self.viewTransparentMsg.hidden=NO;
        self.viewDeleteMessage.hidden=NO;
        self.lblDeleteAlertMsg.text=@"You've made unsaved changes. Would you like to go back and save them?";
        isCancel=1;
        return;
    }
    if ([self.appDelegate.JSONDATAarr count]>0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
        
        self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineimasel;
        self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.themeCyanColor;
    }
    
}





#pragma mark - Send Team data To server



- (IBAction)addNewTeam:(UIButton*)sender {
    
     if (self.selectedTeamIndex>=0) {
         if ([sender.titleLabel.text isEqualToString:@"Edit Team"]) {
             
             //[self showHudView:@"Please update relevant fields"];
             self.viewTransparentMsg.hidden=NO;
             self.viewMessage.hidden=NO;
             self.btnCancl.hidden=YES;
             self.btnOk.hidden=YES;
             self.btnOkay.hidden=NO;
             self.lblAlertMessage.text=@"Please update relevant fields";
             //[self showHudAlert:@"Please update relevant fields"];
             [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
             
             //[self.addBtn setTitle:@"Update Team" forState:UIControlStateNormal];
               [self.editBtn setTitle:@"Update" forState:UIControlStateNormal];  //// 30/01/15
                self.teamFirstView.userInteractionEnabled=YES;
                for (UIImageView *imgVw in self.dropDownArroImage) {
                 
                 imgVw.hidden=NO;
                }
             
         }else{
             
             [self doneBtn:sender];
         }
         
         
     }else{
         
         [self doneBtn:sender];
         
     }
    
}


- (IBAction)doneBtn:(id)sender
{
//    if (mode==1) {
    
     //Validation Checkup//
        
        NSString* tmp=nil;
        
    
        NSString *errorstr=@"";
        
        tmp=[[self.teamNameTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            
            if(errorstr.length==0)
                errorstr=@"Enter Team Name";
            
        }
        
    tmp=[[self.sportTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([tmp  isEqualToString:@""] )
    {
        
        if(errorstr.length==0)
            errorstr=@"Enter Sports Name";
        
    }
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
           
        [self showAlertMessage:errorstr title:@""];
        return;
    }
        
    //Validation Checkup//   

    NSLog(@"creatorNameTxt - %@",self.creatorNameTxt.text);
        
    NSMutableDictionary *cludDict=[NSMutableDictionary dictionary];
        
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
        
    if (self.selectedTeamIndex>=0)  {
        
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
        
        //if(isSelectedImage==0 && (![self.avatarimavw.image isEqual:[UIImage imageNamed:@"no_image.png"]]))
           // [command setObject:@"Y" forKey:@"delete_logo"];
        //else
            [command setObject:@"N" forKey:@"delete_logo"];
        
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] forKey:@"coach_id"];


    }else{
        
        [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];

    }
    
    [command setObject:self.teamNameTxt.text forKey:@"team_name"];
    [command setObject:self.sportTxt.text forKey:@"team_sport"];
        
    [command setObject:self.cludId forKey:@"club_id"];
    [command setObject:self.leagueId forKey:@"league_id"];

    [command setObject:self.zipCodeTxt.text forKey:@"team_zipcode"];
    [command setObject:self.fieldNameTxt.text forKey:@"field_name"];
    [command setObject:[NSString stringWithFormat:@"%@,%@",self.fdashlab.text,self.sdashlab.text] forKey:@"age_group"];
        
    [command setObject:self.genderTxt.text forKey:@"team_gender"];
    [command setObject:[NSString stringWithFormat:@"%@,%@",[[self.uniformColorTxt.text componentsSeparatedByString:@" "] objectAtIndex:0],[[self.teamColorText2.text componentsSeparatedByString:@" "] objectAtIndex:0]] forKey:@"uniform_color"];
    [command setObject:[self.appDelegate.dateFormatM stringFromDate:[NSDate date]] forKey:@"adddate"];
    self.requestDic=command;
        
  
    //[cludDict setObject:self.clubNameTxt.text forKey:@"club"];
//    [cludDict setObject:self.leagueNameTxt.text forKey:@"league"];
//    [cludDict setObject:self.clubTxt.text forKey:@"club_url"];
//    [cludDict setObject:self.leagueTxt.text forKey:@"league_url"]; // on 3/12/14
    
    [cludDict setObject:@"" forKey:@"club"];
    [cludDict setObject:@"" forKey:@"league"];
    
    
    [cludDict setObject:@"" forKey:@"club_url"];
    [cludDict setObject:@"" forKey:@"league_url"];

    //ADDMIN One Info
    
    [command setObject:[self.addMin1Info objectAtIndex:0] forKey:@"creator_name"];
    [command setObject:[self.addMin1Info objectAtIndex:1] forKey:@"creator_email"];
    [command setObject:[self.addMin1Info objectAtIndex:2] forKey:@"creator_phno"];
    [command setObject:@"coach" forKey:@"type"];
    
    //ADDMIN  Two Info
    
    [command setObject:[self.addMin2Info objectAtIndex:0] forKey:@"creator_name2"];
    [command setObject:[self.addMin2Info objectAtIndex:1] forKey:@"creator_email2"];
    [command setObject:[self.addMin2Info objectAtIndex:2] forKey:@"creator_phno2"];
    [command setObject:[self.addMin2Info objectAtIndex:3] forKey:@"type2"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    NSString *jsonClub=[writer stringWithObject:cludDict];
    
    [writer release];
    
    self.cludLeageInfo=cludDict;

    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    if (self.selectedTeamIndex>=0)  {
       // [self hideNativeHudView];
//        [self showNativeHudView];
//        [self showHudAlert:@"Team details updated"];
        //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
    }
    mode=0;

    if (self.selectedTeamIndex>=0)  {

       // if(isSelectedImage==1)
            [appDelegate sendRequestFor:EDIT_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1",UIImageJPEGRepresentation(self.avatarimavw.image,0.1),@"team_logo", nil]];
//        else
//            [appDelegate sendRequestFor:EDIT_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1", nil]];
        
    }else {

        //if(isSelectedImage==1)
            
            [appDelegate sendRequestFor:ADD_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1",UIImageJPEGRepresentation(self.avatarimavw.image,0.1),@"team_logo", nil]];
//        else
//            [appDelegate sendRequestFor:ADD_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1",nil]];
        

        }
        

}


-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:ADD_TEAM])
        {
            
        }
        if (mode==2)
        {
            if([aR.requestSingleId isEqualToString:TEAM_LISTING])
            {
                
            }
        }

         if([aR.requestSingleId isEqualToString:FINDPLAYGROUND])
        {
            self.fieldNameTxt.placeholder=@"Field name";
            self.fieldnameindicator.hidden=YES;
            [self.fieldnameindicator stopAnimating];
            NSString *message=CONNFAILMSG;
            [self showHudAlert:message];
            [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }

        return;
    }
    
    
    NSString *str=(NSString*)aData;
    NSLog(@"JSONData=%@",str);
    
//    if (self.selectedTeamIndex>=0)  {
//        [self showHudAlert:@"Team details updated"];
//        [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
//    }
    
    if (mode==0){
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
        [parser release];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            NSString *message=[aDict objectForKey:@"message"];
            NSLog(@"%@",message);
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                //Subhasish..17th March
                //[self.editBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:154.0/255.0 blue:251.0/255.0 alpha:1] forState:UIControlStateNormal];
                
                if (self.selectedTeamIndex>=0){
                    
                    
                    
                    
                    int selectedWallIndex,wallFlag=0;
                    
                    for (int i=0; i<self.appDelegate.centerVC.dataArrayUpButtonsIds.count; i++) {
                        
                        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] isEqualToString:[self.appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:i]]) {
                            
                            wallFlag=1;
                            selectedWallIndex=i;
                            break;
                        }
                    }
                    
                    if (wallFlag) {
                        
                        NSLog(@"team sport %@",[self.requestDic objectForKey:@"team_name"]);
                        [self.appDelegate.centerVC.dataArrayUpButtons replaceObjectAtIndex:selectedWallIndex withObject:[self.requestDic objectForKey:@"team_name"]];
                        NSLog(@"team sport %@",[self.requestDic objectForKey:@"team_sport"]);
                        [self.appDelegate.centerVC.dataArrayUpTeamSports replaceObjectAtIndex:selectedWallIndex withObject:[self.requestDic objectForKey:@"team_sport"]];
                        [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpButtons ForKey:ARRAYNAMES];
                        [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTeamSports ForKey:ARRAYTEAMSPORTS];
                        
                    }

                 
                    
                    
                    
                    ////////////////////Edit Team
                    
//                    int flag=0;
//                    int i=0;
//                    
//                    for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
//                    {
//                        if([str isEqualToString: [NSString stringWithFormat:@"%@", [self.requestDic objectForKey:@"team_id"] ] ])
//                        {
//                            flag=1;
//                            
//                            
//                            break;
//                        }
//                        i++;
//                    }
//                    
//                    
//                    if(flag)
//                    {
//                        
//                        
//                        
//                        
//                        [appDelegate.centerVC.dataArrayUpButtons replaceObjectAtIndex:i withObject: [self.requestDic objectForKey:@"team_name"]];
//                        
//                        [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpButtons ForKey:ARRAYNAMES];
//                        
//                        [appDelegate.centerVC addTeamListing:[NSMutableArray array] :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]:[NSMutableArray array] ];
//                        [appDelegate.centerVC showParticularTeam:appDelegate.centerVC.lastSelectedTeam];
//                    }
                    
                    
                    ////////////////////
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"team_name"] forKey:@"team_name"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"team_sport"] forKey:@"team_sport"];
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[aDict valueForKey:@"club_id"] forKey:@"club_id"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[aDict valueForKey:@"league_id"] forKey:@"league_id"];
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[aDict valueForKey:@"club_creator_id"] forKey:@"club_creator_id"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[aDict valueForKey:@"league_creator_id"] forKey:@"league_creator_id"];
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.cludLeageInfo objectForKey:@"club"] forKey:@"club_name"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.cludLeageInfo objectForKey:@"league"] forKey:@"league_name"];
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.cludLeageInfo objectForKey:@"club_url"] forKey:@"club_url"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.cludLeageInfo objectForKey:@"league_url"] forKey:@"league_url"];
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"team_zipcode"] forKey:@"team_zipcode"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"field_name"] forKey:@"field_name"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"age_group"] forKey:@"age_group"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"team_gender"] forKey:@"team_gender"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"uniform_color"] forKey:@"uniform_color"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_name"] forKey:@"creator_name"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_email"] forKey:@"creator_email"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_phno"] forKey:@"creator_phno"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"type"] forKey:@"type"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_name2"] forKey:@"creator_name2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_email2"] forKey:@"creator_email2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"creator_phno2"] forKey:@"creator_phno2"];
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[self.requestDic objectForKey:@"type2"] forKey:@"type2"];
                    
                    self.requestDic=nil;
                    
                    [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:[aDict objectForKey:@"team_logo"] forKey:@"team_logo"];
                    
                    
                    if(![[aDict objectForKey:@"team_logo"] isEqualToString:@""])
                    {
                        self.originalImage=self.avatarimavw.image;
                        isLoadImage=1;
                        ImageInfo *imainfo = [self.appDelegate.JSONDATAImages objectAtIndex:self.selectedTeamIndex];
                        imainfo.sourceURL=[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_logo"] ]];
                        imainfo.image=self.originalImage;
                    }
                    else
                    {
                        
                        self.avatarimavw.image=[UIImage imageNamed:@"no_image.png"];
                        [self.avatarimavw cleanPhotoFrame];
                        self.originalImage=nil;
                        isLoadImage=0;
                        ImageInfo *imainfo = [self.appDelegate.JSONDATAImages objectAtIndex:self.selectedTeamIndex];
                        imainfo.sourceURL=[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_logo"] ]];
                        imainfo.image=self.originalImage;
                    }
                    
                    //[self.addBtn setTitle:@"Edit Team" forState:UIControlStateNormal];
                    [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
                    self.addBtn.hidden=YES;  //// 30/01/15
                    
                    self.teamFirstView.userInteractionEnabled=NO;
                    for (UIImageView *imgVw in self.dropDownArroImage) {
                        
                        imgVw.hidden=YES;
                    }
                    
                    
                    [self.teamVc createTeamScroll];
                   // [self.teamVc upBtappedNew:self.selectedTeamIndex];   /////// lets see
                    [self.navigationController popViewControllerAnimated:YES];

                }else{
                    
                    
                    NSMutableDictionary *teamCreatorDetails=[NSMutableDictionary dictionaryWithObjectsAndKeys:[self.requestDic valueForKey:@"creator_name"],@"creator_name",[self.requestDic valueForKey:@"creator_email"],@"creator_email",[self.requestDic valueForKey:@"creator_phno"],@"creator_phno", nil];
                    
                    [appDelegate.centerVC updateArrayByAddingOneTeam:[self.requestDic objectForKey:@"team_name"] :[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] :@"Accept" :[NSNumber numberWithInt:1] :[ NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ] :@"" :[NSMutableArray array]:teamCreatorDetails:[self.requestDic objectForKey:@"team_sport"]];
                    
                    self.addTeamId=[[aDict objectForKey:@"team_id"] intValue] ;
                    
                    [self updateTeamList];
                    
                    [self goToTimeLine:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nSay something to your team by posting comments, pictures or videos.",[self.requestDic objectForKey:@"team_name"] ]];
                }
                
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[aDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }
    else if(mode==1)
    {
        self.fieldNameTxt.placeholder=@"Field name";
        self.fieldnameindicator.hidden=YES;
        [self.fieldnameindicator stopAnimating];
        
        
        self.arrPickerItems4= appDelegate.arrItems;
        NSLog(@"Location=%@",self.arrPickerItems4);
       // self.view.userInteractionEnabled=YES;
        
        
        
        isLoadingLocations=0;
     

        
        if (self.isFieldTap==1) {
            self.isFieldTap=0;
            [self showPlayField];
        }

        
        
        
        
    }else if(mode==2){
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            [parser release];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                    
                self.appDelegate.JSONDATAarr=[NSMutableArray arrayWithArray:[[[aDict objectForKey:@"response"] objectForKey:@"users_team"] objectForKey:@"team_list"]];
                    
                NSLog(@"team list %@",self.appDelegate.JSONDATAarr);
                

                
                ////////////////////////////////////////
                    
                self.appDelegate.JSONDATAImages=[[[NSMutableArray alloc] init] autorelease];
                for(NSDictionary *dic in self.appDelegate.JSONDATAarr )
                {
                        ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]]];
                        [self.appDelegate.JSONDATAImages addObject:userImainfo];
                        [userImainfo release];
                        
                }
                    
                  
                    if (self.selectedTeamIndex== -1) {
                       
                        for (int i=0; i<self.appDelegate.JSONDATAarr.count; i++){
                            
                            NSLog(@"%@",[[self.appDelegate.JSONDATAarr objectAtIndex:i] valueForKey:@"team_id"]);
                            NSLog(@"%d",self.addTeamId);
                            
                            if([[[self.appDelegate.JSONDATAarr objectAtIndex:i] valueForKey:@"team_id"] intValue]==self.addTeamId){
                                
                                self.selectedTeamIndex=i;
                                break;
                                
                            }
                        }
                        if (self.isMyTeam==YES){
                            
                        }
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
                       // [appDelegate.centerViewController setTabBar:0 :5];
                        
                        self.newTeamIndex(self.selectedTeamIndex);

                    }else{
                        

                        
                    }
                
               
            }
        }
        
    }else if(mode==3){
        
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
     /////////////////////////////////////
                    
                    
                    NSString *teamId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"];
                    
                    
                    
                    for(NSString *str in self.appDelegate.centerVC.dataArrayUpButtonsIds)
                    {
                        if([str isEqualToString: teamId ])
                        {
                            
                            
                          
                                 [self.appDelegate.centerVC updateArrayByDeletingOneTeam:teamId];
                                 [self deleteAllEvents:teamId];
                            
                            break;
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                  
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
       ////////////////////////////////////
                    
                    
                    
                    [self.appDelegate.JSONDATAarr removeObjectAtIndex:self.selectedTeamIndex];
                    
                   
                    
                    if (self.appDelegate.JSONDATAarr.count>0) {
                        
                        [self.teamVc createTeamScroll];
                        
                        if (self.selectedTeamIndex==0) {
                            [self.teamVc upBtappedNew:self.selectedTeamIndex];
                        }else{
                            [self.teamVc upBtappedNew:self.selectedTeamIndex - 1];
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                      [self.teamVc createTeamScroll];
                        
                        
                        
                      [self.navigationController popViewControllerAnimated:YES];
                    
                    }
                    
                    
                    
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Operation failed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }

    }


}


-(void)updateTeamList{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"1" forKey:@"case"];

    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [writer release];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
     mode=2;
    [appDelegate sendRequestFor:TEAM_LISTING from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}




-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.superview.superview.frame.origin.y+theView.superview.frame.origin.y+theView.center.y;
    
    CGFloat fsh=af.size.height;
    CGFloat sa=0.0;
    if(isiPhone5)
        sa=vcy-fsh/5.5;   //sa=vcy-fsh/3.2;
    else
        sa=vcy-fsh/6.5;
    
    if(sa<0)
        sa=0;
    
    self.teamScroll.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    NSLog(@"%f-%f-%f,%f",self.teamScroll.contentSize.height,af.size.height,kb.size.height,sa);
    [ self.teamScroll setContentOffset:CGPointMake(0,sa) animated:YES];
}


#pragma mark - DeleteTeam

- (IBAction)deleteteam:(id)sender {
    
    
    //if (self.selectedTeamIndex>=0) {
    if ([self.editBtn.titleLabel.text isEqualToString:@"Edit"]) {
        
        //UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Do want to delete the team?",nil];
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit",@"Delete",nil];
        action.tag=1002;
        
        //action.backgroundColor = [UIColor lightGrayColor];
        
        
        [action showInView:appDelegate.centerViewController.view];
    }
    else{
        
        self.viewTransparentMsg.hidden=NO;
        self.viewMessage.hidden=NO;
        self.btnCancl.hidden=NO;
        self.btnOk.hidden=NO;
        self.btnOkay.hidden=YES;
        self.lblAlertMessage.text=@"Do you want to save changes";
        //[self showHudAlert:@"Please update relevant fields"];
        //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        
        
        
    }
}


#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
   if (actionSheet.tag==1002){
       
        if (buttonIndex==0) {
            if (self.selectedTeamIndex>=0) {
                if ([self.editBtn.titleLabel.text isEqualToString:@"Edit"]) {
                    
                    //[self showHudView:@"Please update relevant fields"];
                    self.viewTransparentMsg.hidden=NO;
                    self.viewMessage.hidden=NO;
                    self.btnCancl.hidden=YES;
                    self.btnOk.hidden=YES;
                    self.btnOkay.hidden=NO;
                    self.lblAlertMessage.text=@"Please update relevant fields";
                    //[self showHudAlert:@"Please update relevant fields"];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    //[self.addBtn setTitle:@"Update Team" forState:UIControlStateNormal];
                    self.teamFirstView.userInteractionEnabled=YES;
                    for (UIImageView *imgVw in self.dropDownArroImage) {
                        
                        imgVw.hidden=NO;
                    }
                    
                }
//                else{
//                    
//                    [self doneBtn:self.editBtn];
//                }
                
                
            }
        }
        else if (buttonIndex==1) {
            
            self.viewTransparentMsg.hidden=NO;
            self.viewDeleteMessage.hidden=NO;
            self.lblDeleteAlertMsg.text= @"Are you sure you want to delete the team?";// @"Do want to delete the team?";
            
          /*
            mode=3;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            
            [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            
            [appDelegate sendRequestFor:DELETE_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];  */

        }
    
   }
}





#pragma mark - TExtFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag==505)
    {
        
        if(self.zipCodeTxt.text && (![self.zipCodeTxt.text isEqualToString:@""]))
        {
            
            [self.zipCodeTxt becomeFirstResponder];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Home field address can not blank" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
     if (self.selectedTeamIndex < 0) {
         [self disableSlidingAndHideTopBar];
     }
    point=self.teamScroll.contentOffset;
    
    if (textField.tag>=1000){
        [self moveScrollView:[[[textField superview] superview] superview]];

    }else{
        [self moveScrollView:textField];

    }
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    isTapp=YES;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
      if(textField.tag!=4)
      {
      if ([textField.text isEqualToString:@""])
      {
        return;
       }
      }
    else if(textField.tag==4)
    {
        
        if(textField.text && (![textField.text isEqualToString:@""]))
        {
            
            self.lastSelectedAddress=textField.text;
            [(UIButton*)[self.teamFirstView viewWithTag:4002]  setTitle:@"" forState:UIControlStateNormal];
            self.arrPickerItems4=[[NSMutableArray alloc] init];
            isLoadingLocations=1;
            [self geocodeAddress];
        }
        else
        {
            self.arrPickerItems4=[[NSMutableArray alloc] init];
             [(UIButton*)[self.teamFirstView viewWithTag:4002]  setTitle:@"" forState:UIControlStateNormal];
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
    
     if (self.selectedTeamIndex < 0) {
         [self enableSlidingAndShowTopBar];
     }

    self.teamScroll.contentSize=svos;
    self.teamScroll.contentOffset=CGPointMake(0, 0);
    
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    
    if (theTextField.tag==4) {
        
        if (theTextField.text.length==0) {
            
            self.fieldNameTxt.text=@"";
            
        }
    }
    int tag=[theTextField tag];
    
    //|| tag==2 || tag==3
    if (tag==100 ) {
        
        if (theTextField.text.length<=20) {
            return YES;
        }else{
            return NO;
        }
        
    }
        
    NSCharacterSet *myCharSet;
    
    
    if(tag==8|tag==7|tag==1)
    {
        myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
    }
    
    if (tag==1002 || tag==2002) {
        
        NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:VALIDPHONENUMBER] invertedSet];
        NSString *filterString=[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filterString];
    }
    
    return YES;


}
#pragma mark - UploadPhoto


- (IBAction)uploadPhoto:(id)sender
{
    isTapp=YES;
    
    if (self.selectedTeamIndex>=0) {
        
        self.isModallyPresentFromCenterVC=1;
        self.isShowActionSheetFromSelf=0;

    }else{
        self.isModallyPresentFromCenterVC=0;
        self.isShowActionSheetFromSelf=1;

    }
    [self takeImage];
}

- (IBAction)crosstapped:(id)sender
{
   
    isSelectedImage=0;
    self.avatarimavw.image=[UIImage imageNamed:@"no_image.png"];
}

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
       isSelectedImage=1;
    
    
    if([info objectForKey:UIImagePickerControllerEditedImage])
        
        self.avatarimavw.image=[info objectForKey:UIImagePickerControllerEditedImage];
    else
        self.avatarimavw.image=[info objectForKey:UIImagePickerControllerOriginalImage];
  
    [self.avatarimavw applyPhotoFrame];
    
      if (self.selectedTeamIndex>=0) {
          
          isUpdateTeamLogo=1;
          
      }
    [self dismissModal];
     
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker1
{
   
    [super imagePickerControllerDidCancel:picker1];
    [appDelegate setHomeView];
}


-(void)resignAllTextFields
{
     [self.zipCodeTxt resignFirstResponder];
}

- (IBAction)dropdownTapped:(id)sender
{
    isTapp=YES;
    [self resignAllTextFields];
    
    
    pickerSelectTag=[sender tag];
    
    if (pickerSelectTag==5 || pickerSelectTag==4) {
        
        if (self.selectedTeamIndex>=0) {
            
            
            if ([sender tag]==4) {
                
                if (![[self.appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_creator_id"]]) {
                    
                    
                    ClubViewController *club=[[ClubViewController alloc] initWithNibName:@"ClubViewController" bundle:nil];
                    
                    [club setLeaguge:^(NSString *selected,NSString *url,NSString *iD){
                        
                        
                        self.leagueTxt.text=url;
                        self.leagueNameTxt.text=selected;
                        self.leagueId=iD;
                        
                        if ([self.leagueId isEqualToString:@""]) {
                            
                            self.leagueTxt.enabled=TRUE;
                            [self.leagueTxt becomeFirstResponder];
                            
                        }else{
                            
                            self.leagueTxt.enabled=FALSE;
                        }
                        
                        
                        
                        
                    }];
                   
                    
                    club.selectedtag=[sender tag];
                    
                    if (self.selectedTeamIndex>=0)
                        [self.appDelegate.centerViewController presentViewControllerForModal:club];
                    else
                        [self presentViewController:club animated:YES completion:nil];

                    [club release];
                    
                }else{
                    
                    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Update",@"Add New One",nil]autorelease];
                    actionSheet.tag=[sender tag];
                    [actionSheet  showInView:self.view];
                    
                }
                
                
            }
            
            if ([sender tag]==5){
                
                if (![[self.appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_creator_id"]]) {
                    
                    ClubViewController *club=[[ClubViewController alloc] initWithNibName:@"ClubViewController" bundle:nil];
                    
                    [club setLeaguge:^(NSString *selected,NSString *url,NSString *iD){
                        
                        self.clubTxt.text=url;
                        self.clubNameTxt.text=selected;
                        self.cludId=iD;
                        if ([self.cludId isEqualToString:@""]) {
                            
                            self.clubTxt.enabled=TRUE;
                            [self.clubTxt becomeFirstResponder];
                            
                        }else{
                            self.clubTxt.enabled=FALSE;
                        }
                        
                    }];
                    
                    club.selectedtag=[sender tag];
                    if (self.selectedTeamIndex>=0)
                        [self.appDelegate.centerViewController presentViewControllerForModal:club];
                    else
                        [self presentViewController:club animated:YES completion:nil];

                    [club release];
                    
                }else{
                    
                    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Update",@"Add New One",nil]autorelease];
                    actionSheet.tag=[sender tag];
                    [actionSheet  showInView:self.view];
                    
                    
                }
                
            }
            
        }else{
            
            ClubViewController *club=[[ClubViewController alloc] initWithNibName:@"ClubViewController" bundle:nil];
            
            
            [club setLeaguge:^(NSString *selected,NSString *url,NSString *iD){
                
                if (pickerSelectTag==4){
                    
                    self.leagueTxt.text=url;
                    self.leagueNameTxt.text=selected;
                    self.leagueId=iD;
                    
                    if ([self.leagueId isEqualToString:@""]) {
                        
                        self.leagueTxt.enabled=TRUE;
                    }else{
                        self.leagueTxt.enabled=FALSE;
                    }
                    
                    
                }else{
                    
                    self.clubTxt.text=url;
                    self.clubNameTxt.text=selected;
                    self.cludId=iD;
                    if ([self.cludId isEqualToString:@""]) {
                        
                        self.clubTxt.enabled=TRUE;
                        
                    }else{
                        self.clubTxt.enabled=FALSE;
                        
                    }
                }
                
            }];
            
            club.selectedtag=pickerSelectTag;
            
            if (self.selectedTeamIndex>=0)
                [self.appDelegate.centerViewController presentViewControllerForModal:club];
            else
                [self presentViewController:club animated:YES completion:nil];
            [club release];
 
        }
               
    }else if (pickerSelectTag==4002){
        
        NSLog(@"%@",self.zipCodeTxt.text);
       /* if([self.zipCodeTxt.text isEqualToString:@""] || self.zipCodeTxt.text.length<=0)
        {
            
            [self.zipCodeTxt becomeFirstResponder];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Home field address can not blank" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
       self.lastSelectedAddress=self.zipCodeTxt.text;
        
        [self geocodeAddress];*/
        self.isFieldTap=1;
        
           ////////  25/7/14   //////
        
        if(self.arrPickerItems4.count>0)
        {
            DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
            
            [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
                
                if (upatedIndex<0) {
                    selectedFiledIndex=0;
                    self.fieldNameTxt.text=name;
                }else{
                    selectedFiledIndex=upatedIndex;
                    self.fieldNameTxt.text=[self.arrPickerItems4 objectAtIndex:selectedFiledIndex];
                }
                
                
            }];
            [appDelegate setTeamMaintenanceViewToUp];
            dropDown.tableDataArr=self.arrPickerItems4;
            dropDown.selectedIndex=selectedFiledIndex;
            dropDown.type=@"Field";
            if (self.selectedTeamIndex>=0)
                [self.appDelegate.centerViewController presentViewControllerForModal:dropDown];
            else
                [self presentViewController:dropDown animated:YES completion:nil];
            // [self.navigationController presentViewController:dropDown animated:YES completion:nil];
            

        }
        else
        {
            if(!isLoadingLocations)
                [self showAlertMessage:@"Please Choose another Zip or City or retry later."];
        }

        
        
    }else if(pickerSelectTag==1){
       
        CustomSportViewController *dropDown=[[CustomSportViewController alloc] initWithNibName:@"CustomSportViewController" bundle:nil];
        
        [dropDown setCustomSport:^(int upatedIndex,NSString *name){
            
            if (upatedIndex<0) {
                selRow1=0;
                self.sportTxt.text=name;
            }else{
                selRow1=upatedIndex;
                self.sportTxt.text=[self.pickerArr objectAtIndex:selRow1];
            }
            
            
        }];
        [appDelegate setTeamMaintenanceViewToUp];
        dropDown.tableDataArr=self.pickerArr;
        dropDown.sportsImageArr=self.sportsImageArr;
        dropDown.selectedIndex=selRow1;
        
        if (self.selectedTeamIndex>=0)
            [self.appDelegate.centerViewController presentViewControllerForModal:dropDown];
        else
            [self presentViewController:dropDown animated:YES completion:nil];

 
    }
    else if (pickerSelectTag ==7)
    {
        
        DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
        
        [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
            
            if (upatedIndex<0)
            {
                selRow7=0;
                self.uniformColorTxt.text=[NSString stringWithFormat:@"%@ (Home)",name];
                
            }
            else
            {
                selRow7=upatedIndex;
                self.uniformColorTxt.text=[NSString stringWithFormat:@"%@ (Home)",[pickerArr7 objectAtIndex:selRow7]];
            }
            
            
        }];
        [appDelegate setTeamMaintenanceViewToUp];
        dropDown.tableDataArr=self.pickerArr7;
        dropDown.selectedIndex=selRow7;
        dropDown.type=@"Color";

        if (self.selectedTeamIndex>=0)
            [self.appDelegate.centerViewController presentViewControllerForModal:dropDown];
        else
            [self presentViewController:dropDown animated:YES completion:nil];
  
    }
    else if (pickerSelectTag==8)
    {
        DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
        
        [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
            
            if (upatedIndex<0)
            {
                selRow8=0;
                self.teamColorText2.text=[NSString stringWithFormat:@"%@ (Away)",name];

            }
            else
            {
                selRow8=upatedIndex;
                self.teamColorText2.text=[NSString stringWithFormat:@"%@ (Away)",[pickerArr7 objectAtIndex:selRow8]];
            }
            
            
        }];
        [appDelegate setTeamMaintenanceViewToUp];
        dropDown.tableDataArr=self.pickerArr7;
        dropDown.selectedIndex=selRow8;
        dropDown.type=@"Color";

        if (self.selectedTeamIndex>=0)
            [self.appDelegate.centerViewController presentViewControllerForModal:dropDown];
        else
            [self presentViewController:dropDown animated:YES completion:nil];
 
    }
    else
    {
        [self ShowPicker:pickerSelectTag];
    }
       
    
}


#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Ad Banner action is about to begin.");
    
    //self.pauseTimeCounting = YES;
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"Ad Banner action did finish");
    
    // self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}


- (IBAction)alertMessageDone:(UIButton *)sender {
    self.viewTransparentMsg.hidden=YES;
    self.viewMessage.hidden=YES;
    if (sender.tag==1) {
        return;
    }
    
    if ([self.editBtn.titleLabel.text isEqualToString:@"Update"])
        [self doneBtn:self.editBtn];
    if ([self.editBtn.titleLabel.text isEqualToString:@"Edit"]){
        [self.editBtn setTitle:@"Update" forState:UIControlStateNormal];  //// 30/01/15
        //Subhasish..17th March
        [self.editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }

}
- (IBAction)deleteAlertMessageDone:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    
    if (isCancel==1) {
        if (btn.tag==0) {
            if ([self.appDelegate.JSONDATAarr count]>0)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
                
                self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineimasel;
                self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.themeCyanColor;
            }
        }
        isCancel=0;
        
    }
    else{
        
        if (btn.tag==1) {
            mode=3;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            
            [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            
            [appDelegate sendRequestFor:DELETE_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
    }
    
    self.viewTransparentMsg.hidden=YES;
    self.viewDeleteMessage.hidden=YES;
}
@end
