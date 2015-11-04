//
//  EventEditViewController.m
//  Social
//
//  Created by Sukhamoy Hazra on 06/09/13.
//
//
#import "DropDownViewController.h"
#import "HomeVC.h"
#import "TeamEventsVC.h"
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
#import "EventDetailsViewController.h"
#import "EventEditViewController.h"
#import "Event.h"
#import "CenterViewController.h"
#import "SaveTeamViewController.h"
@interface EventEditViewController ()

@property (strong, nonatomic) Event *createEvent;


@end

@implementation EventEditViewController
@synthesize view1,view2,view3,view4,scrollView,keyboardToolbar,keyboardToolbarView,mode,buttonMode,arrPickerItems1,arrPickerItems2,arrPickerItems3,eventDate,startDate,endDate,arrivalDate,arrPickerItems4,arrPickerItems5,isEditMode,dataEvent,secondtopview,selectedRow5,arrPickerItems6Dic,arrPickerItems6,selectedLocation,geocoder,lastSelectedAddress,pickerArr7,selRow7,firstTimeDefaultCurrentAddress,dateformatdbString,teamFieldName,teamLocation,teamUniformColor,currbodytext,alertViewForSubmit,defaultDate,isEditFirstTime,yesredima,noredima,yesgreyima,nogreyima,arrPickerItems8,selectedRow8,isFindPlaygroundProcess,arrPickerItems10,selectedRow10,loadStatusReturn,isLoadingLocations;

@synthesize isFieldTap,createEvent;  /// 24/7/14
BOOL keyboardIsShown;

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
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
   // self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.topBarFromTeamAdmin.backgroundColor=appDelegate.barGrayColor;

    self.isTapp=NO;
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneClicked)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexible,doneButton, nil]];
    self.notestxtvw.inputAccessoryView = keyboardDoneButtonView;
    
    
    storeCreatedRequests=[[NSMutableArray alloc] init];
    
    @autoreleasepool
    {
        
        self.yesgreyima=[UIImage imageNamed:@"yes_grey.png"];
          self.yesredima=[UIImage imageNamed:@"yes_red.png"];
          self.nogreyima=[UIImage imageNamed:@"no_grey.png"];
          self.noredima=[UIImage imageNamed:@"no_red.png"];
        
        
        [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [(UITextField*)[self.view6 viewWithTag:5] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [(UITextField*)[self.view1 viewWithTag:1] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        
    
    if([self.defaultDate compare:[NSDate date]]==NSOrderedAscending)
    {
        self.defaultDate=[NSDate date];
        
     
    }
        //self.arrPickerItems5=[[NSArray alloc] init];//[NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Private",@"team_name",@"Private",@"team_id", nil] ];//Add Latest Ch
    }
    self.eventDate=self.defaultDate;
    self.alertViewForSubmit=[[UIAlertView alloc] initWithTitle:@"" message:@"This will send an invite to players." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    
    
   /* self.dateformatdbString=*/
    NSDateFormatter *dtFormat=[[NSDateFormatter alloc ] init];
    [dtFormat setDateFormat:@"EEEE, dd MMM, yyyy"];
    [((UIButton*)[self.view1 viewWithTag:21]) setTitle:[dtFormat stringFromDate:self.eventDate] forState:UIControlStateNormal];
    //[((UIButton*)[self.view1 viewWithTag:21]) setTitle:[self.appDelegate.dateFormatEvent stringFromDate:self.eventDate] forState:UIControlStateNormal];
     self.dateformatdbString= [self.appDelegate.dateFormatDb stringFromDate:self.eventDate];
    
  //  [appDelegate getNewUpdate];
    
    
    self.fieldnameindicator.hidden=YES;
    self.teamnameindicator.hidden=YES;
    self.selectedRow=0;
     self.selectedRow1=0;
     self.selectedRow2=0;
     self.selectedRow3=0;
     self.selectedRow4=0;
    self.selectedRow5=0;
    self.selectedRow8=0;
    //self.selectedRow10=1;
   
    
    self.arrPickerItems10=[NSMutableArray arrayWithObjects:@"Yes",@"No", nil];
    
      self.arrPickerItems8=[NSMutableArray arrayWithObjects:@"Practice",@"Game",@"Tournament", nil];
    self.arrPickerItems1=[NSArray arrayWithObjects:@"Game",@"Practice", nil];
    self.arrPickerItems2=self.arrPickerItemsRepeat;//[NSArray arrayWithObjects:@"Never",@"Every Day",@"Every Week",@"Every Month",@"Every Year", nil];
    self.arrPickerItems3=self.arrPickerItemsAlert;//[NSArray arrayWithObjects:@"At time of event",@"5 mintues before",@"15 mintues before",@"30 mintues before",@"1 hour before",@"2 hours before",@"1 day before",@"2 days before", nil];
      self.pickerArr7=[NSMutableArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Yellow",@"White",@"Black",@"Gray", nil];
    self.arrPickerItems4=[NSArray array];
    
    //////////////////////Add Latest Ch
    if(mode==0)
    {
    [(UIButton*)[self.view1 viewWithTag:31]  setTitle:@"Private" forState:UIControlStateNormal];
        
        
        UIButton *bt= (UIButton*)[self.view1 viewWithTag:31];
        
        bt.enabled=NO;
        
        UITextField *bt1= (UITextField*)[self.view1 viewWithTag:101];
        
        bt1.enabled=NO;
    }
    else
    {
        CGRect f= self.segyesno.frame;
        
        f.origin.y+=5;
        f.size.height-=8;
        f.size.width-=15;
        
    }
    ///////////////////////
    
    
     // mode=1;//Add Latest Ch
    
    
    
    if(self.arrPickerItems5.count==1)
    {
        [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_name"] forState:UIControlStateNormal ];
        [self setSingleTeam];
    }
    
    self.selectedRow4=0;
    /*if(isEditMode)
    {
        
        
        
    }*/

    
    
    
    
    
    
    isEditFirstTime=0;
    if(isEditMode)
    {
        self.secondtopview.hidden=YES;
        self.tobbarlab.text=@"Edit Event";
        self.btnAddCancel.hidden=YES;
        
        
        isEditFirstTime=1;
        
    if([dataEvent.isPublic boolValue])
    mode=1;
    else  
    mode=0;
        
        [(UITextField*)[self.view1 viewWithTag:1] setText:dataEvent.eventName];
        [(UIButton*)[self.view1 viewWithTag:20] setTitle:dataEvent.eventType   forState:UIControlStateNormal];
        
        NSDateFormatter *dtFormat=[[NSDateFormatter alloc ] init];
        [dtFormat setDateFormat:@"EEEE, dd MMM, yyyy"];
        [(UIButton*)[self.view1 viewWithTag:21] setTitle:[dtFormat stringFromDate:dataEvent.eventDate] forState:UIControlStateNormal];
        //[(UIButton*)[self.view1 viewWithTag:21] setTitle:[self.appDelegate.dateFormatEvent stringFromDate:dataEvent.eventDate] forState:UIControlStateNormal];
        self.dateformatdbString=[self.appDelegate.dateFormatDb stringFromDate:dataEvent.eventDate];
        
        
        //if(mode)
        //ch[(UIButton*)[self.view1 viewWithTag:29] setTitle:dataEvent.fieldName forState:UIControlStateNormal];
            [(UITextField*)[self.view6 viewWithTag:4] setText:dataEvent.fieldName ];
        [(UITextField*)[self.view6 viewWithTag:5] setText:dataEvent.location];
          [(UIButton*)[self.view2 viewWithTag:22] setTitle:dataEvent.repeat forState:UIControlStateNormal];
        
       
        
          [(UITextField*)[self.view2 viewWithTag:7] setText:[self.appDelegate.dateFormatM stringFromDate:dataEvent.arrivalTime] ];
        [(UITextField*)[self.view2 viewWithTag:8] setText:[self.appDelegate.dateFormatM stringFromDate:dataEvent.startTime] ];
        [(UITextField*)[self.view2 viewWithTag:9] setText:[self.appDelegate.dateFormatM stringFromDate:dataEvent.endTime] ];
        
        self.notestxtvw.text=dataEvent.notes;
        
        if(  dataEvent.isPublic.boolValue)
        {
            self.segpripub.selectedSegmentIndex=1;
        }
        else
        {
            self.segpripub.selectedSegmentIndex=0;
        }
        
        if(  dataEvent.isHomeGame.boolValue)
        {
            self.segyesno.selectedSegmentIndex=0;
            
            ///////
            
            [self setYesNoBtn:0];
            //////
        }
        else
        {
            self.segyesno.selectedSegmentIndex=1;
            
            ///////
            
            [self setYesNoBtn:1];
            //////
        }
        
        
       /* if(mode)*/
        //{
        
        NSLog(@"%@",dataEvent.uniformColor);
        if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
            [(UITextField*)[self.view3 viewWithTag:10] setText:dataEvent.uniformColor];
            
       int m1=0;
            
            for(NSString *str in pickerArr7)
            {
                if([str isEqualToString:dataEvent.uniformColor])
                {
                    self.selRow7=m1;
                    
                    NSLog(@"%i",self.selRow7);
                    break;
                }
                
                m1++;
            }
            
            
            
         
            [(UITextField*)[self.view3 viewWithTag:12] setText:dataEvent.thingsToBring];
       // }
        
          [(UIButton*)[self.view2 viewWithTag:26] setTitle:dataEvent.alertString forState:UIControlStateNormal];
        
        
        
        self.arrivalDate=dataEvent.arrivalTime;
        self.startDate=dataEvent.startTime;
        self.endDate=dataEvent.endTime;
        self.eventDate=dataEvent.eventDate;
        self.defaultDate=self.eventDate;
        
        int m=0;
        
        
        for(NSString *str in arrPickerItems1)
        {
            if([str isEqualToString:dataEvent.eventType])
            {
                self.selectedRow=m;
                break;
            }
            
            m++;
        }
        
        m=0;
        
        for(NSString *str in arrPickerItems2)
        {
            if([str isEqualToString:dataEvent.repeat])
            {
                self.selectedRow1=m;
                break;
            }
            
            m++;
        }
        
        m=0;
        
        for(NSString *str in arrPickerItems3)
        {
            if([str isEqualToString:dataEvent.alertString])
            {
                self.selectedRow2=m;
                break;
            }
            
            m++;
        }
        
       
            
            
             m=0;
            
            
            for(NSDictionary *str in arrPickerItems5)
            {
                if([[str  objectForKey:@"team_name"] isEqualToString:dataEvent.teamName])
                {
                    [(UIButton*)[self.view1 viewWithTag:31]  setTitle:[str  objectForKey:@"team_name"] forState:UIControlStateNormal];
                    self.selectedRow4=m;
                    break;
                }
                
                m++;
            }
            m=0;
        
        
        
            
        
        
        /*for(NSString *str in arrPickerItems4)
        {
            if([str isEqualToString:dataEvent.fieldName])
            {
                self.selectedRow3=m;
                break;
            }
            
            m++;
        }
        
        m=0;*/
        if(dataEvent.location)
        {
        self.lastSelectedAddress=dataEvent.location;
              isLoadingLocations=1;
              [self geocodeAddress];
         
        }
    }
    else
    {
        self.btnCancel.hidden=YES;
        self.btnUpdate.hidden=YES;
        self.donepbt.hidden = NO;
         [appDelegate createLocationManager];
    }
      
    if(mode)//Add Latest Ch
    [self getTaemListing];
    
    
    
   // [self getAllTaemListing];
    
    
   // [self.view1.layer setCornerRadius:8.0f];
    //[self.view1.layer setMasksToBounds:YES];
   // [self.view2.layer setCornerRadius:8.0f];
    //[self.view2.layer setMasksToBounds:YES];
  //  [self.view3.layer setCornerRadius:8.0f];
    //[self.view3.layer setMasksToBounds:YES];
   // [self.view4.layer setCornerRadius:8.0f];
    //[self.view4.layer setMasksToBounds:YES];
   //   [self.view5.layer setCornerRadius:8.0f];
  //   [self.view6.layer setCornerRadius:8.0f];
    
    if(keyboardToolbar == nil && keyboardToolbarView==nil)
    {
        keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 412, 320, 44)];
        
        if(appDelegate.isIos7)
        keyboardToolbarView.backgroundColor=[UIColor clearColor];
        else
        keyboardToolbarView.backgroundColor=[UIColor blackColor];
        keyboardToolbarView.alpha=0.8;
        
		keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        
        
        if(!appDelegate.isIos7)
		keyboardToolbar.barStyle = UIBarStyleBlackOpaque;
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        cancel.tag=0;
        
        UIBarButtonItem *fspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *done =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        done.tintColor=[UIColor blueColor];
        done.tag=1;
        
        NSArray *items = [[NSArray alloc] initWithObjects:cancel,fspace ,done, nil];
        [keyboardToolbar setItems:items];
        [keyboardToolbar setAlpha:1.0];
        
        
        [keyboardToolbarView addSubview:keyboardToolbar];
	}

   /* self.view1.frame=CGRectMake(12, 5, self.view1.frame.size.width, self.view1.frame.size.height);
     self.view2.frame=CGRectMake(12, 190, self.view1.frame.size.width, self.view1.frame.size.height);
     self.view3.frame=CGRectMake(12, 285, self.view1.frame.size.width, self.view1.frame.size.height);
     self.view4.frame=CGRectMake(12, 380, self.view1.frame.size.width, self.view1.frame.size.height);
     self.scrollView. contentSize=CGSizeMake(320,420);*/
    [self showViewMode:mode];
    
    
    self.view1.frame=CGRectMake(0, 0, self.view1.frame.size.width,self.view1.frame.size.height);
    
    if(mode)
    {
        if (self.isiPad) {
            self.view6.frame=CGRectMake(0, 750, self.view6.frame.size.width, self.view6.frame.size.height);
            
            self.view2.frame=CGRectMake(0,496, self.view2.frame.size.width, self.view2.frame.size.height);
        }
        else{
            self.view6.frame=CGRectMake(0, 320, self.view6.frame.size.width, self.view6.frame.size.height);
            
            self.view2.frame=CGRectMake(0,192, self.view2.frame.size.width, self.view2.frame.size.height);
        }
    }
    else
    {
        if (self.isiPad) {
            self.view6.frame=CGRectMake(0, 680, self.view6.frame.size.width, self.view6.frame.size.height);
            
            self.view2.frame=CGRectMake(0,432, self.view2.frame.size.width, self.view2.frame.size.height);
        }
        else{
            self.view6.frame=CGRectMake(0, 256, self.view6.frame.size.width, self.view6.frame.size.height);
            
            self.view2.frame=CGRectMake(0,128, self.view2.frame.size.width, self.view2.frame.size.height);

        }

       
    }
    
        self.view3.frame=CGRectMake(0,0, self.view3.frame.size.width, self.view3.frame.size.height);
           
          //  self.view4.frame=CGRectMake(10,(self.view2.frame.size.height+self.view2.frame.origin.y+10), self.view4.frame.size.width, self.view4.frame.size.height);
    if (self.isiPad) {
        self.view5.frame=CGRectMake(0, (self.view1.frame.size.height+self.view1.frame.origin.y)+30, self.view5.frame.size.width, self.view5.frame.size.height);
    }
    else{
      self.view5.frame=CGRectMake(0, (self.view1.frame.size.height+self.view1.frame.origin.y), self.view5.frame.size.width, self.view5.frame.size.height);
    }
    
    if (self.isiPad) {
        self.scrollView. contentSize=CGSizeMake(768,(self.view5.frame.size.height+self.view5.frame.origin.y+10));

    }
    else
        self.scrollView. contentSize=CGSizeMake(320,(self.view5.frame.size.height+self.view5.frame.origin.y+10));
    
    
    
    [self.scrollView addSubview:self.view1];
      [self.view1 addSubview:self.view6];
    [self.view1 addSubview:self.view2];
    
    if(mode)
    [self.view6 addSubview:self.view3];
    
    
   // [self.scrollView addSubview:self.view4];
      [self.scrollView addSubview:self.view5];
    
    
    svos=self.scrollView.contentSize;
    
   // point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
   
   
    
    
    if(isEditMode)
    {
        
        
        [self segActionTapped:self.segpripub];
        
        
        [self segActionTapped:self.segyesno];
        
       
        
        [self setEventType];
    }
    else
    {
        //[(UIButton*)[self.view3 viewWithTag:33] setTitle:@"No" forState:UIControlStateNormal];
        self.selectedRow10=1;
    }
    
    
    
    
    if(mode)
    {
        if(isEditMode)
        {
             self.topBarFromTeamAdmin.hidden=YES;
              self.tobbarlab.text=@"Edit Event";
            [self.donepbt setTitle:@"Invitees" forState:UIControlStateNormal];
            CGRect r=  self.donepbt.frame;
            CGRect r1=  self.deletebt.frame;
            if (self.isiPad)
            {
                
                r.size.height=r.size.height+40;
                r1.size.height=r1.size.height+40;
            }
            //Subhasish..16th March
            [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height + self.donepbt.frame.size.height-20)];
                
        }
        else
        {
        self.tobbarlab.text=@"New Event";
            self.deletebt.hidden=YES;
            CGRect r=  self.donepbt.frame;
            r.origin.x=0;
            if (self.isiPad) {
                r.size.width=768;
                r.size.height=r.size.height+40;
            }
            else
                r.size.width=320;
            self.donepbt.frame=r;
        }
       
    }
    else
    {
         self.topBarFromTeamAdmin.hidden=YES;
    }
    
    
    
    
    
}

-(void)setYesNoBtn:(int)tag
{
    if(tag==0)
    {
        [self.yesbt setBackgroundImage:self.yesredima forState:UIControlStateNormal];
         [self.nobt setBackgroundImage:self.nogreyima forState:UIControlStateNormal];
        
        
        [(UIButton*)[self.view3 viewWithTag:33] setTitle:@"Yes" forState:UIControlStateNormal];
        self.selectedRow10=0;
        
    }
    else //if(tag==1)
    {
        [self.yesbt setBackgroundImage:self.yesgreyima forState:UIControlStateNormal];
        [self.nobt setBackgroundImage:self.noredima forState:UIControlStateNormal];
        
        [(UIButton*)[self.view3 viewWithTag:33] setTitle:@"No" forState:UIControlStateNormal];
        self.selectedRow10=1;
    }
}

-(void)getTaemListing
{
  
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSDictionary *command=  [NSDictionary dictionaryWithObjectsAndKeys:[appDelegate.aDef objectForKey:LoggedUserID],@"coach_id", nil];
    NSString *jsonCommand = [writer stringWithObject:command];
    
    NSLog(@"RequestParamJSON=%@=====%@",jsonCommand,command);
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAM_LISTING_LINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
      self.sinReq3=sinReq;
       [self.storeCreatedRequests addObject:self.sinReq3];
    sinReq.notificationName=TEAM_LISTING;
    
  
  
    
    
    [sinReq startRequest];
    if(mode==1)
    {
    self.teamnameindicator.hidden=NO;
    [self.teamnameindicator startAnimating];
    }
}


-(void)getAllTaemListing
{
    
    
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ALL_TEAM_LISTING_LINK] parameterDic:[NSDictionary dictionary]] ;
      self.sinReq4=sinReq;
     [self.storeCreatedRequests addObject:self.sinReq4];
    sinReq.notificationName=ALL_TEAM_LISTING;
    
    [sinReq startRequest];
   
  
        self.opponentteamindicator.hidden=NO;
        [self.opponentteamindicator startAnimating];
    
    
}

