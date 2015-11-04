//
//  EventCell.h
//  Social
//
//  Created by Sukhamoy Hazra on 26/08/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface EventCell :BaseTableCell
@property(nonatomic,strong) IBOutlet UILabel* detailslabTime;
@property(nonatomic,strong) IBOutlet UILabel* detailslabField;
@property(nonatomic,strong) IBOutlet UILabel* detailslabName;
@property(nonatomic,strong) IBOutlet UILabel* detailslabTeamName;
@property(nonatomic,strong) IBOutlet UILabel* detailslabEventName;
@property(nonatomic,strong) IBOutlet UIImageView *leftimav;
@property(nonatomic,strong) IBOutlet UIButton *rosterbt;
@property(nonatomic,strong) IBOutlet UIImageView *rosterIma;
@property (strong, nonatomic) IBOutlet UIView *backgroundStatusView;
@property (strong, nonatomic) IBOutlet UIView *separator;

@end
