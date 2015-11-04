//
//  ClubLeagueCell.h
//  Wall
//
//  Created by Sukhamoy on 04/12/13.
//
//

#import <UIKit/UIKit.h>

@interface ClubLeagueCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *teamName;
@property (retain, nonatomic) IBOutlet UILabel *clubName;
@property (retain, nonatomic) IBOutlet UILabel *leagugeName;
@property (retain, nonatomic) IBOutlet UIButton *leagugeBtn;
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UIButton *clubBtn;
+(id)customCell;

@end