-(void)teamListUpdated:(id)sender
{
      [self hideHudView];
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
    NSString *message=CONNFAILMSG;
    if([sReq.notificationName isEqualToString:TEAM_LISTING])
    {
        self.teamnameindicator.hidden=YES;
        [self.teamnameindicator stopAnimating];
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

        
                    NSDictionary *aDic1=[aDict objectForKey:@"response"];
        
        
        
        
        
                    self.arrPickerItems5=[aDic1 objectForKey:@"team_list"];
                    
                    if(self.arrPickerItems5.count==1)
                    {
                    [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_name"] forState:UIControlStateNormal ];
                        [self setSingleTeam];
                    }
                    
                    self.selectedRow4=0;
                    
                    
                    //[[NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Private",@"team_name",@"Private",@"team_id", nil] ] arrayByAddingObjectsFromArray:[aDic1 objectForKey:@"team_list"] ] ;//Add Latest Ch
    
//                    NSMutableArray *ar1=[[NSMutableArray alloc] init];
//                     NSMutableArray *ar2=[[NSMutableArray alloc] init];
//                     NSMutableArray *ar3=[[NSMutableArray alloc] init];
//                    self.teamLocation=ar1;
//                    self.teamUniformColor=ar2;
//                    self.teamFieldName=ar3;
//                    [ar1 release];
//                    [ar2 release];
//                    [ar3 release];
//        for(NSDictionary *dic in arrPickerItems5)
//        {
//            [self.teamFieldName addObject:[dic objectForKey:@"field_name"]];
//              [self.teamLocation addObject:[dic objectForKey:@"team_zipcode"]];
//              [self.teamUniformColor addObject:[dic objectForKey:@"uniform_color"]];
//        }
        
        
                }
                else
                {
                    message= [aDict objectForKey:@"message"];
                    [self showHudAlert:message];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                }
        
            }
        
        }
        
        
        
        
        
        
        
        
        
    
    if(isEditMode)
    {
        
        
        int m=0;
        
        
        for(NSDictionary *str in arrPickerItems5)
        {
            if([[str  objectForKey:@"team_name"] isEqualToString:dataEvent.teamName])
            {
                   [(UIButton*)[self.view1 viewWithTag:31]  setTitle:[str  objectForKey:@"team_name"] forState:UIControlStateNormal];
                self.selectedRow4=m;
                break;
            }
            
            m++;
        }
        m=0;
        
    }
    }
     else
     {
         [self showHudAlert:message];
         [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
       
     }
    }
    else
    {
        
    }
}

-(void)hideHudViewHereDelete
{
    [self hideHudView];
    
    UINavigationController *aNav=appDelegate.navigationControllerCalendar;
    [aNav popToRootViewControllerAnimated:NO];
    [self dismissModal];
    
    
}

-(void)hideHudViewHere
{
    [self hideHudView];
    
    
}

-(void)hideHudViewHereFinished:(Event*)newEvent
{
    [self hideHudView];
    
    UINavigationController *aNav=appDelegate.navigationControllerCalendar;
   //   [self dismissModal];
     [self.appDelegate.centerViewController dismissViewControllerAnimated:NO completion:nil];
     self.isModallyPresentFromCenterVC=0;
    [aNav popToRootViewControllerAnimated:NO];
    
    
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    eVC.dataEvent=newEvent;
    // [appDelegate.navigationControllerCalendar pushViewController:eVC animated:NO ];
    
    
    [aNav pushViewController:eVC animated:NO ];
    
    [eVC performSelector:@selector(inviteAction:) withObject:nil afterDelay:0.5 ];
    
}

-(void)hideHudViewHereFinishedEdit:(Event*)newEvent
{
    [self hideHudView];
    
    //////////   12/03/2015  ///////
    
    /*
    UINavigationController *aNav=appDelegate.navigationControllerCalendar;
    [aNav popToRootViewControllerAnimated:NO];
   // [self dismissModal];
       [self.appDelegate.centerViewController dismissViewControllerAnimated:NO completion:nil];
      self.isModallyPresentFromCenterVC=0;
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    eVC.dataEvent=newEvent;
    // [appDelegate.navigationControllerCalendar pushViewController:eVC animated:NO ];
   
     
   
    [aNav pushViewController:eVC animated:NO];
    
  
    
   // Send updated event to players
   
     [eVC performSelector:@selector(inviteActionData:) withObject:@"Send updated event to players" afterDelay:0.5 ];
    */
    
    self.createEvent=newEvent;
    self.alertViewBack.hidden=NO;
    self.alertView.hidden=NO;
    
    
    
    
    
    /////////
    
}

-(void)teamAllListUpdated:(id)sender
{
    [self hideHudView];
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    NSString *message=CONNFAILMSG;
    
    if([sReq.notificationName isEqualToString:ALL_TEAM_LISTING])
    {
        self.opponentteamindicator.hidden=YES;
        [self.opponentteamindicator stopAnimating];
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
                        
                        
                        NSDictionary *aDic1=[aDict objectForKey:@"response"];
                        
                        
                        
                        
                        
                        self.arrPickerItems6=[aDic1 objectForKey:@"team_list"];
                        
                        
                        
                        
                    }
                    else
                    {
                          message= [aDict objectForKey:@"message"];
                        [self showHudAlert:message];
                        [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    }
                    
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if(isEditMode)
            {
                
                /*if(mode)
                {*/
                    int m=0;
                    
                    
                    for(NSDictionary *str in arrPickerItems6)
                    {
                        if([[str  objectForKey:@"team_name"] isEqualToString:dataEvent.opponentTeam])
                        {
                            [(UITextField*)[self.view6 viewWithTag:11]  setText:[str  objectForKey:@"team_name"]];
                            self.selectedRow5=m;
                            break;
                        }
                        
                        m++;
                    }
                    
                
                    
                    
                    m=0;
                //}
            }
        }
        else
        {
            [self showHudAlert:message];
            [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
    }
    else
    {
        
    }
}









- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"Row : %d and Col %d ",row,component);
    
    
    if(buttonMode==0)
    {

            self.selectedRow = row;
       
    }
    else if(buttonMode==1)
    {
          self.selectedRow1 = row;
    }
    else if(buttonMode==7)
    {
        self.selectedRow3 = row;
    }
    else if(buttonMode==8)
    {
        self.selectedRow5 = row;
    }
    else if(buttonMode==9)
    {
        self.selectedRow4 = row;
    }
    else if(buttonMode==10)
    {
        self.selRow7 = row;
    }
    else if(buttonMode==11)
    {
        self.selectedRow8 = row;
    }
    else if(buttonMode==12)
    {
        self.selectedRow10 = row;
    }
    else
    {
        

           self.selectedRow2=row;
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if(buttonMode==0)
    {
        
        return [arrPickerItems1 count];
    }
    else if(buttonMode==1)
    {
        NSLog(@"%@", arrPickerItems2 );
        return [arrPickerItems2 count];
    }
    else if(buttonMode==7)
    {
        NSLog(@"%i", [arrPickerItems4 count]);
        return [arrPickerItems4 count];
    }
    else if(buttonMode==8)
    {
        NSLog(@"%i", [arrPickerItems6 count]);
        return [arrPickerItems6 count];
    }
    else if(buttonMode==9)
    {
        NSLog(@"%i", [arrPickerItems5 count]);
        return [arrPickerItems5 count];
    }
    else if(buttonMode==10)
    {
        NSLog(@"%i", [pickerArr7 count]);
        return [pickerArr7 count];
    }
    else if(buttonMode==11)
    {
        NSLog(@"%i", [arrPickerItems8 count]);
        return [arrPickerItems8 count];
    }
    else if(buttonMode==12)
    {
        NSLog(@"%i", [arrPickerItems10 count]);
        return [arrPickerItems10 count];
    }
    else
    {
        NSLog(@"%i", [arrPickerItems3 count]);
        return [arrPickerItems3 count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSLog(@"Row=%i",row);
    
    if(buttonMode==0)
    {
        return [arrPickerItems1 objectAtIndex:row];
    }
    else if(buttonMode==1)
    {
        NSLog(@"%i", [arrPickerItems2 count]);
        return [arrPickerItems2 objectAtIndex:row];
    }
    else if(buttonMode==7)
    {
        NSLog(@"%i", [arrPickerItems4 count]);
        return [arrPickerItems4 objectAtIndex:row];
    }
    else if(buttonMode==8)
    {
        NSLog(@"%i", [arrPickerItems6 count]);
        return [[arrPickerItems6 objectAtIndex:row] objectForKey:@"team_name"];
    }
    else if(buttonMode==9)
    {
        NSLog(@"%i", [arrPickerItems5 count]);
        return [[arrPickerItems5 objectAtIndex:row] objectForKey:@"team_name"];
    }
    else if(buttonMode==10)
    {
        NSLog(@"%i", [pickerArr7 count]);
        return [pickerArr7 objectAtIndex:row] ;
    }
    else if(buttonMode==11)
    {
        NSLog(@"%i", [arrPickerItems8 count]);
        return [arrPickerItems8 objectAtIndex:row];
    }
    else if(buttonMode==12)
    {
        NSLog(@"%i", [arrPickerItems10 count]);
        return [arrPickerItems10 objectAtIndex:row];
    }
    else
    {
        NSLog(@"%i", [arrPickerItems3 count]);
        return [arrPickerItems3 objectAtIndex:row];
    }
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lbl = (UILabel *)view;
    // Reuse the label if possible...
    if ((lbl == nil) || ([lbl class] != [UILabel class]))
    {
        CGRect frame;
        
        /*if (appDelegate.isiphone)
        {*/
            frame = CGRectMake(0.0, 0.0, 270, 30.0);
       /* }
        else
        {
            frame = CGRectMake(0.0, 0.0, 470, 30.0);
        }*/
        
        lbl = [[UILabel alloc] initWithFrame:frame];
        
        
        /*if(isiphone)
         {*/
        
        if(buttonMode==7)
        lbl.font=[UIFont boldSystemFontOfSize:10];
        else
            lbl.font=[UIFont boldSystemFontOfSize:20];
        /*}
         else
         {
         lbl.font=[UIFont boldSystemFontOfSize:18];
         }*/
        lbl.textColor = [UIColor blackColor];
        lbl.backgroundColor=[UIColor clearColor];
    }
    
    if(buttonMode==0)
    {
        
         lbl.text= [arrPickerItems1 objectAtIndex:row];
    }
    else if(buttonMode==1)
    {
        NSLog(@"%i", [arrPickerItems2 count]);
         lbl.text= [arrPickerItems2 objectAtIndex:row];
    }
    else if(buttonMode==7)
    {
        NSLog(@"%i", [arrPickerItems4 count]);
         lbl.text= [arrPickerItems4 objectAtIndex:row];
    }
    else if(buttonMode==8)
    {
        NSLog(@"%i", [arrPickerItems6 count]);
         lbl.text= [[arrPickerItems6 objectAtIndex:row] objectForKey:@"team_name"];
    }
    else if(buttonMode==9)
    {
        NSLog(@"%i", [arrPickerItems5 count]);
        lbl.text= [[arrPickerItems5 objectAtIndex:row] objectForKey:@"team_name"];
    }
    else if(buttonMode==10)
    {
        NSLog(@"%i", [pickerArr7 count]);
        lbl.text= [pickerArr7 objectAtIndex:row] ;
    }
    else if(buttonMode==11)
    {
        NSLog(@"%i", [arrPickerItems8 count]);
        lbl.text=[arrPickerItems8 objectAtIndex:row];
    }
    else if(buttonMode==12)
    {
        NSLog(@"%i", [arrPickerItems10 count]);
        lbl.text=[arrPickerItems10 objectAtIndex:row];
    }
    else
    {
        NSLog(@"%i", [arrPickerItems3 count]);
         lbl.text= [arrPickerItems3 objectAtIndex:row];
    }

    
    
  
        return lbl;
}



- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamListUpdated:) name:TEAM_LISTING object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamAllListUpdated:) name:ALL_TEAM_LISTING object:nil];
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamListUpdated:) name:VIEWEVENTSTATUS object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findLocation) name:kLatLongFound object:nil];
    //    // register for keyboard notifications
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillHide)
    //                                                 name:UIKeyboardWillHideNotification
    //                                               object:nil];
    
     [self setStatusBarStyleOwnApp:0];
    //Subhasish..26th Marchs
    
    //associate Done button with notestxtvw
    
}

