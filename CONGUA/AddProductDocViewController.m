//
//  AddProductDocViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 16/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AddProductDocViewController.h"

@interface AddProductDocViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@end

@implementation AddProductDocViewController
@synthesize mainscroll,lblDesc,lblDocType,txtDocName,txtvwDescription,btnDocType,DocImage,btnsubmit,btnAddDoc,btnPurchaseReceipt,btnOther,btnInsuranceCertificate,DocView,PopDelegate,btnCamera,btnPhotoLib,SegmentedControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
    NSLog(@"product code=%@",ProductCode);
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtDocName.leftView = paddingView;
    txtDocName.leftViewMode = UITextFieldViewModeAlways;
    
    ArrDocType=[[NSMutableArray alloc]initWithObjects:@"Purchase Receipt",@"Insurance Certificate",@"Others",nil];
    /*
    txtDocName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Document Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblDesc.textColor=[UIColor grayColor];
    lblDocType.textColor=[UIColor grayColor];
     */
    
    btnInsuranceCertificate.selected=YES;
    DocType1=@"2";
    btnInsuranceCertificate.backgroundColor=[UIColor colorWithRed:(202.0f/255.0) green:(202.0f/255.0) blue:(202.0f/255.0) alpha:1];
    btnInsuranceCertificate.layer.cornerRadius=15.0f;
    btnPurchaseReceipt.layer.cornerRadius=15.0f;
    btnOther.layer.cornerRadius=15.0f;
    
    [[btnInsuranceCertificate layer] setBorderWidth:0.5f];
    [btnInsuranceCertificate.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
    [btnPurchaseReceipt.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    [[btnOther layer] setBorderWidth:0.5f];
    [btnOther.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    
    if(self.view.frame.size.width==320)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 670)];
    }
    
    btnPhotoLib.frame=CGRectMake(btnPhotoLib.frame.origin.x, btnCamera.frame.origin.y+btnCamera.frame.size.height+16, btnPhotoLib.frame.size.width, btnPhotoLib.frame.size.height);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==txtvwDescription)
    {
        lblDesc.hidden=YES;
         [mainscroll setContentOffset:CGPointMake(0.0f,120.0f) animated:YES];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        if (self.view.frame.size.height==480)
        {
            if(textView==txtvwDescription)
            {
              //  [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
                
                if (txtvwDescription.text.length==0)
                {
                    // lblDesc.hidden=NO;
                }
            }
        }
        
        
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SegmentClick:(id)sender {
    switch (SegmentedControl.selectedSegmentIndex)
    {
        case 0:
            DocType1=@"2";
            break;
        case 1:
            DocType1=@"1";
            break;
        case 2:
            DocType1=@"99";
            break;
            
        default:
            break;
    }
}

- (IBAction)DocTypeClk:(id)sender
{
    [txtDocName resignFirstResponder];
    if (btnDocType.selected==NO)
    {
        btnDocType.selected=YES;
        if (btnAddDoc.selected==YES)
        {
            
            if (self.view.frame.size.width==320)
            {
                [mainscroll setContentOffset:CGPointMake(0,130) animated:YES];
            }
            else
            {
                [mainscroll setContentOffset:CGPointMake(0,40) animated:YES];
            }
        }
        else
        {
            [mainscroll setContentOffset:CGPointMake(0,10) animated:YES];
        }
        [Doctypeview removeFromSuperview];
        
        
        //     Producttypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, btnSubmit.frame.origin.y+btnSubmit.frame.size.height+10, self.view.frame.size.width,200)];
        //    NSLog(@"height=%f",self.view.frame.size.height-200);
        Doctypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-200, self.view.frame.size.width,200)];
        [Doctypeview setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [self.view addSubview:Doctypeview];
        
        
        
        //picker create
        
        Doctypepicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 10, 250,150)];
        //   amtpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width,150)];
        Doctypepicker.delegate=self;
        Doctypepicker.dataSource=self;
        [Doctypepicker setBackgroundColor:[UIColor whiteColor]];
        [Doctypeview addSubview:Doctypepicker];
        
        btnDoctypesave=[[UIButton alloc] initWithFrame:CGRectMake(0,Doctypeview.frame.size.height-35.0,self.view.frame.size.width/2,35)];
        btnDoctypesave.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btnDoctypesave setTitle: @"OK" forState: UIControlStateNormal];
        btnDoctypesave.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnDoctypesave addTarget:self action:@selector(DoctypepickerChange) forControlEvents:UIControlEventTouchUpInside];
        [Doctypeview addSubview:btnDoctypesave];
        
        btnDoctypeCancel=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,Doctypeview.frame.size.height-35,self.view.frame.size.width/2,35)];
        btnDoctypeCancel.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btnDoctypeCancel setTitle: @"CANCEL" forState: UIControlStateNormal];
        btnDoctypeCancel.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnDoctypeCancel addTarget:self action:@selector(DoctypepickerCancel) forControlEvents:UIControlEventTouchUpInside];
        [Doctypeview addSubview:btnDoctypeCancel];
        
    }
    else
    {
        btnDocType.selected=NO;
        [Doctypeview removeFromSuperview];
        
    }
}
-(void)DoctypepickerCancel
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    btnDocType.selected=NO;
    [Doctypeview removeFromSuperview];
}
-(void)DoctypepickerChange
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    if (DocType.length==0) {
        
        lblDocType.text=[ArrDocType objectAtIndex:0];
    }
    else
    {
        lblDocType.text=DocType;
    }
    lblDocType.textColor=[UIColor blackColor];
    DocType=@"";
    btnDocType.selected=NO;
    [Doctypeview removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker)
    {
        return ArrDocType.count;
    }
    else
    {
        return 0;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker)
    {
        return ArrDocType[row];
    }
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker){
        
        DocType= ArrDocType[row];
        lblDocType.textColor=[UIColor blackColor];
    }
    
    else
    {
        
    }
}
- (IBAction)AddDocClk:(id)sender
{
    [txtvwDescription resignFirstResponder];
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    [mainscroll setContentOffset:CGPointMake(0,0) animated:YES];
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
    
    switch (buttonIndex) {
            
        case 0:
            
            
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.navigationController presentViewController:picker animated:YES completion:NULL];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    DocImage.image=info[UIImagePickerControllerOriginalImage];
    DocImage.contentMode = UIViewContentModeScaleAspectFit;
    DocImage.clipsToBounds=YES;
    
  //  [DocImage setUserInteractionEnabled:YES];
 //   btnsubmit.frame=CGRectMake(btnsubmit.frame.origin.x, DocImage.frame.origin.y+DocImage.frame.size.height+10, btnsubmit.frame.size.width, btnsubmit.frame.size.height);
    
    DocView.hidden=YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    btnAddDoc.selected=YES;
    btnsubmit.hidden=NO;
    
    
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

- (IBAction)SubmitClk:(id)sender
{
    /*
    if ([lblDocType.text isEqualToString:@"Purchase Receipt"]) {
        DocType1=@"1";
    }
    else if ([lblDocType.text isEqualToString:@"Insurance Certificate"]) {
        DocType1=@"2";
    }
    else if ([lblDocType.text isEqualToString:@"Others"]) {
        DocType1=@"99";
    }
     */
    if([self textFieldBlankorNot:txtDocName.text].length==0)
    {
        /*
        txtDocName.text=@"";
        txtDocName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Document Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
        */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Document Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
   /*
    else if (lblDocType.text.length==0 || [lblDocType.text isEqualToString:@"Document Type"])
    {
        
        lblDocType.text=@"Document Type";
        lblDocType.textColor=[UIColor redColor];
         
       
    }
    */
  //  else if([DocImage.image isEqual:[UIImage imageNamed:@"doc"]])
     else if(DocImage.image ==nil)
    {
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Document" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    else
    {
        
        [self ImageUploadUrl];
        
    }

}
-(void)ImageUploadUrl
{
    
    //filename
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    FileName=[NSString stringWithFormat:@"%@%@%@",@"ProductDoc",currentTime,@".png"];
    //[@"PortDoc" stringByAppendingString:currentTime];
    NSLog(@"time=%@",FileName);
    
    //image upload
    CGSize size = DocImage.image.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 600.0 / size.width;
    }
    else {
        ratio = 600.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [DocImage.image drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(thumbnail,1.0f);
    //    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    //   NSString *encodedText = [self encodeToPercentEscapeString:base64String];
    [self checkLoader];
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:FileName,@"FileName",[base64String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"FileContent",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UploadFile/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
    //    NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
    
    NSLog(@"--- %@",loginstring);
    
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                FileName=[NSString stringWithFormat:@"%@",[result valueForKey:@"ResultInfo"]];
                [self SubmitDocUrl];
                
            }
            else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
            {
                NSString *email,*password,*remember;
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                if ([[prefs valueForKey:@"remember"] isEqualToString:@"1"])
                {
                    email=[prefs valueForKey:@"email"];
                    password=[prefs valueForKey:@"password"];
                    remember=[prefs valueForKey:@"remember"];
                    
                }
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                
                if ([remember isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"remember"];
                    [[NSUserDefaults standardUserDefaults] setObject:email  forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults] setObject:password  forKey:@"password"];
                    
                }
                login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:obj1 animated:YES];
            }
            else
            {
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [self checkLoader];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    
}
-(NSString*) encodeToPercentEscapeString:(NSString *)string {
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                              (CFStringRef) string,
                                                              NULL,
                                                              (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
}
-(void)SubmitDocUrl
{
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"ProductDocCode",txtDocName.text , @"DocName",DocType1, @"DocTypeCode",txtvwDescription.text,@"Description",FileName,@"FileName",ProductCode,@"ProductCode",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertProductDoc/%@?ProductCode=%@",URL_LINK,AuthToken,ProductCode];
    
    NSLog(@"--- %@",loginstring);
    
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
           
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Document Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                [PopDelegate Popaction_method];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
            {
                NSString *email,*password,*remember;
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                if ([[prefs valueForKey:@"remember"] isEqualToString:@"1"])
                {
                    email=[prefs valueForKey:@"email"];
                    password=[prefs valueForKey:@"password"];
                    remember=[prefs valueForKey:@"remember"];
                    
                }
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                
                if ([remember isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"remember"];
                    [[NSUserDefaults standardUserDefaults] setObject:email  forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults] setObject:password  forKey:@"password"];
                    
                }
                login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController pushViewController:obj1 animated:YES];
            }
            else
            {
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [self checkLoader];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    
}
-(void)checkLoader
{
    
    if([self.view.subviews containsObject:loader_shadow_View])
    {
        
        [loader_shadow_View removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
    else
    {
        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
        [loader_shadow_View setUserInteractionEnabled:NO];
        [[loader_shadow_View layer] setZPosition:2];
        [self.view setUserInteractionEnabled:NO];
        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
        [loader startAnimating];
        
        
        [loader_shadow_View addSubview:loader];
        [self.view addSubview:loader_shadow_View];
    }
}
- (IBAction)BackClk:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)PurchaseReceiptClick:(id)sender
{
    if (btnPurchaseReceipt.selected==NO)
    {
        btnInsuranceCertificate.selected=NO;
        btnPurchaseReceipt.selected=YES;
        btnOther.selected=NO;
        btnOther.backgroundColor=[UIColor whiteColor];
        btnPurchaseReceipt.backgroundColor=[UIColor colorWithRed:(202.0f/255.0) green:(202.0f/255.0) blue:(202.0f/255.0) alpha:1];
        btnInsuranceCertificate.backgroundColor=[UIColor whiteColor];
       
        
        DocType1=@"1";
    }
}

- (IBAction)OtherClick:(id)sender
{
    if (btnOther.selected==NO)
    {
        
        btnInsuranceCertificate.selected=NO;
        btnPurchaseReceipt.selected=NO;
        btnOther.selected=YES;
        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
        btnOther.backgroundColor=[UIColor colorWithRed:(202.0f/255.0) green:(202.0f/255.0) blue:(202.0f/255.0) alpha:1];
        btnInsuranceCertificate.backgroundColor=[UIColor whiteColor];
        
        DocType1=@"99";
    }
}

- (IBAction)InsuranceCertificateClick:(id)sender
{
    if (btnInsuranceCertificate.selected==NO)
    {
        btnInsuranceCertificate.selected=YES;
        btnPurchaseReceipt.selected=NO;
        btnOther.selected=NO;
        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
        btnInsuranceCertificate.backgroundColor=[UIColor colorWithRed:(202.0f/255.0) green:(202.0f/255.0) blue:(202.0f/255.0) alpha:1];
        btnOther.backgroundColor=[UIColor whiteColor];
        
        
        DocType1=@"2";
    }
}

- (IBAction)CameraClick:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
   
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)PhotoLibClick:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
   
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
 
}


@end
