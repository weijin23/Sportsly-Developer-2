//
//  AddProductViewController.m
//  Wall
//
//  Created by Sukhamoy on 27/12/13.
//
//

#import "AddProductViewController.h"
#import "SportViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UITextField+smb_utils.h"
@interface AddProductViewController ()

@end

@implementation AddProductViewController

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
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.isSelectedImage=0;
    self.productImage.image=self.itemdefaultImage;
    self.viewerArr=[[NSMutableArray alloc] initWithObjects:@"Wall",@"Zip Code",@"Club",@"League",@"Everyone",nil];
    self.addItemView.layer.cornerRadius=3.0f;
    [self.addItemView.layer setMasksToBounds:YES];
    if (!self.isCreated) {
        
        self.titleLbl.text=@"Item Details";
        self.deleteBtn.hidden=YES;
        self.nameTxt.text=[self.itemDict valueForKey:@"item_name"];
        self.priceTxt.text=[NSString stringWithFormat:@"$%@",[self.itemDict valueForKey:@"item_price"]];
        self.viewerTxt.text=[self.itemDict valueForKey:@"item_viewer"];
        [self.productImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ITEMIMAGELINK,[self.itemDict objectForKey:@"item_image"]]] placeholderImage:self.photoImage];
        
        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.itemDict valueForKey:@"UserID"]]) {
            
            [self.doneBtn setTitle:@"Edit" forState:UIControlStateNormal];
            self.doneBtn.hidden=NO;
            self.addItemView.userInteractionEnabled=NO;


            
        }else{
            
            self.doneBtn.hidden=YES;
            self.addItemView.userInteractionEnabled=NO;
        }
        
    }else{
        self.deleteBtn.hidden=YES;
        self.titleLbl.text=@"Add Item";
        self.doneBtn.hidden=NO;
        self.addItemView.userInteractionEnabled=YES;
    }
       [self.priceTxt addTarget:self action:@selector(textchangeValue:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nameTxt release];
    [_priceTxt release];
    [_viewerTxt release];
    [_productImage release];
    [_viwerBtn release];
    [_addItemView release];
    [_doneBtn release];
    [_titleLbl release];
    [_deleteBtn release];
    [super dealloc];
}
- (IBAction)uploadImage:(id)sender {
    [self takeImage];

}

- (IBAction)viewerOption:(id)sender {
    
    SportViewController *sport=[[SportViewController alloc] initWithNibName:@"SportViewController" bundle:nil];
    [sport setSportBlock:^(NSString *sportName){
      
        if ([sportName isEqualToString:@"Zip Code"]) {
            
            [self.viewerTxt becomeFirstResponder];
            self.viwerBtn.hidden=YES;
            
          
            
        }else{
            self.viewerTxt.text=sportName;
            self.viwerBtn.hidden=NO;

        }
        
    }];
    sport.sportArr=self.viewerArr;
    [self presentViewController:sport animated:YES completion:nil];

}

- (IBAction)deleteItem:(id)sender {
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.itemDict valueForKey:@"item_id"] forKey:@"item_id"];

    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:DELETESPORTITEM];
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:jsonCommand forKey:@"requestParam"];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];


}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UploadVideo To Server

- (IBAction)done:(UIButton*)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
        
        [self.doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        self.deleteBtn.hidden=NO;
        self.addItemView.userInteractionEnabled=YES;

        
    }else{
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        
        if (self.isCreated) {
            
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            
        }else{
            
              [command setObject:[self.itemDict valueForKey:@"item_id"] forKey:@"item_id"];
            
        }
        
        
        NSString *tmp=[[self.nameTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Item Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }
        
        
        NSString *str =[self.priceTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *trimingStr=[str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"$"]];
        
        if (!trimingStr || [trimingStr length] <=0 ) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Item Price" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
            
        }

        NSString *tmp1=[[self.priceTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp1  isEqualToString:@""] )
        {
                   }
        
        NSString *tmp2=[[self.viewerTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp2  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Tag by" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }
        [command setObject:self.nameTxt.text forKey:@"item_name"];
        [command setObject:trimingStr forKey:@"item_price"];
        [command setObject:self.viewerTxt.text forKey:@"item_viewer"];
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.productImage.image,0.1),@"item_image",nil]];
        
    }
    
}


-(void)sendRequestForPost:(NSDictionary*)dic
{
    
    NSLog(@"dictiony %@",[dic allKeys]);
    NSURL* url=nil;
    if (self.isCreated) {
        
        url = [NSURL URLWithString:ADDSPORTITEMLINK];
        
    }else{
        
        url = [NSURL URLWithString:EDITSPORTITEM];
        
    }
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    
    if([[dic allKeys] count]>1)
    {
        
        [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:1]] forKey:[[dic allKeys] objectAtIndex:1]];
        
        [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
        [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
        
        [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] withFileName:@"product.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:0]];
        
    }
    else
    {
        
        [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] forKey:[[dic allKeys] objectAtIndex:0]];
        
    }
    
    
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    // [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    
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
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    [self hideHudView];
	[self showAlertMessage:CONNFAILMSG];
	
}



#pragma mark - ImagePickerdelegate

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
       self.isSelectedImage=1;
    
    
    if([info objectForKey:UIImagePickerControllerEditedImage])
        self.productImage.image=[info objectForKey:UIImagePickerControllerEditedImage];
    else
        self.productImage.image=[info objectForKey:UIImagePickerControllerOriginalImage];
   
    
    
    [self dismissModal];
    
    
    [appDelegate setHomeView];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker1
{
   
    [super imagePickerControllerDidCancel:picker1];
    [appDelegate setHomeView];
}

#pragma mark - Insert$Function

- (void)textchangeValue:(UITextField*)textField {
    
    if ([textField.text length]>0  && [textField.text characterAtIndex:0]!='$') {
        [textField insertText:@"$" atIndex:0];
    }
    
}


#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==self.viewerTxt) {
        self.viwerBtn.hidden=NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
