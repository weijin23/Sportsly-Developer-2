//
//  ClubLeagueViewController.h
//  Wall
//
//  Created by Sukhamoy on 04/12/13.
//
//

#import <UIKit/UIKit.h>

@interface ClubLeagueViewController : BaseVC
@property(nonatomic,retain)NSArray *allTeams;
@property (nonatomic,retain) IBOutlet UITableView *tblView;
@property (nonatomic,retain) IBOutlet UILabel *msgLabel;
@property (retain, nonatomic) IBOutlet UIView *headerView;
-(void)updateteamList;

@end
