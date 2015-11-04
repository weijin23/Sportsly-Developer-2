//
//  AllHistoryCoachUpdateVC.m
//  Wall
//
//  Created by Mindpace on 10/01/14.
//
//
#import "PostLikeViewController.h"
#import "CommentVC.h"
#import "LikesAndCommentsVC.h"
#import "LikesAndCommentsVCCell.h"

@interface LikesAndCommentsVC ()

@end

@implementation LikesAndCommentsVC
@synthesize dataArray,dotImage,timeFont,loadStatus,dataArrayOrg,popOver,delegate,start,limit,isFinishData,wallfooterview,wallfootervwactivind,wallfootervwgreydot;
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
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
       [[NSNotificationCenter defaultCenter] removeObserver:self name:UPDATELIKECOMMENTSTATUSVIEW object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:LIKECOMMENTARRAYDATAFROMLOGIN object:nil];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:ALLHISTORYLIKECOMMENTS object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:CENTERVIEWONTROLLERSETNIL object:nil];
    
          [[NSNotificationCenter defaultCenter] removeObserver:self name:INDIVIDUALPOST object:nil];
    
}
-(void)nilDelegate:(id)sender
{
    self.delegate=nil;
    
    self.fetchedResultsController=nil;
    self.fetchedResultsController.delegate=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topview.backgroundColor=appDelegate.barGrayColor;
   
    
    if(!(dataArrayOrg && dataArray))
    {
         self.dataArrayOrg=[[NSMutableArray alloc] init];
        self.dataArray=[[NSMutableArray alloc] init];;
    }
    self.start=0;
    self.limit=10;
    self.isFinishData=0;
    
    // Do any additional setup after loading the view from its nib.
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilDelegate:) name:CENTERVIEWONTROLLERSETNIL object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:UPDATELIKECOMMENTSTATUSVIEW object:nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeCommentArrayUpdated:) name:LIKECOMMENTARRAYDATAFROMLOGIN object:nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedNext:) name:ALLHISTORYLIKECOMMENTS object:nil];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedForComment:) name:INDIVIDUALPOST object:nil];
    
    
    
      self.storeCreatedRequests=[[NSMutableArray alloc] init];
    @autoreleasepool {
        self.dotImage=[UIImage imageNamed:@"Red dot.png"];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:12.0];
        self.timeFont=[UIFont fontWithName:@"Helvetica" size:10.0];
    }
    
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    
    
    
    
    if([appDelegate.aDef objectForKey:ISLIKECOMMENTALREADYLOADED ])
    {
        
        if(delegate)
        {
            appDelegate.allHistoryLikesCounts=[[appDelegate.aDef objectForKey:ALLHISTORYLIKECOUNTS] longLongValue];
            
            
            if([delegate respondsToSelector:@selector(didChangeNumberLikeComments:)])
                [delegate didChangeNumberLikeComments:nil];
        }
        
        
        
        [self requestForTableViewFooterLoading:nil ];
    }
    else
    {
          [appDelegate setUserDefaultValue:@"1" ForKey:ISLIKECOMMENTALREADYLOADED];
        
        if(appDelegate.allHistoryLikesComments)
          [self likeCommentArrayUpdated:appDelegate.allHistoryLikesComments];
        else
             [self requestForTableViewFooterLoading:nil ];
    }
    
    
    [self reloadTableView];
}


