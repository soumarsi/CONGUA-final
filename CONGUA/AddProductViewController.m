//
//  AddProductViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 12/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AddProductViewController.h"
#import "countryViewController.h"

@interface AddProductViewController ()<UITextFieldDelegate,UITableViewDelegate,CKCalendarDelegate>

@end

@implementation AddProductViewController
@synthesize txtproductName,txtPurchaseValue,txtVwDescription,btnIsInsuredPort,btnIsOtherInsured,btnproductType,btnPurchaseDt,IsInsuredPortToggleImg,IsOtherInsuredToggleImg,mainscroll,lblDescription,lblProductType,lblPurchaseDt,CategoryCode,ProductType,btnSubmit,DescImgView,InsuredPortSwitch,OtherInsuredSwitch,lblDescTop,PopDelegateFromAddProduct,ArrowImg;

@synthesize ArrCategory,ArrProductType,catCode;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     ArrowImg.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    
    if (ProductType.length==0) {
        
        
        lblProductType.text=@"";
        CategoryCode=@"";
    }

    
    if(self.view.frame.size.height==480)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 520)];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio code=%@",PortfolioCode);
  //  NSLog(@"category code=%@",CategoryCode);
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
 
    
  //i am using category in place of product type and product type kept 1
    
     ArrProductType=[[NSMutableArray alloc]initWithObjects:@"1",nil];
    ArrCategory=[[NSMutableArray alloc]init];

    /*
    txtproductName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtPurchaseValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Purchase Value" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblDescription.textColor=[UIColor grayColor];
    lblProductType.textColor=[UIColor grayColor];
    lblPurchaseDt.textColor=[UIColor grayColor];
    */
    
    InsuredPortSwitch.on=NO;
    [InsuredPortSwitch addTarget:self action:@selector(InsuredPortSwitched:)
            forControlEvents:UIControlEventValueChanged];
    
    OtherInsuredSwitch.on=NO;
    [OtherInsuredSwitch addTarget:self action:@selector(OtherInsuredSwitched:)
            forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *toolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar1.barStyle=UIBarStyleDefault;
    //    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView1)];
    //    // Add buttons to the toolbar
    [toolbar1 setItems:[NSArray arrayWithObjects:flexibleSpace1, barButtonItem1, nil]];
    // Set the toolbar as accessory view of an UITextField object
    txtPurchaseValue.inputAccessoryView = toolbar1;
    
    [[btnproductType layer] setBorderWidth:0.5f];
    [btnproductType.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    btnproductType.layer.cornerRadius=5.0;
    
    [self CategoryShowUrl];
}
-(void)resetView1
{
    [txtPurchaseValue resignFirstResponder];
    [mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if (self.view.frame.size.height==480)
    {
        if(textField==txtPurchaseValue)
        {
            lblDescription.hidden=YES;
            [mainscroll setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
        }
    }
    else
    {
        if(textField==txtPurchaseValue)
        {
            lblDescription.hidden=YES;
            [mainscroll setContentOffset:CGPointMake(0.0f,70.0f) animated:YES];
        }
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if (self.view.frame.size.height==480)
    {
        if(textView==txtVwDescription)
        {
            lblDescription.hidden=YES;
            [mainscroll setContentOffset:CGPointMake(0.0f,340.0f) animated:YES];
        }
    }
    else
    {
    if(textView==txtVwDescription)
    {
        lblDescription.hidden=YES;
          [mainscroll setContentOffset:CGPointMake(0.0f,220.0f) animated:YES];
    }
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
              //  lblDescription.hidden=NO;
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
-(void)CategoryShowUrl
{
    @try {
        
        
        [ArrCategory removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetCategoryInfoList/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrCategory addObject:tempDict1];
                        
                    }
                    NSMutableDictionary *tempDict2=[[NSMutableDictionary alloc]init];
                    [tempDict2 setObject:@"0" forKey:@"CategoryCode"];
                     [tempDict2 setObject:@"Other" forKey:@"CategoryName"];
                    [ArrCategory addObject:tempDict2];
                    //   NSLog(@"category name=%@",ArrCategory);
                    
                    //  [mytabview reloadData];
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
- (IBAction)ProductTypeClk:(id)sender
{
    [txtproductName resignFirstResponder];
    
    NSLog(@"Category btn clicked....");
    
    
    countryViewController *countryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"country"];
//    countryViewController *countryVC=[self.storyboard instantiateViewControllerWithIdentifier:@"country"];
    countryVC.myDelegate=self;
    
    countryVC.header1=@"Product";
   countryVC.header2=@"Category";
//    countryVC.ArrCategory=ArrCategory;
    
    countryVC.ArrCategory=ArrCategory;
    
    
//    NSLog(@"Category array....%@",countryVC.ArrCategory);
    
   

    [self.navigationController pushViewController:countryVC animated:YES];
    
//    [self presentViewController:countryVC animated:YES completion:^{
//        
//        
//        countryVC.headerLbl1.text=@"Product";
//        countryVC.headerLbl2.text=@"Category";
//
//        
//        
//    }];
    
    //[self.view presentedViewController:countryVC];
    
    //[self.navigationController pushViewController:countryVC animated:YES];
   
  /*  if (btnproductType.selected==NO)
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
        if (self.view.frame.size.width==320)
        {
             [self.mainscroll setContentOffset:CGPointMake(0.0f,70.0f) animated:YES];
        }
       
             Producttypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-250, self.view.frame.size.width,250)];
        [Producttypeview setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [self.view addSubview:Producttypeview];
        
        
        //picker create
        NSLog(@"picker create");
        producttypepicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 10, 250,200)];
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
        
    }*/

}


-(void)countryViewcontrollerDismissedwithCategoryName:(NSString *)categoryyName categoryCode:(NSString *)categoryCode
{
    
    NSLog(@"Delegate calling...");
    
    lblProductType.text=categoryyName;
    
    lblProductType.textColor=[UIColor blackColor];
    
    CategoryCode=categoryCode;
    
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


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"View did appear...");
    
    
}

/*

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
        
      //  lblProductType.text=[ArrProductType objectAtIndex:0];
         lblProductType.text=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryName"];
        CategoryCode=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryCode"];
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
       // return ArrProductType.count;
        return ArrCategory.count;
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
       // return ArrProductType[row];
      
        return [[ArrCategory objectAtIndex:row] valueForKey:@"CategoryName"];
    }
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==producttypepicker){
        
      //  ProductType= ArrProductType[row];
        
        ProductType= [[ArrCategory objectAtIndex:row] valueForKey:@"CategoryName"];
        CategoryCode=[[ArrCategory objectAtIndex:row] valueForKey:@"CategoryCode"];
        lblProductType.textColor=[UIColor blackColor];
    }
   
    else
    {
        
    }
}
 */
 
 
-(IBAction)OtherInsuredSwitched:(id)sender{
    NSLog(@"Switch current state %@", OtherInsuredSwitch.on ? @"On" : @"Off");
    if (OtherInsuredSwitch.on==YES) {
        btnIsOtherInsured.selected=YES;
    //    IsOtherInsuredToggleImg.frame=CGRectMake(IsOtherInsuredToggleImg.frame.origin.x+20, IsOtherInsuredToggleImg.frame.origin.y, IsOtherInsuredToggleImg.frame.size.width, IsOtherInsuredToggleImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=YES;
        Isotherinsured=@"1";
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
          //  btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
            DescImgView.hidden=NO;
            lblDescription.hidden=NO;
            lblDescTop.hidden=NO;
            txtVwDescription.hidden=NO;
            if (self.view.frame.size.width==320)
            {
                [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 560)];
            }
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
            
            
        //    btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
             lblDescTop.hidden=YES;
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
            
         //   btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
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
            
            
        //    btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
        }];

    }
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}
- (IBAction)SubmitClk:(id)sender
{
    if([self textFieldBlankorNot:txtproductName.text].length==0)
    {
        /*
        txtproductName.text=@"";
        txtproductName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Product Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    else if (lblProductType.text.length==0)
    {
        /*
        lblProductType.text=@"Choose Category";
        lblProductType.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Choose Category" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ((lblPurchaseDt.text.length==0 || [lblPurchaseDt.text isEqualToString:@"Purchase Date"]))
    {
        /*
        lblPurchaseDt.text=@"Purchase Date";
        lblPurchaseDt.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Choose Purchase Date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if([self textFieldBlankorNot:txtPurchaseValue.text].length==0)
    {
        /*
        txtPurchaseValue.text=@"";
        txtPurchaseValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Purchase Value" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Purchase Value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ([self textFieldBlankorNot:txtVwDescription.text].length==0 && btnIsOtherInsured.selected==YES)
    {
        /*
        lblDescription.text=@"";
        lblDescription.hidden=NO;
        lblDescription.text=@"Enter Description";
        lblDescription.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
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
                [PopDelegateFromAddProduct Popaction_methodFromAddProduct];
                [self.navigationController popViewControllerAnimated:YES];
              //  [self dismissViewControllerAnimated:YES completion:nil];
                
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
    
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)PurchaseDateClk:(id)sender
{
    [txtproductName resignFirstResponder];
    mainscroll.scrollEnabled=NO;
    [myview resignFirstResponder];
    if(self.view.frame.size.width>320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,50.0f) animated:YES];
        myview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [myview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:myview];
        
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        calendar.delegate = self;
        /*
         self.dateFormatter = [[NSDateFormatter alloc] init];
         [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
         self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
         
         self.disabledDates = @[
         //                [self.dateFormatter dateFromString:@"05/01/2013"],
         //                [self.dateFormatter dateFromString:@"06/01/2013"],
         //                [self.dateFormatter dateFromString:@"07/01/2013"]
         ];
         */
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        calendar.layer.cornerRadius=0.0f;
        calendar.backgroundColor=[UIColor whiteColor];

        calendar.frame = CGRectMake(40,150, myview.frame.size.width-80,myview.frame.size.height);
        [myview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 110, 30, 30);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
    }
    
    else if (self.view.frame.size.width==320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
        myview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [myview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:myview];
        
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        calendar.delegate = self;
        /*
         self.dateFormatter = [[NSDateFormatter alloc] init];
         [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
         self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
         
         self.disabledDates = @[
         //                [self.dateFormatter dateFromString:@"05/01/2013"],
         //                [self.dateFormatter dateFromString:@"06/01/2013"],
         //                [self.dateFormatter dateFromString:@"07/01/2013"]
         ];
         */
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        calendar.layer.cornerRadius=0.0f;
        calendar.backgroundColor=[UIColor whiteColor];
        calendar.frame = CGRectMake(20,120, myview.frame.size.width-40,myview.frame.size.height);
        [myview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 80, 30, 30);
        btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
        
        
        
        
    }
    if (self.view.frame.size.height==480)
    {
        [myview removeFromSuperview];
       
        myview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [myview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:myview];
        
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        calendar.delegate = self;
        /*
         self.dateFormatter = [[NSDateFormatter alloc] init];
         [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
         self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
         
         self.disabledDates = @[
         //                [self.dateFormatter dateFromString:@"05/01/2013"],
         //                [self.dateFormatter dateFromString:@"06/01/2013"],
         //                [self.dateFormatter dateFromString:@"07/01/2013"]
         ];
         */
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        calendar.layer.cornerRadius=0.0f;
        calendar.backgroundColor=[UIColor whiteColor];
        calendar.frame = CGRectMake(20,120, myview.frame.size.width-40,myview.frame.size.height);
        [myview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 80, 30, 30);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [myview addSubview:btnCross];
        
        
        
        
    }

}
-(void)CrossClick
{
    [myview removeFromSuperview];
    mainscroll.scrollEnabled=YES;
}
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    //  TODO: play with the coloring if we want to...
    
    //future date is disabled
    if ([self dateIsDisabled:date])
    {
        dateItem.backgroundColor = [UIColor whiteColor];
        dateItem.textColor = [UIColor lightGrayColor];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    //show priviously selected date
    if (lblPurchaseDt.text.length>0)
    {
        
        NSDate *selectedDate = [[NSDate alloc] init];
        selectedDate = [formatter dateFromString:lblPurchaseDt.text];
        
        NSComparisonResult result;
        result=[selectedDate compare:date];
        if (result==NSOrderedSame)
        {
             dateItem.backgroundColor = [UIColor lightGrayColor];
        }
        
        NSString *stringDate = [formatter stringFromDate:[NSDate date]];
        NSDate *dateFromString = [formatter dateFromString:stringDate];
        NSComparisonResult result1;
        result1=[dateFromString compare:date];
        
        if (result1==NSOrderedSame && result!=NSOrderedSame)
        {
            
            dateItem.backgroundColor = [UIColor clearColor];
        }
    }
   
    
   
    //   NSString *Current_date = [formatter stringFromDate:date];
    
    
    
    
    
}





- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
     mainscroll.scrollEnabled=YES;
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
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:date]];
    
  
        lblPurchaseDt.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        lblPurchaseDt.textColor=[UIColor blackColor];
        lblPurchaseDt.text=str;
  
    
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}
- (BOOL)dateIsDisabled:(NSDate *)date {
   
    NSDate *today = [NSDate date];
    NSComparisonResult result;
    result=[today compare:date];
        if (result==NSOrderedAscending) {
            return YES;
        }
    
    return NO;
}
- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date
{
    return ![self dateIsDisabled:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    
    NSDate *today = [NSDate date];
    NSComparisonResult result;
    result=[today compare:date];
    if (result==NSOrderedAscending) {
        return NO;
    }
    return YES;
}
@end