-(void)doneClicked{
    [self.notestxtvw resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
   
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAM_LISTING object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:ALL_TEAM_LISTING object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
     
                                                    name:UIKeyboardDidHideNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:kLatLongFound object:nil];
    //    // unregister for keyboard notifications while not visible.
    //    [[NSNotificationCenter defaultCenter] removeObserver:self
    //                                                    name:UIKeyboardWillShowNotification
    //                                                  object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] removeObserver:self
    //                                                    name:UIKeyboardWillHideNotification
    //                                                  object:nil];
     [self setStatusBarStyleOwnApp:1];
}


-(void)viewDidUnload
{
    [self setShowaslab:nil];
    [self setSegpripub:nil];
    [self setView5:nil];
    [self setNoteslab:nil];
    [self setNotestxtvw:nil];
    [self setHomegamelab:nil];
    [self setSegyesno:nil];
    [self setView6:nil];
    [self setYesbt:nil];
    [self setNobt:nil];
    [self setTopBarFromTeamAdmin:nil];
    [super viewDidUnload];
    self.keyboardToolbar=nil;
    self.keyboardToolbarView=nil;
    self.view1=nil;
    self.view2=nil;
    self.view3=nil;
    self.view4=nil;
    self.scrollView=nil;
    self.top=nil;
    self.picker=nil;
    self.pickercontainer=nil;
    self.dpicker=nil;
}





#pragma mark - Text Field

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
// {
//     [self.view endEditing:YES];
////     [textField resignFirstResponder];
//     return YES;
// }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  [self.view endEditing:YES];
}

/*- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height );//- kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    //    [[UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"Scroll Starting");
}

/*- (void)keyboardWillShow1:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height);// - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    //    [UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = YES;
}*/

-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.superview.frame.origin.y+theView.center.y;
    
    CGFloat fsh=af.size.height;
    
    CGFloat sa;//=vcy-fsh/5.8;
    
    if(isiPhone5)
        sa=vcy-fsh/5.5;   //sa=vcy-fsh/3.2;
    else
        sa=vcy-fsh/6.5;    //sa=vcy-fsh/5.2;
    
    if(sa<0)
        sa=0;
    
    self.scrollView.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    
    NSLog(@"%f-%f-%f,%f",self.scrollView.contentSize.height,af.size.height,kb.size.height,sa);
    [ self.scrollView setContentOffset:CGPointMake(0,sa) animated:YES];
    
    
    
    point=self.scrollView.contentOffset;
}

