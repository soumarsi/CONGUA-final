//
//  EditPortfolioDocViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 24/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "EditPortfolioDocViewController.h"

@interface EditPortfolioDocViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@end

@implementation EditPortfolioDocViewController
@synthesize lblDocType,lblDesc,txtDocName,txtVwDesc,DocImage,mainscroll,btnDocType,btnsubmit,btnAddDoc,btnPurchaseReceipt,btnOther,btnInsureCertificate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.view.frame.size.height==480)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 520)];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioDocCode=[prefs valueForKey:@"PortfolioDocCode"];
     PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio doc code=%@",PortfolioDocCode);
    
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
    
    txtDocName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Document Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblDesc.textColor=[UIColor grayColor];
    lblDocType.textColor=[UIColor grayColor];
    
    [self DocumentViewUrl];
}
-(void)DocumentViewUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioDocInfoDetail/%@?PortfolioCode=%@&PortfolioDocCode=%@",URL_LINK,AuthToken,PortfolioCode,PortfolioDocCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /*
                     for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                     {
                     [ArrPortDetail addObject:tempDict1];
                     
                     }
                     */
                    
                    txtDocName.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"DocName"];
                    
                    txtVwDesc.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"];
                    lblDesc.hidden=YES;
                    
                   
                    lblDocType.textColor=[UIColor blackColor];
                    if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==1) {
                        lblDocType.text=@"Purchase Receipt";
                        btnPurchaseReceipt.selected=YES;
                        [btnPurchaseReceipt.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btnPurchaseReceipt.layer.borderWidth=0.5;
                        btnPurchaseReceipt.layer.cornerRadius=15.0f;
                        [btnPurchaseReceipt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
                        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnPurchaseReceipt.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
                        
                        btnInsureCertificate.selected=NO;
                        btnInsureCertificate.layer.borderWidth=0.5;
                        btnInsureCertificate.layer.cornerRadius=15.0f;
                        [btnInsureCertificate setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnInsureCertificate layer] setBorderWidth:0.5f];
                        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnInsureCertificate.backgroundColor=[UIColor whiteColor];
                        
                        btnOther.selected=NO;
                        btnOther.layer.borderWidth=0.5;
                        btnOther.layer.cornerRadius=15.0f;
                        [btnOther setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnOther layer] setBorderWidth:0.5f];
                        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnOther.backgroundColor=[UIColor whiteColor];
                        
                        
                        DocType1=@"1";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==2) {
                        lblDocType.text=@"Insurance Certificate";
                        btnInsureCertificate.selected=YES;
                        [btnInsureCertificate.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btnInsureCertificate.layer.borderWidth=0.5;
                        btnInsureCertificate.layer.cornerRadius=15.0f;
                        [btnInsureCertificate setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        [[btnInsureCertificate layer] setBorderWidth:0.5f];
                        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnInsureCertificate.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
                        
                        btnPurchaseReceipt.selected=NO;
                        btnPurchaseReceipt.layer.borderWidth=0.5;
                        btnPurchaseReceipt.layer.cornerRadius=15.0f;
                        [btnPurchaseReceipt setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
                        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
                        
                        btnOther.selected=NO;
                        btnOther.layer.borderWidth=0.5;
                        btnOther.layer.cornerRadius=15.0f;
                        [btnOther setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnOther layer] setBorderWidth:0.5f];
                        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnOther.backgroundColor=[UIColor whiteColor];
                        
                        
                        DocType1=@"2";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==99) {
                        lblDocType.text=@"Others";
                        btnOther.selected=YES;
                        [btnOther.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
                        btnOther.layer.borderWidth=0.5;
                        btnOther.layer.cornerRadius=15.0f;
                        [btnOther setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                        [[btnOther layer] setBorderWidth:0.5f];
                        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnOther.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
                        
                        btnInsureCertificate.selected=NO;
                        btnInsureCertificate.layer.borderWidth=0.5;
                        btnInsureCertificate.layer.cornerRadius=15.0f;
                        [btnInsureCertificate setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnInsureCertificate layer] setBorderWidth:0.5f];
                        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnInsureCertificate.backgroundColor=[UIColor whiteColor];
                        
                        btnPurchaseReceipt.selected=NO;
                        btnPurchaseReceipt.layer.borderWidth=0.5;
                        btnPurchaseReceipt.layer.cornerRadius=15.0f;
                        [btnPurchaseReceipt setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
                        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
                        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
                        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
                        
                        
                        DocType1=@"99";
                    }
                    
                    FileName=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"FileName"]];
                    if (FileName.length==0)
                    {
                        
                    }
                    else
                    {
                        
                        [self DownloadUrl];
                    }
                    
                }
                else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
                {
                    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                    login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    [self.navigationController pushViewController:obj1 animated:YES];
                }
                else
                {
                    
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [aler show];
                }
                
                
                
                
            }];
        }
        else{
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
    }
    
    
    
    
}
-(void)DownloadUrl
{
    @try {
        
        //  FileName=@"34.png";
        NSString *str=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
        NSLog(@"str=%@",str);
        
        
        //   NSURL *url = [NSURL URLWithString:str];
        //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        //    [WebView loadRequest:requestObj];
        [DocImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        DocImage.contentMode=UIViewContentModeScaleAspectFit;
        
        btnsubmit.frame=CGRectMake(btnsubmit.frame.origin.x, DocImage.frame.origin.y+DocImage.frame.size.height+10, btnsubmit.frame.size.width, btnsubmit.frame.size.height);
        btnAddDoc.selected=YES;
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
    }
    
    
    
    
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
    if(textView==txtVwDesc)
    {
        lblDesc.hidden=YES;
         [mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==txtVwDesc)
        {
              [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            
            if (txtVwDesc.text.length==0)
            {
               // lblDesc.hidden=NO;
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

- (IBAction)DocTypeClick:(id)sender
{
    [txtDocName resignFirstResponder];
    if (btnDocType.selected==NO)
    {
        btnDocType.selected=YES;
        //  [mainscroll setContentOffset:CGPointMake(0,20) animated:YES];
        if (btnAddDoc.selected==YES)
        {
            
            if (self.view.frame.size.width==320)
            {
                [mainscroll setContentOffset:CGPointMake(0,140) animated:YES];
            }
            else
            {
                [mainscroll setContentOffset:CGPointMake(0,40) animated:YES];
            }
            if (self.view.frame.size.height==480)
            {
                [mainscroll setContentOffset:CGPointMake(0,220) animated:YES];
            }
        }
        else
        {
            if (self.view.frame.size.height==480)
            {
                [mainscroll setContentOffset:CGPointMake(0,80) animated:YES];
            }
        }
        [Doctypeview removeFromSuperview];
        
        Doctypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, btnsubmit.frame.origin.y+btnsubmit.frame.size.height+10, self.view.frame.size.width,200)];
        //    NSLog(@"height=%f",self.view.frame.size.height-200);
        //     Doctypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-200, self.view.frame.size.width,200)];
        [Doctypeview setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [mainscroll addSubview:Doctypeview];
        
        
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
        
        btnDoctypeCancel=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,Doctypeview.frame.size.height-35.0,self.view.frame.size.width/2,35)];
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
    btnDocType.selected=NO;
    [Doctypeview removeFromSuperview];
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
-(void)DoctypepickerChange
{
    
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
    
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
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

- (IBAction)AddDocumentClick:(id)sender
{
    [txtVwDesc resignFirstResponder];
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
            
        case 0:
            
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            
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
    
    DocImage.image=info[UIImagePickerControllerEditedImage];
    DocImage.contentMode = UIViewContentModeScaleAspectFit;
    DocImage.clipsToBounds=YES;
    
  //  [DocImage setUserInteractionEnabled:YES];
    btnsubmit.frame=CGRectMake(btnsubmit.frame.origin.x, DocImage.frame.origin.y+DocImage.frame.size.height+10, btnsubmit.frame.size.width, btnsubmit.frame.size.height);
    btnAddDoc.selected=YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}
- (IBAction)SubmitClick:(id)sender
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
    if(txtDocName.text.length==0)
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
 //   else if([DocImage.image isEqual:[UIImage imageNamed:@"doc"]])
     else if(DocImage.image==nil)
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
    FileName=[NSString stringWithFormat:@"%@%@%@",@"PortDoc",currentTime,@".png"];
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
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
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
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:PortfolioDocCode,@"PortfolioDocCode",txtDocName.text , @"DocName",DocType1, @"DocTypeCode",txtVwDesc.text,@"Description",FileName,@"FileName",nil];
    NSLog(@"tempdic=%@",tempDict);
    
    NSString *loginstring = [NSString stringWithFormat:@"%@UpdatePortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
    
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
                
                
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Document Updated Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
            {
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
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
- (IBAction)BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)InsureCertificateClick:(id)sender
{
    if (btnInsureCertificate.selected==NO)
    {
        btnInsureCertificate.selected=YES;
        [btnInsureCertificate.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
        btnInsureCertificate.layer.borderWidth=0.5;
        btnInsureCertificate.layer.cornerRadius=15.0f;
        [btnInsureCertificate setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [[btnInsureCertificate layer] setBorderWidth:0.5f];
        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnInsureCertificate.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
        
        btnPurchaseReceipt.selected=NO;
        btnPurchaseReceipt.layer.borderWidth=0.5;
        btnPurchaseReceipt.layer.cornerRadius=15.0f;
        [btnPurchaseReceipt setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
        
        btnOther.selected=NO;
        btnOther.layer.borderWidth=0.5;
        btnOther.layer.cornerRadius=15.0f;
        [btnOther setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnOther layer] setBorderWidth:0.5f];
        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnOther.backgroundColor=[UIColor whiteColor];
        
        
        DocType1=@"2";
    }
}

- (IBAction)PurchaseReceiptClick:(id)sender
{
    if (btnPurchaseReceipt.selected==NO)
    {
        btnPurchaseReceipt.selected=YES;
        [btnPurchaseReceipt.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
        btnPurchaseReceipt.layer.borderWidth=0.5;
        btnPurchaseReceipt.layer.cornerRadius=15.0f;
        [btnPurchaseReceipt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnPurchaseReceipt.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
        
        btnInsureCertificate.selected=NO;
        btnInsureCertificate.layer.borderWidth=0.5;
        btnInsureCertificate.layer.cornerRadius=15.0f;
        [btnInsureCertificate setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnInsureCertificate layer] setBorderWidth:0.5f];
        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnInsureCertificate.backgroundColor=[UIColor whiteColor];
        
        btnOther.selected=NO;
        btnOther.layer.borderWidth=0.5;
        btnOther.layer.cornerRadius=15.0f;
        [btnOther setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnOther layer] setBorderWidth:0.5f];
        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnOther.backgroundColor=[UIColor whiteColor];
        
        
        DocType1=@"1";
    }
}

- (IBAction)OtherClick:(id)sender
{
    if (btnOther.selected==NO)
    {
        btnOther.selected=YES;
        [btnOther.layer setBorderColor:[[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
        btnOther.layer.borderWidth=0.5;
        btnOther.layer.cornerRadius=15.0f;
        [btnOther setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [[btnOther layer] setBorderWidth:0.5f];
        [[btnOther layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnOther.backgroundColor=[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1];
        
        btnInsureCertificate.selected=NO;
        btnInsureCertificate.layer.borderWidth=0.5;
        btnInsureCertificate.layer.cornerRadius=15.0f;
        [btnInsureCertificate setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnInsureCertificate layer] setBorderWidth:0.5f];
        [[btnInsureCertificate layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnInsureCertificate.backgroundColor=[UIColor whiteColor];
        
        btnPurchaseReceipt.selected=NO;
        btnPurchaseReceipt.layer.borderWidth=0.5;
        btnPurchaseReceipt.layer.cornerRadius=15.0f;
        [btnPurchaseReceipt setTitleColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1] forState:UIControlStateNormal];
        [[btnPurchaseReceipt layer] setBorderWidth:0.5f];
        [[btnPurchaseReceipt layer] setBorderColor:[UIColor colorWithRed:(224.0f/255.0) green:(44.0f/255.0) blue:(17.0f/255.0) alpha:1].CGColor];
        btnPurchaseReceipt.backgroundColor=[UIColor whiteColor];
        
        
        DocType1=@"99";
    }
}
@end
