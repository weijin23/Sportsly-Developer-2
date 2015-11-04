//
//  TeamEventsVC.m
//  Wall
//
//  Created by Mindpace on 12/02/14.
//
//
#import "TeamMaintenanceVC.h"
#import "CenterViewController.h"
#import "HomeVC.h"
#import "EventEditViewController.h"
#import "TeamEventsVC.h"

@interface TeamEventsVC ()

@end

@implementation TeamEventsVC

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
    // Do any additional setup after loading the view from its nib.
   // self.topview.backgroundColor=appDelegate.backgroundPinkColor;
    
    
}





-(void)createEvent
{
    [self.teamNavController.view removeFromSuperview];
    self.teamNavController=nil;
    
    
    
    if(appDelegate.JSONDATAarr.count)
    {
        self.topview.hidden=YES;
    }
    else
    {
        self.topview.hidden=NO;
        [self.view bringSubviewToFront:self.topview];
        return;
    }
    
    
    
    
    EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
    eVc.mode=1;
    // eVc.selectedTeamIndex=self.selectedTeamIndex;
    eVc.defaultDate=[NSDate date];
    UINavigationController *aNav=[[UINavigationController alloc] initWithRootViewController:eVc];
    //  [self.navigationController pushViewController:eVc animated:YES];
    
    self.teamNavController=aNav;
    self.teamNavController.delegate=self;
    aNav=nil;
    self.teamNavController.navigationBarHidden=YES;
    
    
    CGRect navFrameRect;
  //  navFrameRect=CGRectMake(0, 0, 320,(351+37+36));
    float height=appDelegate.centerViewController.view.bounds.size.height-49;//Ch in xcode 5 (424)
    
     if(appDelegate.isIphone5)
       navFrameRect=CGRectMake(0,0,320,(height+88));
     else
       navFrameRect=CGRectMake(0,0,320,(height));
     
     
    self.teamNavController.view.frame=navFrameRect;
    [self.view addSubview:self.teamNavController.view];
    [self.view bringSubviewToFront:self.teamNavController.view];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    CGRect m= self.teamNavController.view.frame;
    m.origin.y=0;
    
    
    
        self.teamNavController.view.frame=m;
        
    
    
}

- (IBAction)firsttimesecondAction:(id)sender {
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]]){
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
        TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
        teamVc.isShowFristTime=YES;
    }
    /* [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:nil];*/
}

