//
//  MyContactViewController.h
//  Wall
//
//  Created by Sukhamoy on 09/12/13.
//
//

#import <UIKit/UIKit.h>

@interface MyContactViewController : BaseVC
@property (retain, nonatomic) IBOutlet UITableView *myContactTable;
-(void)reloadData;

@end
