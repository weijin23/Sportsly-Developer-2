//
//  MyContactViewController.m
//  Wall
//
//  Created by Sukhamoy on 09/12/13.
//
//

#import "MyContactViewController.h"
#import "TeamListCell.h"
#import "TeamPlayerViewController.h"
@interface MyContactViewController ()

@end

@implementation MyContactViewController

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

    self.myContactTable.separatorColor=[UIColor lightGrayColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_myContactTable release];
    [super dealloc];
}
-(void)reloadData{
    
    [self.myContactTable reloadData];
    
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%i",[self.appDelegate.JSONDATAarr count]);
    return [self.appDelegate.JSONDATAarr count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isiPad) {
        return 60;
    }
    return 38;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeamListCell";
    
    TeamListCell *cell = [self.myContactTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (TeamListCell *)[TeamListCell cellFromNibNamed:@"TeamListCell"];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TeamListCell *cell1=(TeamListCell*)cell;
    
         
        cell1.teamName.textColor=[UIColor darkGrayColor];
        //cell1.teamName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
        cell1.teamName.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_name"];
        cell1.sport.text=[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_sport"];
        
        if( ![[[self.appDelegate.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"] isEqualToString:@""])
        {
            ImageInfo * info1 = [self.appDelegate.JSONDATAImages objectAtIndex:indexPath.row];
            
            if(info1.image)
            {
                [cell1.posted setImage:info1.image   ];
                cell1.posted.hidden=NO;
                cell1.acindviewposted.hidden=YES;
                [cell1.acindviewposted stopAnimating];
                
            }
            else
            {
                cell1.acindviewposted.hidden=NO;
                cell1.posted.hidden=YES;
                [cell1.acindviewposted startAnimating];
                info1.notificationName=TEAMLISTINGIMAGELOADEDADDAFRIEND;
                info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
                
                if(!info1.isProcessing)
                [info1 getImage];
            }
            
            
        }
        else
        {
            cell1.posted.hidden=NO;
            cell1.acindviewposted.hidden=YES;
            [cell1.acindviewposted stopAnimating];
            cell1.posted.image=[UIImage imageNamed:@"no_image.png"];
            
        }
        
    
        
    [cell1.mainBackgroundVw.layer setCornerRadius:4.0f];
    [cell1.mainBackgroundVw.layer setMasksToBounds:YES];
    
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamPlayerViewController *teamPlayer=[[TeamPlayerViewController alloc] initWithNibName:@"TeamPlayerViewController" bundle:nil];
  //  teamPlayer.selectedTeamIndex=indexPath.row;
    [self.navigationController pushViewController:teamPlayer animated:YES];
    [teamPlayer release];
    
       
    
}

@end
