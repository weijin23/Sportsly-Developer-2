//
//  CommentVC.m
//  Social
//
//  Created by Mindpace on 07/09/13.
//
//
#import "PlayerRelationVC.h"
#import "FPPopoverController.h"
#import "HomeVCTableCell.h"
#import "HomeVC.h"
#import "CommentVC.h"
#import "CommentVCTableData.h"
#import "CommentVCTableCell.h"
#import "MBProgressHUD.h"
#import "CenterViewController.h"
#import "PostLikeViewController.h"
@interface CommentVC ()

@end

@implementation CommentVC

@synthesize commentTableVw,postCommentVw,postTxtVw,postCommentBtn,hvcData,commentDetailsData,likedImage,nonLikedImage,previousIndexPath,start,totalCellCount,wallfootervw,wallfootervwactivind,isFinishData,wallfootervwgreydot,limit,isFromHome;

@synthesize firstCommentCell,mainContainer;
@synthesize userImg,acindviewuser,mainPostedByLbl,mainPostedOnLbl,userPost;
@synthesize subContainer,commentCountLbl,commentBtn,likeCountLbl,likeBtn;
@synthesize mainCommentsLbl,closeBtn,dataArray,moreBtn,cellMoreBtn;

@synthesize selectedRow,commentCell,orgComment,hud;

int rowNoToExpand;
float dY=0.0;
float dYRow=0.0;
float dYCell=0.0;
CGSize mainLabelTextSize,cellLabelTextSize;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:COMMENTVIEWCONTROLLERIMAGELOADED object:nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedUser:) name:COMMENTVIEWCONTROLLERIMAGELOADEDUSER object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedUser:) name:COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeTextUpdated:) name:LIKECOUNTCHANGEFORTEXT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeAnimationUpdated:) name:LIKECOUNTCHANGEFORANIMATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeFailed:) name:LIKEFAILED object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentExtraDataLoaded:) name:COMMENTLISTING object:nil];
    
//    self.mainCommentsLbl.frame=CGRectMake(19, 350, 255, 41);
//
//    CGRect fr1=self.mainContainer.frame;
//
//    if(self.mainLblTxt.length>125)
//    {
//        NSString *reducedStr=[self.mainLblTxt substringWithRange:NSMakeRange(0, 124)];
//        reducedStr=[NSString stringWithFormat:@"%@...",reducedStr];
//
//        NSLog(@"The reduced string is %@",reducedStr);
////        CGSize size1 = [reducedStr sizeWithFont:self.mainCommentsLbl.font constrainedToSize:CGSizeMake (self.mainCommentsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
//        
////        float valY=fr1.origin.y+size1.height;
////        valY=valY-(mainLabelTextSize.height-size1.height);
//        
////        float valY=0.0;
////        valY=373;
//        
//        self.mainCommentsLbl.text=[NSString stringWithFormat:@"%@",reducedStr];
//    
//        moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        moreBtn.frame=CGRectMake(18, 386, 45, 25);
//        [moreBtn setTitle:@"See More" forState:UIControlStateNormal];
//        moreBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 10.0f];
//        moreBtn.titleLabel.textColor = [UIColor blueColor];
//        [moreBtn addTarget:self action:@selector(showFullComment:) forControlEvents:UIControlEventTouchUpInside];
//        [self.commentTableVw addSubview:moreBtn];
//        
//        
//        //dY=(self.mainCommentsLbl.frame.origin.y+(self.mainCommentsLbl.frame.size.height-2));
//        fr1.size.height=405;
//
//    }
//    else
//        fr1.size.height=dY;
//    self.mainContainer.frame=fr1;
    
//    if(!isFromHome)
//      [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    [self disableSlidingAndHideTopBar];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMENTVIEWCONTROLLERIMAGELOADED object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMENTVIEWCONTROLLERIMAGELOADEDUSER object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LIKECOUNTCHANGEFORTEXT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LIKECOUNTCHANGEFORANIMATION object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:LIKEFAILED object:nil];
    
       [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMENTLISTING object:nil];
    
    
    [self enableSlidingAndShowTopBar];
}








- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    
    ///////////////////
    self.isFinishData=0;
    
    self.storeCreatedRequests=[[NSMutableArray alloc] init];
    
    self.relationVC=[[PlayerRelationVC alloc] initWithNibName:@"PlayerRelationVC" bundle:nil];
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.relationVC];
    
    self.relationPopover=popover;
    [self.relationVC view];
     self.relationPopover.contentSize = CGSizeMake(270,90);
    self.relationPopover.tint=FPPopoverLightGrayTint;
    ///////////////////
   /* self.userPost.layer.borderColor=self.blackcolor.CGColor;
    self.userPost.layer.borderWidth=1.0;*/
    self.tapGesture=[[UITapGestureRecognizer alloc] init];
    self.tapGesture.numberOfTapsRequired=1;
    [self.tapGesture addTarget:self action:@selector(videoTapped:)];
    
    
    
    self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
   // self.postCommentVw.backgroundColor=appDelegate.backgroundPinkColor;
    rowNoToExpand=-1;
    selectedRow=0;

    self.teamNamelab.text=@"Comments";//[appDelegate.centerVC.dataArrayUpButtons objectAtIndex:appDelegate.centerVC.lastSelectedTeam];
    NSArray *arrgreensets=nil;
    NSArray *arrwhitesets=nil;
    @autoreleasepool {
        
        if(!self.isiPad)
        {
        arrgreensets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite1.png"],[UIImage imageNamed:@"likewrite2.png"],[UIImage imageNamed:@"likewrite3.png"],[UIImage imageNamed:@"likewrite4.png"],[UIImage imageNamed:@"likewrite5.png"],[UIImage imageNamed:@"likewrite6.png"],[UIImage imageNamed:@"likewrite7.png"] ,nil];
        arrwhitesets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite7.png"],[UIImage imageNamed:@"likewrite6.png"],[UIImage imageNamed:@"likewrite5.png"],[UIImage imageNamed:@"likewrite4.png"],[UIImage imageNamed:@"likewrite3.png"],[UIImage imageNamed:@"likewrite2.png"],[UIImage imageNamed:@"likewrite1.png"] ,nil];
    
        }
        else
            
        {
            arrgreensets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite1_ipad.png"],[UIImage imageNamed:@"likewrite2_ipad.png"],[UIImage imageNamed:@"likewrite3_ipad.png"],[UIImage imageNamed:@"likewrite4_ipad.png"],[UIImage imageNamed:@"likewrite5_ipad.png"],[UIImage imageNamed:@"likewrite6_ipad.png"],[UIImage imageNamed:@"likewrite7_ipad.png"] ,nil];
            arrwhitesets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite7_ipad.png"],[UIImage imageNamed:@"likewrite6_ipad.png"],[UIImage imageNamed:@"likewrite5_ipad.png"],[UIImage imageNamed:@"likewrite4_ipad.png"],[UIImage imageNamed:@"likewrite3_ipad.png"],[UIImage imageNamed:@"likewrite2_ipad.png"],[UIImage imageNamed:@"likewrite1_ipad.png"] ,nil];
        }
    
    self.animationtogreensets=arrgreensets;
    
  
    
    self.animationtowhitesets=arrwhitesets;
        
        if(self.isiPad)
              self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:16.0];
            else
         self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:12.0];
    }
  
    
    
    // ------------------------ Requesting Table data from server -------------------------
    //    NSURL *url = [NSURL URLWithString:@"http://getmymobileapps.com/BarAPP/administrator/administrator/AppBarList"];
    //    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //    NSLog(@"The request is %@",request.responseString);
    //    [request setRequestMethod:@"POST"];
    //    [request setDelegate:self];
    //    [request startAsynchronous];
    //-------------------------------------------------------------------------------------
    
    // ----------------------------------- Displaying HUD ---------------------------------
    //    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.hud.labelText = @"Loading Bar List...";
    //    [self performSelector:@selector(timeout:) withObject:nil afterDelay:10.0];
    //-------------------------------------------------------------------------------------
    
    
    
    
    HomeVCTableData *data=self.hvcData;
    
    int row = [appDelegate.centerVC.dataArray indexOfObject:self.hvcData];
    
    
    @autoreleasepool {
        
        
        if(!self.isiPad)
        
        {
        self.likedImage=[UIImage imageNamed:@"likewritesel.png"];
        self.nonLikedImage=[UIImage imageNamed:@"likewrite.png"];
        
        self.normalpost=[UIImage imageNamed:@"commentpostbtn.png"];
         self.normalSelpost=[UIImage imageNamed:@"commentpostbtnBlue.png"];
        }
        else
        {
            self.likedImage=[UIImage imageNamed:@"likewritesel_ipad.png"];
            self.nonLikedImage=[UIImage imageNamed:@"likewrite_ipad.png"];
            
            self.normalpost=[UIImage imageNamed:@"commentpostbtn_ipad.png"];
            self.normalSelpost=[UIImage imageNamed:@"commentpostbtnBlue_ipad.png"];
        }
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        self.previousIndexPath=indexPath;
    }
 
    
  
    
    
    
     dY=self.userPost.frame.origin.y;
    
    if(data.isExistPostedImageInfo)
    {
        ImageInfo * info2 = data.postedImageInfo;
        
        if(info2.image)
        {
            CGRect fr=self.userPost.frame;
          __weak  UIImage *image=info2.image;
            
           
            
            fr.size.width=image.size.width/appDelegate.deviceScale;
             fr.size.height=image.size.height/appDelegate.deviceScale;
              // NSLog(@"resizeAfterImageDownload==1.%@-2.%@",[NSValue valueWithCGSize:fr.size],[NSValue valueWithCGSize:image.size]);
            self.userPost.frame=fr;
            
             [self.userPost setImage:image];
            
            
            if(data.videoUrlStr)
            {
                float x=0.0;
                float y=0.0;
                
                
                x= self.userPost.center.x-(self.videoplayimavw.frame.size.width/2);
                y= self.userPost.center.y-(self.videoplayimavw.frame.size.height/2);
                self.videoplayimavw.frame=CGRectMake(x,y,self.videoplayimavw.frame.size.width,self.videoplayimavw.frame.size.height);
                
                
               
            }
            
            
            
            
            
            self.userPost.hidden=NO;
            self.acindviewpost.hidden=YES;
            [self.acindviewpost stopAnimating];
            
            
           [appDelegate.centerVC.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        else
        {
            
            
            self.acindviewpost.hidden=NO;
            self.userPost.hidden=YES;
            self.videoplayimavw.hidden=YES;
            [self.acindviewpost startAnimating];
            info2.notificationName=COMMENTVIEWCONTROLLERIMAGELOADEDUSERPOST;
              info2.isSmall=0;
            
            if(!info2.isProcessing)
            [info2 getImage];
        }
        
        
        if(self.isiPad)
            dY+=(self.userPost.frame.size.height+17);
        else
            dY+=(self.userPost.frame.size.height+7);
        
    }
    else
    {
       
        
        self.userPost.hidden=YES;
        self.acindviewpost.hidden=YES;
       [self.acindviewpost stopAnimating];
        
        
        
        
    }
    
    
    if(data.videoUrlStr)
    {
        self.userPost.userInteractionEnabled=YES;
        [self.userPost addGestureRecognizer:self.tapGesture];
        
        
        
    }
    else
    {
        self.videoplayimavw.hidden=YES;
    }
    
    
    [self.userImg cleanPhotoFrame];
    
    if(data.isExistUserImageInfo)
    {
        ImageInfo * info1= data.userImageInfo;
        
       [self.userImg applyPhotoFrame];
        
        if(info1.image)
        {
            [self.userImg setImage:info1.image/*[self getImage:info1.image isWidth:0 length:self.userImg.frame.size.height]*/];
            self.userImg.hidden=NO;
            self.acindviewuser.hidden=YES;
            [self.acindviewuser stopAnimating];
            
        }
        else
        {
                        
            self.acindviewuser.hidden=NO;
            self.userImg.hidden=YES;
            [self.acindviewuser startAnimating];
            info1.notificationName=COMMENTVIEWCONTROLLERIMAGELOADEDUSER;
            
            if(!info1.isProcessing)
            [info1 getImage];
        }
    }
    else
    {
        [self.userImg setImage:self.noImage];
        self.userImg.hidden=NO;
        self.acindviewuser.hidden=YES;
        [self.acindviewuser stopAnimating];
        
        
    }

    if(hvcData.isLike)
    {
        self.likeImage.image=self.likedImage;
          self.likeorunlikelab.text=@"Unlike";
    }
    else
    {
        self.likeImage.image=self.nonLikedImage;
          self.likeorunlikelab.text=@"Like";
    }
    
     if(data.number_of_likes>0)
     {
    NSString *s=[[NSString alloc] initWithFormat:@"%@",data.likecountlab];//ch
    self.likeCountLbl.text=s;
         
         self.likeCountLbl.hidden=NO;
         
         self.likeslabel.hidden=NO;
           self.viewLikesBt.hidden=NO;
           self.likestatusimage.hidden=NO;
         
         if(data.number_of_likes==1)
             self.likeslabel.text=@"Like";
         else
             self.likeslabel.text=@"Likes";
     }
    else
    {
         self.likeCountLbl.text=@"0";//ch
            self.likeCountLbl.hidden=YES;
          self.likeslabel.hidden=YES;
          self.viewLikesBt.hidden=YES;
          self.likestatusimage.hidden=YES;
    }
    self.commentCountLbl.text=data.commentcountlab;
    self.mainLblTxt=hvcData.commentstr;
    
    if(hvcData.playerfname && (!([hvcData.playerfname isEqualToString:@""])))
    {
        
    self.mainPostedByLbl.text=[NSString stringWithFormat:@"%@ %@",hvcData.playerfname,hvcData.playerlname];
        
        CGSize labelTextSize11 ;
        
        if(self.isiPad)
            labelTextSize11 =[self getSizeOfText:self.mainPostedByLbl.text :CGSizeMake (320,26) :self.mainPostedByLbl.font];
        else
            labelTextSize11 =[self getSizeOfText:self.mainPostedByLbl.text :CGSizeMake (160,20) :self.mainPostedByLbl.font];
        
        
        
        if(self.isiPad)
        {
        if(labelTextSize11.width>320)
            labelTextSize11.width=320;
        }
        else
        {
            if(labelTextSize11.width>160)
                labelTextSize11.width=160;
        }
        self.mainPostedByLbl.frame=CGRectMakeWithSize(self.mainPostedByLbl.frame.origin.x, self.mainPostedByLbl.frame.origin.y, labelTextSize11);

        
        
        if(self.isiPad)
        
        {
            if(appDelegate.isIos7)
                self.closeBtn.frame=CGRectMakeWithSize(((self.mainPostedByLbl.frame.origin.x+self.mainPostedByLbl.frame.size.width)-20),( self.closeBtn.frame.origin.y -6),self.closeBtn.frame.size);
            else
                self.closeBtn.frame=CGRectMakeWithSize(((self.mainPostedByLbl.frame.origin.x+self.mainPostedByLbl.frame.size.width)-50), self.closeBtn.frame.origin.y,self.closeBtn.frame.size);
        }
        else
        {
        if(appDelegate.isIos7)
            self.closeBtn.frame=CGRectMakeWithSize(((self.mainPostedByLbl.frame.origin.x+self.mainPostedByLbl.frame.size.width)-10),( self.closeBtn.frame.origin.y -3),self.closeBtn.frame.size);
        else
            self.closeBtn.frame=CGRectMakeWithSize(((self.mainPostedByLbl.frame.origin.x+self.mainPostedByLbl.frame.size.width)-25), self.closeBtn.frame.origin.y,self.closeBtn.frame.size);
        }
    }
    
    if(hvcData.adddate )
    {
    self.mainPostedOnLbl.text=/*[appDelegate.dateFormatFullHome stringFromDate:[appDelegate.dateFormatFullOriginalComment dateFromString:hvcData.adddate] ];*/[self getTimeString:[self getTimeStampFromDateString:hvcData.adddate] ];
    }
    mainLabelTextSize =[self getSizeOfText:self.mainLblTxt :CGSizeMake (self.mainCommentsLbl.frame.size.width,10000) :self.mainCommentsLbl.font];
    
    

    
    CGRect fr1=self.mainCommentsLbl.frame;
    
    if(self.isiPad)
        dY+=7;
    else
        dY+=3;
    fr1.origin.y=dY;
  
    fr1.size=mainLabelTextSize;
    self.mainCommentsLbl.frame=fr1;
    self.mainCommentsLbl.text=self.mainLblTxt;
    
    
    if(self.isiPad)
        dY=(self.mainCommentsLbl.frame.origin.y+self.mainCommentsLbl.frame.size.height+17+7);
    else
        dY=(self.mainCommentsLbl.frame.origin.y+self.mainCommentsLbl.frame.size.height+7+3);
 
    
    
    
    
    
    CGRect fr=self.subContainer.frame;
    fr.origin.y=dY;
    self.subContainer.frame=fr;
    
    dY=(self.subContainer.frame.origin.y+self.subContainer.frame.size.height+0);//7 to 0
    
    
    
    
    
    
    
    fr1=self.mainContainer.frame;


        fr1.size.height=dY;
    

    self.mainContainer.frame=fr1;
    
    self.mainContainer.layer.borderWidth=1.0;
    self.mainContainer.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.mainContainer.layer.cornerRadius=3.0;
   
    
    CGRect mainFrame=self.firstCommentCell.frame;
    
    if(self.isiPad)
          mainFrame.size=CGSizeMake(self.firstCommentCell.frame.size.width, self.mainContainer.frame.size.height+17);
    else
        mainFrame.size=CGSizeMake(self.firstCommentCell.frame.size.width, self.mainContainer.frame.size.height+7);
    self.firstCommentCell.frame=mainFrame;

    
    
    

    
    
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    
  
    [self processAllComments];

    
    
    
    
    
    
    //-------------------------- Adding a textview for commenting your own post ---------------------------//
    
   // self.postCommentVw.frame=CGRectMake(commentTableVw.frame.origin.x ,commentTableVw.frame.origin.y+406 , 316 ,50);
   /* self.postTxtVw.layer.borderWidth=0.5;
    self.postTxtVw.layer.borderColor=[appDelegate.cellRedColor CGColor];*/
    self.postTxtVw.text=@"Comments";
    self.postTxtVw.textColor=self.darkgraycolor;
    self.postTxtVw.layer.cornerRadius=6.0;
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
    
    appDelegate.centerViewController.navigationItem.title=@"Post";
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





-(void)showRelationComment:(id)sender
{
    UIButton *bt=(UIButton*)sender;
    CommentVCTableCell *hCell=(CommentVCTableCell*)bt.superview.superview;
    
    NSUInteger row = [[self.commentTableVw indexPathForCell:hCell] row];
    CommentVCTableData *cData=[self.dataArray objectAtIndex:(row-1)];
    
  /*  //  [self.relationVC setData:<#(NSString *)#> :<#(NSString *)#> :<#(BOOL)#>];
    
    //the popover will be presented from the okButton view
    [self.relationPopover presentPopoverFromView:sender];*/
    
    if(cData.isCoach)
    {
       // [self.relationVC setData:COACH :@"" :0];
    }
    else if(cData.isPlayer)
    {
        //[self.relationVC setData:PLAYER :@"" :0];
    }
    else if(cData.isPrimary)
    {
        CGSize m1=[self.relationVC setData:cData.playerNameTeam :cData.primaryRelation :1];
        
        self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);
        [self.relationPopover presentPopoverFromView:sender];
    }
    else
    {
      
       CGSize m1=[self.relationVC setData:cData.playerNameTeam :@"" :2];
      
        self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);
        [self.relationPopover presentPopoverFromView:sender];
    }
    
    
    
    
    //the popover will be presented from the okButton view
   
    
}


