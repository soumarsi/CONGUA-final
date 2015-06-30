//
//  AddProductViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 12/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()<UITextFieldDelegate,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation AddProductViewController
@synthesize txtproductName,txtPurchaseValue,txtVwDescription,btnIsInsuredPort,btnIsOtherInsured,btnproductType,btnPurchaseDt,IsInsuredPortToggleImg,IsOtherInsuredToggleImg,mainscroll,lblDescription,lblProductType,lblPurchaseDt,CategoryCode,btnSubmit,DescImgView,InsuredPortSwitch,OtherInsuredSwitch;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio code=%@",PortfolioCode);
    NSLog(@"category code=%@",CategoryCode);
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtproductName.leftView = paddingView;
    txtproductName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtPurchaseValue.leftView = paddingView1;
    txtPurchaseValue.leftViewMode = UITextFieldViewModeAlways;
 
    
  //  ArrProductType=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
     ArrProductType=[[NSMutableArray alloc]initWithObjects:@"1",nil];

    txtproductName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtPurchaseValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Purchase Value" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblDescription.textColor=[UIColor grayColor];
    lblProductType.textColor=[UIColor grayColor];
    lblPurchaseDt.textColor=[UIColor grayColor];
    
    InsuredPortSwitch.on=NO;
    [InsuredPortSwitch addTarget:self action:@selector(InsuredPortSwitched:)
            forControlEvents:UIControlEventValueChanged];
    
    OtherInsuredSwitch.on=NO;
    [OtherInsuredSwitch addTarget:self action:@selector(OtherInsuredSwitched:)
            forControlEvents:UIControlEventValueChanged];
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
    if(textView==txtVwDescription)
    {
        lblDescription.hidden=YES;
          [mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
    }
   
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==txtVwDescription)
        {
                           [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
          
            if (txtVwDescription.text.length==0)
            {
                lblDescription.hidden=NO;
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
-(IBAction)InsuredPortSwitched:(id)sender{
    NSLog(@"Switch current state %@", InsuredPortSwitch.on ? @"On" : @"Off");
    
    if (InsuredPortSwitch.on==YES) {
        btnIsInsuredPort.selected=YES;
     //   IsInsuredPortToggleImg.frame=CGRectMake(IsInsuredPortToggleImg.frame.origin.x+20, IsInsuredPortToggleImg.frame.origin.y, IsInsuredPortToggleImg.frame.size.width, IsInsuredPortToggleImg.frame.size.height);
        Isinsured=@"1";
    }
    else if (InsuredPortSwitch.on==NO) {
        btnIsInsuredPort.selected=NO;
 //       IsInsuredPortToggleImg.frame=CGRectMake(IsInsuredPortToggleImg.frame.origin.x-20, IsInsuredPortToggleImg.frame.origin.y, IsInsuredPortToggleImg.frame.size.width, IsInsuredPortToggleImg.frame.size.height);
        Isinsured=@"0";
    }
}
- (IBAction)IsInsuredPortClk:(id)sender
{
    if (btnIsInsuredPort.selected==NO) {
        btnIsInsuredPort.selected=YES;
        IsInsuredPortToggleImg.frame=CGRectMake(IsInsuredPortToggleImg.frame.origin.x+20, IsInsuredPortToggleImg.frame.origin.y, IsInsuredPortToggleImg.frame.size.width, IsInsuredPortToggleImg.frame.size.height);
        Isinsured=@"1";
    }
    else if (btnIsInsuredPort.selected==YES) {
        btnIsInsuredPort.selected=NO;
        IsInsuredPortToggleImg.frame=CGRectMake(IsInsuredPortToggleImg.frame.origin.x-20, IsInsuredPortToggleImg.frame.origin.y, IsInsuredPortToggleImg.frame.size.width, IsInsuredPortToggleImg.frame.size.height);
        Isinsured=@"0";
    }
}

- (IBAction)ProductTypeClk:(id)sender
{
    [txtproductName resignFirstResponder];
   
    if (btnproductType.selected==NO)
    {
        btnproductType.selected=YES;
        //  [mainscroll setContentOffset:CGPointMake(0,20) animated:YES];
        if (btnIsOtherInsured.selected==YES)
        {
            
            if (self.view.frame.size.width==320)
            {
                [mainscroll setContentOffset:CGPointMake(0,110) animated:YES];
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
        [Producttypeview removeFromSuperview];
        
        
   //     Producttypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, btnSubmit.frame.origin.y+btnSubmit.frame.size.height+10, self.view.frame.size.width,200)];
        //    NSLog(@"height=%f",self.view.frame.size.height-200);
             Producttypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-200, self.view.frame.size.width,200)];
        [Producttypeview setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [self.view addSubview:Producttypeview];
        
        
        //picker create
        
        producttypepicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 10, 250,150)];
        //   amtpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width,150)];
        producttypepicker.delegate=self;
        producttypepicker.dataSource=self;
        [producttypepicker setBackgroundColor:[UIColor whiteColor]];
        [Producttypeview addSubview:producttypepicker];
        
        btnProducttypesave=[[UIButton alloc] initWithFrame:CGRectMake(0,Producttypeview.frame.size.height-35.0,self.view.frame.size.width/2,35)];
        btnProducttypesave.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btnProducttypesave setTitle: @"OK" forState: UIControlStateNormal];

        btnProducttypesave.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnProducttypesave addTarget:self action:@selector(producttypepickerChange) forControlEvents:UIControlEventTouchUpInside];
        [Producttypeview addSubview:btnProducttypesave];
        
        btnproducttypeCancel=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,Producttypeview.frame.size.height-35,self.view.frame.size.width/2,35)];
        btnproducttypeCancel.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btnproducttypeCancel setTitle: @"CANCEL" forState: UIControlStateNormal];
        btnproducttypeCancel.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnproducttypeCancel addTarget:self action:@selector(producttypepickerCancel) forControlEvents:UIControlEventTouchUpInside];
        [Producttypeview addSubview:btnproducttypeCancel];
        
    }
    else
    {
        btnproductType.selected=NO;
        [Producttypeview removeFromSuperview];
        
    }

}
-(void)producttypepickerCancel
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
    btnproductType.selected=NO;
    [Producttypeview removeFromSuperview];
}
-(void)producttypepickerChange
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
    if (ProductType.length==0) {
        
        lblProductType.text=[ArrProductType objectAtIndex:0];
    }
    else
    {
        lblProductType.text=ProductType;
    }
    lblProductType.textColor=[UIColor blackColor];
    ProductType=@"";
    btnproductType.selected=NO;
    [Producttypeview removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==producttypepicker)
    {
        return ArrProductType.count;
    }
    else
    {
        return 0;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==producttypepicker)
    {
        return ArrProductType[row];
    }
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==producttypepicker){
        
        ProductType= ArrProductType[row];
        lblProductType.textColor=[UIColor blackColor];
    }
   
    else
    {
        
    }
}
-(IBAction)OtherInsuredSwitched:(id)sender{
    NSLog(@"Switch current state %@", OtherInsuredSwitch.on ? @"On" : @"Off");
    if (OtherInsuredSwitch.on==YES) {
        btnIsOtherInsured.selected=YES;
    //    IsOtherInsuredToggleImg.frame=CGRectMake(IsOtherInsuredToggleImg.frame.origin.x+20, IsOtherInsuredToggleImg.frame.origin.y, IsOtherInsuredToggleImg.frame.size.width, IsOtherInsuredToggleImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=YES;
        Isotherinsured=@"1";
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
            DescImgView.hidden=NO;
            lblDescription.hidden=NO;
            txtVwDescription.hidden=NO;
        }];
    }
    else if (OtherInsuredSwitch.on==NO) {
        btnIsOtherInsured.selected=NO;
    //    IsOtherInsuredToggleImg.frame=CGRectMake(IsOtherInsuredToggleImg.frame.origin.x-20, IsOtherInsuredToggleImg.frame.origin.y, IsOtherInsuredToggleImg.frame.size.width, IsOtherInsuredToggleImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=NO;
        Isotherinsured=@"0";
        
        // hide insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
        }];
        
    }
}
- (IBAction)IsOtherInsuredClk:(id)sender
{
    if (btnIsOtherInsured.selected==NO) {
        btnIsOtherInsured.selected=YES;
        IsOtherInsuredToggleImg.frame=CGRectMake(IsOtherInsuredToggleImg.frame.origin.x+20, IsOtherInsuredToggleImg.frame.origin.y, IsOtherInsuredToggleImg.frame.size.width, IsOtherInsuredToggleImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=YES;
        Isotherinsured=@"1";
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
            DescImgView.hidden=NO;
            lblDescription.hidden=NO;
            txtVwDescription.hidden=NO;
        }];
    }
    else if (btnIsOtherInsured.selected==YES) {
        btnIsOtherInsured.selected=NO;
        IsOtherInsuredToggleImg.frame=CGRectMake(IsOtherInsuredToggleImg.frame.origin.x-20, IsOtherInsuredToggleImg.frame.origin.y, IsOtherInsuredToggleImg.frame.size.width, IsOtherInsuredToggleImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=NO;
        Isotherinsured=@"0";
        
        // hide insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
        }];

    }
}

