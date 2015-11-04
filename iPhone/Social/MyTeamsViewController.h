//
//  MyTeamsViewController.h
//  Wall
//
//  Created by User on 11/06/15.
//
//

#import "BaseVC.h"

@interface MyTeamsViewController : BaseVC<UISearchBarDelegate,UISearchControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableTeam;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBarTeam;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;
@property (strong, nonatomic) IBOutlet UIView *noTeamView;


@property int notiCount;
@property int rowCount;

- (IBAction)addTeams:(id)sender;
-(void)loadMyTeamData;
@end