-(void)videoTapped:(UITapGestureRecognizer*)gesture
{
  //  UIImageView *imaView= (UIImageView*)gesture.view;
    
    
//    HomeVCTableCell *cell=(HomeVCTableCell*)imaView.superview.superview.superview;
//    
//    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
//    
//    
//    
//    
//    
//    HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
    
    [self btnVideoClicked:hvcData.videoUrlStr ];
    
}

-(void)resizeAfterImageDownload:(UIImage*)image1
{
    
    
    dY=self.userPost.frame.origin.y;
    if(image1)
    {
        CGRect fr=self.userPost.frame;
       __weak UIImage *image=image1;
        
        
        
        fr.size.width=image.size.width;///appDelegate.deviceScale;
        fr.size.height=image.size.height;///appDelegate.deviceScale;
        
       // NSLog(@"resizeAfterImageDownload==1.%@-2.%@",[NSValue valueWithCGSize:fr.size],[NSValue valueWithCGSize:image.size]);
        
        self.userPost.frame=fr;
    }
    
    if(self.isiPad)
    dY+=(self.userPost.frame.size.height+17);
    else
    dY+=(self.userPost.frame.size.height+7);
    mainLabelTextSize =[self getSizeOfText:self.mainLblTxt :CGSizeMake (self.mainCommentsLbl.frame.size.width,10000) :self.mainCommentsLbl.font];
    //[self.mainLblTxt sizeWithFont:self.mainCommentsLbl.font constrainedToSize:CGSizeMake (self.mainCommentsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    
    
    
    CGRect fr1=self.mainCommentsLbl.frame;
    
    if(self.isiPad)
    dY+=7;
    else
    dY+=3;
    fr1.origin.y=dY;
 
    fr1.size=mainLabelTextSize;
    self.mainCommentsLbl.frame=fr1;
    
    if(self.isiPad)
        dY=(self.mainCommentsLbl.frame.origin.y+self.mainCommentsLbl.frame.size.height+17+7);
    else
    dY=(self.mainCommentsLbl.frame.origin.y+self.mainCommentsLbl.frame.size.height+7+3);
    
    
    
    
    CGRect fr=self.subContainer.frame;
    fr.origin.y=dY;
    self.subContainer.frame=fr;
    
    dY=(self.subContainer.frame.origin.y+self.subContainer.frame.size.height+0);//7 to 0
    
    
    fr1=self.mainContainer.frame;
      fr1.size.height=dY;
    self.mainContainer.frame=fr1;
    CGRect mainFrame=self.firstCommentCell.frame;
    
    
    if(self.isiPad)
         mainFrame.size=CGSizeMake(self.firstCommentCell.frame.size.width, self.mainContainer.frame.size.height+17);
        else
    mainFrame.size=CGSizeMake(self.firstCommentCell.frame.size.width, self.mainContainer.frame.size.height+7);
    
    self.firstCommentCell.frame=mainFrame;
    
    
    if(self.hvcData.videoUrlStr)
    {
        float x=0.0;
        float y=0.0;
        
        
        x= self.userPost.center.x-(self.videoplayimavw.frame.size.width/2);
        y= self.userPost.center.y-(self.videoplayimavw.frame.size.height/2);
        self.videoplayimavw.frame=CGRectMake(x,y,self.videoplayimavw.frame.size.width,self.videoplayimavw.frame.size.height);
        
         self.videoplayimavw.hidden=NO;
        
    }
       
    

    
    [self.commentTableVw reloadData];
    
    
  
    
    
    
   // [appDelegate.centerVC.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}



-(void)processAllComments
{

   
    
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    self.dataArray=marr;
   // NSLog(@"CommentDetails=%@",marr);
    self.commentDetailsData=[self.hvcData commentdetailsarr];
    
     NSLog(@"CommentDetails=%@---%i",commentDetailsData,commentDetailsData.count);
    self.start=commentDetailsData.count;
    self.limit=5;
    //for(int i=(commentDetailsData.count-1); i>=0;i--)
    for(int i=0; i<(commentDetailsData.count);i++)
    {
        NSDictionary *dic =[commentDetailsData objectAtIndex:i];
        
        
        CommentVCTableData *dvca=[[CommentVCTableData alloc] init];
        
        BOOL existuserima=0;
        ImageInfo *imauser=nil;
        
        NSString *user=nil;
        NSString *comment=nil;
        NSString *adddate=nil;
        NSDate *pDate=nil;
        NSDate *pTime=nil;
        
        dvca.userImageInfo=nil;
        
        
        if(![[dic objectForKey:PROFILEIMAGE] isEqualToString:@""])
        {
            imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:PROFILEIMAGE]]]];
            existuserima=1;
            dvca.userImageInfo=imauser;
        }
        user=[[NSString alloc] initWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"],[dic objectForKey:@"LastName"] ];
        comment=/*@"self.moreBtn=[UIButton buttonWithType:UIButtonTypeCustom]moreBtn.frame=CGRectMake(18, 386, 45, 25)NSLog(,dY)[moreBtn setTitle forState:UIControlStateNormal]moreBtn.titleLabel.font = [UIFont fontWithName:moreBtn.titleLabel.textColor = [UIColor blueColor][moreBtn addTarget:self action:@selector(showFullComment:) forControlEvents:UIControlEventTouchUpInside][self.commentTableVw addSubview:moreBtn]";*/[dic objectForKey:@"Comment"];
        adddate=/*[appDelegate.dateFormatFullHome stringFromDate:[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"AddDate"]] ];*/[self getTimeString:[self getTimeStampFromDateString:[dic objectForKey:@"AddDate"]] ];
        
        
        
        
        NSDictionary *diction1=[dic objectForKey:@"cmnt_playerdetails"];
        @autoreleasepool
        {
            dvca.isPlayer=[[diction1 objectForKey:@"IsPlayer"] boolValue];
            dvca.isPrimary=[[diction1 objectForKey:@"Is_Primary"] boolValue];
            dvca.isCoach=[[diction1 objectForKey:@"Is_Coach"] boolValue];
            
            if(!dvca.isCoach)
            {
                NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                  playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                  playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.playerNameTeam=playerNameArray;
                dvca.playerIdTeam=playerIdArray;
            }
            
            if(dvca.isPrimary)
            {
                NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                  playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Relation"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                  playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.primaryUserName=playerNameArray;
                dvca.primaryRelation=playerIdArray;
            }
            
        }

        
        
        
        
        //            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
        //            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //            NSDate *now = [[NSDate alloc] init];
        //            NSString *dateString = [dateFormat stringFromDate:now];
        //            pDate=[dateFormat dateFromString:dateString];
        //            self.pDateString=[dateFormat stringFromDate:pDate];
        //
        //            NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
        //            [timeFormat setDateFormat:@"dd mmm,yyyy hh:mm a"];
        //            NSString *timeString = [timeFormat stringFromDate:now];
        //            pTime=[timeFormat dateFromString:timeString];
        //            self.pTimeString=[[timeFormat stringFromDate:pTime] lowercaseString];
        
        
        
        dvca.isExistUserImageInfo=existuserima;
        
        dvca.userName=user;
        dvca.postDate=pDate;
        dvca.postTime=pTime;
        dvca.postdatestr=adddate;
        dvca.commentstr= comment;
        
        CGSize rsize;
        if(self.isiPad)
         rsize= [self getSizeOfText:dvca.commentstr :CGSizeMake(590, 10000) :self.helveticaFont];
        else
         rsize= [self getSizeOfText:dvca.commentstr :CGSizeMake(236, 10000) :self.helveticaFont];
        
        /*if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//dvca.commentstr.length>100
        {
            NSString *reducedStr=nil;
            if(dvca.commentstr.length>100)
           reducedStr= [NSString stringWithFormat:@"%@...",[dvca.commentstr substringWithRange:NSMakeRange(0, 99)]];
            else
                reducedStr=dvca.commentstr;
            dvca.reducedCommentstr=reducedStr;
            dvca.isExpand=0;
        }
        else
        {*/
            dvca.isExpand=1;
        //}
        
        
        [self.dataArray addObject:dvca];
    }
   
  //  NSLog(@"The value of dY is %f",dY);  //416.0
    
      HomeVCTableData *data=self.hvcData;
    
    if(data.number_of_comment>0)
    {
        
        NSLog(@"Commentcountlab=%@---%lli",data.commentcountlab,data.number_of_comment);
        
 self.commentCountLbl.text=data.commentcountlab;
        self.commentCountLbl.hidden=NO;
        self.comntslabel.hidden=NO;
        self.commentsstatusimagevw.hidden=NO;
        
         if(data.number_of_comment==1)
        self.comntslabel.text=@"Comment";
        else
        self.comntslabel.text=@"Comments";
    }
    else
    {
 self.commentCountLbl.text=@"0";//ch
        self.commentCountLbl.hidden=YES;
        self.comntslabel.hidden=YES;
         self.commentsstatusimagevw.hidden=YES;
    }
    
     [self.commentTableVw reloadData];
    
    
    
    /*if(self.dataArray.count>0)
        self.commentTableVw.hidden=NO;
    else
        self.commentTableVw.hidden=YES;*/

}




