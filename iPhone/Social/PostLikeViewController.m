//
//  PostLikeViewController.m
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import "PostLikeViewController.h"
#import "PostLikeCell.h"
#import "AFHTTPClient.h"
#import "UIImageView+AFNetworking.h"
#import "CenterViewController.h"



@interface PostLikeViewController ()

@end

@implementation PostLikeViewController
@synthesize postLikeArr,isFinishData,no_of_likesStr;

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
   // self.postId=@"95";
    //self.topview.backgroundColor=appDelegate.barGrayColor;
    //self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    self.start=0;
    self.limit=10;
    self.isFinishData=0;
   
    [self updateServerData];
}


-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backwhite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        //self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.title=[[NSString alloc] initWithFormat:@"%@ Likes", no_of_likesStr ];
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)toggleRightPanel:(id)sender
{
    
    
    
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*- (void)dealloc {
    [_postLikeTable release];
    [super dealloc];
}*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)updateServerData
{
  
    
    
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc] init];
    [command setObject:self.postId forKey:@"post_id"];
    @autoreleasepool {
        
        
        [command setObject:[NSString stringWithFormat:@"%lli",self.start] forKey:@"start"];
        [command setObject:[NSString stringWithFormat:@"%lli",self.limit] forKey:@"limit"];
    }
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
   
    [self sendRequestForPhotoAlbums:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
}


-(void)sendRequestForPhotoAlbums:(NSDictionary*)dic
{
    // NSString *str=POST;
    [self showNativeHudView];
    NSURL* url =[NSURL URLWithString:POSTPHOTOLIKELINK];
        
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
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
            // NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
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


-(void)showStatusBasisofNumber
{
    if(self.postLikeArr.count>0)
      self.nolikesvw.hidden=YES;
        else
      self.nolikesvw.hidden=NO;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    @autoreleasepool {
        
        NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
        
        NSString *str=[request responseString];
        
        NSLog(@"Data=%@",str);
        [self hideNativeHudView];
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
          
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                
                if([[NSString stringWithFormat:@"%@",[aDict objectForKey:@"status"] ] isEqualToString:@"1"])
                {
                    
                    aDict=[aDict objectForKey:@"response"];
                    
                    
                    if(!postLikeArr)
                    self.postLikeArr=[[NSMutableArray alloc] initWithArray:[aDict valueForKey:@"post_details"]];
                    else
                    [self.postLikeArr addObjectsFromArray:[aDict valueForKey:@"post_details"]];
                    
                      self.start+=self.limit;
                    
                 
                                                         
                }
                else
                {
                  //  [self showAlertMessage:[aDict objectForKey:@"message"]  title:@""];
                  
                    if(self.start!=0)
                        isFinishData=1;
                    
                    
                    
                    self.wallfootervwgreydot.hidden=NO;
                    [self.wallfootervwactivind stopAnimating];
                    
                    [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
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
    
    [self showStatusBasisofNumber];
       [self.postLikeTable reloadData];
}


-(void)hideHudViewHere
{
    [self hideHudView];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
//	[self showAlertMessage:CONNFAILMSG];
    
    
    if(self.start!=0)
        isFinishData=1;
    
    
    
    self.wallfootervwgreydot.hidden=NO;
    [self.wallfootervwactivind stopAnimating];
    
       [self showStatusBasisofNumber];
    [self.postLikeTable reloadData];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return   ([self.postLikeArr count]+1);
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==[self.postLikeArr count])
    {
        return self.wallfooterview.frame.size.height;
    }
    else
    {
    return 50.0f;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"PostLikecell";
    
    static NSString *CellIdentifier1 = @"Cell1";
    if(indexPath.row==[self.postLikeArr count])
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
            [self performSelector:@selector(updateServerData) withObject:nil afterDelay:0.0];
            
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
        
    
    PostLikeCell *cell = [self.postLikeTable dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil)
    {
        cell =[PostLikeCell customCell];
    }
    
        [cell.proileImageView cleanPhotoFrame];
        
        if (![[[self.postLikeArr objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"] isEqualToString:@""])
        {
            [cell.proileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[self.postLikeArr objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]]] placeholderImage:self.noImage];
            
            [cell.proileImageView applyPhotoFrame];
        }
        else
        {
            [cell.proileImageView setImage:self.noImage];
        }

        
        
   
        
    @autoreleasepool {
        
    
    NSString *s=[[[self.postLikeArr objectAtIndex:indexPath.row] valueForKey:@"UserName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([s isEqualToString:@""])
    cell.playername.text=@"Unknown";
        else
             cell.playername.text=s;
    }
        
        
        if([[self.postLikeArr objectAtIndex:indexPath.row] objectForKey:@"AddDate"])
        {
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[[self.postLikeArr objectAtIndex:indexPath.row] objectForKey:@"AddDate"]] dateByAddingTimeInterval:difftime]  ;
            
            
            
           cell.time.text= [self getDateTimeForHistory:datetime ];
            
        }
        
        
    cell.backView.layer.cornerRadius=3.0f;
    [cell.backView.layer setMasksToBounds:YES];

    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==([self.postLikeArr count]))
    {
        return;
    }
}


@end
