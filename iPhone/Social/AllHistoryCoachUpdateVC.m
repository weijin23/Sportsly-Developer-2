//
//  AllHistoryCoachUpdateVC.m
//  Wall
//
//  Created by Mindpace on 10/01/14.
//
//
#import "Invite.h"
#import "AllHistoryCoachUpdateVC.h"

@interface AllHistoryCoachUpdateVC ()

@end

@implementation AllHistoryCoachUpdateVC
@synthesize dataArray,dotImage,timeFont,loadStatus,dataArrayOrg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    
       [[NSNotificationCenter defaultCenter] removeObserver:self name:COACHUPDATEVIEWSTATUS object:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:COACHUPDATEVIEWSTATUS object:nil];
    
      self.storeCreatedRequests=[[NSMutableArray alloc] init];
    @autoreleasepool {
        self.dotImage=[UIImage imageNamed:@"Red dot.png"];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:12.0];
        self.timeFont=[UIFont fontWithName:@"Helvetica" size:10.0];
    }
    
    self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Invite *data=[dataArray objectAtIndex:indexPath.row];
    
    float dY=5;
    
    CGSize labelTextSize = [data.message sizeWithFont:self.helveticaFont constrainedToSize:CGSizeMake (260,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    dY=dY+labelTextSize.height+5+15+5;
 
    
    return dY;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    
    for(id vw in cell.contentView.subviews)
    {
        [vw removeFromSuperview];
    }
    
    Invite *data=[dataArray objectAtIndex:indexPath.row];
    
    
    NSLog(@"AllHistoryTbCellTeamId=%@----%@",data.teamId,data.message);
    
    
    float dY=5;
    
    CGSize labelTextSize = [data.message sizeWithFont:self.helveticaFont constrainedToSize:CGSizeMake (260,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    
    
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(5, dY, 260, labelTextSize.height)];
    
    lab.font=self.helveticaFont;
    lab.textColor=self.darkgraycolor;
    lab.text=data.message;
    lab.numberOfLines=0;
    [cell.contentView addSubview:lab ];
    
    
    dY+=labelTextSize.height;
    
    dY+=5;
    
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(5, dY, 260, 15)];
    
    lab1.font=self.timeFont;
    lab1.textColor=self.darkgraycolor;
    lab1.text=[self getDateTimeForHistory:data.datetime ];
    
    [cell.contentView addSubview:lab1 ];
    
    
    if( data.inviteStatus.intValue==0)
    {
        cell.accessoryView=[[UIImageView alloc] initWithImage:self.dotImage];
        
    }
    
    else
    {
         cell.accessoryView=nil;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(loadStatus)
        return;
    
    
    
   
    
    Invite *newinvite=[self.dataArray objectAtIndex:indexPath.row];
    
    if(newinvite.inviteStatus.intValue==0)
    {
        self.lastSelRow=indexPath.row;
     self.loadStatus=1;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    [command setObject:newinvite.postId forKey:@"update_id"];
    [command setObject:@"1" forKey:@"status"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COACHUPDATEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=COACHUPDATEVIEWSTATUS;
    
    [sinReq startRequest];
    }
}






-(void)userListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COACHUPDATEVIEWSTATUS])
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
                        
                        
                        
                        Invite *newEvent=[self.dataArray objectAtIndex:self.lastSelRow];
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                        
                        [appDelegate saveContext];

                        
                        
                        
                        
                    }
                    else
                    {
                        
                    }
                    
                }
                
            }
        }
        else
        {
            
            
        }
    }
    else
    {
        
    }
    
}

-(void)reloadTableView
{
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

NSArray *newAllObjects= [[self dataArrayOrg] sortedArrayUsingDescriptors:sortDescriptors];
self.dataArray=newAllObjects;
    
    [self.tableVw reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setTableVw:nil];
    [super viewDidUnload];
}
@end