-(void)commentExtraDataLoaded:(id)sender
{
    
  
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COMMENTLISTING])
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
                    
                    aDict=[aDict objectForKey:@"response"];
                      aDict=[aDict objectForKey:@"team_details"];
                      aDict=[aDict objectForKey:@"post_details"];
                  NSArray *arr=[aDict objectForKey:@"comment_user_details"];
                    
                   // if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    if(arr.count>0)
                    {
                        
                        
                        self.wallfootervwgreydot.hidden=NO;
                        [self.wallfootervwactivind stopAnimating];
                        
                      
                        
                     
                       
                        
                        NSMutableArray *mar= [self loadListingCommentDetails:arr];
                        
                        [self.dataArray addObjectsFromArray:mar];
                        
                        self.start+=self.limit;
                        /////////////////////
                        
                      
                        
                    }
                                       
                    else
                    {
                        isFinishData=1;
                        self.wallfootervwgreydot.hidden=NO;
                        [self.wallfootervwactivind stopAnimating];
                    }
                    
                }
                else
                {
                    isFinishData=1;
                }
                
            }
            else
            {
                isFinishData=1;
            }
        }
        else
        {
              isFinishData=1;
            
        }
    }
    else
    {
          isFinishData=1;
    }



   [self.commentTableVw reloadData];
}



