//
//  PhotoMainVCTableCell.m
//  Social
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import "PhotoMainVCTableCell.h"

@implementation PhotoMainVCTableCell

@synthesize btn1,btn2,btn3,btn4,lbl1,lbl2,lbl3,crossBtn1,crossBtn2,crossBtn3,txt1,txt2,txt3,imgFrm1,imgFrm2,imgFrm3,imgFrm4,pmvc,vw1,vw2,vw3,vw4,editBtn1,editBtn2,editBtn3,editBtn4,upvw1,upvw2,upvw3,upvw4,playimage4,playimage3,playimage2,playimage1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.pmvc=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
}







//- (void)dealloc
//{
//    self.pmvc=nil;
//    self.btn1=nil;
//    self.btn2=nil;
//    self.btn3=nil;
//    self.btn4=nil;
//    self.lbl1=nil;
//    self.lbl2=nil;
//    self.lbl3=nil;
//    self.crossBtn1=nil;
//    self.crossBtn2=nil;
//    self.crossBtn3=nil;
//    self.txt1=nil;
//     self.txt2=nil;
//     self.txt3=nil;
//    self.imgFrm1=nil;
//  self.imgFrm2=nil;
//      self.imgFrm3=nil;
//      self.imgFrm4=nil;
//    self.vw1=nil;
//      self.vw2=nil;
//      self.vw3=nil;
//      self.vw4=nil;
//    self.upvw1=nil;
//    self.upvw2=nil;
//    self.upvw3=nil;
//      self.upvw4=nil;
//    self.editBtn1=nil;
//   self.editBtn2=nil;
//     self.editBtn3=nil;
//      self.editBtn4=nil;
//    [super dealloc];
//}




@end
