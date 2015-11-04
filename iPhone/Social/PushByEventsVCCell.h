//
//  TeamListCell.h
//  Social
//
//  Created by Animesh@Mindpace on 10/09/13.
//
//

#import <UIKit/UIKit.h>


@interface PushByEventsVCCell : BaseTableCell

@property(nonatomic,strong) IBOutlet UIImageView *posted;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *acindviewposted;
@property(nonatomic,strong) IBOutlet UIImageView *dotimavw;

@property(nonatomic,strong) IBOutlet UIImageView *imageViewTime;
@property(nonatomic,strong) IBOutlet UILabel *statusLabel;
@property(nonatomic,strong) IBOutlet UILabel *teamName;
@property(nonatomic,strong) IBOutlet UILabel *senderName;
@property(nonatomic,strong) IBOutlet UIButton *acceptBtn;
@property(nonatomic,strong) IBOutlet UIView *mainBackgroundVw;
@property(nonatomic,strong) IBOutlet UIButton *declineBtn;
@property(nonatomic,strong) IBOutlet UIView *separator;
@end