-(NSMutableArray*)loadListingCommentDetails:(NSArray*)responses
{
    NSMutableArray *marray=[[NSMutableArray alloc] init];
    
    
    NSLog(@"responses=%@",responses);
    
   // self.commentDetailsData=[self.hvcData commentdetailsarr];
    
    
    
    
    
    //for(int i=(responses.count-1); i>=0;i--)
     for(int i=0; i<(responses.count);i++)
    {
        NSDictionary *dic =[responses objectAtIndex:i];
        
        
        CommentVCTableData *dvca=[[CommentVCTableData alloc] init];
        
        BOOL existuserima=0;
        ImageInfo *imauser=nil;
        
        NSString *user=nil;
        NSString *comment=nil;
        NSString *adddate=nil;
        NSDate *pDate=nil;
        NSDate *pTime=nil;
        
        dvca.userImageInfo=nil;
        
        
        if(![[dic objectForKey:PROFILEIMAGE] isEqualToString:@""])
        {
            imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:PROFILEIMAGE]]]];
            existuserima=1;
            dvca.userImageInfo=imauser;
        }
        user=[[NSString alloc] initWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"],[dic objectForKey:@"LastName"] ];
        comment=/*@"self.moreBtn=[UIButton buttonWithType:UIButtonTypeCustom]moreBtn.frame=CGRectMake(18, 386, 45, 25)NSLog(,dY)[moreBtn setTitle forState:UIControlStateNormal]moreBtn.titleLabel.font = [UIFont fontWithName:moreBtn.titleLabel.textColor = [UIColor blueColor][moreBtn addTarget:self action:@selector(showFullComment:) forControlEvents:UIControlEventTouchUpInside][self.commentTableVw addSubview:moreBtn]";*/[dic objectForKey:@"Comment"];
        adddate=/*[appDelegate.dateFormatFullHome stringFromDate:[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"AddDate"]] ];*/[self getTimeString:[self getTimeStampFromDateString:[dic objectForKey:@"AddDate"]] ];
        
        
        
        
        NSDictionary *diction1=[dic objectForKey:@"cmnt_playerdetails"];
        @autoreleasepool
        {
            dvca.isPlayer=[[diction1 objectForKey:@"IsPlayer"] boolValue];
            dvca.isPrimary=[[diction1 objectForKey:@"Is_Primary"] boolValue];
            dvca.isCoach=[[diction1 objectForKey:@"Is_Coach"] boolValue];
            
            if(!dvca.isCoach)
            {
                NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.playerNameTeam=playerNameArray;
                dvca.playerIdTeam=playerIdArray;
            }
            
            if(dvca.isPrimary)
            {
                NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Relation"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                dvca.primaryUserName=playerNameArray;
                dvca.primaryRelation=playerIdArray;
            }
            
        }
        
        
               
        
        
        dvca.isExistUserImageInfo=existuserima;
        
        dvca.userName=user;
        dvca.postDate=pDate;
        dvca.postTime=pTime;
        dvca.postdatestr=adddate;
        dvca.commentstr= comment;
        
        CGSize rsize;
        if(self.isiPad)
          rsize= [self getSizeOfText:dvca.commentstr :CGSizeMake(590, 10000) :self.helveticaFont];
        else
         rsize= [self getSizeOfText:dvca.commentstr :CGSizeMake(236, 10000) :self.helveticaFont];
        
        /*if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//dvca.commentstr.length>100
        {
            NSString *reducedStr=nil;
            
               if(dvca.commentstr.length>100)
          reducedStr=  [NSString stringWithFormat:@"%@...",[dvca.commentstr substringWithRange:NSMakeRange(0, 99)]];
            else
                reducedStr=dvca.commentstr;
            
            dvca.reducedCommentstr=reducedStr;
            dvca.isExpand=0;
        }
        else
        {*/
            dvca.isExpand=1;
        //}
        
        
        [marray addObject:dvca];
    }
    
    
    
    
    return marray;
}


    //---------------------- Adjusting the position of the textfield for posting comment ----------------------//

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //self.postCommentBtn.hidden=NO;
    
    self.postTxtVw.text = @"";
    self.postTxtVw.textColor = self.darkgraycolor;
    
    self.commentcancelbt.hidden=NO;
    self.commentTableVw.frame= CGRectMake(self.commentTableVw.frame.origin.x, self.commentTableVw.frame.origin.y, self.commentTableVw.frame.size.width, self.commentTableVw.frame.size.height - 216);
    self.postCommentVw.frame= CGRectMake(self.postCommentVw.frame.origin.x, self.postCommentVw.frame.origin.y - 216, self.postCommentVw.frame.size.width, self.postCommentVw.frame.size.height);
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:((int)[self.dataArray count])-1 inSection:0];
    [self.commentTableVw scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
        [self.postCommentBtn setBackgroundImage:self.normalSelpost forState:UIControlStateNormal];
    
      [self.postCommentBtn setTitleColor:self.whitecolor forState:UIControlStateNormal];

    return YES;
}




- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
     //self.postCommentBtn.hidden=YES;
    
    
      self.commentcancelbt.hidden=YES;
    self.commentTableVw.frame= CGRectMake(self.commentTableVw.frame.origin.x, self.commentTableVw.frame.origin.y, self.commentTableVw.frame.size.width, self.commentTableVw.frame.size.height + 216);
    self.postCommentVw.frame= CGRectMake(self.postCommentVw.frame.origin.x, self.postCommentVw.frame.origin.y + 216, self.postCommentVw.frame.size.width, self.postCommentVw.frame.size.height);
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:((int)[self.dataArray count])-1 inSection:0];
    
    [self.commentTableVw scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
        [self.postCommentBtn setBackgroundImage:self.normalpost forState:UIControlStateNormal];
     [self.postCommentBtn setTitleColor:self.lightgraycolor forState:UIControlStateNormal];
    return YES;
}


-(void) textViewDidChange:(UITextView *)textView
{
    if(self.postTxtVw.text.length == 0)
    {
        self.postTxtVw.textColor = self.darkgraycolor;
        self.postTxtVw.text = @"Comments";
        [self.postTxtVw resignFirstResponder];
        
         [self.postCommentBtn setBackgroundImage:self.normalpost forState:UIControlStateNormal];
        [self.postCommentBtn setTitleColor:self.lightgraycolor forState:UIControlStateNormal];
    }
   
}

