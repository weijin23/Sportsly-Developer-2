//
//  CustomcellCell.h
//  TestContact
//
//  Created by Sukhamoy on 18/11/13.
//  Copyright (c) 2013 Sukhamoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomcellCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *deletBtn;
@property (retain, nonatomic) IBOutlet UIButton *dropDownlist;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIButton *delBtn;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;

+(id)customCell;
@end
