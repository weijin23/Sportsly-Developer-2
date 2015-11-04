//
//  ShowVideoViewController.m
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import "ShowVideoViewController.h"
#import "VideoCell.h"
#import "SportViewController.h"
#import "AddVideoViewController.h"
#import "HomeVC.h"
#import "CreatePostViewController.h"
#import "CenterViewController.h"
@interface ShowVideoViewController ()

@end

@implementation ShowVideoViewController
@synthesize isSport,isDate,isName,isFromHomeVC;
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
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.sportNameArr=[NSMutableArray arrayWithObjects:@"Baseball",@"Basketball",@"Cricket",@"Football",@"Hockey",@"Lacrosse",@"Soccer",@"Volleyball", nil];
    self.allAlphabet=[[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    self.thumbImageDict=[[NSMutableDictionary alloc] init];
    self.sportName=nil;
    self.selectedUsername=nil;
    self.selectedDate=nil;
    self.isName=NO;
    self.isSport=NO;
    self.isDate=NO;
    self.dateImageview.image=self.imageDtae;
    self.sportImageview.image=self.sportsImage;
    self.playerImageView.image=self.playerImage;
    [self getAllTrainingVideos];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:RIGHTVCPLAYERIMAGELOADED object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageUpdated:(id)notif
{
    UIImageView * info = [notif object];
    
    VideoCell *rcell=(VideoCell*)info.superview.superview;
    
    NSIndexPath * indexPath =[self.tablView indexPathForCell:rcell];
        
    @autoreleasepool
    {
               
        if([[self.tablView indexPathsForVisibleRows] containsObject:indexPath])
        {
            [self.tablView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }
        
        
    }
    
    
}



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addNewVideo:(id)sender {
    
    AddVideoViewController *add=[[AddVideoViewController alloc] initWithNibName:@"AddVideoViewController" bundle:nil];
    add.isCreated=YES;
    [self.navigationController pushViewController:add animated:YES];
    
   
}


-(void)getAllTrainingVideos{
    
    NSURL* url = [NSURL URLWithString:ALLTRAININGVIDEO];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc ] initWithURL:url];
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
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
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                self.allVideos=[[aDict valueForKey:@"response"] valueForKey:@"training_list"];
                self.allVideosArr=self.allVideos;
                [self sortAllVideoAlphabet];
                NSLog(@"all videos %@",self.allVideosArr);
                self.userName=[[NSMutableArray alloc] init] ;
                for (int i=0; i<self.allVideosArr.count; i++) {
                    if (![self.userName containsObject:[[self.allVideosArr objectAtIndex:i] valueForKey:@"user_name"]]) {
                        [self.userName addObject:[[self.allVideosArr objectAtIndex:i] valueForKey:@"user_name"]];
                    }
                }
                
                [self sortAllVideoAlphabet];

            }
            else
            {
             
                
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
#pragma mark - SortAllVideos

-(void)sortAllVideoAlphabet{
    
    if (self.isSport) {
        
        NSPredicate *predicated=[NSPredicate predicateWithFormat:@"sports_name==%@",self.sportName];
        NSLog(@"predicated %@",predicated);
        self.allVideos=[self. self.allVideosArr filteredArrayUsingPredicate:predicated];
        
        NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"tag_name" ascending:YES];
        self.allVideos= [self.allVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]];
        
        self.indexTitles=[[NSArray alloc] init] ;
        
        self.allVideosDict = [NSMutableDictionary dictionary];
        NSMutableArray *unsortedArray=[[NSMutableArray alloc] init] ;
        
        for (int i=0;i<self.allVideos.count;i++) {
            
            NSString *firstLetter = [[[[self.allVideos objectAtIndex:i] valueForKey:@"tag_name"]substringToIndex:1] uppercaseString];
            NSMutableArray *letterList = [self.allVideosDict objectForKey:firstLetter];
            if (!letterList) {
                letterList = [NSMutableArray array];
                [self.allVideosDict setObject:letterList forKey:firstLetter];
                [unsortedArray addObject:firstLetter];
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }else{
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }
        }
        NSLog(@"%@",  self.allVideosDict);
        self.indexTitles=(NSArray*)unsortedArray;
        self.indexTitles =[self.indexTitles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tablView reloadData];

        
    }else if (isName){
        NSPredicate *predicated=[NSPredicate predicateWithFormat:@"user_name==%@",self.selectedUsername];
        NSLog(@"predicated %@",predicated);
        self.allVideos=[self. self.allVideosArr filteredArrayUsingPredicate:predicated];
        
        NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"tag_name" ascending:YES];
        self.allVideos= [self.allVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]];
        
        self.indexTitles=[[NSArray alloc] init] ;
        
        self.allVideosDict = [NSMutableDictionary dictionary];
        NSMutableArray *unsortedArray=[[NSMutableArray alloc] init] ;
        
        for (int i=0;i<self.allVideos.count;i++) {
            
            NSString *firstLetter = [[[[self.allVideos objectAtIndex:i] valueForKey:@"tag_name"]substringToIndex:1] uppercaseString];
            NSMutableArray *letterList = [self.allVideosDict objectForKey:firstLetter];
            if (!letterList) {
                letterList = [NSMutableArray array];
                [self.allVideosDict setObject:letterList forKey:firstLetter];
                [unsortedArray addObject:firstLetter];
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }else{
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }
        }
        NSLog(@"%@",  self.allVideosDict);
        self.indexTitles=(NSArray*)unsortedArray;
        self.indexTitles =[self.indexTitles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tablView reloadData];

        
        
    }else if (isDate){
        
        NSPredicate *predicated=[NSPredicate predicateWithFormat:@"adddate==%@",self.selectedDate];
        NSLog(@"predicated %@",predicated);
        self.allVideos=[self. self.allVideosArr filteredArrayUsingPredicate:predicated];
        
        NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"tag_name" ascending:YES];
        self.allVideos= [self.allVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]];
        
        self.indexTitles=[[NSArray alloc] init] ;
        
        self.allVideosDict = [NSMutableDictionary dictionary];
        NSMutableArray *unsortedArray=[[NSMutableArray alloc] init] ;
        
        for (int i=0;i<self.allVideos.count;i++) {
            
            NSString *firstLetter = [[[[self.allVideos objectAtIndex:i] valueForKey:@"tag_name"]substringToIndex:1] uppercaseString];
            NSMutableArray *letterList = [self.allVideosDict objectForKey:firstLetter];
            if (!letterList) {
                letterList = [NSMutableArray array];
                [self.allVideosDict setObject:letterList forKey:firstLetter];
                [unsortedArray addObject:firstLetter];
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }else{
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }
        }
        NSLog(@"%@",  self.allVideosDict);
        self.indexTitles=(NSArray*)unsortedArray;
        self.indexTitles =[self.indexTitles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tablView reloadData];

        
    }else{
        
        NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"tag_name" ascending:YES];
        self.allVideos= [self.allVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]];
        
        self.indexTitles=[[NSArray alloc] init] ;
        
        self.allVideosDict = [NSMutableDictionary dictionary];
        NSMutableArray *unsortedArray=[[NSMutableArray alloc] init] ;
        
        for (int i=0;i<self.allVideos.count;i++) {
            
            NSString *firstLetter = [[[[self.allVideos objectAtIndex:i] valueForKey:@"tag_name"]substringToIndex:1] uppercaseString];
            NSMutableArray *letterList = [self.allVideosDict objectForKey:firstLetter];
            if (!letterList) {
                letterList = [NSMutableArray array];
                [self.allVideosDict setObject:letterList forKey:firstLetter];
                [unsortedArray addObject:firstLetter];
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }else{
                [letterList addObject:[self.allVideos objectAtIndex:i]];
            }
        }
        NSLog(@"%@",  self.allVideosDict);
        self.indexTitles=(NSArray*)unsortedArray;
        self.indexTitles =[self.indexTitles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tablView reloadData];

    }
   
}
#pragma mark - TableViewDataSourace

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.allVideosDict allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.allVideosDict valueForKey:[self.indexTitles objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Videocell";
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[VideoCell customCell];
        }
    
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.titleLbl.text=[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"tag_name"];
    NSMutableDictionary *imgstoreDic=self.thumbImageDict;
    
    NSString *imgUrl=   [NSString stringWithFormat:@"%@%@",TRAININGVIDEOTHUMB,[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_thumb"]];
    
      NSString *traningID= [NSString stringWithFormat:@"%@",[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"training_id"]];

    cell.videoThumImv.image=self.noVideThumbImage;
    if(![imgUrl isEqualToString:@""])
    {
        ImageInfo * info = [imgstoreDic objectForKey:traningID];
        
        if(!info)
        {
            ImageInfo *imaInfo=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:imgUrl ]];
            [imgstoreDic setObject:imaInfo forKey:traningID];
        }
        
        if(info.image)
        {
            [cell.videoThumImv setImage:info.image ];
            
            
        }
        else
        {
            
            info.notificationName=TRAININGVIDEOTHUMBIMAGEUPDATE;
            info.notifiedObject=cell.videoThumImv;
            if(!info.isProcessing)
            [info getImage];
            
        }
    }
    else
    {
        cell.videoThumImv.image=self.noVideThumbImage;
    }
    
    cell.backView.layer.cornerRadius=3.0f;
    [cell.backView.layer setMasksToBounds:YES];

    
    return cell;
}
#pragma mark - UITableViewDelgate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    return index;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.contentView.backgroundColor=[UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(isFromHomeVC)
    {
        isFromHomeVC=0;
        
        
        NSMutableDictionary *imgstoreDic=self.thumbImageDict;
        
        NSString *imgUrl=   [NSString stringWithFormat:@"%@%@",TRAININGVIDEOTHUMB,[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_thumb"]];
        
        NSString *traningID= [NSString stringWithFormat:@"%@",[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"training_id"]];
       NSString *videoLink= [[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_link"];
        ImageInfo * info=nil;
        if(![imgUrl isEqualToString:@""])
        {
           info = [imgstoreDic objectForKey:traningID];
            
          
        }
        
        NSLog(@"VideoTrainningSelect=%@--------%@",videoLink,imgUrl);
        NSString *stringToSearch=@"http";
        NSString *myString=videoLink;
        
        if ([myString rangeOfString:stringToSearch].location != NSNotFound)
        {
            // stringToSearch is present in myString
          
            
            
        }
       else
       {
        videoLink=[NSString stringWithFormat:@"%@%@",TRANINGVEDIOLINK,videoLink];
       }
            [appDelegate.centerVC.createPostVC loadVideoURL:videoLink :imgUrl :info ];
        
      

        
        
         [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
        
        
        
        
        
    }
    else
    {
    self.selectedVideoDict=[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
     NSArray *arr=[[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_link"] componentsSeparatedByString:@"."];
    
    if ([[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"UserID"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit Video",@"Show Video",nil];
        [actionSheet  showInView:self.view];
        
        
    }else{
        
        
        if (arr.count>1){
            
            if ([[arr objectAtIndex:1] isEqualToString:@"mp4"]){
                
                [self btnVideoClicked: [NSString stringWithFormat:@"%@%@",TRANINGVEDIOLINK,[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_link"]]];
                
            }else{
                [self btnVideoClicked: [NSString stringWithFormat:@"%@",[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_link"]]];
            }
        }else{
            [self btnVideoClicked: [NSString stringWithFormat:@"%@",[[[self.allVideosDict  valueForKey:[self.indexTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"video_link"]]];
        }

    }
    
   
    }
}

#pragma mark - DatePicker
-(void)showDatePicker{
    
    self.datePickerView.hidden=NO;
    [self.view bringSubviewToFront:self.datePickerView];
    
}
- (IBAction)datePickercancel:(id)sender {
    self.datePickerView.hidden=YES;
}

- (IBAction)datePickerDone:(id)sender {
    
    self.datePickerView.hidden=YES;
    self.isName=NO;
    self.isSport=NO;
    self.isDate=YES;
    self.searchTxt.text=@"";
    self.nameTxt.text=@"";
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    self.selectedDate=[dateformatter stringFromDate:[self.datePicker date]];
    self.dateTxt.text=self.selectedDate;
    [self sortAllVideoAlphabet];
}


#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
  

    if (textField.tag==110) {
        
         SportViewController *sport=[[SportViewController alloc] initWithNibName:@"SportViewController" bundle:nil];
        [sport setSportBlock:^(NSString *sportName){
            self.searchTxt.text=sportName;
            self.sportName=sportName;
            self.isName=NO;
            self.isSport=YES;
            self.isDate=NO;
            self.nameTxt.text=@"";
            self.dateTxt.text=@"";
        }];
        sport.sportArr=self.sportNameArr;
        sport.selectedTag=textField.tag;
        [self presentViewController:sport animated:YES completion:nil];

    }else if (textField.tag==103){
        
        SportViewController *sport=[[SportViewController alloc] initWithNibName:@"SportViewController" bundle:nil];
        [sport setSportBlock:^(NSString *sportName){
            self.nameTxt.text=sportName;
            self.selectedUsername=sportName;
            self.isName=YES;
            self.isSport=NO;
            self.isDate=NO;
            self.searchTxt.text=@"";
            self.dateTxt.text=@"";
        }];
        sport.sportArr=self.userName;
        sport.selectedTag=textField.tag;
        [self presentViewController:sport animated:YES completion:nil];
        

    }else{
            [self showDatePicker];

    }
    
}

#pragma mark - ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([choice isEqualToString:@"Edit Video"]) {
        
        AddVideoViewController *editVideo=[[AddVideoViewController alloc] initWithNibName:@"AddVideoViewController" bundle:nil];
        editVideo.isCreated=NO;
        editVideo.editVideoDict=self.selectedVideoDict;
        [self.navigationController pushViewController:editVideo animated:YES];
        
    }else if ([choice isEqualToString:@"Show Video"]){
        
         NSArray *arr=[[self.selectedVideoDict valueForKey:@"video_link"] componentsSeparatedByString:@"."];
        
        if (arr.count>1){
            
            if ([[arr objectAtIndex:1] isEqualToString:@"mp4"]){
                
                [self btnVideoClicked: [NSString stringWithFormat:@"%@%@",TRANINGVEDIOLINK,[self.selectedVideoDict valueForKey:@"video_link"]]];
                
            }else{
                [self btnVideoClicked: [NSString stringWithFormat:@"%@",[self.selectedVideoDict valueForKey:@"video_link"]]];
            }
        }else{
            [self btnVideoClicked: [NSString stringWithFormat:@"%@",[self.selectedVideoDict valueForKey:@"video_link"]]];
        }
        

    }
}

@end