-(void)likeCommentArrayUpdated:(id)sender
{
    
    if(!(dataArrayOrg && dataArray))
    {
        self.dataArrayOrg=[[NSMutableArray alloc] init];
        self.dataArray=[[NSMutableArray alloc] init];
    }
    
    [self.dataArrayOrg addObjectsFromArray:(NSArray*)/*[*/sender /*object]*/];//[(NSArray*)sender mutableCopy];
    
    self.start=self.dataArrayOrg.count;
    
    [self reloadTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return (self.dataArray.count+1);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==[self.dataArray count])
    {
        return self.wallfooterview.frame.size.height;
    }
    else
    {
        LikeCommentData *data=[dataArray objectAtIndex:indexPath.row];
        
        float dY=5;
        
        CGSize labelTextSize = [data.message sizeWithFont:self.helveticaFont constrainedToSize:CGSizeMake (230,10000) lineBreakMode: NSLineBreakByWordWrapping];
        
        dY=dY+labelTextSize.height+2+15+5;
        
        
        if(dY<40)
            dY=40;
        
        return dY;
    }
    
    
  
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier1 = @"Cell1";
    if(indexPath.row==[self.dataArray count])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            
            cell.backgroundColor=[UIColor clearColor];
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
       
        
        if(!self.wallfooterview.superview)
        {
            [cell addSubview:self.wallfooterview];
        }
        
        if(tableView.contentSize.height>tableView.frame.size.height &&   self.isFinishData==0)
        {
            self.wallfootervwgreydot.hidden=YES;
            self.wallfootervwactivind.hidden=NO;
            [self.wallfootervwactivind startAnimating];
            [self performSelector:@selector(requestForTableViewFooterLoading:) withObject:nil afterDelay:0.0];
            
        }
        else
        {
            self.wallfootervwactivind.hidden=YES;
            
            if(self.isFinishData==1)
                self.wallfootervwgreydot.hidden=NO;
            else
                self.wallfootervwgreydot.hidden=YES;
        }
        
        return cell;
        
    }
    else
    {
    
            
    
    
    
    LikesAndCommentsVCCell *cell = (LikesAndCommentsVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (LikesAndCommentsVCCell *)[LikesAndCommentsVCCell cellFromNibNamed:@"LikesAndCommentsVCCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    }
    
    
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    LikesAndCommentsVCCell *cell1=(LikesAndCommentsVCCell*)cell;
    
    LikeCommentData *data=[dataArray objectAtIndex:indexPath.row];
    
    
   // NSLog(@"AllHistoryTbCellTeamId=%@----%@",data.teamId,data.message);
    
    
    float dY=5;
    
    CGSize labelTextSize = [data.message sizeWithFont:self.helveticaFont constrainedToSize:CGSizeMake (230,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    
    cell1.senderName.frame=CGRectMake(50, dY, 230, labelTextSize.height);
    
    
    
   UILabel *m= (UILabel*)[cell1.mainBackgroundVw viewWithTag:10];
    if(m)
    {
        [m removeFromSuperview];
    }
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(50, dY, 230, labelTextSize.height)];
    
    lab.font=self.helveticaFont;
    lab.textColor=self.darkgraycolor;
   /* cell1.senderName.text=data.message;
    cell1.senderName.numberOfLines=0;*/
    lab.text=data.message;
    

    lab.numberOfLines=0;
    [cell1.mainBackgroundVw addSubview:lab ];
    
    
    dY+=labelTextSize.height;
    
    dY+=2;
    
    cell1.teamName.frame= CGRectMake(50, dY, 230, 15);
    
    /*UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(5, dY, 230, 15)];
    
    lab1.font=self.timeFont;
    lab1.textColor=self.darkgraycolor;*/
    cell1.teamName.text=[self getDateTimeForHistory:data.datetime ];
    
    //[cell.contentView addSubview:lab1 ];
    
    NSURL *url=[NSURL URLWithString:data.profImg];
    
    [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
    
    
    if( data.inviteStatus==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        
    }
    
    else
    {
         cell1.statusimagvw.image=nil;
    }
    
    
}


-(void)goToComment:(LikeCommentData*)ldata
{

NSMutableDictionary *command = [NSMutableDictionary dictionary];


[command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:ldata.data1 forKey:@"post_id"];



SBJsonWriter *writer = [[SBJsonWriter alloc] init];


NSString *jsonCommand = [writer stringWithObject:command];



NSLog(@"RequestParamJSON=%@",jsonCommand);


SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INDIVIDUALPOSTLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
self.sinReq3=sinReq;

[self.storeCreatedRequests addObject:self.sinReq3];
sinReq.notificationName=INDIVIDUALPOST;
sinReq.userInfo=ldata;
    
    [self showHudView:@"Connecting..."];
[sinReq startRequest];


}







-(void)requestForTableViewFooterLoading:(NSNumber*)index
{
  
    
   
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
   
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
   
    
    @autoreleasepool {
        
        
        [command setObject:[NSString stringWithFormat:@"%lli",self.start] forKey:@"start"];
        [command setObject:[NSString stringWithFormat:@"%lli",self.limit] forKey:@"limit"];
    }
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ALLHISTORYLIKECOMMENTSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq4];
    sinReq.notificationName=ALLHISTORYLIKECOMMENTS;
    //sinReq.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:self.start],@"StartIndex",/*index,@"Index",*/ nil ];
    [sinReq startRequest];
    
    
   
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(loadStatus)
        return;
    
    if(indexPath.row==([self.dataArray count]))
    {
        return;
    }
    
   
    
    LikeCommentData *newinvite=[self.dataArray objectAtIndex:indexPath.row];
    
    if(newinvite.inviteStatus==0)
    {
        self.lastSelRow=indexPath.row;
     self.loadStatus=1;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:newinvite.last_id forKey:@"id"];
    [command setObject:@"1" forKey:@"view_status"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:UPDATELIKECOMMENTSTATUSVIEWLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=UPDATELIKECOMMENTSTATUSVIEW;
        sinReq.userInfo=newinvite;
        [self showHudView:@"Connecting..."];
    [sinReq startRequest];
    }
    else
    {
        
        
        if(newinvite.isComment)
        {
            [self goToComment:newinvite];
        }
        else
        {
            
            
            PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
            self.postLikeVC=commentView;
            
            commentView.postId=newinvite.data1;
            /////
               /*commentView.no_of_likesStr=[[NSString alloc] initWithFormat:@"%lli",hvcData.number_of_likes];*/
            ////
            
            [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
            
            commentView=nil;
        }
        
        
        
        
    }
    
}






-(void)userListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:UPDATELIKECOMMENTSTATUSVIEW])
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
                        
                        
                        
                        LikeCommentData *newEvent=(LikeCommentData*)sReq.userInfo;
                        newEvent.inviteStatus=1 ;
                        
                        if(appDelegate.allHistoryLikesCounts>0)
                        {
                        appDelegate.allHistoryLikesCounts--;
                         [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                        
                        }
                        [self reloadTableView];

                        
                        
                        if(newEvent.isComment)
                        {
                        [self goToComment:newEvent];
                        }
                        else
                        {
                            
                            
                            PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
                         
                            self.postLikeVC=commentView;
                            commentView.postId=newEvent.data1;
                            /////
                            /*
                                commentView.no_of_likesStr=[[NSString alloc] initWithFormat:@"%lli",hvcData.number_of_likes];
                             
                             */
                            
                            /////
                            
                            [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
                            
                            commentView=nil;
                        }
                        
                        
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



-(void)userListUpdatedForComment:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:INDIVIDUALPOST])
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
                    
                    NSLog(@"IndividualpostresponseStringData=%@",sReq.responseString);
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        aDict=[aDict objectForKey:@"response"];
                        
                        if(((NSArray*)[aDict objectForKey:@"post_details"]).count>0)
                        {
                        aDict=[[aDict objectForKey:@"post_details"] objectAtIndex:0];
                        
                        
                       
                       
                        
                        
                        
                        CommentVC *commentView=[[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
                        self.commVC=commentView;
                            commentView.isFromHome=1;
                        commentView.hvcData=[self getPostData:aDict];
                        [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
                        }
                        
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



-(HomeVCTableData*)getPostData:(NSDictionary*)diction
{
    
        HomeVCTableData *dvca=[[HomeVCTableData alloc] init];
        ImageInfo *imauser=nil;
        ImageInfo *imaposted=nil;
        ImageInfo *imapostedsecondary=nil;
        NSString *likecountstr=nil;
        NSString *commentcountstr=nil;
        NSString *comnt=nil;
        
        BOOL existuserima=0;
        BOOL existpostedima=0;
        BOOL existpostedimasecondary=0;
        
        
        
        if(![[diction objectForKey:@"ProfileImage"] isEqualToString:@""])
        {
            imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[diction objectForKey:@"ProfileImage"]]]];
            existuserima=1;
        }
        dvca.imageWidth=0.0;
        dvca.imageHeight=0.0;
        dvca.videoUrlStr=nil;
        if(![[diction objectForKey:@"image"] isEqualToString:@""])
        {
            imaposted= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTIMAGELINK,[diction objectForKey:@"image"]]]];
            existpostedima=1;
            
            
            /*if([[diction objectForKey:@"image_width"] isKindOfClass:[NSDecimalNumber class]])
             {*/
            dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
            dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
            /*}
             else  if([[diction objectForKey:@"image_width"] isKindOfClass:[NSString class]])
             {
             if(![[diction objectForKey:@"image_width"] isEqualToString:@""])
             {
             dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
             dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
             }
             
             }*/
        }
        else  if(![[diction objectForKey:@"video_thumb"] isEqualToString:@""])
        {
            NSString *stringToSearch=@"http";
            NSString *myString= [diction objectForKey:@"video"];
            
            if ([myString rangeOfString:stringToSearch].location != NSNotFound)
            {
                // stringToSearch is present in myString
                dvca.videoUrlStr=[diction objectForKey:@"video"] ;
                
                
            }
            else
            {
                
                dvca.videoUrlStr=[NSString stringWithFormat:@"%@%@",VIDEOLINK , [diction objectForKey:@"video"] ];
            }
            
            
            
            imaposted=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTVIDEOIMAGELINK,[diction objectForKey:@"video_thumb"]]]];
            existpostedima=1;
            
            
            /* if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSDecimalNumber class]])
             {*/
            dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
            dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
            
            
            
            /*}
             else  if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSString class]])
             {
             if(![[diction objectForKey:@"video_thumb_width"] isEqualToString:@""])
             {
             dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
             dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
             }
             
             }*/
            
        }
        
        //imapostedsecondary= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:@""]];
        existpostedimasecondary=0;
        
        
        comnt=[diction objectForKey:@"comment_text"];
        
        commentcountstr=[NSString stringWithFormat:@"%@",[diction objectForKey:@"number_of_comment"]];//()
        
        NSString *s=[[NSString alloc] initWithFormat:@"%@",[diction objectForKey:@"number_of_likes"] ];
        likecountstr=s;
        
        if([[diction objectForKey:@"Islike"] isEqualToString:@"Y"])
            dvca.isLike=1;
        else
            dvca.isLike=0;
        
        dvca.post_id=[diction objectForKey:@"post_id"];
        dvca.number_of_likes=[likecountstr intValue];
        NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
        dvca.commentdetailsarr=marray;
        
        dvca.number_of_comment=dvca.commentdetailsarr.count;
        dvca.adddate=[diction objectForKey:@"adddate"];
        
        
        /*marray=[[diction objectForKey:@"like_user_details"] mutableCopy];
         dvca.likedetailsarr=marray;
         [marray release];*/
        
        dvca.userId=[diction objectForKey:@"user_id"];
        dvca.playerfname=[diction objectForKey:@"FirstName"];
        dvca.playerlname=[diction objectForKey:@"LastName"];
        
        
        NSDictionary *diction1=[diction objectForKey:@"playerdetails"];
        
        @autoreleasepool
        {
            dvca.isPlayer=[[diction1 objectForKey:@"IsPlayer"] boolValue];
            dvca.isPrimary=[[diction1 objectForKey:@"Is_Primary"] boolValue];
            dvca.isCoach=[[diction1 objectForKey:@"Is_Coach"] boolValue];
            
            if(!dvca.isCoach)
            {
                NSString *playerNameArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                NSString *playerIdArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.playerNameTeam=playerNameArray;
                dvca.playerIdTeam=playerIdArray;
            }
            
            if(dvca.isPrimary)
            {
                NSString *playerNameArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString *playerIdArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Relation"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.primaryUserName=playerNameArray;
                dvca.primaryRelation=playerIdArray;
            }
            
            
            
            if((dvca.isPlayer==0) && (dvca.isPrimary==0) && (dvca.isCoach==0))
            {
                if([diction1 objectForKey:@"secondary_sender_name"])
                    dvca.playerNameTeam=[diction1 objectForKey:@"secondary_sender_name"];
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        dvca.secondaryImageInfo=imapostedsecondary;
        dvca.postedImageInfo=imaposted;
        dvca.userImageInfo=imauser;
        dvca.likecountlab=likecountstr;
        dvca.commentstr= comnt;
        dvca.commentcountlab=commentcountstr;
        dvca.isExistUserImageInfo=existuserima;
        dvca.isExistPostedImageInfo=existpostedima;
        dvca.isExistSecondaryImageInfo=existpostedimasecondary;
       
    
    
    return dvca;
    
}



-(void)userListUpdatedNext:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:ALLHISTORYLIKECOMMENTS])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                
                NSLog(@"responseStringAllLikeComment=%@",sReq.responseString);
                
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    /*if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {*/
                    
                       // NSDictionary* aDict = (NSDictionary*) res;
                    
                        aDict=[aDict objectForKey:@"response"];
                    
                     NSString *notnumberstr=@"0";
                    
                    if(![[aDict objectForKey:@"notification"] objectForKey:@"blank"])
                    {
                    
                     
                        NSArray *arr=[[aDict objectForKey:@"notification"] objectForKey:@"notification_array"];
                    
                       notnumberstr=[[NSString alloc] initWithFormat:@"%@",[[aDict objectForKey:@"notification"] objectForKey:@"countunview"]];
                        
                        // if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                        if(arr.count>0)
                        {
                            
                            
                            /*self.wallfootervwgreydot.hidden=NO;
                            [self.wallfootervwactivind stopAnimating];*/
                            
                            
                            
                            
                            
                            
                            NSMutableArray *mar= [self parseLikeAndComments:arr];
                            
                            [self.dataArrayOrg addObjectsFromArray:mar];//[(NSArray*)sender mutableCopy];
                            
                            self.start=self.dataArrayOrg.count;
                            
                            [self reloadTableView];
                            
                           // [self.dataArray addObjectsFromArray:mar];
                            
                          //  self.start+=self.limit;
                            /////////////////////
                            
                            
                            
                        }
                        
                        else
                        {
                              if(self.start!=0)
                              {
                            isFinishData=1;
                            self.wallfootervwgreydot.hidden=NO;
                            [self.wallfootervwactivind stopAnimating];
                              }
                        }

                        
                        
                    }
                    else
                    {
                          if(self.start!=0)
                          {
                        isFinishData=1;
                        self.wallfootervwgreydot.hidden=NO;
                        [self.wallfootervwactivind stopAnimating];
                          }
                    }
                   
                    if([notnumberstr longLongValue]==0)
                    {
                        
                       /* if([notnumberstr longLongValue]!=appDelegate.allHistoryLikesCounts)
                        {
                            appDelegate.allHistoryLikesCounts=[notnumberstr longLongValue];
                            [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                        }*/
                    }
                    else
                    {
                        appDelegate.allHistoryLikesCounts=[notnumberstr longLongValue];
                    [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                    }
                }
                else
                {
                      if(self.start!=0)
                      {
                    isFinishData=1;
                      }
                }
                
            }
            else
            {
                  if(self.start!=0)
                isFinishData=1;
            }
        }
        else
        {
            if(self.start!=0)
                isFinishData=1;
            
        }
    }
    else
    {
        if(self.start!=0)
            isFinishData=1;
    }
    
}



