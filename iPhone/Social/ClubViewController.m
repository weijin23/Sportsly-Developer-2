//
//  ClubViewController.m
//  Wall
//
//  Created by Sukhamoy on 26/11/13.
//
//

#import "ClubViewController.h"

@interface ClubViewController ()

@end

@implementation ClubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
   
   // [self setStatusBarStyleOwnApp:0];

    if (self.selectedtag==4) {
        
        self.titleLbl.text=@"Add Leaguge";
        self.customTxt.placeholder=@"Enter custom leaguge name HERE";
        
    }else if (self.selectedtag==5){
        
        self.titleLbl.text=@"Add Club";
        self.customTxt.placeholder=@"Enter custom club name HERE";

    }

  
    
    [self getList];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setStatusBarStyleOwnApp:0];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_dropDwonTable release];
    [_customTxt release];
    [_titleLbl release];
    [_customView release];
    [super dealloc];
}


-(void)getList{
    
    [self showNativeHudView];
    
      if (self.selectedtag==4){
           [self showHudView:@"Loading league names..."];
      }else{
           [self showHudView:@"Loading club names..."];
      }
    
    NSURL* url = [NSURL URLWithString:CLUB_LEAGUE_LIST];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc ] initWithURL:url];
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
    [aRequest release];

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
    [self hideHudView];

    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    if(str)
        
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
        [parser release];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            
                
            if (self.selectedtag==4){
                
                if ([[[[res valueForKey:@"club"] valueForKey:@"status"] objectAtIndex:0] integerValue]==1) {
  
                    NSDictionary* aDict = [res valueForKey:@"league"];
                    self.tableDataSorce=[[[aDict valueForKey:@"response"] valueForKey:@"league_list"] objectAtIndex:0];
 
                    }
                 
                }else{
                    
                    NSLog(@"status %@",[[res valueForKey:@"club"] valueForKey:@"status"]);
                    
                    if ([[[[res valueForKey:@"club"] valueForKey:@"status"] objectAtIndex:0] integerValue]==1) {
                         NSDictionary* aDict = [res valueForKey:@"club"];
                        self.tableDataSorce=[[[aDict valueForKey:@"response"] valueForKey:@"club_list"] objectAtIndex:0];
                    }
                    
                }
                
                NSLog(@"data sourace %@",self.tableDataSorce);
                
                [self.dropDwonTable reloadData];
            }
           

        
            
              
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    // [self hideHudView];
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    
}


- (IBAction)cancel:(id)sender {
    
    [self.customTxt resignFirstResponder];
    [self  dismissViewControllerAnimated:YES completion:nil];
   

}

- (IBAction)done:(id)sender {
    
    [_customTxt resignFirstResponder];
    
    if (_customTxt.text.length>0) {
      
        [UIView animateWithDuration:0.3
                         animations:^{
                             CGRect frame = self.animatedView.frame;
                             
                             if(self.isiPhone5)
                                 frame.origin.y=+170;
                             else
                                 frame.origin.y=+200;
                             
                             self.animatedView.frame=frame;
                         }
                         completion:^(BOOL finished){
                         }];
        
        int flag=0;
        
        for (int i=0; i<self.tableDataSorce.count; i++) {
            
            if (self.selectedtag==4) {
                
                if ([_customTxt.text isEqualToString: [[self.tableDataSorce objectAtIndex:i] valueForKey:@"league_name"]]) {
                    
                    flag=1;
                    break;
                }
                
                
            }else{
                
                if ([_customTxt.text isEqualToString: [[self.tableDataSorce objectAtIndex:i] valueForKey:@"club_name"]]) {
                    
                    flag=1;
                    break;

                }
                
            }
        }
        
        
    if (!flag) {
            
            if (self.selectedtag==4) {
                
                self.leaguge(_customTxt.text,@"",@"");
                
            }else{
                
                self.leaguge(_customTxt.text,@"",@"");
                
            }
      
        
    }else{
          self.animatedView.frame=CGRectMake(self.animatedView.frame.origin.x, self.topview.frame.size.height + 5, self.animatedView.frame.size.width, self.animatedView.frame.size.height);
        return;
    }
    
    [self  dismissViewControllerAnimated:YES completion:nil];
        
    }

}

- (IBAction)addCustom:(id)sender {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = self.view.frame;
                         frame.origin.y=-150;
                         self.view.frame=frame;
                     }
                     completion:^(BOOL finished){
                     }];

    self.dropDwonTable.frame=CGRectMake(self.dropDwonTable.frame.origin.x, self.dropDwonTable.frame.origin.y, self.dropDwonTable.frame.size.width, self.dropDwonTable.frame.size.height -60);
    [self.customTxt becomeFirstResponder];
    
}

#pragma mark - TableViewDataSorace
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableDataSorce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSLog(@"%@",[self.tableDataSorce objectAtIndex:indexPath.row]);
    if(self.isiPad)
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Regular" size:16.0];
    else
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    
    if (self.selectedtag==4) {
        
        cell.textLabel.text=[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"league_name"];

    }else{
        cell.textLabel.text=[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"club_name"];

    }
    return cell;
}
#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedtag==4) {

    self.leaguge([[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"league_name"],[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"league_url"],[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"league_id"]);
        
    }else{
        
    self.leaguge([[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"club_name"],[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"club_url"],[[self.tableDataSorce objectAtIndex:indexPath.row] valueForKey:@"club_id"]);
 
    }
    [self dismissViewControllerAnimated:YES completion:nil];
      
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = self.animatedView.frame;
                         
                         if(self.isiPhone5)
                             frame.origin.y=-170;
                         else
                             frame.origin.y=-200;
                         self.animatedView.frame=frame;
                     }
                     completion:^(BOOL finished){
                     }];

    
 }
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
       
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length==0) {
        return NO;
    }
    [textField resignFirstResponder];

    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = self.animatedView.frame;
                         
                         if(self.isiPhone5)
                             frame.origin.y=+170;
                         else
                             frame.origin.y=+200;
                         
                         self.animatedView.frame=frame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    int flag=0;
    
        
    for (int i=0; i<self.tableDataSorce.count; i++) {
        
        NSLog(@"Text:%@",textField.text);
        
        if (self.selectedtag==4) {
            
            if ([textField.text isEqualToString: [NSString stringWithFormat:@"%@",[[self.tableDataSorce objectAtIndex:i] valueForKey:@"league_name"]]]) {
                flag=1;
                break;
            }
          
            
        }else{
            
            if ([textField.text isEqualToString: [NSString stringWithFormat:@"%@",[[self.tableDataSorce objectAtIndex:i] valueForKey:@"club_name"]]]) {
                flag=1;
                break;
            }
            
        }
    }
    
    if (!flag) {
        
        if (self.selectedtag==4) {
            
            self.leaguge(textField.text,@"",@"");
            
        }else{
            
            self.leaguge(textField.text,@"",@"");
            
        }

    }else{
        
        self.animatedView.frame=CGRectMake(self.animatedView.frame.origin.x, self.topview.frame.size.height + 5, self.animatedView.frame.size.width, self.animatedView.frame.size.height);
        return NO;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
   
    return YES;
}


@end
