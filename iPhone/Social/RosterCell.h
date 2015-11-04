//
//  RosterCell.h
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface RosterCell : BaseTableCell
@property(nonatomic,retain) IBOutlet UILabel* detailslabTime;
@property(nonatomic,retain) IBOutlet UILabel* detailslabField;
@property(nonatomic,retain) IBOutlet UILabel* detailslabName;
@property(nonatomic,retain) IBOutlet UIImageView *leftimav;

@property (retain, nonatomic) IBOutlet UIView *backgroundStatusView;
@property (retain, nonatomic) IBOutlet UIButton *rosterBtn;
@property (retain, nonatomic) IBOutlet UIImageView *rosterImageView;

@end