-(void) keyboardDidShow:(NSNotification *) notification
{
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue =
    [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    [aValue getValue:&kb];
    
}

-(void) keyboardDidHide:(NSNotification *) notification
{
    
}

-(void)dissmissCanKeyboard:(id)sender
{
    int tag=[sender tag];
    
    
    
    if(tag==0)
    {
        self.notestxtvw.text=self.currbodytext;
        
    }
    
    [self.notestxtvw resignFirstResponder];
    
    self.scrollView.contentSize=svos;
    self.scrollView.contentOffset=point;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.isTapp=YES;
    [self moveScrollView:textField];
      point=self.scrollView.contentOffset;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if(textField.tag==5)
    {
        if(textField.text && (![textField.text isEqualToString:@""]))
        {
            /*if(![textField.text isEqualToString:self.lastSelectedAddress])
            {*/
                self.lastSelectedAddress=textField.text;
              //ch  [(UIButton*)[self.view1 viewWithTag:29]  setTitle:@"" forState:UIControlStateNormal];
              [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
            [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Getting Field Name"];
            [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            
            ///////////////ADDDEB//UNCommented
            
            ///////////////ADDDEBNEW
            self.arrPickerItems4=[[NSMutableArray alloc] init];
            /////////////
            isLoadingLocations=1;
            [self geocodeAddress];
            
            ///////////////
            
            //}
        }
        else
        {
            self.arrPickerItems4=[[NSMutableArray alloc] init];
            [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
            [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@""];
        }
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    self.scrollView.contentSize=svos;
    self.scrollView.contentOffset=point;
    
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int tag=[theTextField tag];
    
    
    NSCharacterSet *myCharSet;
    
    
    if(tag==1|tag==10|tag==12|tag==11)
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
    

    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.isTapp=YES;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    self.currbodytext=textView.text;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    
    
    
    //rect.origin.y = 204;
    float ym=170;
    
    if(mode)
    {
        ym=204-44+44+3;
    
    }
//    if (self.isiPad) {
//        rect.origin.y = ym;
//    }
    else{
        if(appDelegate.isIphone5)
            rect.origin.y = ym+88;
        else
            rect.origin.y = ym;
    }
    
    
    keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    if (!self.isiPad) {
        [self.view addSubview:keyboardToolbarView];
    }
    
    [UIView commitAnimations];
    
    [self moveScrollView:textView];
    
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self hideKeyTool];
    
    
    self.scrollView.contentOffset=point;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}


- (void)geocodeAddress
{
    /*CLGeocoder *geocoder1=[[CLGeocoder alloc] init];
    self.geocoder = geocoder1;
    
    NSLog(@"\"%@\"",self.lastSelectedAddress);*/
    
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
        }
        NSLog(@"combine address %@",combineAddress);
        
        NSString *unescaped=[[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",combineAddress];
        NSURL* apiUrl = [[NSURL alloc] initWithString:unescaped];
        NSString *aResponse = [[NSString alloc] initWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"respone %@",aResponse);
        __block  NSError *error;
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            if (aResponse) {
                
                
                @autoreleasepool {
                    
                
                NSMutableDictionary *jsonResponeDict= [NSJSONSerialization JSONObjectWithData: [aResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
                
                
                
                if([[jsonResponeDict objectForKey:@"status"] isEqualToString:@"OK"])
                {
                    
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
                    
                    if(mode==1)
                    {
                        self.fieldnameindicator.hidden=NO;
                        [self.fieldnameindicator startAnimating];
                        [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Getting Field Name"];//Getting Ch
                        [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                    }
                    
                    isFindPlaygroundProcess=1;
                    [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
                    
                    
                    
                    

                
                }
                else
                {
                    self.arrPickerItems4=[[NSMutableArray alloc] init];
                    isLoadingLocations=0;
                    NSLog(@"error");
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
                
                self.arrPickerItems4=[[NSMutableArray alloc] init];
                isLoadingLocations=0;
                NSLog(@"error");
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
    
   
    
    
    ////////////////////////
    
    
    /////////////////////////
    /*[geocoder geocodeAddressString:self.lastSelectedAddress completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if([placemarks count])
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            //CLLocationCoordinate2D coordinate = location.coordinate;
            
            NSLog(@"\"%@\"-\"%@\"",self.lastSelectedAddress,self.firstTimeDefaultCurrentAddress);
            
            if(![self.lastSelectedAddress isEqualToString:self.firstTimeDefaultCurrentAddress])
            {
            self.selectedLocation=location;
            self.appDelegate.locationLatPlayground=location.coordinate.latitude;
             self.appDelegate.locationLongPlayground=location.coordinate.longitude;
                
                NSLog(@"\"%@-%@-%@-%@\"", placemark.postalCode,placemark.name,placemark.country,[placemark addressDictionary]);
                NSLog(@"%f %f", self.appDelegate.locationLatPlayground,self.appDelegate.locationLongPlayground);
            }
            [self showNativeHudView];
            
            if(mode==1)
            {
            self.fieldnameindicator.hidden=NO;
            [self.fieldnameindicator startAnimating];
            [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Getting Field Name"];//Getting Ch
            }
            
            isFindPlaygroundProcess=1;
            [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
        }
        else
        {
            NSLog(@"error");
            self.selectedLocation=nil;
            self.appDelegate.locationLatPlayground=0.0;
            self.appDelegate.locationLongPlayground=0.0;
            NSString *message=LOCATIONNOTDETERMINEDERROR;
           // [self showHudAlert:message];
           // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
            [self showAlertMessage:message title:@""];
        }
    }];*/
    
}


-(void)findLocation
{
  
 
    self.selectedLocation=appDelegate.currentLocation;
    self.appDelegate.locationLatPlayground=self.selectedLocation.coordinate.latitude;
    self.appDelegate.locationLongPlayground=self.selectedLocation.coordinate.longitude;
    
      [self reverseGeocodeAddress];
  
}

- (void)reverseGeocodeAddress
{
    /*CLGeocoder *geocoder1=[[CLGeocoder alloc] init];
    self.geocoder = geocoder1;*/
    
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
                 self.lastSelectedAddress=  self.firstTimeDefaultCurrentAddress;
                 [(UITextField*)[self.view6 viewWithTag:5] setText:self.lastSelectedAddress];
                 
                 
                 [(UITextField*)[self.view6 viewWithTag:4] setText:@"" ];
                 
                 
                 [self showNativeHudView];
                 
                 if(mode==1)
                 {
                     self.fieldnameindicator.hidden=NO;
                     [self.fieldnameindicator startAnimating];
                     [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Getting Field Name"];
                     [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                 }
                 
                 isFindPlaygroundProcess=1;
                 [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
             }
             }
             else
             {
                 NSLog(@"error");
                 
                 [(UITextField*) [self.view6 viewWithTag:5] setPlaceholder:@"Zipcode/City"];
                 
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
                
                [(UITextField*) [self.view6 viewWithTag:5] setPlaceholder:@"Zipcode/City"];
                
                self.selectedLocation=nil;
                self.appDelegate.locationLatPlayground=0.0;
                self.appDelegate.locationLongPlayground=0.0;
                NSString *message=LOCATIONNOTDETERMINEDERROR;
                
                [self showAlertMessage:message title:@""];
                
                
            }
            
            
            
            
            }
        );
        
        
        
        
        
        
    });

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    /*[geocoder reverseGeocodeLocation:self.selectedLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {
      
        if(placemarks.count)
        {
            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
            
            NSLog(@"addressDictionary=%@",dictionary);
            
            NSMutableString *locStr=[[NSMutableString alloc] initWithFormat:@"%@",[dictionary valueForKey:@"FormattedAddressLines"]];
           
            
            
        
            self.firstTimeDefaultCurrentAddress=[[[locStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            self.lastSelectedAddress=  self.firstTimeDefaultCurrentAddress;
            [(UITextField*)[self.view6 viewWithTag:5] setText:self.lastSelectedAddress];
           
            
              [(UITextField*)[self.view6 viewWithTag:4] setText:@"" ];
            
            
            [self showNativeHudView];
            
            if(mode==1)
            {
                self.fieldnameindicator.hidden=NO;
                [self.fieldnameindicator startAnimating];
                [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Getting Field Name"];
            }
            
              isFindPlaygroundProcess=1;
            [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
            
        }
        else
        {
            NSLog(@"error");
            
            [(UITextField*) [self.view6 viewWithTag:5] setPlaceholder:@"Zipcode/City"];
            
            self.selectedLocation=nil;
            self.appDelegate.locationLatPlayground=0.0;
            self.appDelegate.locationLongPlayground=0.0;
            NSString *message=LOCATIONNOTDETERMINEDERROR;
            
            [self showAlertMessage:message title:@""];
        }
    }];*/
    
    
    /*[geocoder geocodeAddressString:self.lastSelectedAddress completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if([placemarks count])
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             CLLocation *location = placemark.location;
             //CLLocationCoordinate2D coordinate = location.coordinate;
             self.selectedLocation=location;
             self.appDelegate.locationLatPlayground=location.coordinate.latitude;
             self.appDelegate.locationLongPlayground=location.coordinate.longitude;
             [self showNativeHudView];
             
             if(mode==1)
             {
                 self.fieldnameindicator.hidden=NO;
                 [self.fieldnameindicator startAnimating];
             }
             [self.appDelegate sendRequestFor:FINDPLAYGROUND from:self parameter:nil];
         }
         else
         {
             NSLog(@"error");
             self.appDelegate.locationLatPlayground=0.0;
             self.appDelegate.locationLongPlayground=0.0;
             NSString *message=CONNFAILMSG;
             [self showHudAlert:message];
             [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
         }
     }];*/
    
}


-(void)hideKeyTool
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    rect.origin.y = 372;
    keyboardToolbarView.frame = rect;
    if (!self.isiPad) {
        [keyboardToolbarView removeFromSuperview];
    }
    [UIView commitAnimations];
}

- (IBAction)TeamPlayerSwitch:(id)sender
{
    switch ([sender tag])
    {
        case 1:
            mode=0;
          
            //self.scrollView.scrollEnabled=YES;
         
            
            [self.privateBtn setBackgroundImage:[UIImage imageNamed:@"team-select.png"] forState:UIControlStateNormal];
            [self.privateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"player-nonselect.png"] forState:UIControlStateNormal];
            [self.publicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.privateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.publicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            break;
        case 2:
            mode=1;
            
            //self.teamScroll.scrollEnabled=NO;
           
            
            [self.privateBtn setBackgroundImage:[UIImage imageNamed:@"team-nonselect.png"] forState:UIControlStateNormal];
            [self.privateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.publicBtn setBackgroundImage:[UIImage imageNamed:@"player-select.png"] forState:UIControlStateNormal];
            [self.publicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.privateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.publicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            break;
            
        default:
            break;
    }
    
   // self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, (self.view4.frame.origin.y+self.view4.frame.size.height+10));
    [self showViewMode:mode];
    
}

-(void)showViewMode:(BOOL)viewMode
{
//    if(viewMode==0)
//    {
//        self.view1.frame=CGRectMake(12, 5, self.view1.frame.size.width, 200);
//        self.view2.frame=CGRectMake(12, 210, self.view2.frame.size.width, self.view2.frame.size.height);
//        //self.view3.frame=CGRectMake(12, 415, self.view3.frame.size.width, self.view3.frame.size.height);
//        self.view3.hidden=YES;
//        self.view4.frame=CGRectMake(12, 335, self.view4.frame.size.width, self.view4.frame.size.height);
//        self.scrollView. contentSize=CGSizeMake(320,385);
//        
//        
//        
//      UIView *vw=  [self.view1 viewWithTag:44];
//        CGRect r=vw.frame;
//        r.origin.y=130;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:45];
//       r=vw.frame;
//        r.origin.y=170;
//        vw.frame=r;
//        
//        ///////////Later
//        vw=  [self.view1 viewWithTag:40];
//         r=vw.frame;
//        r.origin.y=10;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:41];
//        r=vw.frame;
//        r.origin.y=50;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:42];
//        r=vw.frame;
//        r.origin.y=90;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:21];
//        r=vw.frame;
//        r.origin.y=85;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:3];
//        r=vw.frame;
//        r.origin.y=85;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:20];
//        r=vw.frame;
//        r.origin.y=45;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:2];
//        r=vw.frame;
//        r.origin.y=45;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:1];
//        r=vw.frame;
//        r.origin.y=5;
//        vw.frame=r;
//        ///////////
//        
//        vw=  [self.view1 viewWithTag:5];
//        r=vw.frame;
//        r.origin.y=125;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:6];
//        r=vw.frame;
//        r.origin.y=165;
//        vw.frame=r;
//        vw=  [self.view1 viewWithTag:22];
//         r=vw.frame;
//        r.origin.y=165;
//        vw.frame=r;
//        /*vw=  [self.view1 viewWithTag:34];
//         r=vw.frame;
//        r.origin.y=90;
//        vw.frame=r;*/
//       
//          vw=  [self.view1 viewWithTag:43];
//        vw.hidden=YES;
//          vw=  [self.view1 viewWithTag:4];
//         vw.hidden=YES;
//          vw=  [self.view1 viewWithTag:34];
//         vw.hidden=YES;
//        vw=  [self.view1 viewWithTag:29];
//        vw.hidden=YES;
//        ///////Later
//        vw=  [self.view1 viewWithTag:100];
//        vw.hidden=YES;
//        vw=  [self.view1 viewWithTag:101];
//        vw.hidden=YES;
//        vw=  [self.view1 viewWithTag:31];
//        vw.hidden=YES;
//        vw=  [self.view1 viewWithTag:33];
//        vw.hidden=YES;
//        ///////
//    }
//    else
//    {
//        self.view1.frame=CGRectMake(12, 5, self.view1.frame.size.width, 280);
//        self.view2.frame=CGRectMake(12, 290, self.view2.frame.size.width, self.view2.frame.size.height);
//        self.view3.frame=CGRectMake(12, 415, self.view3.frame.size.width, self.view3.frame.size.height);
//         self.view3.hidden=NO;
//        self.view4.frame=CGRectMake(12, 540, self.view4.frame.size.width, self.view4.frame.size.height);
//        self.scrollView. contentSize=CGSizeMake(320,590);
//        
//        
//        
//        
//        
//        UIView *vw=  [self.view1 viewWithTag:44];
//        CGRect r=vw.frame;
//        r.origin.y=210;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:45];
//        r=vw.frame;
//        r.origin.y=250;
//        vw.frame=r;
//        
//        ///////////Later
//        vw=  [self.view1 viewWithTag:40];
//        r=vw.frame;
//        r.origin.y=50;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:41];
//        r=vw.frame;
//        r.origin.y=90;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:42];
//        r=vw.frame;
//        r.origin.y=130;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:21];
//        r=vw.frame;
//        r.origin.y=125;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:3];
//        r=vw.frame;
//        r.origin.y=125;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:20];
//        r=vw.frame;
//        r.origin.y=85;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:2];
//        r=vw.frame;
//        r.origin.y=85;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:1];
//        r=vw.frame;
//        r.origin.y=45;
//        vw.frame=r;
//        ///////////
//        
//        vw=  [self.view1 viewWithTag:5];
//        r=vw.frame;
//        r.origin.y=205;
//        vw.frame=r;
//        
//        vw=  [self.view1 viewWithTag:6];
//        r=vw.frame;
//        r.origin.y=245;
//        vw.frame=r;
//        vw=  [self.view1 viewWithTag:22];
//        r=vw.frame;
//        r.origin.y=245;
//        vw.frame=r;
//       /* vw=  [self.view1 viewWithTag:34];
//        r=vw.frame;
//        r.origin.y=120;
//        vw.frame=r;*/
//       // self.fieldnameindicator.frame=CGRectMake(125,170,20,20);
//        
//        
//        vw=  [self.view1 viewWithTag:43];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:4];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:34];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:29];
//        vw.hidden=NO;
//        
//        ///////Later
//        vw=  [self.view1 viewWithTag:100];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:101];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:31];
//        vw.hidden=NO;
//        vw=  [self.view1 viewWithTag:33];
//        vw.hidden=NO;
//        ///////
//    }
   
}


-(void)resignAllTextFields
{
    [(UITextField*)[self.view1 viewWithTag:1] resignFirstResponder];
    [(UITextField*)[self.view6 viewWithTag:4] resignFirstResponder];
    [(UITextField*)[self.view6 viewWithTag:5] resignFirstResponder];
    [(UITextField*)[self.view3 viewWithTag:10] resignFirstResponder];
    [(UITextField*)[self.view3 viewWithTag:12] resignFirstResponder];
    [(UITextField*)[self.view6 viewWithTag:11] resignFirstResponder];
    [(UITextField*)[self.view1 viewWithTag:1] resignFirstResponder];
    [self.notestxtvw resignFirstResponder];
    self.scrollView. contentSize=CGSizeMake(320,(self.view5.frame.size.height+self.view5.frame.origin.y+10));

}




- (IBAction)toolbarBtapped:(id)sender
{
    [self resignAllTextFields];
    self.isTapp=YES;
    
       int tag=[sender tag];
    
    self.dpicker.minimumDate=[NSDate date];
    
    
    if(tag==20)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
          [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=0;
        
       
       
        [self.picker reloadAllComponents];
        [self.picker selectRow:self.selectedRow inComponent:0 animated:NO];
        
        
    }
    else if(tag==21)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=YES;
        self.dpicker.hidden=NO;
        [self.view bringSubviewToFront:self.pickercontainer];
         [self.view bringSubviewToFront:self.top];
        self.dpicker.datePickerMode=UIDatePickerModeDate;
        
        
        self.top.hidden=NO;
        buttonMode=3;
        
        NSDate *  date;
        
        if(self.eventDate)
            date=eventDate;
        else
            date=[NSDate date];
        
        self.dpicker.date= date;
        
    }
    else if(tag==22)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
          [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=1;
        
        
        [self.picker reloadAllComponents];
        
        [self.picker selectRow:self.selectedRow1 inComponent:0 animated:NO];
        
    }
    else if(tag==23)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=YES;
        self.dpicker.hidden=NO;
        [self.view bringSubviewToFront:self.pickercontainer];
         [self.view bringSubviewToFront:self.top];
         self.dpicker.datePickerMode=UIDatePickerModeTime;
        self.top.hidden=NO;
        buttonMode=4;
        NSDate *  date;
        if(self.arrivalDate)
            date=arrivalDate;
        else{
            if(!startDate)
                date=[ [NSDate date] dateByAddingTimeInterval:24*60*60];//[self dateFromSD: [ [NSDate date] dateByAddingTimeInterval:24*60*60] ];
            else
                date=[self dateFromSD:startDate ];
        }
        self.dpicker.date= date;
    }
    else if(tag==24)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=YES;
        self.dpicker.hidden=NO;
        [self.view bringSubviewToFront:self.pickercontainer];
         [self.view bringSubviewToFront:self.top];
           self.dpicker.datePickerMode=UIDatePickerModeTime;
        self.top.hidden=NO;
        buttonMode=5;
        NSDate *  date;
        if(self.startDate)
            date=startDate;
        else
            date=[ [NSDate date] dateByAddingTimeInterval:24*60*60];//[self dateFromSD: [ [NSDate date] dateByAddingTimeInterval:24*60*60] ];
        self.dpicker.date= date;
    }
    else if(tag==25)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=YES;
        self.dpicker.hidden=NO;
        [self.view bringSubviewToFront:self.pickercontainer];
         [self.view bringSubviewToFront:self.top];
           self.dpicker.datePickerMode=UIDatePickerModeTime;
        self.top.hidden=NO;
        buttonMode=6;
        NSDate *  date;
        if(self.endDate)
            date=endDate;
        else
        {
            if(!startDate)
                date=[ [NSDate date] dateByAddingTimeInterval:24*60*60];//[self dateFromSD: [ [NSDate date] dateByAddingTimeInterval:24*60*60] ];
            else
                date=[self dateFromSD:startDate ];
        }
        self.dpicker.date= date;
    }
    else if(tag==26)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
         [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=2;
       
        
       
        [self.picker reloadAllComponents];
        [self.picker selectRow:self.selectedRow2 inComponent:0 animated:NO];
        
    }
    else if(tag==27)
    {
        self.pickercontainer.hidden=YES;
        
        
        self.top.hidden=YES;
        
        [self.view bringSubviewToFront:self.scrollView];
    }
    else if(tag==28)
    {
        self.pickercontainer.hidden=YES;
        
        
        self.top.hidden=YES;
        
        if(buttonMode==0)
        {
                [(UIButton*)[self.view1 viewWithTag:20] setTitle:[self.arrPickerItems1 objectAtIndex:self.selectedRow] forState:UIControlStateNormal ];
        }
        else if(buttonMode==1)
        {
          [(UIButton*)[self.view2 viewWithTag:22] setTitle:[self.arrPickerItems2 objectAtIndex:self.selectedRow1] forState:UIControlStateNormal ];
        }
        else if(buttonMode==2)
        {
               [(UIButton*)[self.view2 viewWithTag:26] setTitle:[self.arrPickerItems3 objectAtIndex:self.selectedRow2] forState:UIControlStateNormal ];
        }
        else if(buttonMode==7)
        {
           //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[self.arrPickerItems4 objectAtIndex:self.selectedRow3] forState:UIControlStateNormal ];
              [(UITextField*)[self.view6 viewWithTag:4] setText:[self.arrPickerItems4 objectAtIndex:self.selectedRow3] ];
        }
        else if(buttonMode==9)
        {
            
            
            
             if(self.arrPickerItems5.count)
            [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_name"] forState:UIControlStateNormal ];
            
            [self setEventType];
            
            if(mode==1)
            {
            if(self.segyesno.selectedSegmentIndex==0)
            {
                
                   //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
                
                 if(self.arrPickerItems5.count)
                [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
                
                 if(self.arrPickerItems5.count)
                    [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
                
                  
                
                @autoreleasepool {
                    
                    NSArray *ar= nil;
                    
                    if(self.arrPickerItems5.count)
                        ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                  
                    
                    if(ar.count>0){
                        NSString *homecolor=   [ar objectAtIndex:0];
                        if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                            [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                    }
                    
                    
                }
                
                
                
                    
                
                [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
                
                if (self.selectedRow10) {
                    [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
                    [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
                }
                else{
                    [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
                    [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
                }
                [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
                [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
            }
            else
            {
                
                @autoreleasepool {
                    
                    NSArray *ar= nil;
                    
                    if(self.arrPickerItems5.count)
                        ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                    
                    
                    if(ar.count>1){
                        NSString *homecolor=   [ar objectAtIndex:1];
                        if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                            [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                    }
                    
                    
                }
                
                
                [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
                [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
                [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
                [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
                [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
            }
            }
            else
            {
                [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
            [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
            [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
           /* [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
            [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
            
                [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
                [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];*/
            /*if(!isEditFirstTime)
            {
                isEditFirstTime=0;
                //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:@"" forState:UIControlStateNormal];
                [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
                
                [(UITextField*)[self.view6 viewWithTag:5] setText:@"" ];
                [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@""]];
                
                
                self.selRow7=0;
                self.selectedRow3=0;
                
                self.arrPickerItems4=[NSMutableArray array];
                [appDelegate createLocationManager];
            }*/
            }
           /* else if(mode==1)
            {*/
                
                /*if(!isEditFirstTime)
                {
                    isEditFirstTime=0;
                    //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
                    [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
                    
                    [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
                    [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"]];
                }*/
               /* [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
                [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
                [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
                [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
                [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
                
            }*/
            
            
            /////////////
            @autoreleasepool 
            {
                
                
                
                NSString *str=  [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                 NSString *str1=  [ [[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                
                if(([str isEqualToString:@""] || (!str)) && ([str1 isEqualToString:@""] || (!str1)))
                {
                    self.yesbt.enabled=NO;
                    self.nobt.enabled=NO;
                }
                else
                {
                    self.yesbt.enabled=YES;
                    self.nobt.enabled=YES;
                }
                
              
                
                
                
                
                
                
                //  [[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"];
                
            }
            
            
            
            
            
            
            
            
            
            
        }
        else if(buttonMode==8)
        {
           
            [(UITextField*)[self.view6 viewWithTag:11] setText:[[self.arrPickerItems6 objectAtIndex:self.selectedRow5] objectForKey:@"team_name"]  ];
         
        }
        else if(buttonMode==10)
        {
            if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                [(UITextField*)[self.view3 viewWithTag:10] setText:[self.pickerArr7 objectAtIndex:self.selRow7]];
            
        }
        else if(buttonMode==12)
        {
            
            if( [[self.arrPickerItems10 objectAtIndex:self.selectedRow10] isEqualToString:@"Yes"])
            {
            [self segBtAction:self.yesbt];
            }
            else
            {
            [self segBtAction:self.nobt];
            }
            
        }
        else if(buttonMode==11)
        {
            [(UITextField*)[self.view1 viewWithTag:1] setText:[self.arrPickerItems8 objectAtIndex:self.selectedRow8]];
        
        }
        else if(buttonMode==3)
        {
            self.eventDate=self.dpicker.date;
            NSDateFormatter *dtFormat=[[NSDateFormatter alloc ] init];
            [dtFormat setDateFormat:@"EEEE, dd MMM, yyyy"];
            
            [(UIButton*)[self.view1 viewWithTag:21] setTitle:[dtFormat stringFromDate:self.eventDate] forState:UIControlStateNormal ];

            
            self.dateformatdbString=[appDelegate.dateFormatDb stringFromDate:self.eventDate];
        }
        else if(buttonMode==4)
        {
            
            
            
            if(!startDate)
            {
                //[self showAlertMessage:@"Start Time must be entered before Arrival Time" title:@"ERROR"];
                
               // return;
            }
            else
            {
                /*if(([startDate compare:endDate]==NSOrderedDescending) && endDate)
                 {
                 [self showAlertMessage:@"End Date should be greater than Start Date" title:@"ERROR"];
                 
                 return;
                 }
                 else*/ if(([self.dpicker.date compare:startDate]==NSOrderedDescending) )
                 {
                     [self showAlertMessage:@"Start Time should be greater than Arrival Time" title:@"ERROR"];
                     return;
                 }
            }
            
            
            self.arrivalDate=self.dpicker.date;
            [(UITextField*)[self.view2 viewWithTag:7] setText:[appDelegate.dateFormatM stringFromDate:self.arrivalDate]  ];
            
            
            
            /*if((startDate ))
            {
                
                
                if(([arrivalDate compare:startDate]==NSOrderedDescending) && arrivalDate)
                {
                [self showAlertMessage:@"Start Date should be greater than Arrival Date" title:@""];
                return;
                }
                else if(([self.dpicker.date compare:startDate]==NSOrderedDescending))
                {
                    [self showAlertMessage:@"Start Date should be greater than Arrival Date" title:@""];
                    return;
                }
            }*/
            
//             self.arrivalDate=self.dpicker.date;
//            
//            
//            
//            ///////////////////Add Latest Ch
//            /*if((!self.startDate) && (!self.endDate))
//            {*/
//            self.startDate=[[NSDate alloc] initWithTimeInterval:60*30 sinceDate:self.arrivalDate];
//            [(UITextField*)[self.view2 viewWithTag:8] setText:[appDelegate.dateFormatM stringFromDate:self.startDate]  ];
//                
//                
//            self.endDate=[[NSDate alloc] initWithTimeInterval:60*60 sinceDate:self.startDate];
//            [(UITextField*)[self.view2 viewWithTag:9] setText:[appDelegate.dateFormatM stringFromDate:self.endDate]  ];
//            
//            /*}*/
//            //////////////////
//              [(UITextField*)[self.view2 viewWithTag:7] setText:[appDelegate.dateFormatM stringFromDate:self.arrivalDate] ];
        }
        else if(buttonMode==5)
        {
            
            if(mode)
            {
            if((arrivalDate ))
            {
                if(([startDate compare:arrivalDate]==NSOrderedAscending) && startDate)
                {
                [self showAlertMessage:@"Start Time should be greater than Arrival Time" title:@""];
                return;
                }
                else if(([self.dpicker.date compare:arrivalDate]==NSOrderedAscending) )
                {
                    [self showAlertMessage:@"Start Date should be greater than Arrival Date" title:@""];
                    return;
                }
                /*else if(([self.dpicker.date compare:endDate]==NSOrderedDescending) && endDate)
                {
                    [self showAlertMessage:@"End Date should be greater than Start Date" title:@""];
                    return;
                }*///ChAfter
            }
            }
            else
            {
                /*if(([startDate compare:arrivalDate]==NSOrderedAscending) && startDate)
                {
                    [self showAlertMessage:@"Start Date should be greater than Arrival Date" title:@""];
                    return;
                }
                else if(([self.dpicker.date compare:arrivalDate]==NSOrderedAscending) )
                {
                    [self showAlertMessage:@"Start Date should be greater than Arrival Date" title:@""];
                    return;
                }
                else*/
                if(([self.dpicker.date compare:endDate]==NSOrderedDescending) && endDate)
                {
                    [self showAlertMessage:@"End Time should be greater than Start Time" title:@"ERROR"];
                    return;
                }
            }
            
             self.startDate=self.dpicker.date;
              [(UITextField*)[self.view2 viewWithTag:8] setText:[appDelegate.dateFormatM stringFromDate:self.startDate]  ];
            
            
        ////// Arpita 1st April
            
          /*  self.arrivalDate=[[NSDate alloc] initWithTimeInterval:(-(60*30)) sinceDate:self.startDate];//[self.startDate dateByAddingTimeInterval:(-(60*30))];
            
                 [(UITextField*)[self.view2 viewWithTag:7] setText:[appDelegate.dateFormatM stringFromDate:self.arrivalDate]];
            */
            ///////////////
            self.endDate=[[NSDate alloc] initWithTimeInterval:60*60 sinceDate:self.startDate];
            [(UITextField*)[self.view2 viewWithTag:9] setText:[appDelegate.dateFormatM stringFromDate:self.endDate]  ];
            
            
        }
        else if(buttonMode==6)
        {
            
            
            if(!startDate)
            {
                [self showAlertMessage:@"Start Time must be entered before End Time" title:@"ERROR"];
                
                return;
            }
            else
            {
                /*if(([startDate compare:endDate]==NSOrderedDescending) && endDate)
                {
                    [self showAlertMessage:@"End Date should be greater than Start Date" title:@"ERROR"];
                    
                    return;
                }
                else*/ if(([startDate compare:self.dpicker.date]==NSOrderedDescending) )
                {
                    [self showAlertMessage:@"End Time should be greater than Start Time" title:@"ERROR"];
                    return;
                }
            }
            
            
             self.endDate=self.dpicker.date;
              [(UITextField*)[self.view2 viewWithTag:9] setText:[appDelegate.dateFormatM stringFromDate:self.endDate]  ];
        }
        
    }
    else if(tag==29)
    {
        self.isFieldTap=1;
        if(self.arrPickerItems4.count>0)
        {
            //[(UITextField*)[self.view6 viewWithTag:4] text];
            
            
            ////////////ADDDEB//Commented
            
           // [self geocodeAddress];
            
            //////////////////////////////////////////////////
        /*self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
          [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=7;
       
      
        [self.picker reloadAllComponents];
        
        [self.picker selectRow:self.selectedRow3 inComponent:0 animated:NO];*/
           ///////////////////////////////////////////////////
            
            /////////////////////   24/7/14   /////////////////////////////
             ///////////////ADDDEB//UNCommented
            DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
            
            [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
                
                if (upatedIndex<0) {
                    self.selectedRow3=0;
                   
                     [(UITextField*)[self.view6 viewWithTag:4] setText:name ];
                }else{
                    self.selectedRow3=upatedIndex;
                     [(UITextField*)[self.view6 viewWithTag:4] setText:[self.arrPickerItems4 objectAtIndex:self.selectedRow3] ];
                   
                }
                
                
            }];
            
            dropDown.tableDataArr=self.arrPickerItems4;
            dropDown.selectedIndex=self.selectedRow3;
            [self showModal:dropDown];
            
            
            
          ///////////////////////////////////
            
                     
            
        }
        else
        {
            if(!isLoadingLocations)
            [self showAlertMessage:@"Please first choose location in the left box"];
        }
    }
    else if(tag==30)
    {
        
        
        if(arrPickerItems6.count>0)
        {
            
            /*if([[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal ] isEqualToString:@""])
            {
                [self showAlertMessage:@"Please choose team name first." title:@"ERROR"];
                
                return;
            }*/
           
            
            
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
          [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=8;
         
        [self.picker reloadAllComponents];
        
        [self.picker selectRow:self.selectedRow5 inComponent:0 animated:NO];
        }
        else
        {
            //[self showHudView:@"Getting All Team List..."];
            if(self.opponentteamindicator.hidden==YES)
            {
            [self getAllTaemListing];
            }
        }
    }
    else if(tag==31)
    {
        
        
        if(arrPickerItems5.count>0)
        {
            self.pickercontainer.hidden=NO;
            self.picker.hidden=NO;
            self.dpicker.hidden=YES;
            [self.view bringSubviewToFront:self.pickercontainer];
            [self.view bringSubviewToFront:self.top];
            self.top.hidden=NO;
            buttonMode=9;
            
            [self.picker reloadAllComponents];
            
            [self.picker selectRow:self.selectedRow4 inComponent:0 animated:NO];
            
            
            
        }
        else
        {
            //[self showHudView:@"Getting Team List..."];
            
            if(self.teamnameindicator.hidden==YES)
            {
                if(mode)//Add Latest Ch
            [self getTaemListing];
            }
        }
    }
    else if(tag==32)
    {
    self.pickercontainer.hidden=NO;
    self.picker.hidden=NO;
    self.dpicker.hidden=YES;
    [self.view bringSubviewToFront:self.pickercontainer];
    [self.view bringSubviewToFront:self.top];
    self.top.hidden=NO;
    buttonMode=10;
    
    
    [self.picker reloadAllComponents];
     NSLog(@"%i",self.selRow7);
    [self.picker selectRow:self.selRow7 inComponent:0 animated:NO];
        
        
    }
    else if(tag==33)
    {
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
        [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=12;
        
        
        [self.picker reloadAllComponents];
        
        [self.picker selectRow:self.selectedRow10 inComponent:0 animated:NO];
    }
    
}




-(void)setSingleTeam
{
    [self setEventType];
    
    if(mode==1)
    {
        if(self.segyesno.selectedSegmentIndex==0)
        {
            
            //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
            
            if(self.arrPickerItems5.count)
                [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
            
            if(self.arrPickerItems5.count)
                [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
            
            
            
            @autoreleasepool {
                
                NSArray *ar= nil;
                
                if(self.arrPickerItems5.count)
                    ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                
                
                if(ar.count>0){
                    NSString *homecolor=   [ar objectAtIndex:0];
                    if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                        [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                }
                
                
            }
            
            
            
            
            
            [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
            if (self.selectedRow10) {
                [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
                [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
            }
            else{
                [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
                [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
            }
            [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
            [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
        }
        else
        {
            
            @autoreleasepool {
                
                NSArray *ar= nil;
                
                if(self.arrPickerItems5.count)
                    ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                
                
                if(ar.count>1){
                    NSString *homecolor=   [ar objectAtIndex:1];
                    if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                        [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                }
                
                
            }
            
            

            
            
            
            [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
            [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
            [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
            [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
            [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
        }
    }
    else
    {
        [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
        [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
        [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
        /* [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
         [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
         
         [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
         [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];*/
        /*if(!isEditFirstTime)
         {
         isEditFirstTime=0;
         //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:@"" forState:UIControlStateNormal];
         [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
         
         [(UITextField*)[self.view6 viewWithTag:5] setText:@"" ];
         [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@""]];
         
         
         self.selRow7=0;
         self.selectedRow3=0;
         
         self.arrPickerItems4=[NSMutableArray array];
         [appDelegate createLocationManager];
         }*/
    }
    /* else if(mode==1)
     {*/
    
    /*if(!isEditFirstTime)
     {
     isEditFirstTime=0;
     //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
     [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
     
     [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
     [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"]];
     }*/
    /* [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
     [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
     [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
     [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
     [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
     
     }*/
    
    
    /////////////
    @autoreleasepool
    {
        
        
        
        NSString *str=  [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *str1=  [ [[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        if(([str isEqualToString:@""] || (!str)) && ([str1 isEqualToString:@""] || (!str1)))
        {
            self.yesbt.enabled=NO;
            self.nobt.enabled=NO;
        }
        else
        {
            self.yesbt.enabled=YES;
            self.nobt.enabled=YES;
        }
        
        
        
        
        
        
        
        
        //  [[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"];
        
    }
    

}



- (IBAction)eventNamebtAction:(id)sender
{
    
    
    self.isTapp=YES;
      [self resignAllTextFields];
    
    
    
    
   
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.pickercontainer];
        [self.view bringSubviewToFront:self.top];
        self.top.hidden=NO;
        buttonMode=11;
    
    
        [self.picker reloadAllComponents];
    
        [self.picker selectRow:self.selectedRow8 inComponent:0 animated:NO];
   
}

- (IBAction)btapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
        if (self.isTapp==YES) {
            self.alertViewBack.hidden=NO;
            self.alertViewCancel.hidden=NO;
//            self.lblDeleteAlertMsg.text=@"You've made unsaved changes. Would you like to go back and save them?";
//            isCancel=1;
            return;
        }
        
        
        [self dismissModal];
        
        
    }
    else
    {
        if(isFindPlaygroundProcess==0)
        {
        if(!isEditMode)
        {
        if(!mode)
        {
        [self sendDataToServer];
        }
        else
        {
           // [self.alertViewForSubmit show];
              [self sendDataToServer];
        }
        }
        else
        {
             [self sendDataToServer];
            
        }
        }
    }
}


/*- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView isEqual:self.alertViewForSubmit])
    {
        if(buttonIndex==1)
        {
            [self sendDataToServer];
        }
        else
        {
            self.segpripub.selectedSegmentIndex=0;
            [self segActionTapped:self.segpripub];
            
             if(self.arrPickerItems5.count)
            [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:0] objectForKey:@"team_name"] forState:UIControlStateNormal ];
            [self setEventType];
        }
    }
}*/


-(void)sendDataToServer
{
    
    NSString* tmp=nil;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
    NSString *errorstr=@"";
    
    
    NSString *teamName=[[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
        tmp=[[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        teamName=tmp;
        if ([tmp isEqualToString:@""])
        {
            
            
            if(errorstr.length==0)
                errorstr=@"Please enter team name.";
            
            
            
        }
        
        
        for(NSDictionary *str in arrPickerItems5)
        {
            if([[str  objectForKey:@"team_name"] isEqualToString:tmp])
            {
                [command setObject:[str  objectForKey:@"team_id"] forKey:@"team_id"];
                break;
            }
            
            
        }
        
    
    
    
    tmp=[[(UITextField*)[self.view1 viewWithTag:1] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if ([tmp isEqualToString:@""] || tmp==nil)
    {
        
        
        if(errorstr.length==0 || tmp==nil)
            errorstr=@"Please enter event name.";
        
        
        
    }
    
    if (tmp.length >20 || tmp==nil)
    {
        
        
        if(errorstr.length==0 || tmp==nil)
            errorstr=@"The Event name can be maximum 20 characters long.";
        
        
        
    }
    
    if( tmp!=nil)
    [command setObject:tmp forKey:@"event_name"];
    
    /*tmp=[[(UIButton*)[self.view1 viewWithTag:20] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"Event Type=%@ ",tmp);
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        
        if(errorstr.length==0)
            errorstr=@"One or more fields are missing.";
        
        
        
    }*/
    
    
    [command setObject:@"" forKey:@"event_type"];
    
    tmp=[self.dateformatdbString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//[[(UIButton*)[self.view1 viewWithTag:21] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"EventDateString=%@",tmp);
    
    
    if ([tmp  isEqualToString:@""] || (tmp==nil) || (tmp==NULL) || ([tmp isKindOfClass:[NSNull class]]))
    {
        
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter event date.";
        
        
        
    }
    
    
    [command setObject:tmp forKey:@"event_date"];
    
 
    
    
    
    tmp=[[(UITextField*)[self.view2 viewWithTag:7] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(mode)
    {
    if ([tmp  isEqualToString:@""] )
    {
        
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter arrival time.";
        
        
        
    }
    }
    if(arrivalDate)
        [command setObject:[[command objectForKey:@"event_date"]stringByAppendingString:[appDelegate.dateFormatFull stringFromDate:arrivalDate] ] forKey:@"arrival_time"];
    
    tmp=[[(UITextField*)[self.view2 viewWithTag:8] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter start time.";
        
        
        
    }
    
    if(startDate)
        [command setObject:[ [command objectForKey:@"event_date"]stringByAppendingString: [appDelegate.dateFormatFull stringFromDate:startDate]] forKey:@"start_time"];
    
    tmp=[[(UITextField*)[self.view2 viewWithTag:9] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter end time.";
        
        
        
    }
    
    if(endDate)
        [command setObject:[[command objectForKey:@"event_date"]stringByAppendingString:[appDelegate.dateFormatFull stringFromDate:endDate] ] forKey:@"end_time"];
    
    
    
    
    
    
    if(mode)
    {
        //ch tmp=[[(UIButton*)[self.view1 viewWithTag:29] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        tmp=[[(UITextField*)[self.view6 viewWithTag:4] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([tmp  isEqualToString:@""] )
        {
            
            
            
            /*if(errorstr.length==0)
                errorstr=@"Please enter field name.";*/
             [command setObject:@"" forKey:@"field_name"];
            
            
        }
        if (!tmp )
        {
             [command setObject:@"" forKey:@"field_name"];
        }
        else
        {
        [command setObject:tmp forKey:@"field_name"];
        }
    }
    
    tmp=[[(UITextField*)[self.view6 viewWithTag:5] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(mode==1)
    {
        if ([tmp  isEqualToString:@""] )
        {
            
            
            
            /*if(errorstr.length==0)
                errorstr=@"Please enter location.";*/
            
              [command setObject:@"" forKey:@"location"];
            
        }
        
        
       
    }
    
    if (!tmp )
    {
        [command setObject:@"" forKey:@"location"];
    }
    else
    {
    [command setObject:tmp forKey:@"location"];
    
    }

       
    
    NSString *opponentTeam=[[(UITextField*)[self.view6 viewWithTag:11]  text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(mode)
    {
        tmp=[[(UITextField*)[self.view3 viewWithTag:10] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            
            
            
           /*if(errorstr.length==0)
                errorstr=@"One or more fields are missing.";*/
            
          //  tmp=@"";
              [command setObject:@"" forKey:@"uniform"];
        }
        else
        {
        [command setObject:tmp forKey:@"uniform"];
        
        }
        tmp=[[(UITextField*)[self.view6 viewWithTag:11]  text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        opponentTeam=tmp;
        
        
        
        /*if ([tmp  isEqualToString:@""] )
        {
            
            
            
            if(errorstr.length==0)
                errorstr=@"One or more fields are missing.";
            
            
            
        }
        
        
        int f11=0;
        
        for(NSDictionary *str in arrPickerItems6)
        {
            if([[str  objectForKey:@"team_name"] isEqualToString:tmp])
            {
                [command setObject:[str  objectForKey:@"team_id"] forKey:@"opponent_team_id"];
                
                 [command setObject:[str  objectForKey:@"team_name"] forKey:@"opponent_team_name"];
                
                f11=1;
                break;
            }
            
            
        }
        
        if(!f11)
        {
            [command setObject:@"" forKey:@"opponent_team_id"];
            
            [command setObject:tmp forKey:@"opponent_team_name"];
        }*/
        [command setObject:@"" forKey:@"opponent_team_id"];
        
        [command setObject:@"" forKey:@"opponent_team_name"];
        
       /* tmp=[[(UITextField*)[self.view3 viewWithTag:12] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([tmp  isEqualToString:@""] )
        {
            
            
            
            if(errorstr.length==0)
                errorstr=@"One or more fields are missing.";
            
            
           // tmp=@"";
        }*/
        
        
        [command setObject:@"" forKey:@"things_to_bring"];
        
        
        
        
        NSString *str=nil;
        if(!self.segyesno.selectedSegmentIndex)
        {
            str=@"1";
        }
        else
        {
            str=@"0";
        }
        
        
        [command setObject:str forKey:@"is_home_ground"];
    }
    
      [command setObject:self.notestxtvw.text forKey:@"notes"];
    
    
    
    
    NSString *userId=[appDelegate.aDef objectForKey:LoggedUserID];
    
    if([command objectForKey:@"team_id"])
    {
    for(int i=0;i<appDelegate.centerVC.dataArrayUpButtonsIds.count;i++)
    {
       
        
        if([[appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:i] isEqualToString:[command objectForKey:@"team_id"]])
        {
           
            if([[appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:@"creator_id"])
                userId=[[appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:@"creator_id"];
            
            break;
        }
        
    }
    }
    
    
    
    if(isEditMode)
    {
        if(mode)
        {
            if(dataEvent.eventId)
            {
            [command setObject:dataEvent.eventId forKey:@"event_id"];
            }
            else
            {
            [command setObject:userId forKey:@"createdby"];
            }
            
        }
    }
    else
    {
        [command setObject:userId forKey:@"createdby"];
    }
    
    [command setObject:[NSString stringWithFormat:@"%i",self.selectedRow1] forKey:@"repeat"];
    [command setObject:[NSString stringWithFormat:@"%i",self.selectedRow2] forKey:@"alert"];
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:@"Error"];
        return;
    }
    
   /* if(mode)
    {*/
        /*if([teamName isEqualToString:opponentTeam] && (![teamName isEqualToString:@""]) && (![opponentTeam isEqualToString:@""]))
        {
            
            [self showAlertMessage:@"Both team name and opponent team can not be same." title:@"Error"];
            return;
        }*/
   // }
    
    self.requestDic=command;
    
    
    
        if(appDelegate.systemVersion<6.0)
        {
            [self accessGrantedForCalendar];
        }
        else
        {
            [self checkEventStoreAccessForCalendar];
        }
}



-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:ADDEVENT])
        {
            
        }
        else if([aR.requestSingleId isEqualToString:EDITEVENT])
        {
            
        }
        else if ([aR.requestSingleId isEqualToString:DELETEEVENT])
        {
            
        }
        else if([aR.requestSingleId isEqualToString:FINDPLAYGROUND])
        {
              isFindPlaygroundProcess=0;
            self.fieldnameindicator.hidden=YES;
            [self.fieldnameindicator stopAnimating];
            [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Field"];   //// 28/01/14
            [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            NSString *message=CONNFAILMSG;
            [self showHudAlert:message];
            [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
        
        return;
    }
    
     ConnectionManager *aR=(ConnectionManager*)aData1;
    NSString *str=(NSString*)aData;
    
    if([aR.requestSingleId isEqualToString:DELETEEVENT])
    {
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    
                    
                    EKEvent *newEvent=nil;
                    newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
                    
                    NSError *error=nil;
                    BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
                    NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
                    
                   // if(save)//ADDDEBNEW
                        [self deleteObjectOfTypeEvent:dataEvent];
                    
                    
                   // self.isFromPushBadge=0;
                    
                   /* NSString *message=[aDict objectForKey:@"message"];
                    [self showHudAlert:message];*/
                    
                    [self performSelector:@selector(hideHudViewHereDelete) withObject:nil afterDelay:0.0];
                }
                else
                {
                    
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@"Error"];
                }
            }
        }
        
        
        
    }
    
    else if(![aR.requestSingleId isEqualToString:FINDPLAYGROUND ])
    {
       
           
        
    NSLog(@"Data=%@",str);
    NSString *eventId=nil;
   // [self saveMessageEvent:eventId];
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                eventId= [NSString stringWithFormat:@"%@", [aDict objectForKey:@"event_id"]];
              Event *retevent= [self saveMessageEvent:eventId];
                
                
                /*if([[aDict objectForKey:@"message"] caseInsensitiveCompare:@"No player found"])
                
                
                [self showHudAlert:[aDict objectForKey:@"message"]];*/
                
                
                if([aR.requestSingleId isEqualToString:ADDEVENT ])
                
                    [self performSelector:@selector(hideHudViewHereFinished:) withObject:retevent afterDelay:0.0];
                else if([aR.requestSingleId isEqualToString:EDITEVENT])
                    [self performSelector:@selector(hideHudViewHereFinishedEdit:) withObject:retevent afterDelay:0.0];
                
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@"Error"];
            }
        }
    }
    
    }
    else if([aR.requestSingleId isEqualToString:FINDPLAYGROUND ])
    {
        isLoadingLocations=0;
          isFindPlaygroundProcess=0;
        self.fieldnameindicator.hidden=YES;
        [self.fieldnameindicator stopAnimating];
        [(UITextField*)[self.view6 viewWithTag:4] setPlaceholder:@"Field"];  //// 28/01/14
        [(UITextField*)[self.view6 viewWithTag:4] setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        self.arrPickerItems4= appDelegate.arrItems;
        
        
        
        
        NSLog(@"Location=%@",self.arrPickerItems4);
        if (self.isFieldTap==1) {
            self.isFieldTap=0;
            [self showFieldList];
        }
        
        
        if(isEditMode)
        {
            
            
            int m=0;
            
            
            for(NSString *str in arrPickerItems4)
            {
                if([str isEqualToString:dataEvent.fieldName])
                {
                   //ch [(UIButton*)[self.view1 viewWithTag:29]  setTitle:str forState:UIControlStateNormal];
                     [(UITextField*)[self.view6 viewWithTag:4]  setText:str ];
                    self.selectedRow3=m;
                    break;
                }
                
                m++;
            }
            m=0;
            
        }
    }
    
    
    
}

#pragma mark - ShowFieldList 24/7/14 -
-(void)showFieldList{
    
    DropDownViewController *dropDown=[[DropDownViewController alloc] initWithNibName:@"DropDownViewController" bundle:nil];
    
    [dropDown setUpdateBlock:^(int upatedIndex,NSString *name){
        
        if (upatedIndex<0) {
            self.selectedRow3=0;
            
            [(UITextField*)[self.view6 viewWithTag:4] setText:name ];
        }else{
            self.selectedRow3=upatedIndex;
            [(UITextField*)[self.view6 viewWithTag:4] setText:[self.arrPickerItems4 objectAtIndex:self.selectedRow3] ];
            
        }
        
        
    }];
    
    dropDown.tableDataArr=self.arrPickerItems4;
    dropDown.selectedIndex=self.selectedRow3;
    [self showModal:dropDown];
}


-(Event*)saveMessageEvent:(NSString*)eventId
{
    
    Event   *eventvar = nil;
    
    if(isEditMode)
    {
        eventvar= [self objectOfType1Event:dataEvent.eventIdentifier];
    }
    else
    {
    eventvar= (Event *)[NSEntityDescription insertNewObjectForEntityForName:EVENT inManagedObjectContext:self.managedObjectContext];
        
        if(mode==1)
        {
        eventvar.isCreated=[NSNumber numberWithBool:1];
            eventvar.playerName=COACH;
            eventvar.playerId=[appDelegate.aDef objectForKey:LoggedUserID];
            eventvar.playerUserId=[appDelegate.aDef objectForKey:LoggedUserID];
        }
        else
        {
              eventvar.isCreated=[NSNumber numberWithBool:0];
            eventvar.playerName=[NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]];
            eventvar.playerId=[appDelegate.aDef objectForKey:LoggedUserID];
            eventvar.playerUserId=[appDelegate.aDef objectForKey:LoggedUserID];
        }
    }
    
   
    
    eventvar.eventDate=self.eventDate;
    
    
   ////////////////////
    NSString *tmp=nil;
     NSString *teamId=nil;
      NSString *fieldname=nil;
      NSString *uniform=nil;
     NSString *oppoteamId=nil;
     NSString *thingstobring=nil;
    
    tmp=[[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    for(NSDictionary *str in arrPickerItems5)
    {
        if([[str  objectForKey:@"team_name"] isEqualToString:tmp])
        {
         teamId=   [str  objectForKey:@"team_id"];
            break;
        }
        
        
    }
 //ch   tmp=[[(UIButton*)[self.view1 viewWithTag:29] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    tmp=[[(UITextField*)[self.view6 viewWithTag:4] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

   fieldname= tmp ;
    tmp=[[(UITextField*)[self.view3 viewWithTag:10] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   uniform= tmp ;
    tmp=[[(UITextField*)[self.view6 viewWithTag:11]  text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    for(NSDictionary *str in arrPickerItems6)
    {
        if([[str  objectForKey:@"team_name"] isEqualToString:tmp])
        {
          oppoteamId= [str  objectForKey:@"team_id"] ;
            break;
        }
        
        
    }
    
    tmp=[[(UITextField*)[self.view3 viewWithTag:12] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    thingstobring=tmp;
    
    
    
  
    
    
    NSLog(@"%@-%@-%@-%@-%@",teamId,fieldname,uniform,oppoteamId,thingstobring);
  ///////////////////////
    
    /*if(mode)
    {*/
    eventvar.teamName= [[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([self.requestDic objectForKey:@"team_id"])
    eventvar.teamId= [self.requestDic objectForKey:@"team_id"];
    else
        eventvar.teamId=teamId;
    //}
    eventvar.eventName=[self.requestDic objectForKey:@"event_name"];
    eventvar.eventType=[self.requestDic objectForKey:@"event_type"];
    eventvar.location= [self.requestDic objectForKey:@"location"];
    
   /* if(mode)
    {*/
    if([self.requestDic objectForKey:@"field_name"])
    eventvar.fieldName= [self.requestDic objectForKey:@"field_name"];
    else
        eventvar.fieldName=fieldname;
   // }
    eventvar.repeat=[[(UIButton*)[self.view2 viewWithTag:22] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    ///////////////////////////
      NSDate *stDateF= [self dateFromSD:self.eventDate ];
    
   
   NSDate *arrDate= [self dateFromSD:self.arrivalDate];
     NSDate *arrDate1= [self dateFromSD:self.startDate];
     NSDate *arrDate2= [self dateFromSD:self.endDate];
  
   NSDate *actArrivalDate= [stDateF dateByAddingTimeInterval:[self.arrivalDate timeIntervalSinceDate:arrDate]];
    
     NSDate *actStartDate= [stDateF dateByAddingTimeInterval:[self.startDate timeIntervalSinceDate:arrDate1]];
    
      NSDate *actEndDate= [stDateF dateByAddingTimeInterval:[self.endDate timeIntervalSinceDate:arrDate2]];
   
    eventvar.arrivalTime=actArrivalDate;
    eventvar.startTime=actStartDate;
    eventvar.endTime=actEndDate;
    
   ////////////////////////////
    /*if(mode)
    {*/
    if([self.requestDic objectForKey:@"uniform"])
    eventvar.uniformColor=[self.requestDic objectForKey:@"uniform"];
    else
        eventvar.uniformColor=uniform;
    
  
    eventvar.opponentTeam= [[(UITextField*)[self.view6 viewWithTag:11]  text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
      if([self.requestDic objectForKey:@"opponent_team_id"])
    eventvar.opponentTeamId= [self.requestDic objectForKey:@"opponent_team_id"];
    else
        eventvar.opponentTeamId=oppoteamId;
    
    if([self.requestDic objectForKey:@"things_to_bring"])
    eventvar.thingsToBring= [self.requestDic objectForKey:@"things_to_bring"];
    else
        eventvar.thingsToBring=thingstobring;
    //}
    eventvar.alertString=[[(UIButton*)[self.view2 viewWithTag:26] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(![eventvar.alertString isEqualToString:@"Never"])
    {
        NSDate *d=[self getAlertDateForAlertString:eventvar.alertString];
    NSDate *arrDate3=[self dateFromSD:d];
        
    eventvar.alertDate=[stDateF dateByAddingTimeInterval:[d timeIntervalSinceDate:arrDate3]];
    }
    
    eventvar.isPublicAccept=[NSNumber numberWithInt:0];
    ///////////////************Create Events
    
    
    EKEvent *newEvent=nil;
    
    if(isEditMode)
    {
       newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
    }
    else
    {
   newEvent= [EKEvent eventWithEventStore:appDelegate.eventStore];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"Calendar"] == nil) // Create Calendar if Needed
    {
        EKSource *theSource = nil;
        
        for (EKSource *source in appDelegate.eventStore.sources)
        {
            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
            {
                theSource = source;
                NSLog(@"iCloud Store Source");
                break;
            }
            else
            {
                for (EKSource *source in appDelegate.eventStore.sources)
                {
                    if (source.sourceType == EKSourceTypeLocal)
                    {
                        theSource = source;
                        NSLog(@"iPhone Local Store Source");
                        break;
                    }
                }
            }
        }
        
        EKCalendar *cal;
        if(appDelegate.systemVersion<6.0)
        cal=[EKCalendar calendarWithEventStore:appDelegate.eventStore];
        else
        cal=[EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:appDelegate.eventStore ];
        
        cal.title = @"hello";
        cal.source = theSource;
        [appDelegate.eventStore saveCalendar:cal commit:YES error:nil];
        NSLog(@"cal id = %@", cal.calendarIdentifier);
        NSString *calendar_id = cal.calendarIdentifier;
        [defaults setObject:calendar_id forKey:@"Calendar"];
        [defaults synchronize];
        newEvent.calendar  = cal;
        
    }
    else
    {
        newEvent.calendar  = [appDelegate.eventStore calendarWithIdentifier:[defaults objectForKey:@"Calendar"]];
        NSLog(@"Calendar Existed");
        
        /*if(appDelegate.defaultCalendar)
            newEvent.calendar=appDelegate.defaultCalendar;*/
    }
    }
    
    
   /* if(appDelegate.systemVersion<6.0)
    newEvent.calendar=[EKCalendar calendarWithEventStore:appDelegate.eventStore];
    else
    newEvent.calendar=[EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:appDelegate.eventStore ];*/
    
    NSLog(@"newEvent.eventIdentifier1===%@",newEvent.eventIdentifier);
    
    
    
    
    
    newEvent.notes=self.notestxtvw.text;
    newEvent.title=eventvar.eventName;
    newEvent.startDate=eventvar.startTime;
    newEvent.endDate=eventvar.endTime;
    newEvent.location=eventvar.location;
    
    if(eventvar.alertDate)
    {
    EKAlarm *newAlarm=[EKAlarm alarmWithAbsoluteDate:eventvar.alertDate];
        [newEvent addAlarm:newAlarm];
    }
   
    
    
    if(![eventvar.repeat isEqualToString:@"Never"])
    {
        EKRecurrenceFrequency rfcy;
        
        
        if([eventvar.repeat isEqualToString:@"Every Day"])
        {
            rfcy=EKRecurrenceFrequencyDaily;
        }
        else if([eventvar.repeat isEqualToString:@"Every Week"])
        {
            rfcy=EKRecurrenceFrequencyWeekly;
        }
        else if([eventvar.repeat isEqualToString:@"Every Month"])
        {
            rfcy=EKRecurrenceFrequencyMonthly;
        }
        else
        {
            rfcy=EKRecurrenceFrequencyYearly;
        }
        
        EKRecurrenceRule *rule=[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:rfcy interval:1 end:nil];
        [newEvent addRecurrenceRule:rule];
        
    }
    if(mode)
    {
    eventvar.isPublic=[NSNumber numberWithBool:1];
    }
    else
    {
     eventvar.isPublic=[NSNumber numberWithBool:0];
    }
   
    eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
    eventvar.eventId=eventId;
    eventvar.eventDateString=[self getDateTimeCanName:eventvar.eventDate];
    
    ///////
    
    if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil) {
        eventvar.isHomeGame=[NSNumber numberWithBool:!(self.segyesno.selectedSegmentIndex)];
    }
    //eventvar.isHomeGame=[NSNumber numberWithBool:!(self.segyesno.selectedSegmentIndex)];   //// AD 19th june
     eventvar.notes=self.notestxtvw.text;
    
    //////
    
    
    NSError *error=nil;
  BOOL save=  [appDelegate.eventStore saveEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error];
    NSLog(@"SaveEventStatus=%i \n%@",save,error.description);
    
     NSLog(@"newEvent.eventIdentifier2===%@",newEvent.eventIdentifier);
    eventvar.eventIdentifier=newEvent.eventIdentifier;
    [appDelegate saveContext];
    
     appDelegate.isProcessEventPublic=0;
 
    return eventvar;
}

-(NSDate*)getAlertDateForAlertString:(NSString*)str
{ 
    
    
    
    NSDate *retDate=nil;
    
    if([str isEqualToString:@"At time of event"])
    {
       retDate= self.startDate;
    }
    else if([str isEqualToString:@"5 minutes before"])
    {
       retDate=  [self.startDate dateByAddingTimeInterval:(-(5*60))];
    }
    else if([str isEqualToString:@"15 minutes before"])
    {
       retDate=  [self.startDate dateByAddingTimeInterval:(-(15*60))];
    }
    else if([str isEqualToString:@"30 minutes before"])
    {
        retDate= [self.startDate dateByAddingTimeInterval:(-(30*60))];
    }
    else if([str isEqualToString:@"1 hour before"])
    {
        retDate= [self.startDate dateByAddingTimeInterval:(-(60*60))];
    }
    else if([str isEqualToString:@"2 hours before"])
    {
         retDate= [self.startDate dateByAddingTimeInterval:(-(2*60*60))];
    }
    else if([str isEqualToString:@"1 day before"])
    {
       retDate=  [self.startDate dateByAddingTimeInterval:(-(24*60*60))];
    }
    else if([str isEqualToString:@"2 days before"])
    {
       retDate=  [self.startDate dateByAddingTimeInterval:(-(2*24*60*60))];
    }
    
    
    return retDate;
}




-(void)checkEventStoreAccessForCalendar
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    switch (status)
    {
            // Update our UI if the user has granted access to their Calendar
        case EKAuthorizationStatusAuthorized: [self accessGrantedForCalendar];
            break;
            // Prompt the user for access to Calendar if there is no definitive answer
        case EKAuthorizationStatusNotDetermined: [self requestCalendarAccess];
            break;
            // Display a message if the user has denied or restricted access to Calendar
        case EKAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning" message:@"Please allow calendar access to enable event scheduling.\nGo under Settings > Privacy > Calendars" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
            break;
        case EKAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning" message:@"Please allow calendar access to enable event scheduling.\nGo under Settings > Privacy > Calendars" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}


// Prompt the user for access to their Calendar
-(void)requestCalendarAccess
{
    [appDelegate.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
            
             // Let's ensure that our code will be executed from the main queue
             dispatch_async(dispatch_get_main_queue(), ^{
                 // The user has granted access to their Calendar; let's populate our UI with all events occuring in the next 24 hours.
                 [self accessGrantedForCalendar];
             });
         }
     }];
}

-(void)accessGrantedForCalendar
{
    appDelegate.defaultCalendar = appDelegate.eventStore.defaultCalendarForNewEvents;
  
   
    
    
    
    if(mode)
    {
        
        
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:self.requestDic];
        
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        appDelegate.isProcessEventPublic=1;
        
        
        if(isEditMode)
        {
            if([self.requestDic objectForKey:@"event_id"])
                [appDelegate sendRequestFor:EDITEVENT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
            else
                [appDelegate sendRequestFor:ADDEVENT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
        else
            [appDelegate sendRequestFor:ADDEVENT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    }
    else
    {
        
        Event *eventn=   [self saveMessageEvent:nil];
        
        
        if(isEditMode)
        {
            //
            //
            //
            //
            //
            //            [self hideHudView];
            
            // UINavigationController *aNav=self.navigationController;
           // [self.navigationController popToRootViewControllerAnimated:NO];
              [self dismissModal];
            EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
            eVC.dataEvent=eventn;
            [appDelegate.navigationControllerCalendar pushViewController:eVC animated:NO ];
            
            
            
            // [aNav pushViewController:eVC animated:NO];
        }
        else
        {
            //[self.navigationController popViewControllerAnimated:YES];
            [self dismissModal];
        }
        
    }

}


- (IBAction)segActionTapped:(UISegmentedControl*)sender
{
    
    if([sender isEqual:self.segyesno])
    {
        int tag=[self.segyesno selectedSegmentIndex];
        [self setYesNoBtn:tag];
        
        if(self.segyesno.selectedSegmentIndex==0)
        {
            NSString *scompare= [[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@" " withString:@""];
           
            
            
            if( (![scompare isEqualToString:@""]) && (![scompare isEqualToString:@"Private"]))
            {
                
                /*if(!isEditFirstTime)
                {*/
                    isEditFirstTime=0;
       //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
                
                
                  if(self.arrPickerItems5.count)
                  {
            [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
                    
        [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
                    
                    @autoreleasepool {
                        
                      
                        
                        NSArray *ar= nil;
                        
                      
                            ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                        
                        
                        NSString *homecolor=nil;
                        if(ar.count>0){
                            homecolor=   [ar objectAtIndex:0];
                            if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                                [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                            
                            
                            int m1=0;
                            
                            for(NSString *str in pickerArr7)
                            {
                                if([str isEqualToString:homecolor])
                                {
                                    self.selRow7=m1;
                                    
                                    NSLog(@"%i",self.selRow7);
                                    break;
                                }
                                
                                m1++;
                            }
                        }
                        
                        
                     

                    
                    }
                    }
                //}
                [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
                if (self.selectedRow10) {
                    [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
                    [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
                }
                else{
                    [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
                    [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
                }
                  [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
                  [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
                
            }
            
            
             
        }
        else
        {
            [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
              [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
            [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
            [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
              [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
            
            
            if(!isEditFirstTime)
            {
                 isEditFirstTime=0;
           //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:@"" forState:UIControlStateNormal];
              [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
                
            [(UITextField*)[self.view6 viewWithTag:5] setText:@"" ];
            
            
                if(self.arrPickerItems5.count){
                    if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                        [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@""]];
                    
                }
            
            
           // self.selRow7=0;//Commented Later
            self.selectedRow3=0;
            
            self.arrPickerItems4=[NSMutableArray array];
                
            /////////ADDDEB
            [appDelegate getNewUpdate];
            /////////
                [(UITextField*)[self.view6 viewWithTag:4] setText:dataEvent.fieldName ];
                [(UITextField*)[self.view6 viewWithTag:5] setText:dataEvent.location];
            }
            
            @autoreleasepool {
                
                NSArray *ar= nil;
                
                if(self.arrPickerItems5.count)
               ar= [[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"] componentsSeparatedByString:@","];
                
                if(ar.count>1){
                    NSString *homecolor=   [ar objectAtIndex:1];
                    if (![[(UIButton*)[self.view3 viewWithTag:33] titleLabel].text isEqualToString:@""] && [(UIButton*)[self.view3 viewWithTag:33] titleLabel].text!=nil)
                        [(UITextField*)[self.view3 viewWithTag:10] setText:homecolor];
                    
                    int m1=0;
                    
                    for(NSString *str in pickerArr7)
                    {
                        if([str isEqualToString:homecolor])
                        {
                            self.selRow7=m1;
                            
                            NSLog(@"%i",self.selRow7);
                            break;
                        }
                        
                        m1++;
                    }
                }
                
                
            }
        }
        
       
       
    }
    else
    {
        if(self.segpripub.selectedSegmentIndex==0)
        {
        mode=0;
        }
        else
        {

        
        mode=1;
        }
        
        
    }
    
    
    
}






- (IBAction)segBtAction:(id)sender
{
    int tag=[sender tag];
    
    
    NSString *scompare= [[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    if( (![scompare isEqualToString:@""]) && (![scompare isEqualToString:@"Private"]))
    {
        if(tag==0)
             [self showAlertMessage:@"Uniform and Location set from team details" title:@""];
        
    }
    else
    {
        [self showAlertMessage:@"Please select team." title:@"Error"];
        return;
    }
    
    
    self.segyesno.selectedSegmentIndex=tag;
    [self segActionTapped:self.segyesno];
    [self setYesNoBtn:tag];
    
    /*if(tag==0)
    {
        
        if( (![[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] isEqualToString:@""]) && (![[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] isEqualToString:@"Private"]))
        {
            
            if(!isEditFirstTime)
            {
                isEditFirstTime=0;
                //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] forState:UIControlStateNormal];
                [(UITextField*)[self.view6 viewWithTag:4] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"field_name"] ];
                
                [(UITextField*)[self.view6 viewWithTag:5] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_zipcode"]];
                [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"uniform_color"]];
            }
            [(UIButton*)[self.view6 viewWithTag:29] setEnabled:NO];
            [(UITextField*)[self.view6 viewWithTag:4] setEnabled:NO];
            [(UITextField*)[self.view6 viewWithTag:5] setEnabled:NO];
            [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
            [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
            
        }
        
        
        
    }
    else
    {
        [(UIButton*)[self.view6 viewWithTag:29] setEnabled:YES];
        [(UITextField*)[self.view6 viewWithTag:4] setEnabled:YES];
        [(UITextField*)[self.view6 viewWithTag:5] setEnabled:YES];
        [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
        [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
        
        
        if(!isEditFirstTime)
        {
            isEditFirstTime=0;
            //ch [(UIButton*)[self.view1 viewWithTag:29] setTitle:@"" forState:UIControlStateNormal];
            [(UITextField*)[self.view6 viewWithTag:4] setText:@""];
            
            [(UITextField*)[self.view6 viewWithTag:5] setText:@"" ];
            [(UITextField*)[self.view3 viewWithTag:10] setText:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@""]];
            
            
            self.selRow7=0;
            self.selectedRow3=0;
            
            self.arrPickerItems4=[NSMutableArray array];
            [appDelegate createLocationManager];
        }
    }*/
    
    
    
}

-(void)setEventType
{
    // [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:self.selectedRow4] objectForKey:@"team_name"] forState:UIControlStateNormal ]
    NSString *s=   [(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal ];
    
   if( [s isEqualToString:@"Private"])
   {
          mode=0;
     //  self.homegamelab.textColor=appDelegate.veryLightGrayColor;
       self.segyesno.enabled=NO;
       self.yesbt.enabled=NO;
       self.nobt.enabled=NO;
       
     //   [(UITextField*)[self.view3 viewWithTag:10] setTextColor:appDelegate.veryLightGrayColor];
       [(UITextField*)[self.view3 viewWithTag:10] setEnabled:NO];
       [(UIButton*)[self.view3 viewWithTag:32] setEnabled:NO];
     //  [(UILabel*)[self.view3 viewWithTag:350] setTextColor:appDelegate.veryLightGrayColor];
       
       [(UITextField*)[self.view6 viewWithTag:4] setHidden:YES];
       [(UIButton*)[self.view6 viewWithTag:29] setHidden:YES];
       [(UIView*)[self.view6 viewWithTag:101] setHidden:YES];
       //  [(UITextField*)[self.view6 viewWithTag:5] setFrame:CGRectMake(100, 41, 95*2, 26)];
       
       [(UITextField*)[self.view6 viewWithTag:5] setPlaceholder:@"Zip/City"];
   }
    else
    {
           mode=1;
        self.homegamelab.textColor=appDelegate.labelRedColor;
        self.segyesno.enabled=YES;
        self.yesbt.enabled=YES;
        self.nobt.enabled=YES;
        
        // [(UITextField*)[self.view3 viewWithTag:10] setTextColor:self.darkgraycolor];
        [(UITextField*)[self.view3 viewWithTag:10] setEnabled:YES];
        [(UIButton*)[self.view3 viewWithTag:32] setEnabled:YES];
       // [(UILabel*)[self.view3 viewWithTag:350] setTextColor:appDelegate.labelRedColor];
        
        
        [(UITextField*)[self.view6 viewWithTag:4] setHidden:NO];
        [(UIButton*)[self.view6 viewWithTag:29] setHidden:NO];
        [(UIView*)[self.view6 viewWithTag:101] setHidden:NO];
        //[(UITextField*)[self.view6 viewWithTag:5] setFrame:CGRectMake(15, 16, 142, 44)];
        
        if ([[[(UIButton*)[self.view3 viewWithTag:33] titleLabel] text] isEqualToString:@"Yes"]) {
            [(UITextField*)[self.view6 viewWithTag:5] setPlaceholder:@"Getting Current Location"];
        }
        
        
    }
    
  // [(UITextField*)[self.view3 viewWithTag:10] setText:[self.pickerArr7 objectAtIndex:self.selRow7]];

}




- (IBAction)topBarTeamAdminAction:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
       
        TeamEventsVC *teVC= (TeamEventsVC*)[appDelegate.navigationControllerTeamEvents.viewControllers objectAtIndex:0];
        
        [teVC createEvent];
        
        
    }
    else if(tag==1)
    {
        
        if(isFindPlaygroundProcess==0)
        {
        EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
              [self dismissModal];
       // [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
        
        
        
        
        eVC.eventheaderlab.text=CREATETEAMEVENTINVITATION;
        eVC.isMonth=0;
            eVC.custompopuptopselectionvw.hidden=YES;
            eVC.custompopupbottomvw.hidden=YES;
        eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
        [eVC.callistvc loadTable];
        eVC.calvc.view.hidden=YES;
        eVC.callistvc.view.hidden=NO;
        
        eVC.downarrowfilterimavw.hidden=NO;
        eVC.downarrowfilterbt.hidden=NO;
       
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
        
         [eVC setOwnViewDependOnFlag:1];
        }
        else
        {
            [self showAlertMessage:@"Please wait for getting location fields"];
        }
    }
    else if(tag==2)
    {
      
       /* SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
        teamView.itemno=self.selectedTeamIndex;
        teamView.editMode=YES;
        teamView.isInvite=1;
        teamView.selectedTeamIndex=self.selectedTeamIndex;
        teamView.isTeamView=NO;
        [self.navigationController pushViewController:teamView animated:NO];*/
    }
    
    
    
    
    
    
}

- (IBAction)deleteAction:(id)sender
{
    if(isFindPlaygroundProcess==0)
    {
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure want to delete this event?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView show];
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView isEqual:self.alertViewForSubmit])
    {
        if(buttonIndex==1)
        {
            [self sendDataToServer];
        }
        else
        {
            self.segpripub.selectedSegmentIndex=0;
            [self segActionTapped:self.segpripub];
            
            if(self.arrPickerItems5.count)
                [(UIButton*)[self.view1 viewWithTag:31] setTitle:[[self.arrPickerItems5 objectAtIndex:0] objectForKey:@"team_name"] forState:UIControlStateNormal ];
            [self setEventType];
        }
    }
    else
    {
    if(buttonIndex==1)
    {
        if([dataEvent.isPublic boolValue])
        {
            
            if([dataEvent.isCreated boolValue])
            {
                NSMutableDictionary *command = [NSMutableDictionary dictionary];
                
                NSLog(@"%@-%@",dataEvent.teamId,dataEvent.eventId);
                
                [command setObject:dataEvent.teamId forKey:@"team_id"];
                
                [command setObject:dataEvent.eventId forKey:@"event_id"];
                
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                
                
                NSString *jsonCommand = [writer stringWithObject:command];
                
                
                [self showHudView:@"Deleting..."];
                [self showNativeHudView];
                NSLog(@"RequestParamJSON=%@",jsonCommand);
                
                
                [appDelegate sendRequestFor:DELETEEVENT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
            }
            //            else
            //            {
            //                EKEvent *newEvent=nil;
            //                newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
            //                NSLog(@"DeleteEventDetails=%@--%@",dataEvent.eventIdentifier,newEvent);
            //                NSError *error=nil;
            //                BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            //                NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
            //
            //                if(save)
            //                    [self deleteObjectOfTypeEvent:dataEvent];
            //
            //
            //                 [self.navigationController popViewControllerAnimated:YES];
            //
            //            }
        }
    }
}

}



///////   06/03/2015  //////


- (IBAction)invitePlayerForEvent:(id)sender {
    
   
    NSString *errorstr=@"";
    NSString *teamId=@"";
    
    NSString *teamName=[[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *tmp=[[(UIButton*)[self.view1 viewWithTag:31] titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    teamName=tmp;
    if ([tmp isEqualToString:@""])
    {
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter team name.";
        
        
        
    }
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:@"Error"];
        return;
    }
    
    for(NSDictionary *str in arrPickerItems5)
    {
        if([[str  objectForKey:@"team_name"] isEqualToString:tmp])
        {
            teamId=[str  objectForKey:@"team_id"];
            break;
        }
        
        
    }

    
    EventPlayerStatusVC *player=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
    player.isFromAttendance=1;
    if(!isEditMode)
    {
        player.eventId=@"";
        player.eventTeamId=teamId;
    }
    else{
        player.eventId=dataEvent.eventId;
        player.eventTeamId=dataEvent.teamName;
    }
    
    
   // self.isModallyPresentFromCenterVC=1;
    self.inviteViewPlayer.hidden=NO;
    [self.inviteViewPlayer addSubview:player.view];
    
    
    
    
   // [self showModalEventInvite:player];
    //[self.navigationController pushViewController:player animated:YES];
    
//    UINavigationController *aNav=appDelegate.navigationControllerCalendar;
//    [aNav popToRootViewControllerAnimated:NO];
//    [appDelegate.navigationControllerCalendar pushViewController:player animated:NO ];*/
    
}



/////////  AD  /////////
- (IBAction)updateAlertDone:(UIButton *)sender {
    
    self.alertViewBack.hidden=YES;
    self.alertView.hidden=YES;
    self.alertViewCancel.hidden=YES;
    
    if (sender.tag==1) {
        
        [self dismissModal];
        return;
    }
    else if (sender.tag==2) {
        return;
    }
    
    UINavigationController *aNav=appDelegate.navigationControllerCalendar;
    [aNav popToRootViewControllerAnimated:NO];
    // [self dismissModal];
    [self.appDelegate.centerViewController dismissViewControllerAnimated:NO completion:nil];
    self.isModallyPresentFromCenterVC=0;
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    eVC.dataEvent=self.createEvent;
    // [appDelegate.navigationControllerCalendar pushViewController:eVC animated:NO ];
    
    
    
    [aNav pushViewController:eVC animated:NO];
    
}
@end
