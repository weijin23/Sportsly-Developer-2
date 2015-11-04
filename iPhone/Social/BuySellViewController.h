//
//  BuySellViewController.h
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import <UIKit/UIKit.h>

@interface BuySellViewController : BaseVC

@property (retain, nonatomic) IBOutlet UITableView *itemTable;
@property(nonatomic,retain)NSArray * AllItems;
@property(nonatomic,retain)NSArray *AllItemsArr;
@property (nonatomic,retain) NSMutableArray *itemNameList;

- (IBAction)addSportItem:(id)sender;

@end
