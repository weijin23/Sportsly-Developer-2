//
//  TeamUpdateCreateVC.m
//  Wall
//
//  Created by Mindpace on 18/11/13.
//
//
#import "HomeVC.h"
#import "TeamUpdateCreateVC.h"
#import "CenterViewController.h"
@interface TeamUpdateCreateVC ()

@end

@implementation TeamUpdateCreateVC
@synthesize defaultText,isEditMode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    
    
    
    [self disableSlidingAndHideTopBar];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self enableSlidingAndShowTopBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.topview.backgroundColor=appDelegate.barGrayColor;
 //   self.keyboardTopbarvw.backgroundColor=appDelegate.backgroundPinkColor;
    
   
    
    if([self.updateTextVw.text isEqualToString:GOTEAM])
    {
        if(isEditMode)
        self.updateTextVw.text=@"";
     
    }
    else
        self.updateTextVw.text=self.defaultText;
    
    if(!isEditMode)
    {
        if([self.updateTextVw.text isEqualToString:@""])
        {
            self.updateTextVw.text=GOTEAM;
        }
    }
    
    NSString *str=[[NSString alloc] initWithFormat:@"(%i chracters remaining)",(TOTALCHARACTERS-[[self.updateTextVw text] length])];
    self.smsnumbertextl.text=str;
    
    
    if(!isEditMode)
    {
        self.keyboardTopbarvw.hidden=YES;
        self.updateTextVw.editable=NO;
        self.donebt.hidden=YES;
        
        self.backredlab.hidden=YES;
        
    }
    else
    {
     [self.updateTextVw becomeFirstResponder];
        self.backred.hidden=YES;
    
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
        if([text isEqualToString:@""])
        {
            if([textView.text length]==0)
                return NO;
            
            NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length-1)), @"characters remaining"];
            self.smsnumbertextl.text= str;
            return YES;
        }
        
        
        if([textView.text length]>=TOTALCHARACTERS)
            return NO;
        
        
        NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length+text.length)), @"characters remaining"];
        self.smsnumbertextl.text= str;
    
    
    return YES;
}

- (void)viewDidUnload
{
    [self setUpdateTextVw:nil];
    [self setCancelbt:nil];
    [self setDonebt:nil];
    [self setSmsnumbertextl:nil];
    [self setKeyboardTopbarvw:nil];
    [self setBackred:nil];
    [self setBackredlab:nil];
    [super viewDidUnload];
}
- (IBAction)bTapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(tag==2)
    {
        
        if(self.updateTextVw.text)
        {
            /*if(( [self.updateTextVw.text isEqualToString:@""]))
            {
                [self showAlertMessage:@"Team Status update field can't be left blank."];
               // self.updateTextVw.text=self.defaultText;
            }
            else
            {*/
                NSString *postText=self.updateTextVw.text;
                
                @autoreleasepool {
                    postText=[postText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
                }
                
                
                [self postUpdate:postText];
            //}
        }

        
    }
    
}


-(void)postUpdate:(NSString*)text
{
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:text forKey:@"status_update"];
    
    [command setObject:[appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:appDelegate.centerVC. lastSelectedTeam] forKey:@"team_id"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    [appDelegate sendRequestFor:UPDATEPOST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
}




-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:UPDATEPOST])
        {
//            self.updatetextvw.text=[self textForUpdateField:[appDelegate.centerVC.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
//            
//            self.updatetextvw.enabled=NO;
//            self.smsnumbertextl.hidden=YES;
            
        }
        
        
        return;
    }
    ConnectionManager *aR=(ConnectionManager*)aData1;
    NSString *str=(NSString*)aData;
    @autoreleasepool {
        if([aR.requestSingleId isEqualToString:UPDATEPOST ])
        {
            
            
            
            NSLog(@"Data=%@",str);
            
            
            
            if (str)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:str];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    // aDict=[aDict objectForKey:@"responseData"];
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        appDelegate.centerVC.updatetextvw.text=self.updateTextVw.text;
                        
                        [appDelegate.centerVC.dataArrayUpTexts replaceObjectAtIndex:appDelegate.centerVC. lastSelectedTeam withObject:appDelegate.centerVC.updatetextvw.text];
                        [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
                        //   [self showHudAlert:[aDict objectForKey:@"message"]];
                        //  [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                       appDelegate.centerVC.updatetextvw.editable=NO;
//                        self.smsnumbertextl.hidden=YES;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
//                        self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
//                        self.updatetextvw.enabled=NO;
//                        self.smsnumbertextl.hidden=YES;
                        
                    }
                }
            }
            
        }
        
    }
    
    
    
    
    
}





@end
