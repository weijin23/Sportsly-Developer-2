//
//  EventCell.h
//  Social
//
//  Created by Sukhamoy Hazra on 26/08/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface EventPushCell :BaseTableCell
@property(nonatomic,strong) IBOutlet UILabel* detailslabTime;
@property(nonatomic,strong) IBOutlet UILabel* detailslabField;
@property(nonatomic,strong) IBOutlet UILabel* detailslabName;
@property(nonatomic,strong) IBOutlet UIImageView *leftimav;

@property (strong, nonatomic) IBOutlet UIView *backgroundStatusView;


@end