-(void) showFullComment: (UIButton *) sender
{
//    [self.view bringSubviewToFront:commentTableVw];
//    
//    dY=(self.subContainer.frame.origin.y+self.subContainer.frame.size.height+2);
//    
///*   CGSize mainLabelTextSize = [self.mainLblTxt sizeWithFont:self.mainCommentsLbl.font constrainedToSize:CGSizeMake (self.mainCommentsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];*/
//    
//    CGRect fr1=self.mainCommentsLbl.frame;
//    fr1.origin.y=dY;
//    fr1.size=mainLabelTextSize;
//    self.mainCommentsLbl.frame=fr1;
//    self.mainCommentsLbl.text=self.mainLblTxt;
//
//    
//    dY=(self.mainCommentsLbl.frame.origin.y+self.mainCommentsLbl.frame.size.height);
//
//    fr1=self.mainContainer.frame;
//    fr1.size.height=dY;
//    self.mainContainer.frame=fr1;
//    
//    self.mainContainer.layer.borderWidth=0.5;
//    self.mainContainer.layer.borderColor=[[UIColor lightGrayColor] CGColor];
//    self.mainContainer.layer.cornerRadius=8.0;
//    
//    CGRect mainFrame=self.firstCommentCell.frame;
//    mainFrame.size=CGSizeMake(self.mainContainer.frame.size.width, self.mainContainer.frame.size.height+3);
//    self.firstCommentCell.frame=mainFrame;
//    
//    moreBtn.hidden=YES;
//    
//    [self.commentTableVw reloadData];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}


-(void) showFullCellComment: (UIButton *) sender
{
    rowNoToExpand=sender.tag;
    
    CommentVCTableData *cData=[self.dataArray objectAtIndex:(rowNoToExpand-1)];
    cData.isExpand=1;
    
    sender.hidden=YES;
    
    [self.commentTableVw reloadData];
}

- (IBAction)backf:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadVC
{
    
}

-(void)resetVC
{
    
}

//- (void)timeout:(id)arg
//{
//    hud.labelText = @"Timeout.";
//    hud.detailsLabelText = @"Please try again later.";
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//	hud.mode = MBProgressHUDModeCustomView;
//    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
//}

- (void)dismissHUD:(id)arg
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    hud = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageUpdated:(NSNotification *)notif
{
    CommentVCTableData * info = [notif object];
    
    if([self.dataArray containsObject:info])
    {
        int row = [self.dataArray indexOfObject:info];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:(row+1) inSection:0];
        
      //  NSLog(@"Image for row %d updated! Count=%i", row,[self.dataArray count]);
        
        [self.commentTableVw reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)imageUpdatedUser:(NSNotification *)notif
{
    ImageInfo *imaInfo=(ImageInfo*)[notif object];
    
   
    
    
 
    
    if([imaInfo.notificationName isEqualToString:COMMENTVIEWCONTROLLERIMAGELOADEDUSER])
    {
        [self.userImg setImage:imaInfo.image/*[self getImage:imaInfo.image isWidth:0 length:imaInfo.image.size.height]*/];
        self.userImg.hidden=NO;
        self.acindviewuser.hidden=YES;
        [self.acindviewuser stopAnimating];
    }
    else
    {
        UIImage *ima=[self getImage:imaInfo.image isWidth:1 length:self.userPost.frame.size.width];
        
        [self.userPost setImage:ima];
        [self resizeAfterImageDownload:ima];
        
        self.userPost.hidden=NO;
        self.acindviewpost.hidden=YES;
        [self.acindviewpost stopAnimating];
    }
    
}

#pragma mark - Table View


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 2;
  totalCellCount=[self.dataArray count]+1+1;
    return (totalCellCount);
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if(indexPath.row==0)
    {
        return firstCommentCell.frame.size.height;
    }
    else
    {
        
        if(indexPath.row==([self.dataArray count]+1))
        {
            return self.wallfootervw.frame.size.height;
        }
        else
        {
            
            
            CommentVCTableData *data=[self.dataArray objectAtIndex:(indexPath.row-1)];
            
            if(self.isiPad)
                dYRow=110;
            else
                dYRow=54;
            
            CGSize labelTextSize;
            if(self.isiPad)
                labelTextSize =[self getSizeOfText:data.commentstr :CGSizeMake (590,10000) :[UIFont systemFontOfSize:19.0]];
            else
                labelTextSize =[self getSizeOfText:data.commentstr :CGSizeMake (236,10000) :[UIFont systemFontOfSize:12.0]];
            
            //[data.commentstr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake (236,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            
            if(self.isiPad)
                cellLabelTextSize=CGSizeMake(590, COMMENTTEXTLIMITEDHEIGHT);
            else
                cellLabelTextSize=CGSizeMake(236, COMMENTTEXTLIMITEDHEIGHT);//[self getSizeOfText:data.reducedCommentstr :CGSizeMake (236,10000) :[UIFont systemFontOfSize:12.0]];
            
            //  [data.reducedCommentstr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake (236,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            CGSize rsize;
            
            
            if(self.isiPad)
                rsize=  [self getSizeOfText:data.commentstr :CGSizeMake(590, 10000) :self.helveticaFont];
            else
                rsize=  [self getSizeOfText:data.commentstr :CGSizeMake(236, 10000) :self.helveticaFont];
            
            
            
            
            
            if(self.isiPad)
                
            {
                if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//if(((int)[data.commentstr length])>100)
                {
                    if(!data.isExpand)
                    {
                        //   NSLog(@"1.The new height of the expanded row is %f-%f-%i",dYRow,cellLabelTextSize.height,indexPath.row);
                        dYRow=(dYRow+cellLabelTextSize.height+5)+50+17;
                        // NSLog(@"1.1-The new height of the expanded row is %f",dYRow);
                    }
                    else
                    {
                        //   NSLog(@"2.The new height of the expanded row is %f-%f-%i",dYRow,labelTextSize.height,indexPath.row);
                        dYRow=(dYRow+labelTextSize.height+5)+17;
                        // NSLog(@"2.2-The new height of the expanded row is %f",dYRow);
                    }
                }
                else
                {
                    dYRow=(dYRow+labelTextSize.height+5)+17;
                }
                
            }
            else
            {
                if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//if(((int)[data.commentstr length])>100)
                {
                    if(!data.isExpand)
                    {
                        //   NSLog(@"1.The new height of the expanded row is %f-%f-%i",dYRow,cellLabelTextSize.height,indexPath.row);
                        dYRow=(dYRow+cellLabelTextSize.height+2)+20+7;
                        // NSLog(@"1.1-The new height of the expanded row is %f",dYRow);
                    }
                    else
                    {
                        //   NSLog(@"2.The new height of the expanded row is %f-%f-%i",dYRow,labelTextSize.height,indexPath.row);
                        dYRow=(dYRow+labelTextSize.height+2)+7;
                        // NSLog(@"2.2-The new height of the expanded row is %f",dYRow);
                    }
                }
                else
                {
                    dYRow=(dYRow+labelTextSize.height+2)+7;
                }
            }
            //NSLog(@"The height of the row is %f",dYRow);
            
            
            
            
            
            
            
            
            
            
            return dYRow;
        }
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    tableView.sectionHeaderHeight=0.0;
    return 0.0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    tableView.sectionFooterHeight=0;
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CommentVCTableCell";
    static NSString *CellIdentifier1 = @"cell";
     static NSString *CellIdentifier2 = @"cell1";

    if(indexPath.row==0)
    {
        UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        if(![self.firstCommentCell.superview.superview isEqual:cell])
        {
            CGRect fr= self.firstCommentCell.frame;
            fr.origin.x=5;
            if (self.isiPad)
                fr.size.width=758;
            else
                fr.size.width=310;
            self.firstCommentCell.frame=fr;
            [cell.contentView addSubview:self.firstCommentCell];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else
    {
        
        if(indexPath.row==([self.dataArray count]+1))
        {
            UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
                
                cell.backgroundColor=[UIColor clearColor];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
               
            
            if(!self.wallfootervw.superview)
            {
                [cell addSubview:self.wallfootervw];
            }
            
            if(tableView1.contentSize.height>tableView1.frame.size.height &&   self.isFinishData==0)
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
        
        CommentVCTableCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            /*if(self.isiPad)
             cell = (CommentVCTableCell *)[CommentVCTableCell cellFromNibNamed:@"CommentVCTableCell_iPad"];
               else*/
            cell = (CommentVCTableCell *)[CommentVCTableCell cellFromNibNamed:@"CommentVCTableCell"];
        }
        [self configureCell:cell atIndexPath:indexPath];
        
        return cell;
        }
    }
    
}

-(void)requestForTableViewFooterLoading:(NSNumber*)index
{
    
    
    /*  if(self.dataArray==nil)
     [self showMiddleActivityInd];*/
    
    NSString *postId=hvcData.post_id;
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
   
    // [command setObject:@"" forKey:@"invites"];
    [command setObject:postId forKey:@"post_id"];
    
   // [command setObject:[appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:appDelegate.centerVC.lastSelectedTeam] forKey:@"team_id"];
    
    
    //self.limit+=[DEFAULTLIMIT longLongValue];
    
    @autoreleasepool {
        
        
        [command setObject:[NSString stringWithFormat:@"%lli",self.start] forKey:@"start"];
        [command setObject:[NSString stringWithFormat:@"%lli",self.limit] forKey:@"limit"];
    }
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COMMENTLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq4];
    sinReq.notificationName=COMMENTLISTING;
    sinReq.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:self.start],@"StartIndex",/*index,@"Index",*/ nil ];
    [sinReq startRequest];
    
    
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    self.commentCell=(CommentVCTableCell *)cell;
    commentCell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSUInteger row = [indexPath row];
    CommentVCTableData *cData=[self.dataArray objectAtIndex:(row-1)];
    

    
//    float dYCell=0.0;
    dYCell=commentCell.commntsLbl.frame.origin.y;
 //    dYCell=commentCell.userimg.frame.origin.y+commentCell.userimg.frame.size.height+7;
//        dY=self.firstCommentCell.frame.size.height;
//        dY=(dY+self.mainContainer.frame.size.height+5)+28+3;
       [commentCell.userprofimabt addTarget:self action:@selector(showRelationComment:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [commentCell.userimg cleanPhotoFrame];
    
    if(cData.isExistUserImageInfo)
    {
        ImageInfo *info1 = cData.userImageInfo;
        
        
        [commentCell.userimg applyPhotoFrame];
        
        if(info1.image)
        {
            [commentCell.userimg setImage:info1.image];
            commentCell.userimg.hidden=NO;
            commentCell.acindviewuser.hidden=YES;
            [commentCell.acindviewuser stopAnimating];
        }
        else
        {
            commentCell.acindviewuser.hidden=NO;
            commentCell.userimg.hidden=YES;
            [commentCell.acindviewuser startAnimating];
            info1.notificationName=COMMENTVIEWCONTROLLERIMAGELOADED;
            info1.notifiedObject=cData;
            
            if(!info1.isProcessing)
            [info1 getImage];
        }
       
    }
    else
    {
        commentCell.userimg.image=self.noImage;
        commentCell.acindviewuser.hidden=YES;
        [commentCell.acindviewuser stopAnimating];
    }
        
    commentCell.postedByLbl.text=cData.userName;
    NSString *commntTime=cData.postdatestr;
    commentCell.postedOnLbl.text=commntTime;
    
    //commentCell.commntsLbl.frame=CGRectMake(29, 44, 271, 52);

    self.orgComment=cData.commentstr;
    
    cellLabelTextSize =[self getSizeOfText:cData.commentstr :CGSizeMake (commentCell.commntsLbl.frame.size.width,10000) :commentCell.commntsLbl.font];
    
    //[cData.commentstr sizeWithFont:commentCell.commntsLbl.font constrainedToSize:CGSizeMake (commentCell.commntsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    
    
 //   NSLog(@"******** Here the original comment is %@",cData.commentstr);
    
    if([[commentCell.contentView viewWithTag:indexPath.row] isMemberOfClass:[UIButton class]])
    {
        self.cellMoreBtn=(UIButton*)[commentCell.contentView viewWithTag:indexPath.row];
         self.cellMoreBtn.hidden=YES;
    }
    //************************************************************************//
    
    CGSize rsize;
    if(self.isiPad)
    rsize= [self getSizeOfText:orgComment :CGSizeMake(590, 10000) :self.helveticaFont];
    else
    rsize= [self getSizeOfText:orgComment :CGSizeMake(236, 10000) :self.helveticaFont];
    
    if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//if(orgComment.length>100)
    {
        if(!cData.isExpand)
        {
            
            
          //  NSString *reducedStr=[NSString stringWithFormat:@"%@",[cData.commentstr substringWithRange:NSMakeRange(0, 99)]];
          //  reducedStr=[NSString stringWithFormat:@"%@...",reducedStr];
            
          //  NSLog(@"The reduced string is and length is %@ and %d",reducedStr,reducedStr.length);
            //NSLog(@"Width = %f  Height = %f",size1.width,size1.height);
            
           // cData.reducedCommentstr=[NSString stringWithFormat:@"%@",reducedStr];
            commentCell.commntsLbl.text=cData.reducedCommentstr;
            
            
            if(self.isiPad)
            cellLabelTextSize =CGSizeMake(590, COMMENTTEXTLIMITEDHEIGHT);
                else
            cellLabelTextSize =CGSizeMake(236, COMMENTTEXTLIMITEDHEIGHT);
            
            
            
            //[self getSizeOfText:cData.reducedCommentstr :CGSizeMake (commentCell.commntsLbl.frame.size.width,10000):commentCell.commntsLbl.font];
           // [cData.reducedCommentstr sizeWithFont:commentCell.commntsLbl.font constrainedToSize:CGSizeMake (commentCell.commntsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            if([[commentCell.contentView viewWithTag:indexPath.row] isMemberOfClass:[UIButton class]])
            {
                self.cellMoreBtn=(UIButton*)[commentCell.contentView viewWithTag:indexPath.row];
                 self.cellMoreBtn.hidden=NO;
            }
            else
            {
            self.cellMoreBtn=[UIButton buttonWithType:UIButtonTypeCustom]; //398
            cellMoreBtn.tag=(indexPath.row);
            
            }
            
            //commentCell.contentView.frame.origin.x
            if(self.isiPad)
            {
                cellMoreBtn.frame=CGRectMake(150, 210, 50, 50);
                cellMoreBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.0f];
            }
            else
            {
            cellMoreBtn.frame=CGRectMake(60, 83, 45, 25);
            cellMoreBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 12.0f];
            }
            //NSLog(@"The new vlaue of dY is %f",dY);
            [cellMoreBtn setTitle:@"More" forState:UIControlStateNormal];
            
            cellMoreBtn.titleLabel.textColor =appDelegate.themeCyanColor;
            [cellMoreBtn addTarget:self action:@selector(showFullCellComment:) forControlEvents:UIControlEventTouchUpInside];
            
            [commentCell.contentView addSubview:cellMoreBtn];
            [commentCell.contentView bringSubviewToFront:cellMoreBtn];
            
            
            //fr2=commentCell.commntsLbl.frame;
            //fr2.size=cellLabelTextSize;
            //fr2.origin.y=dYCell;
//            fr2.size=cellLabelTextSize;
//            commentCell.commntsLbl.frame=fr2;
//            commentCell.commntsLbl.text=cData.commentstr;
        }
       
    }
  
    
    CGRect fr2=commentCell.commntsLbl.frame;
    fr2.origin.y=dYCell;
    fr2.size=cellLabelTextSize;
    commentCell.commntsLbl.frame=fr2;
    commentCell.commntsLbl.text=cData.commentstr;

    //dYCell=(commentCell.commntsLbl.frame.origin.y+commentCell.commntsLbl.frame.size.height);

    dYCell=(dYCell+commentCell.commntsLbl.frame.size.height);

    
    
     //************************************************************************//
//    if(indexPath.row==rowNoToExpand)
//    {
//        
//        dYCell=(commentCell.commntsLbl.frame.origin.y+commentCell.commntsLbl.frame.size.height+2);
//        NSLog(@"The new value of dYCell is %f",dYCell);
//        
//        cellLabelTextSize = [orgComment sizeWithFont:commentCell.commntsLbl.font constrainedToSize:CGSizeMake (commentCell.commntsLbl.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
//        
//        NSLog(@"The original comment is %@",orgComment);
//        
//        
//        CGRect fr2=commentCell.commntsLbl.frame;
//        fr2.origin.y=dYCell;
//        fr2.size=cellLabelTextSize;
//        commentCell.commntsLbl.frame=fr2;
//        commentCell.commntsLbl.text=orgComment;
//        
//        dYRow=dYRow+dYCell;
//        
//        NSLog(@"The new value of dYRow is %f",dYRow);
//        
//        fr2=self.commentCell.frame;
//        fr2.size.height=dYRow;
//        self.commentCell.frame=fr2;
//        
//        CGRect mainFrame=self.commentCell.frame;
//        mainFrame.size=CGSizeMake(self.commentCell.frame.size.width, self.commentCell.frame.size.height+3);
//        self.commentCell.frame=mainFrame;
//        
//        [cellMoreBtn setTitle:@"" forState:UIControlStateNormal];
//        cellMoreBtn.titleLabel.textColor = [UIColor whiteColor];
//        cellMoreBtn.hidden=YES;
//    }
    
     float m1;
    if(self.isiPad)
    {
        m1=20;
        
        if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//if(orgComment.length>100)
        {
            if(!cData.isExpand)
            {
                m1=70;
            }
            else
            {
                
            }
            
        }
    }
    else
    {
    m1=8;
    
    if(rsize.width>COMMENTTEXTLIMITEDHEIGHT)//if(orgComment.length>100)
    {
        if(!cData.isExpand)
        {
             m1=28;
        }
        else
        {
           
        }
        
    }
    }
    CGRect r1=self.commentCell.separator.frame;
    r1.origin.y=  dYCell+m1;
    self.commentCell.separator.frame=r1;
    
}

