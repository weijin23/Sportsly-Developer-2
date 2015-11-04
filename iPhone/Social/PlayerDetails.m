//
//  Playerself.m
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//
#import "CenterViewController.h"
#import "PlayerDetails.h"
#import "PlayerCell.h"
@interface PlayerDetails ()

@end

@implementation PlayerDetails
@synthesize selectedPlayer,dataArray,emailIdList,emailIdRelation,phoneNoList,phoneNoRelation;
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
    
  //  self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;

    self.playerDetailTable.layer.cornerRadius=3.0f;
    self.playerDetailTable.layer.cornerRadius=3.0f;
    
    self.emailIdList=[[[NSMutableArray alloc] init] autorelease];
    self.phoneNoList=[[[NSMutableArray alloc] init] autorelease];
    
    self.emailIdRelation=[[[NSMutableArray alloc] init] autorelease];
    self.phoneNoRelation=[[[NSMutableArray alloc] init] autorelease];
    
    if (self.selectedPlayer>=0) {
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email1"] isEqualToString:@""]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email1"]];
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel1"] isEqualToString:@"Player"]) {
                
                 [self.emailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
               
                [self.emailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel1"]]];
            }
           
            
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
        }
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email2"] isEqualToString:@""]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email2"]];
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel2"] isEqualToString:@"Player"]) {
                
                [self.emailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
                
                [self.emailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel2"]]];
            }

            //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel2"]];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
        }
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email3"] isEqualToString:@""]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email3"]];
            
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel3"] isEqualToString:@"Player"]) {
                
                [self.emailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
                
                [self.emailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel3"]]];
            }

            
            //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel3"]];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
        }
        
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no"] isEqualToString:@""] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no2"] isEqualToString:@"0"] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no3"] integerValue] ==0 ) {
            
            [self.phoneNoList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no"]];
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel1"] isEqualToString:@"Player"]) {
                
                [self.phoneNoRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
                
                [self.phoneNoRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel1"]]];
            }

          //  [self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel1"]];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
            
            
        }
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no2"] isEqualToString:@""] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no3"] isEqualToString:@"0"] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no"] integerValue] ==0) {
            
            [self.phoneNoList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no2"]];
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel2"] isEqualToString:@"Player"]) {
                
                [self.phoneNoRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
                
                [self.phoneNoRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel2"]]];
            }

            //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel2"]];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
            
        }
        
        if (![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no2"] isEqualToString:@""] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no3"] isEqualToString:@"0"] && ![[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no"] integerValue] ==0) {
            
            [self.phoneNoList addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"ph_no3"]];
            
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel3"] isEqualToString:@"Player"]) {
                
                [self.phoneNoRelation addObject:[NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"]]];
            }else{
                
                [self.phoneNoRelation addObject: [NSString stringWithFormat:@"%@ Email",[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel3"]]];
            }

            
            //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel3"]];
            
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
        }
        
        
        if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] count]>0) {
            
            self.isPrimary=1;
               self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email1"] isEqualToString:@""]) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email1"]];
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel1"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel1"]]];
                }
                
                
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            }
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email2"] isEqualToString:@""]) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email2"]];
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel2"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel2"]]];
                }
                
                //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel2"]];
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
            }
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email3"] isEqualToString:@""]) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email3"]];
                
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel3"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel3"]]];
                }
                
                
                //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel3"]];
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
            }
            
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"] integerValue] ==0 ) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"]];
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel1"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel1"]]];
                }
                
                //  [self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel1"]];
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
                
                
            }
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no2"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no2"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"] integerValue] ==0) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no2"]];
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel2"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel2"]]];
                }
                
                //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel2"]];
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
                
            }
            
            if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no3"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no3"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no"] integerValue] ==0) {
                
                [self.primaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"ph_no3"]];
                
                
                if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel3"] isEqualToString:@"Player"]) {
                    
                    [self.primaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"]]];
                }else{
                    
                    [self.primaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel3"]]];
                }
                
                
                //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel3"]];
                
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
            }
            
            if ([[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] count]>1) {
                
                self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email1"] isEqualToString:@""]) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email1"]];
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email_Rel1"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email_Rel1"]]];
                    }
                    
                    
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                }
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email2"] isEqualToString:@""]) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email2"]];
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email_Rel2"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email_Rel2"]]];
                    }
                    
                    //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel2"]];
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                    
                }
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email3"] isEqualToString:@""]) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email3"]];
                    
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Email_Rel3"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Email_Rel3"]]];
                    }
                    
                    
                    //[self.emailIdRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Email_Rel3"]];
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                    
                }
                
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"] integerValue] ==0 ) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"]];
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0]  objectForKey:@"Ph_Rel1"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Ph_Rel1"]]];
                    }
                    
                    //  [self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel1"]];
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                    
                    
                    
                }
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no2"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no2"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"] integerValue] ==0) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no2"]];
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Ph_Rel2"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Ph_Rel2"]]];
                    }
                    
                    //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel2"]];
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                    
                    
                }
                
                if (![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no3"] isEqualToString:@""] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no3"] isEqualToString:@"0"] && ![[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no"] integerValue] ==0) {
                    
                    [self.secondaryEmailIdList addObject:[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"ph_no3"]];
                    
                    
                    if ([[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Ph_Rel3"] isEqualToString:@"Player"]) {
                        
                        [self.secondaryEmailIdRelation addObject:[NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"]]];
                    }else{
                        
                        [self.secondaryEmailIdRelation addObject: [NSString stringWithFormat:@"%@ Email",[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1]  objectForKey:@"Ph_Rel3"]]];
                    }
                    
                    
                    //[self.phoneNoRelation addObject:[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"Ph_Rel3"]];
                    
                    self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
                    
                }

            }
            
            
        }else{
            
            self.isPrimary=0;

        }

        
    }else{
       
        if (![[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_email"] isEqualToString:@""]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_email"]];
            [self.emailIdRelation addObject:@"Admin1 Email"];
            
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
        }
        
        if (![[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_email2"] isEqualToString:@""]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_email2"]];
            [self.emailIdRelation addObject:@"Admin1 Email"];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
        }
        

        if (![[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_phno"] isEqualToString:@""] && ![[[self.appDelegate.JSONDATAarr objectAtIndex:0]  objectForKey:@"creator_phno"] isEqualToString:@"0"] ) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_phno"]];
            [self.emailIdRelation addObject:@"Admin1 Phone"];
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
            
        }
        
        if (![[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_phno2"] isEqualToString:@""] && ![[[self.appDelegate.JSONDATAarr objectAtIndex:0]  objectForKey:@"creator_phno2"] isEqualToString:@"0"]) {
            
            [self.emailIdList addObject:[[self.dataArray objectAtIndex:0]  objectForKey:@"creator_phno2"]];
            [self.emailIdRelation addObject:@"Admin1 Phone"];
            
            self.playerDetailTable.frame=CGRectMake(self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.origin.x, self.playerDetailTable.frame.size.width, self.playerDetailTable.frame.size.height + 35);
            
        }

    }
    
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_playerDetailTable release];
    [super dealloc];
}
- (IBAction)settingsbTapped:(id)sender
{
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerSettings];
}