-(void)addFromPush:(NSDictionary*)dic
{
    
    NSLog(@"UserInfoAddFromPush=%@",dic);
    
    
        
        
        LikeCommentData *data=[[LikeCommentData alloc] init];
        
        
        data.data1=[dic objectForKey:@"p_id"];
        data.last_id=[dic objectForKey:@"l_id"];
    
    if([dic objectForKey:@"L_u_id"])
        data.isComment=1;
    else
        data.isComment=0;
        if([dic objectForKey:@"date"])
        {
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"date"]] dateByAddingTimeInterval:difftime]  ;
            
            
            
            data.datetime=datetime;
            
        }
        else
        {
            data.datetime=[[NSDate alloc] init];
        }
    
     if(![[dic objectForKey:@"p_img"] isEqualToString:@""])
     {
         NSString *profimg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"p_img"]];
    
       
         data.profImg=profimg;
         profimg=nil;
         
     }
        data.message=[[dic objectForKey:@"aps"] objectForKey:@"alert"];
        data.inviteStatus=0;
        
    
    
    
    
    
        appDelegate.allHistoryLikesCounts++;
        [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
    
    [self.dataArrayOrg insertObject:data atIndex:0];//[(NSArray*)sender mutableCopy];
    
    self.start=self.dataArrayOrg.count;
    
      [self reloadTableView];
    
    
}


