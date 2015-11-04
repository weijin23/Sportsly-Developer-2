//
//  TeamListCell.h
//  Social
//
//  Created by Animesh@Mindpace on 10/09/13.
//
//

#import <UIKit/UIKit.h>


@interface TeamListCell : BaseTableCell

@property(nonatomic,strong) IBOutlet UIImageView *posted;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *acindviewposted;

@property(nonatomic,strong) IBOutlet UILabel *teamName;
@property(nonatomic,strong) IBOutlet UILabel *sport;
@property(nonatomic,strong) IBOutlet UIButton *delBtn;
@property(nonatomic,strong) IBOutlet UIView *mainBackgroundVw;


@end