- (IBAction)commentPost:(id)sender
{
    if((self.postTxtVw.text.length>0) && !([self.postTxtVw.text isEqualToString:@"Comments"]))
    {
        [self postComment:self.postTxtVw.text];
        [self.view endEditing:YES];
        self.postTxtVw.text=@"Comments";
        self.postTxtVw.textColor =self.darkgraycolor;
        
        
        
    }
    else
    {
        UIAlertView *alarmMsg=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter some comments." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alarmMsg show];
    }
   
}


-(void)likeFailed:(id)sender
{
     // [self showAlertMessage:CONNFAILMSG title:@"Error"];ChAfter
}

- (IBAction)likeComment:(id)sender
{
    int tag=[sender tag];
    if(tag==0)
    {
    int row = [appDelegate.centerVC.dataArray indexOfObject:self.hvcData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    UIButton *bt=[(HomeVCTableCell*)[appDelegate.centerVC.tableView cellForRowAtIndexPath:indexPath] likebt];

    
    
    [appDelegate.centerVC likeComment:bt];
    }
    else
    {
        [self.postTxtVw becomeFirstResponder];
        
        [self.postCommentBtn setBackgroundImage:self.normalSelpost forState:UIControlStateNormal];
        [self.postCommentBtn setTitleColor:self.whitecolor forState:UIControlStateNormal];
    }
}

-(void)postComment:(NSString*)strforpost
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
      [command setObject:[hvcData post_id] forKey:@"post_id"];
    [command setObject:strforpost forKey:@"comment"];
    
    self.requestDic=command;
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
       [appDelegate sendRequestFor:COMMENTPOST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
   
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:COMMENTPOST])
        {
            // [self resetPostView];
        }
        return;
    }
    ConnectionManager *aR=(ConnectionManager*)aData1;
    NSString *str=(NSString*)aData;
    
    if([aR.requestSingleId isEqualToString:COMMENTPOST ])
    {
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
                    
                    [self reloadAfterComment:[self.requestDic objectForKey:@"comment"]:[aDict objectForKey:@"comment_adddate"]:[aDict objectForKey:PROFILEIMAGE]];
                    
                    
                    self.requestDic=nil;
                    
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
    }
    
}