-(NSMutableArray*)parseLikeAndComments:(NSArray*)arr
{
    
    NSMutableArray *mar=[[NSMutableArray alloc] init];
    
    for(NSDictionary* dic in arr)
    {
        
        /* if([dic objectForKey:@"Like_user_id"])
         [self.appDelegate savePushDataForLike:dic :[dic objectForKey:@"message"]];
         else if([dic objectForKey:@"cmnt_user_id"])
         [self.appDelegate savePushDataForComment:dic :[dic objectForKey:@"message"]];*/
        
        id mlike=nil;
        
        mlike= [dic objectForKey:@"Like_user_id" ] ;
        
        if(!mlike)
        {
            mlike= [dic objectForKey:@"Comment_user_id" ] ;
        }
        
        int flagg=0;
        if(mlike)
        {
            if([mlike isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID] ])
                flagg=1;
        }
        //  flagg=0;
        if(mlike)
        {
        if(flagg)
        {
           
            continue;
        }
        }
        
        
        
        LikeCommentData *data=[[LikeCommentData alloc] init];
        
        
        data.data1=[dic objectForKey:@"post_id"];
        data.last_id=[dic objectForKey:@"id"];
        data.isComment=[[dic objectForKey:@"IsComment"] integerValue];
        if([dic objectForKey:@"adddate"])
        {
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
            
            
            
            data.datetime=datetime;
            
        }
        else
        {
            data.datetime=[[NSDate alloc] init];
        }
        
        
        if(![[dic objectForKey:PROFILEIMAGE] isEqualToString:@""])
        {
            NSString *profimg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:PROFILEIMAGE]];
            
            
            data.profImg=profimg;
            profimg=nil;
            
        }
        
        
        data.message=[dic objectForKey:@"message"];
        data.inviteStatus=[[dic objectForKey:@"view_status"] integerValue];
        
        [mar addObject:data];
    }
    
    
    return mar;
}





-(void)reloadTableView
{
    if(self.dataArrayOrg.count>0)
    {
    
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    @autoreleasepool
     {
        
    
NSArray *newAllObjects= [[self dataArrayOrg] sortedArrayUsingDescriptors:sortDescriptors];
self.dataArray=[newAllObjects mutableCopy];
     }
    [self.tableVw reloadData];
     self.nolbl.hidden=YES;
        
        
        
        if(delegate)
        {
            if([delegate respondsToSelector:@selector(didChangeNumberLikeComments:)])
        [delegate didChangeNumberLikeComments:nil];
        }
    }
    else
    {
       
       
    self.nolbl.hidden=NO;
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.view.hidden=YES;
    
}
- (void)viewDidUnload {
    [self setTableVw:nil];
    [self setNolbl:nil];
    [super viewDidUnload];
}
@end
