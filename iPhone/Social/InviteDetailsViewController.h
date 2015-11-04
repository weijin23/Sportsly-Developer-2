//
//  InviteDetailsViewController.h
//  Wall
//
//  Created by Mindpace on 26/09/13.
//
//
#import "Invite.h"
#import "BaseVC.h"

@interface InviteDetailsViewController : BaseVC



- (IBAction)backf:(id)sender;


- (IBAction)bTapped:(id)sender;

@property (strong, nonatomic) Invite *newinvite;
@property (strong, nonatomic) IBOutlet UITextView *textVw;


@end