- (IBAction)sendMail:(id)sender {
    //[self sendMail:nil :self.playerEmail.text];
}

- (IBAction)sendSms:(id)sender {
    
    UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"CALL",@"SMS",nil]autorelease];

    [sheet  showInView:self.view];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableViewDataSorace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.selectedPlayer>=0){
        
        return [[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] count] + 1;

    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.emailIdList.count +  1;
    }else if(section==1){
        return self.primaryEmailIdList.count +  1;
    }else if(section==2){
        return self.secondaryEmailIdList.count +  1;

    }else{
        return 1;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerCell";
    PlayerCell *cell =[self.playerDetailTable dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil){
        
        cell =[PlayerCell playerCell];
        //cell.userName.textColor=[UIColor darkGrayColor];
       // cell.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];

        
    }
    if (indexPath.section==0) {
        
       
        if (indexPath.row==0) {
            cell.titleLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            
            if (self.selectedPlayer>=0) {
                cell.titleLbl.text=[[self.dataArray objectAtIndex:selectedPlayer] valueForKey:@"player_name"];
                cell.relationLbl.text=@"Player Name";
            }else{
                cell.titleLbl.text=[[self.dataArray objectAtIndex:selectedPlayer + 1] valueForKey:@"creator_name"];
                cell.relationLbl.text=@"Admin1 Name";
            }
            
            cell.iconImageView.image=nil;
            
        }else{
            cell.titleLbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
            cell.titleLbl.text=[self.emailIdList objectAtIndex:indexPath.row - 1];
            cell.relationLbl.text=[self.emailIdRelation objectAtIndex:indexPath.row - 1];;
            cell.iconImageView.image=[UIImage imageNamed:@"icon-envelop.png"];;

        }
        
        
    }else if(indexPath.section==1){
        
        if (indexPath.row==0) {
            
           cell.titleLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0]; 
            cell.titleLbl.text=[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:0] valueForKey:@"player_name"];
            cell.relationLbl.text=@"Player Name";

        }else{
            
            cell.titleLbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
            cell.titleLbl.text=[self.primaryEmailIdList objectAtIndex:indexPath.row - 1];
            cell.relationLbl.text=[self.primaryEmailIdRelation objectAtIndex:indexPath.row - 1];
            cell.iconImageView.image=[UIImage imageNamed:@"icon-envelop.png"];;
        }
       

       
    }else{
      
        if (indexPath.row==0) {
            
            cell.titleLbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            cell.titleLbl.text=[[[[self.dataArray objectAtIndex:selectedPlayer]  objectForKey:@"primary_player"] objectAtIndex:1] valueForKey:@"player_name"];
            cell.relationLbl.text=@"Player Name";

        }else{
            cell.titleLbl.font=[UIFont fontWithName:@"Helvetica" size:14.0];
            cell.titleLbl.text=[self.secondaryEmailIdList objectAtIndex:indexPath.row - 1];
            cell.relationLbl.text=[self.secondaryEmailIdRelation objectAtIndex:indexPath.row - 1];
            cell.iconImageView.image=[UIImage imageNamed:@"icon-phone.png"];
            
            
        }
        
    }
    
       
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }else if (indexPath.section==1) {
        
        [self sendMail:nil :[self.emailIdList objectAtIndex:indexPath.row]];
        
    }else{
        
        UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"CALL",@"SMS",nil]autorelease];
        sheet.tag=indexPath.row;
        [sheet  showInView:self.view];
    }
}

#pragma mark - UiactionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([choice isEqualToString:@"CALL"])
    {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ NSString stringWithFormat:@"tel://%@",[self.phoneNoList objectAtIndex:actionSheet.tag]]]];
        
    }else if ([choice isEqualToString:@"SMS"]){
        
        [self sendSMS:[self.phoneNoList objectAtIndex:actionSheet.tag]:nil];
    }
}
@end
