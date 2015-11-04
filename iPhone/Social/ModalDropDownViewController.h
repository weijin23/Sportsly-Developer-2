//
//  ModalDropDownViewController.h
//  TestContact
//
//  Created by Sukhamoy on 18/11/13.
//  Copyright (c) 2013 Sukhamoy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^updateSelectedIndex)(int upatedIndex,NSString *name);

@interface ModalDropDownViewController : BaseVC

@property (retain, nonatomic) IBOutlet UITextField *nameText;
@property(nonatomic,retain)NSMutableArray *emailIdArr;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,copy)updateSelectedIndex updateBlock;

@property (retain, nonatomic) IBOutlet UITableView *modalTable;
@property (retain, nonatomic) IBOutlet UIView *middlevw;
@property (retain, nonatomic) IBOutlet UIView *topvw;
@property (strong, nonatomic) IBOutlet UIView *topsecond;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)addCustom:(id)sender;


@end
