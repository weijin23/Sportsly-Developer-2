//
//  PopOverViewController.m
//  Social
//
//  Created by Mindpace on 13/09/13.
//
//

#import "PopOverViewController.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController
@synthesize dataArray,delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	cell.selectionStyle=UITableViewCellSelectionStyleGray;
	cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"team_name"] ;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([delegate respondsToSelector:@selector(didSelectString:::)])
    {
        [delegate didSelectString:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"team_id"]:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"team_name"]:_popOver];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    self.delegate=nil;
}

@end
