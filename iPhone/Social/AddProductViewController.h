//
//  AddProductViewController.h
//  Wall
//
//  Created by Sukhamoy on 27/12/13.
//
//

#import <UIKit/UIKit.h>

@interface AddProductViewController : BaseVC
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)NSDictionary *itemDict;
@property (retain, nonatomic) IBOutlet UIView *addItemView;
@property (retain, nonatomic) IBOutlet UIButton *viwerBtn;
@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property (retain, nonatomic) IBOutlet UITextField *priceTxt;
@property (retain, nonatomic) IBOutlet UITextField *viewerTxt;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;
@property (retain, nonatomic) IBOutlet UIButton *doneBtn;
@property(nonatomic,assign) BOOL isCreated;
@property(nonatomic,retain) NSMutableArray *viewerArr;
@property(nonatomic,assign) int isSelectedImage;
- (IBAction)uploadImage:(id)sender;
- (IBAction)viewerOption:(id)sender;
- (IBAction)deleteItem:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)done:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;

@end