-(void)reloadAfterComment:(NSString*)cmnt :(NSString*)datestr :(NSString*)profileImage
{
   // NSLog(@"reloadAfterComment%@---%@-----%@",cmnt,datestr,profileImage);
    
    hvcData.commentcountlab=[NSString stringWithFormat:@"%lli",++(hvcData.number_of_comment)];//ch
    
    
   
    
    
   NSMutableDictionary *mdic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[appDelegate.aDef objectForKey:FIRSTNAME],@"FirstName",[appDelegate.aDef objectForKey:LASTNAME],@"LastName",profileImage,PROFILEIMAGE,cmnt,@"Comment",datestr,@"AddDate", nil];
    NSMutableArray *marr=[[NSMutableArray alloc] initWithArray:hvcData.commentdetailsarr];
    
    
    [marr addObject:mdic];
    hvcData.commentdetailsarr=marr;
    
   
    
  
    
    
    
    
    [self processAllComments];
    
    [appDelegate.centerVC.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)likeTextUpdated:(id)sender
{
    self.likeCountLbl.text=[sender object];
    
    int m=[[self.likeCountLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] integerValue];
    if(m>0)
    {
        NSString *s=[[NSString alloc] initWithFormat:@"%i",m];//ch
        self.likeCountLbl.text=s;
        
        self.likeCountLbl.hidden=NO;
        self.likeslabel.hidden=NO;
        self.viewLikesBt.hidden=NO;
        self.likestatusimage.hidden=NO;
        
        if(m==1)
        self.likeslabel.text=@"Like";
        else
        self.likeslabel.text=@"Likes";
    }
    else
    {
        self.likeCountLbl.text=@"0";//ch
        self.likeCountLbl.hidden=YES;
         self.likeslabel.hidden=YES;
          self.viewLikesBt.hidden=YES;
          self.likestatusimage.hidden=YES;
    }
}
-(void)likeAnimationUpdated:(id)sender
{
    
    BOOL like=[[sender object] boolValue];
    
    
    
    if(!like)
    {
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             
                             CGRect theFrame = self.likeImage.frame;
                             theFrame.origin.x -= 2;
                             theFrame.origin.y -= 2;
                             theFrame.size.height += 4;
                             theFrame.size.width += 4;
                             
                             
                             self.likeImage.frame = theFrame;
                             
                             self.likeImage.image=self.likedImage;
                             self.likeorunlikelab.text=@"Unlike";
                             self.likeImage.animationRepeatCount=1;
                             self.likeImage.animationDuration=0.5;
                             self.likeImage.animationImages=self.animationtogreensets;
                             [self.likeImage startAnimating];
                             
                             
                         } completion:^(BOOL finished) {
                             
                             self.likeImage.image=self.likedImage;
                               self.likeorunlikelab.text=@"Unlike";
                             [UIView animateWithDuration:0.5
                                                   delay:0.0
                                                 options:UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  CGRect theFrame = self.likeImage.frame;
                                                  theFrame.origin.x += 2;
                                                  theFrame.origin.y += 2;
                                                  theFrame.size.height -= 4;
                                                  theFrame.size.width -= 4;
                                                  self.likeImage .frame = theFrame;
                                                  
                                                  
                                              }completion:^(BOOL finished) {
                                                  
                                                  
                                                  self.likeImage.image=self.likedImage;
                                                    self.likeorunlikelab.text=@"Unlike";
                                              }];
                         }];
        
    }
    else
    {
        self.likeImage.image=self.nonLikedImage;
          self.likeorunlikelab.text=@"Like";
        self.likeImage.animationImages=self.animationtowhitesets;
        self.likeImage.animationDuration=1.0;
        self.likeImage.animationRepeatCount=1;
        [self.likeImage startAnimating];
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // selectedRow=indexPath.row+1;
    
    if(indexPath.row==([self.dataArray count]+1))
    {
        return;
    }
    
    
    
    if(indexPath.row==0)
        selectedRow=indexPath.row;
    else
    {
        if((indexPath.row-1)< self.dataArray.count)
        {
        selectedRow=indexPath.row-1;

    CommentVCTableData *cellHt=[self.dataArray objectAtIndex:(selectedRow)];
        
        }
  //  NSLog(@"The height of the selected row %d is: %f",selectedRow,dYRow);
  //  NSLog(@"The length of the comment of the selected row %d is %d",selectedRow,cellHt.commentstr.length);
    }
}



- (void)viewDidUnload
{
    self.moreBtn=nil;
    self.cellMoreBtn=nil;
   
    self.firstCommentCell=nil;
    self.mainContainer=nil;
    self.subContainer=nil;
    
    self.userImg=nil;
    self.mainPostedByLbl=nil;
    self.mainPostedOnLbl=nil;
    self.userPost=nil;
    
    self.likeCountLbl=nil;
    self.commentCountLbl=nil;
    self.likeBtn=nil;
    self.commentBtn=nil;
    
    self.mainCommentsLbl=nil;
  
    self.closeBtn=nil;
    
    self.commentTableVw=nil;
   
    
    
    
    self.postCommentVw =nil;
    self.postTxtVw =nil;
    self.postCommentBtn =nil;
    
  
 
    self.commentCell=nil;
    self.hud=nil;

    
    [self setLikeImage:nil];
    [self setCommentcancelbt:nil];
    [self setTeamNamelab:nil];
    [self setLikeorunlikelab:nil];
    [self setCommentlabel:nil];
    [self setLikeslabel:nil];
    [self setComntslabel:nil];
    [self setViewLikesBt:nil];
    [self setVideoplayimavw:nil];
    [super viewDidUnload];
}
- (IBAction)commentCancelbTapped:(id)sender
{
    
    self.postTxtVw.textColor = self.darkgraycolor;
    self.postTxtVw.text = @"Comments";
    [self.postTxtVw resignFirstResponder];
    [self.postCommentBtn setBackgroundImage:self.normalpost forState:UIControlStateNormal];
    [self.postCommentBtn setTitleColor:self.lightgraycolor forState:UIControlStateNormal];
}
- (IBAction)showRelationPlayer:(id)sender
{
    
    
    
    
    
    
}

- (IBAction)relationActionPlayer:(id)sender
{
    
    /* [self.relationVC setData:hvcData.playerfname :hvcData.playerlname :0];
    
    //the popover will be presented from the okButton view
    [self.relationPopover presentPopoverFromView:sender];*/
    
    if([hvcData.userId isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]])
        return;
    
    if(hvcData.isCoach)
    {
        //[self.relationVC setData:COACH :@"" :0];
    }
    else if(hvcData.isPlayer)
    {
       // [self.relationVC setData:PLAYER :@"" :0];
    }
    else if(hvcData.isPrimary)
    {
        CGSize m1=[self.relationVC setData:hvcData.playerNameTeam :hvcData.primaryRelation :1];
       
        self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);
        [self.relationPopover presentPopoverFromView:sender];
    }
    else
    {
             
        CGSize m1= [self.relationVC setData:hvcData.playerNameTeam :@"" :2];
        self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);

         [self.relationPopover presentPopoverFromView:sender];
    }
    
    
    
    
    //the popover will be presented from the okButton view
   
}
- (IBAction)viewLikes:(id)sender
{
    
    
    PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
    self.postLikeVC=commentView;
    
    
    
    commentView.no_of_likesStr=[[NSString alloc] initWithFormat:@"%lli",hvcData.number_of_likes];
    commentView.postId=hvcData.post_id;
    
    [self.navigationController pushViewController:commentView animated:YES];
    
    commentView=nil;
    
    
    
    
    
}
@end
