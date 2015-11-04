//
//  PhotoMainVC.m
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import "PhotoListVC.h"
#import "PhotoListVCTableCell.h"
#import "UIButton+AFNetworking.h"
#import "AFHTTPClient.h"
#import "PhotoVC.h"

@interface PhotoListVC ()

@end

@implementation PhotoListVC

@synthesize backToAlbumBtn,pmvc,selectedAlbumNo,photoCount,isEditEnabled,tableVw,maxPhotoNo,photoNameList,editBtn,addBtn,albName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pmvc=[[PhotoMainVC alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    
    self.photoNameList=[[NSMutableArray alloc]init];
    self.photoCount=arc4random()%25;//29;//say
    self.maxPhotoNo=photoCount;
    self.isEditEnabled=NO;
    
    
    photoNameList=[[NSMutableArray alloc] initWithCapacity:photoCount];
    
    self.navigationController.navigationBarHidden=YES;
    
    // ===================== To be removed when we get names from the server ===================
    for(int i=1;i<=photoCount;i++)
    {
        [self.photoNameList addObject:[NSString stringWithFormat:@"Photo%d",i]];
    }
    //==========================================================================================
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.backToAlbumBtn.titleLabel.text=[self.pmvc.albumNameList objectAtIndex:self.selectedAlbumNo];
//    NSLog(@"Album Name :: %@",[self.pmvc.albumNameList objectAtIndex:self.selectedAlbumNo]);
    
    self.albName.text=[self.pmvc.albumNameList objectAtIndex:self.selectedAlbumNo];
    
    if(self.isEditEnabled==YES)
    {
        self.editBtn.imageView.image=[UIImage imageNamed:@"Album button.png"];
    }
    else
    {
        self.editBtn.imageView.image=[UIImage imageNamed:@"button.png"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((int)(photoCount/4))+(photoCount%4?1:0);
}

-(void)updateServerData
{
//================================== To be used when connecting with server ================================
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            albumNameList, @"albumNameList",
//                            nil];
//    
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
//                            [NSURL URLWithString:@"http://localhost:8080/"]];
//    
//    [client postPath:@"/mypage.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"Response: %@", text);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }];
//==========================================================================================================
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoListVCTableCell";
    
    
    PhotoListVCTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (PhotoListVCTableCell *)[PhotoListVCTableCell cellFromNibNamed:@"PhotoListVCTableCell"];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoListVCTableCell *scell=(PhotoListVCTableCell *)cell;
    
    scell.selectionStyle=UITableViewCellSelectionStyleNone;

    if(indexPath.row>=((int)(photoCount/4)))
    {
        if(photoCount%4==1)
        {
            scell.btn2.hidden=YES;
            scell.crossBtn2.hidden=YES;
            scell.btn3.hidden=YES;
            scell.crossBtn3.hidden=YES;
            scell.btn4.hidden=YES;
            scell.crossBtn4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn1 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            
            [scell.crossBtn1 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
                        
            scell.btn1.tag=scell.crossBtn1.tag=indexPath.row*4;
            
            if(isEditEnabled==YES)
            {
                scell.crossBtn1.hidden=NO;
            }
            else
            {
                scell.crossBtn1.hidden=YES;
            }
        }
        else if(photoCount%4==2)
        {
            scell.btn3.hidden=YES;
            scell.crossBtn3.hidden=YES;
            scell.btn4.hidden=YES;
            scell.crossBtn4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn2 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            [scell.btn1 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            [scell.btn2 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            
            [scell.crossBtn1 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.crossBtn2 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
                        
            scell.btn1.tag=scell.crossBtn1.tag=indexPath.row*4;
            scell.btn2.tag=scell.crossBtn2.tag=indexPath.row*4+1;
            
            if(isEditEnabled==YES)
            {
                scell.crossBtn1.hidden=NO;
                scell.crossBtn2.hidden=NO;
                
            }
            else
            {
                scell.crossBtn1.hidden=YES;
                scell.crossBtn2.hidden=YES;
                
            }
        }
        else if(photoCount%4==3)
        {
            scell.btn4.hidden=YES;
            scell.crossBtn4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn2 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn3 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            [scell.btn1 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            [scell.btn2 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            [scell.btn3 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
            
            [scell.crossBtn1 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.crossBtn2 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [scell.crossBtn3 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            scell.btn1.tag=scell.crossBtn1.tag=indexPath.row*4;
            scell.btn2.tag=scell.crossBtn2.tag=indexPath.row*4+1;
            scell.btn3.tag=scell.crossBtn3.tag=indexPath.row*4+2;
            
            if(isEditEnabled==YES)
            {
                scell.crossBtn1.hidden=NO;
                scell.crossBtn2.hidden=NO;
                scell.crossBtn3.hidden=NO;
                
            }
            else
            {
                scell.crossBtn1.hidden=YES;
                scell.crossBtn2.hidden=YES;
                scell.crossBtn3.hidden=YES;
                
            }
        }
        
    }
    else
    {
        [scell.btn1 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.btn2 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.btn3 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.btn4 addTarget:self action:@selector(viewPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [scell.crossBtn1 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.crossBtn2 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.crossBtn3 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scell.crossBtn4 addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        scell.btn1.tag=scell.crossBtn1.tag=indexPath.row*3;
        scell.btn2.tag=scell.crossBtn2.tag=indexPath.row*3+1;
        scell.btn3.tag=scell.crossBtn3.tag=indexPath.row*3+2;
        scell.btn4.tag=scell.crossBtn4.tag=indexPath.row*3+3;
        
        if(isEditEnabled==YES)
        {
            scell.crossBtn1.hidden=NO;
            scell.crossBtn2.hidden=NO;
            scell.crossBtn3.hidden=NO;
            scell.crossBtn4.hidden=NO;

        }
        else
        {
            scell.crossBtn1.hidden=YES;
            scell.crossBtn2.hidden=YES;
            scell.crossBtn3.hidden=YES;
            scell.crossBtn4.hidden=YES;

        }
        
        [scell.btn1 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
        [scell.btn2 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
        [scell.btn3 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
        [scell.btn4 setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"Plus button.png"] forState:UIControlStateNormal];
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToAlbum:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPhoto:(id)sender {
    [self.photoNameList addObject:[NSString stringWithFormat:@"Photo%d",maxPhotoNo+1]];
    photoCount++;
    maxPhotoNo++;
    //    [self updateServerData];
    [self.tableVw reloadData];
}

- (IBAction)albumNameTouch:(id)sender {
    [self.tableVw reloadData];
}

-(void)viewPhoto:(UIButton *)sender
{
    PhotoVC *photoVC=[[PhotoVC alloc] initWithNibName:@"PhotoVC" bundle:nil];
    photoVC.pvc=self;
    photoVC.selectedPhotoNo=sender.tag;
    photoVC.photoCount=photoCount;
    [self.navigationController pushViewController:photoVC animated:YES];
}

-(void)deletePhoto:(UIButton *)sender
{
    [self.photoNameList removeObjectAtIndex:sender.tag];
    photoCount--;
    //[self updateServerData];
    [self.tableVw reloadData];
}

//- (void)dealloc {
//    [backToAlbumBtn release];
//    [tableVw release];
//    [albName release];
//    [editBtn release];
//    [addBtn release];
//    [super dealloc];
//}

@end
