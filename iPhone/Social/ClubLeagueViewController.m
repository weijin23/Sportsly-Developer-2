

#import "ClubLeagueViewController.h"
#import "ClubLeagueCell.h"
#import "WebViewController.h"

@interface ClubLeagueViewController ()

@end

@implementation ClubLeagueViewController
@synthesize allTeams;
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
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.view.backgroundColor=appDelegate.backgroundPinkColor;

    self.allTeams=[[[NSArray alloc] init] autorelease];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  [self updateteamList];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateteamList{
    [self.tblView reloadData];
}
-(void)loadTeamData
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [writer release];
    
    [self showNativeHudView];
    [self sendRequestForTeamData:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}

-(void)sendRequestForTeamData:(NSDictionary*)dic
{
    
    NSURL* url = [NSURL URLWithString:TEAM_LISTING_LINK];
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
    
    [aRequest release];
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
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            NSString *message=[aDict objectForKey:@"message"];
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"]){
                
                self.tblView.hidden=NO;
                self.msgLabel.hidden=YES;
                self.allTeams=[NSMutableArray arrayWithArray:[[aDict objectForKey:@"response"] objectForKey:@"team_list"]];
                [self.tblView reloadData];
                
            }else{
                
                self.tblView.hidden=YES;
                self.msgLabel.hidden=NO;
                self.msgLabel.text=message;
            }
        }
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    
}

#pragma mark - TableViewDatasourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.allTeams count];
    return [self.appDelegate.JSONDATAarr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClubLeagueCell";
    
    ClubLeagueCell *cell = [self.tblView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (ClubLeagueCell *)[ClubLeagueCell customCell];
        [cell.clubBtn addTarget:self action:@selector(openClubuUrl:) forControlEvents:UIControlEventTouchUpInside];
        [cell.leagugeBtn addTarget:self action:@selector(openLeagueUrl:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    cell.teamName.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] valueForKey:@"team_name"];
    cell.clubName.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] valueForKey:@"club_name"];
    cell.leagugeName.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] valueForKey:@"league_name"];

    cell.clubBtn.tag=indexPath.row;
    cell.leagugeBtn.tag=indexPath.row;
    cell.backView.layer.cornerRadius=4.0;
    [cell.backView.layer setMasksToBounds:YES];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - OpenWebView
-(void)openClubuUrl:(UIButton*)sender{
    
    WebViewController *webView=[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webView.urlstr=[[self.appDelegate.JSONDATAarr objectAtIndex:sender.tag] valueForKey:@"club_url"];
    webView.websiteTitle=[[self.appDelegate.JSONDATAarr objectAtIndex:sender.tag] valueForKey:@"club_name"];
    [self.navigationController pushViewController:webView animated:YES];
}
-(void)openLeagueUrl:(UIButton*)sender{
    WebViewController *webView=[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webView.urlstr=[[self.appDelegate.JSONDATAarr objectAtIndex:sender.tag] valueForKey:@"league_url"];
    webView.websiteTitle=[[self.appDelegate.JSONDATAarr objectAtIndex:sender.tag] valueForKey:@"league_name"];
    [self.navigationController pushViewController:webView animated:YES];
}


- (void)dealloc {
    [_headerView release];
    [super dealloc];
}
@end
