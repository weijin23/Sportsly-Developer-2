//
//  FAQViewController.m
//  Wall
//
//  Created by Sukhamoy on 02/01/14.
//
//

#import "FAQViewController.h"
#import "FaqCell.h"
#import "CenterViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController
@synthesize questions,answers;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERFAQ object:nil];

    
    
    self.questions=[NSArray arrayWithObjects:@"1) I am a first-time user,  what do I do?",@"2) What is a Timeline?",@"3) Can I have more than one Timeline?",@"4) How do I move from one Timeline to the other?",@"5) How do I create a Team?",@"6) How do I add players to my Team?",@"7) How do I invite players to join the team?",@"8) How do I see what players have accepted Team invite",@"9) What if some players choose not to use the app?",@"10) Who can create Events (practice, games, etc)?",@"11) What does the Event screen do?",@"12) Can I see who is attending a particular event?",@"13) Can I view all my events in a Calendar within this app?",@"14) Can I email, call or text a team member?",@"15) How can I contact a team member?",@"16) What does the Message screen do?",@"17) Can I Group Chat?",@"18) What does the Friends screen do?",@"19) Will my friends be bombarded with unnecessary team event emails?",@"20) Can I view all my pictures and videos posted by team members during the season from all the teams I belong to?",@"21) Can I upload pictures and videos to Facebook, Twitter, etc",@"22) Can I view my events in the iPhone Calendar?",@"23) Will I get emails for all team events?",@"24) How do I control what emails I receive?",@"25) How do I control what push notifications I receive?",@"26) Who can post to the team Timeline  (wall)",@"27) When a non-team member posts on my team’s Timeline, can I see who invited that person?",nil];
    
    
    
    self.answers=[NSArray arrayWithObjects:@"You can create a team by clicking on the top right icon in Timelines; or you can wait for  your Team Admin to create a team and invite you; or a friend or family member can invite you to view their team moments; or go to the Team icon at the bottom of the screen to create a new team.",@"A timeline is a wall to share team moments by writing comments, or posting pictures and videos.",@"Yes, absolutely can have as many timelines as the teams you or your family/friends belong to.Each team you belong to will have its own timeline.Multiple teams can be accessed via the scroll bar at the top of any screen.",@"Scroll by swiping left or right on the scroll bar at the top.",@"Click top right icon in Timelines (main wall screen).Under Team screen, click top right icon to create a new team. You can also create a new team or access any team information via the Team icon in the bottom bar.",@"Click top right icon and click the Players tab and + button at top right. Add players by populating manually or select from your Contacts list by clicking on.",@"Click on top right icon and click on Players tab or go to Teams icon in the bottom bar and click on Players tab.Under Players tab click Add button to the right of any player or click Select all to invite all at the same time.",@"Go to Teams and click on Players tab. Accepted player’s color changes to blue.",@"Non-app users will still get all team emails.",@"Events are created by Team Admin (coach, team parent, etc) in the Events screen.",@"Team admin can create team events such as practice, tournaments, etc.Team players can view all their team events in one place.",@"Yes – In the Event screen click on the specific event and click on Invitees at the bottom of the Event details.",@"Yes – Go to Events screen and click Calendar.",@"Yes (see how below)",@"Click top right Team Icon in any Timeline or go to Teams screen and click on Players tab.Click on any player you wish to communicate with.You can call, email or chat with that team member or any of their optional contacts.",@"Allows you to chat with teams and friends within the app. You can chat individually or as a whole team.",@"Yes.",@"One can invite friends and family member to view your team wall.These friends can view and post to your Timeline but cannot view Team event details.",@"No. Friends can view your Timeline and can also post comments, videos and pictures.They will not be bothered by team event scheduling emails or notifications.",@"Yes – Go to Team Photos in the left panel.You can view all pictures and videos from all your Timelines in one place in Team Photos.",@"Yes go to Team Photos in left panel.Click Select (top right) – make your selection.Click Share on bottom of screen.",@"Yes.",@"Yes - check your settings to make sure they are turned on receive notifications and emails.You can turn it off as well.",@"Under Settings in left panel, turn on/off under Emails.",@"Under Settings in Left panel, turn on/off under Push.",@"All team players and any friends invited by them.",@"Yes – click on the poster’s name.",nil];
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERFAQ object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




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
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_message.png"] style:UIBarButtonItemStylePlain target:self action:@selector(messageToplayer:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"FAQs";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}





#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERFAQ object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

#pragma mark - UITableViewDatasourace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.questions.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isiPad) {
        CGSize textSize= [self getSizeOfText:[self.answers objectAtIndex:indexPath.section] :CGSizeMake (710,9999) :[UIFont fontWithName:@"Helvetica" size:20.0]];
        return textSize.height+28;
    }
    CGSize textSize= [self getSizeOfText:[self.answers objectAtIndex:indexPath.section] :CGSizeMake (260,9999) :[UIFont fontWithName:@"Helvetica" size:14.0]];
    return textSize.height+28;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (self.isiPad) {
        UIView  *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 100)];
        view.backgroundColor=[UIColor clearColor];
        
        UIImageView *imgVw=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 100)];
        imgVw.image=[UIImage imageNamed:@"faq_header_bg_ipad.png"];
        [view addSubview:imgVw];
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(34,0,700,100)];
        lbl.textColor=[UIColor blackColor];
        lbl.numberOfLines=0;
        lbl.font=[UIFont fontWithName:@"Helvetica" size:20.0];
        lbl.text=[self.questions objectAtIndex:section];
        [view addSubview:lbl];
        
        return view;
    }
    
    
    UIView  *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgVw=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    imgVw.image=[UIImage imageNamed:@"faq_header_bg.png"];
    [view addSubview:imgVw];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(27,0,265,50)];
    lbl.textColor=[UIColor blackColor];
    lbl.numberOfLines=0;
    lbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    lbl.text=[self.questions objectAtIndex:section];
    [view addSubview:lbl];

    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isiPad) {
        return 100.0;
    }
    return 50.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"FaqCell";
    
    FaqCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [FaqCell customCell];
      
        
    }
    
    //cell.fqLbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
    cell.fqLbl.textColor=[UIColor grayColor];
    
    if (self.isiPad) {
        CGSize textSize= [self getSizeOfText:[self.answers objectAtIndex:indexPath.section] :CGSizeMake (710,9999) :[UIFont fontWithName:@"Helvetica" size:20.0]];
        cell.fqLbl.frame=CGRectMake(cell.fqLbl.frame.origin.x, cell.fqLbl.frame.origin.y, cell.fqLbl.frame.size.width, textSize.height);
    }
    else{
    CGSize textSize= [self getSizeOfText:[self.answers objectAtIndex:indexPath.section] :CGSizeMake (260,9999) :[UIFont fontWithName:@"Helvetica" size:14.0]];
        cell.fqLbl.frame=CGRectMake(cell.fqLbl.frame.origin.x, cell.fqLbl.frame.origin.y, cell.fqLbl.frame.size.width, textSize.height);
    }
    
    cell.fqLbl.text=[self.answers objectAtIndex:indexPath.section];
  //  [cell.fqLbl sizeToFit];
    return cell;
}


@end
