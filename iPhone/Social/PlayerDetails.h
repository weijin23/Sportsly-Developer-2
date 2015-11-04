//
//  PlayerDetails.h
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//

#import <UIKit/UIKit.h>

@interface PlayerDetails : BaseVC<UIActionSheetDelegate>


@property (retain, nonatomic) IBOutlet UITableView *playerDetailTable;

@property(retain,nonatomic) NSArray *dataArray;
@property(nonatomic,retain)NSMutableArray *emailIdList;
@property(nonatomic,retain)NSMutableArray *phoneNoList;
@property(nonatomic,retain)NSMutableArray *emailIdRelation;
@property(nonatomic,retain)NSMutableArray *phoneNoRelation;

@property(nonatomic,retain)NSMutableArray *primaryEmailIdList;
@property(nonatomic,retain) NSMutableArray *primaryPhoneNoList;
@property(nonatomic,retain)NSMutableArray *primaryPhoneNoRelation;
@property(nonatomic,retain)NSMutableArray *primaryEmailIdRelation;

@property(nonatomic,retain)NSMutableArray *secondaryEmailIdList;
@property(nonatomic,retain) NSMutableArray *secondaryPhoneNoList;
@property(nonatomic,retain)NSMutableArray *secondaryPhoneNoRelation;
@property(nonatomic,retain)NSMutableArray *secondaryEmailIdRelation;

@property(nonatomic,assign) int isPrimary;
@property(nonatomic,assign) int selectedPlayer;
- (IBAction)sendMail:(id)sender;
- (IBAction)sendSms:(id)sender;

- (IBAction)back:(id)sender;
@end