#pragma mark - CreateTeamScroolView
-(void)createTeamScroll{
    
    float x=0;
    float y=1;
    float btag=0;
    int j=0;
    NSMutableArray *dataArrayUpButtons=[NSMutableArray array];
    
    for (int i=0; i<[self.appDelegate.JSONDATAarr count]; i++) {
        
        [dataArrayUpButtons addObject:[[self.appDelegate.JSONDATAarr objectAtIndex:i] objectForKey:@"team_name"]];
    }
    
    for(NSString* str in dataArrayUpButtons)
    {
        UIView *btvw=[[UIView alloc] init];
        btvw.backgroundColor=appDelegate.topBarRedColor;
        
        UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        bt.titleLabel.textAlignment=NSTextAlignmentLeft;
        [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
        [bt setTitle:str forState:UIControlStateNormal];
        bt.tag=btag++;
        
        if(bt.tag==0)
            self.buttonfirstinscroll=bt;
        [bt addTarget:self action:@selector(upBtapped:) forControlEvents:UIControlEventTouchUpInside];
        CGSize s=[str sizeWithFont:bt.titleLabel.font constrainedToSize:CGSizeMake(190, 14)];
        
       /* UIButton * crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CALayer * l = [crossButton layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:8.0];
        crossButton.hidden=YES;
        crossButton.tag=bt.tag;
        [crossButton addTarget:self action:@selector(CrossButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [crossButton setImage:self.crossImage forState:UIControlStateNormal];
        
        UILongPressGestureRecognizer *pahGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerStateChanged:)];
        pahGestureRecognizer.minimumPressDuration = 1.0;
        
        [bt addGestureRecognizer:pahGestureRecognizer];*/
        
        // NSLog(@"XX=%f",x);
        //  NSLog(@"01F.%f 02F.%f",(x+s.width+20),(320*y));
        
        if((x+s.width+20)>(240*y))
        {
            
            x=(y*240);
            y++;
        }
        
        
        bt.frame=CGRectMake(0,0, (s.width+20), 35);
      //  crossButton.frame=CGRectMake(bt.frame.size.width - 30, 5, 25, 25);
        btvw.frame=CGRectMake(x,0, (s.width+20), 35);
        
        [self.teamScroll addSubview:btvw];
        [btvw addSubview:bt];
      //  [bt addSubview:crossButton];
        btvw.clipsToBounds=NO;
        //  NSLog(@"CurrStr=%@ - %f",str,x);
        
        
        x+=(s.width+20);
        // NSLog(@"CurrStr1=%@ - %f",str,x);
        /*if(x<320)
         {
         UIView *divider=[[UIView alloc] initWithFrame:CGRectMake(x, 6, 1, 12)];
         divider.backgroundColor=self.darkgraycolor;
         [self.menuupscrollview addSubview:divider];
         }*/
        if(!(j>=dataArrayUpButtons.count))
        {
            
            int f=0;
            
            
            if((j+1)<dataArrayUpButtons.count)
            {
                NSString *nextstr=[dataArrayUpButtons objectAtIndex:(j+1)];
                
                //NSLog(@"1.%@",nextstr);
                
                CGSize s1=[nextstr sizeWithFont:bt.titleLabel.font constrainedToSize:CGSizeMake(190, 14)];
                // NSLog(@"XX=%f",x);
                // NSLog(@"01.%f 02.%f",(x+s1.width+20),(320*y));
                
                
                if((x+s1.width+20)>(240*y))
                {
                    f=1;
                    //NSLog(@"2.%@",nextstr);
                }
            }
            
            
            
            if(f==0)
            {
                if((j+1)<dataArrayUpButtons.count)
                {
                    UIView *divider=[[UIView alloc] initWithFrame:CGRectMake((btvw.frame.size.width-1), 0, 1, 35)];
                    divider.backgroundColor=appDelegate.veryLightGrayColor;//verylightgray
                    [btvw addSubview:divider];
                    [btvw bringSubviewToFront:bt];
                }
            }
        }
        j++;
    }
    
    self.teamScroll.contentSize=CGSizeMake((y*240), 35);
    
    
}

-(void)upBtapped:(id)sender
{
    int tag=[sender tag];
  
    
    for(id v in self.teamScroll.subviews)
    {
        if([v isMemberOfClass:[UIView class]])
        {
            UIView *vw=(UIView*)v;
            
            UIButton *bt= nil;
            for(id viww in vw.subviews)
                if([viww isMemberOfClass:[UIButton class]])
                    bt=(UIButton*)viww;//(UIButton*)v;
            
            
            if(tag==[bt tag])
            {
                CGPoint orgPoint= vw.frame.origin;
                CGFloat orgX=orgPoint.x;
                CGFloat flo=240;
                
                orgX=    orgX -((int)orgX % (int)flo);
                
                self.teamScroll.contentOffset=CGPointMake(orgX,orgPoint.y);
                
                if(orgX<240)
                {
                    self.redbackindicator.hidden=YES;
                    self.redbackindicator1.hidden=YES;
                }
                else if(orgX>=240)
                {
                    self.redbackindicator.hidden=NO;
                    self.redbackindicator1.hidden=NO;
                }
                
                if((orgX+240+10)> self.teamScroll.contentSize.width)
                {
                    self.rednextindicator.hidden=YES;
                    self.rednextindicator1.hidden=YES;
                }
                else
                {
                    self.rednextindicator.hidden=NO;
                    self.rednextindicator1.hidden=NO;
                }
                
                [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
                [bt.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                bt.superview.backgroundColor=appDelegate.topBarRedColor;
                
                // int previous=lastSelectedTeam;
                
                // lastSelectedTeam=tag;
            }
            else
            {
                [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
                [bt.titleLabel setFont:[UIFont systemFontOfSize:12]];
                bt.superview.backgroundColor=appDelegate.topBarRedColor;
            }
        }
    }
    
    
    if([self.teamNavController.view.superview isEqual:self.view])
        [self.teamNavController.view removeFromSuperview];
    
   /* TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    addTeam.selectedTeamIndex=[sender tag];
    addTeam.teamVc=self;
    addTeam.selectedTeamButton=sender;*/
   
    
    EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
    eVc.mode=1;
   // eVc.selectedTeamIndex=self.selectedTeamIndex;
    eVc.defaultDate=[NSDate date];
     UINavigationController *aNav=[[UINavigationController alloc] initWithRootViewController:eVc];
  //  [self.navigationController pushViewController:eVc animated:YES];
    
    self.teamNavController=aNav;
    aNav=nil;
    self.teamNavController.navigationBarHidden=YES;
    if(appDelegate.isIphone5)
        self.teamNavController.view.frame=CGRectMake(0,36,320,(appDelegate.commonHeight+88));
    else
        self.teamNavController.view.frame=CGRectMake(0,36,320,appDelegate.commonHeight);
    [self.view addSubview:self.teamNavController.view];
    [self.view bringSubviewToFront:self.teamNavController.view];
    
    //    //[self.navigationController popViewControllerAnimated:NO];
    //    TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    //    addTeam.selectedTeamIndex=[sender tag];
    //    self.teamNavController.viewControllers=[[NSArray alloc] initWithObjects:addTeam, nil] ;
    //
    //    [self.navigationController pushViewController:addTeam animated:NO];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
