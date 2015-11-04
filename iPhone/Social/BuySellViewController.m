//
//  BuySellViewController.m
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import "BuySellViewController.h"
#import "AddProductViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BuySellCell.h"

@interface BuySellViewController ()

@end

@implementation BuySellViewController

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
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self updateServerData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_itemTable release];
    [super dealloc];
}


-(void)updateServerData
{
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc] init];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:@"1000" forKey:@"limit"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    [writer release];
    [command release];
    [self sendRequestForPhotoAlbums:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
}


-(void)sendRequestForPhotoAlbums:(NSDictionary*)dic
{
    [self showNativeHudView];

     NSURL *url= [NSURL URLWithString:SPORTITEMLIST];
  
    
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
            
            [parser release];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                NSLog(@"dict %@",aDict);
                
                if([[NSString stringWithFormat:@"%@",[aDict objectForKey:@"status"] ] isEqualToString:@"1"])
                {
                    
                    
                    aDict=[aDict objectForKey:@"response"];
                    
                        self.AllItems=[aDict objectForKey:@"sport_items_list"];
                        self.AllItemsArr=self.AllItems;
                        NSLog(@"alll Post Photos %@",self.AllItems);
                        NSMutableArray *s=[[NSMutableArray alloc] init];
                        self.itemNameList=s;
                        [s release];
                        
                       
                        
                        for (NSDictionary *d in  self.AllItems)
                        {
                            NSString *image=  [d objectForKey:@"item_image"];
                            
                            if(![image isEqualToString:@""])
                            {
                                NSString *str=[[NSString alloc] initWithFormat:@"%@%@",ITEMIMAGELINK,image];
                                [self.itemNameList addObject:str];
                                [str release];
                            }
                    
                        }
                    
                    NSLog(@"itemlist %@",self.itemNameList);
                    [self.itemTable reloadData];
        
                }
                else
                {
                  //  [self showAlertMessage:[[aDict objectForKey:@"status"] objectForKey:@"message"]  title:@"Error"];
                }
            }
        }
        
        
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	[self showAlertMessage:CONNFAILMSG];
	
}


- (IBAction)addSportItem:(id)sender {
    
    AddProductViewController *addproduct=[[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    addproduct.isCreated=YES;
    [self.navigationController pushViewController:addproduct animated:YES];
    [addproduct release];
}



#pragma mark - ViewPostItem
-(void)viewAllItems:(UIButton *)sender{
    
//    PhotoMainVCTableCell *photoCell=(PhotoMainVCTableCell*)[[sender superview] superview];
//    NSIndexPath *selectedIndexPath=[self.itemTable indexPathForCell:photoCell];
//    
//    AddProductViewController *addproduct=[[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
//    addproduct.isCreated=NO;
//    addproduct.itemDict=[self.AllItemsArr objectAtIndex:selectedIndexPath.row + sender.tag];
//    [self.navigationController pushViewController:addproduct animated:YES];
//    [addproduct release];
  
}

#pragma mark - TableViewDelegate && DataSourace

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return self.AllItems.count;
        
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BuySellCell";
    
    BuySellCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (BuySellCell *)[BuySellCell buyCell];
        cell.backView.layer.cornerRadius=3.0f;
        [cell.backView.layer setMasksToBounds:YES];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row=%i-Cell=%@",indexPath.row,cell);
    
    @autoreleasepool {
        
        BuySellCell *scell=(BuySellCell *)cell;
        
        scell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        scell.itemNameLbl.text=[[self.AllItems objectAtIndex:indexPath.row] valueForKey:@"item_name"];
        scell.priceLbl.text=[NSString stringWithFormat:@"$%@",[[self.AllItems objectAtIndex:indexPath.row] valueForKey:@"item_price"]];
        [scell.itemImageView setImageWithURL:[NSURL URLWithString:[self.itemNameList objectAtIndex:indexPath.row]] placeholderImage:self.itemdefaultImage];
                           
        }
               
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddProductViewController *addproduct=[[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    addproduct.isCreated=NO;
    addproduct.itemDict=[self.AllItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:addproduct animated:YES];
    [addproduct release];


}


@end
