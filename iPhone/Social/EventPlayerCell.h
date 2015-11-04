//
//  EventPlayerCell.h
//  Wall
//
//  Created by Mindpace on 27/11/13.
//
//

#import "BaseTableCell.h"

@interface EventPlayerCell : BaseTableCell
@property(nonatomic,strong) IBOutlet UIView *mainbackground;
@property(nonatomic,strong) IBOutlet UILabel *userName;
@property(nonatomic,strong) IBOutlet UILabel *statusNameLab;
@property(nonatomic,strong) IBOutlet UIImageView *imastatus_firstvw;
@property(nonatomic,strong) IBOutlet UIImageView *profileimavw;
@end