- (IBAction)SubmitClk:(id)sender
{
    if(txtproductName.text.length==0)
    {
        txtproductName.text=@"";
        txtproductName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
    else if (lblProductType.text.length==0 || [lblProductType.text isEqualToString:@"Product Type"])
    {
        lblProductType.text=@"Product Type";
        lblProductType.textColor=[UIColor redColor];
    }
    else if ((lblPurchaseDt.text.length==0 || [lblPurchaseDt.text isEqualToString:@"Purchase Date"]))
    {
        lblPurchaseDt.text=@"Purchase Date";
        lblPurchaseDt.textColor=[UIColor redColor];
    }
    else if(txtPurchaseValue.text.length==0)
    {
        txtPurchaseValue.text=@"";
        txtPurchaseValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Purchase Value" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (txtVwDescription.text.length==0 && btnIsOtherInsured.selected==YES)
    {
        lblDescription.text=@"";
        lblDescription.hidden=NO;
        lblDescription.text=@"Enter Description";
        lblDescription.textColor=[UIColor redColor];
    }
    
    else
    {
        
            [self AddProductUrl];
        
    }
}
-(void)AddProductUrl
{
    
    NSLog(@"category code=%@",CategoryCode);
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"ProductCode",txtproductName.text, @"ProductName",@"1", @"ProductTypeCode",CategoryCode,@"CategoryCode",PortfolioCode,@"PortfolioCode", lblPurchaseDt.text, @"PurchaseDate",txtPurchaseValue.text,@"PurchaseValue",Isinsured,@"IsInsuredWithPortfolio",Isotherinsured,@"IsOtherInsured",txtVwDescription.text,@"Description",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertProduct/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
    NSLog(@"str=%@",loginstring);
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
        [self checkLoader];
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
               
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Product Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                [self dismissViewControllerAnimated:YES completion:nil];
                
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
- (IBAction)BackClk:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)PurchaseDateClk:(id)sender
{
    [txtproductName resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,280.0f) animated:YES];
        PurchaseDateview = [[UIView alloc] initWithFrame:CGRectMake(0,540,375,340)];
        [PurchaseDateview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,187,35)];
        btn.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,235,187,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn1];
        
        
        datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,375,10)];
        [PurchaseDateview addSubview:datepicker];
        [mainscroll addSubview:PurchaseDateview];
        
        [datepicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        datepicker.datePickerMode=UIDatePickerModeDate;
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [datepicker setMinimumDate:currDate];
        //    picker.hidden=NO;
        datepicker.date=[NSDate date];
        [datepicker addTarget:self action:@selector(datepickerChange:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(DateSaveClk:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
        PurchaseDateview = [[UIView alloc] initWithFrame:CGRectMake(0,400,320,280)];
        [PurchaseDateview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,160,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(160,235,160,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn1];
        
        
        
        datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [PurchaseDateview addSubview:datepicker];
        [mainscroll addSubview:PurchaseDateview];
        
        [datepicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        datepicker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [datepicker setMinimumDate:currDate];
        //    picker.hidden=NO;
        datepicker.date=[NSDate date];
        [datepicker addTarget:self action:@selector(datepickerChange:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(DateSaveClk:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        PurchaseDateview = [[UIView alloc] initWithFrame:CGRectMake(0,620,414,280)];
        [PurchaseDateview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,207,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn];
        
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(207,235,207,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [PurchaseDateview addSubview:btn1];
        datepicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [PurchaseDateview addSubview:datepicker];
        [mainscroll addSubview:PurchaseDateview];
        
        [datepicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        datepicker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [datepicker setMinimumDate:currDate];
        
        //    picker.hidden=NO;
        datepicker.date=[NSDate date];
        [datepicker addTarget:self action:@selector(datepickerChange:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(DateSaveClk:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)datepickerChange:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datepicker.date]];
 //   lblPurchaseDt.font = [UIFont fontWithName:@"HelveticaNeueLTPro-UltLt.otf" size:14];
    lblPurchaseDt.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblPurchaseDt.textColor=[UIColor blackColor];
    lblPurchaseDt.text=str;
    
    
    //[picker removeFromSuperview];
}
-(void)DateSaveClk:(id)sender
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
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datepicker.date]];
    lblPurchaseDt.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblPurchaseDt.textColor=[UIColor blackColor];
    lblPurchaseDt.text=str;
    
    self.navigationItem.rightBarButtonItem=nil;
    [PurchaseDateview removeFromSuperview];
    
}
-(void)buttoncross:(id)sender
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
    lblPurchaseDt.text=@"Purchase Date";
    lblPurchaseDt.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblPurchaseDt.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
    self.navigationItem.rightBarButtonItem=nil;
    [PurchaseDateview removeFromSuperview];
    
}
@end
