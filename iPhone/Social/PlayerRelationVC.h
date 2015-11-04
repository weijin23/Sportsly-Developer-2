//
//  PlayerRelationVC.h
//  Wall
//
//  Created by Mindpace on 13/12/13.
//
//



@interface PlayerRelationVC : BaseVC
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *relationlab;



-(CGSize)setData:(NSString*)name :(NSString*)relation :(int)isSelf;
@end
