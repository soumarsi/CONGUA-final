//
//  EditProductViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "EditProductViewController.h"
#import "UrlconnectionObject.h"
#import "login.h"
#import "countryViewController.h"

@interface EditProductViewController ()<UITextFieldDelegate,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CKCalendarDelegate,UIAlertViewDelegate,countryDelegate>

@end

@implementation EditProductViewController
@synthesize lblDescription,lblProductType,lblPurchaseDt,txtProductNmae,txtPurchaseValue,txtVwDescription,btnIsInsured,btnIsOtherInsure,btnProductType,btnPurchaseDt,mainscroll,CategoryCode,IsInsureImg,IsOtherInsureImg,btnSubmit,DescImgView,InsuredPortSwitch,OtherInsuredSwitch,lblDescTop,btnDelete;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainscroll.hidden=YES;
    if(self.view.frame.size.width==320)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 560)];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
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
    txtProductNmae.leftView = paddingView;
    txtProductNmae.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtPurchaseValue.leftView = paddingView1;
    txtPurchaseValue.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    

 //   ArrProductType=[[NSMutableArray alloc]initWithObjects:@"1",nil];
    ArrCategory=[[NSMutableArray alloc]init];
   
    ArrProductDetail=[[NSMutableArray alloc]init];
  
    /*
    txtProductNmae.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
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
    
    [[btnProductType layer] setBorderWidth:0.5f];
    [btnProductType.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    btnProductType.layer.cornerRadius=5.0;
    
    [self CategoryShowUrl];
    

}
-(void)resetView1
{
    [txtPurchaseValue resignFirstResponder];
    [mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
}

-(void)ProductViewUrl
{
    @try {
        
        
        //     [ArrPortDetail removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetProductInfoDetail/%@?CustomerCode=%@&ProductCode=%@",URL_LINK,AuthToken,CustomerCode,ProductCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                   
                    txtProductNmae.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductName"]];
                   
                //    lblProductType.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductTypeCode"]];
                    lblPurchaseDt.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PurchaseDate"]];
                    txtPurchaseValue.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PurchaseValue"]];
                    
                     CategoryCode=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"CategoryCode"]];
                    
                    PortfolioCode=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioCode"]];
                    
                    lblPurchaseDt.textColor=[UIColor blackColor];
                    lblProductType.textColor=[UIColor blackColor];
                    
                /*    if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
                        lblPortfolioType.text=@"Home";
                        
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==2) {
                        lblPortfolioType.text=@"Business";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==3) {
                        lblPortfolioType.text=@"Personal";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==4) {
                        lblPortfolioType.text=@"Other";
                    }
               */
                    Isinsured=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"IsInsuredWithPortfolio"]];
                    if ([Isinsured isEqualToString:@"0"])
                    {
                        btnIsInsured.selected=NO;
                        InsuredPortSwitch.on=NO;
                       // Isinsured=@"0";
                    }
                    else
                    {
                        btnIsInsured.selected=YES;
                        InsuredPortSwitch.on=YES;
                     //   Isinsured=@"1";
                     //   btnIsInsured.userInteractionEnabled=NO;
                    //    IsInsureImg.frame=CGRectMake(IsInsureImg.frame.origin.x+20, IsInsureImg.frame.origin.y, IsInsureImg.frame.size.width, IsInsureImg.frame.size.height);
                       
                        
                    }
                    
                    Isotherinsured=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"IsOtherInsured"]];
                    if ([Isotherinsured isEqualToString:@"0"])
                    {
                        btnIsOtherInsure.selected=NO;
                        // Isinsured=@"0";
                        txtVwDescription.userInteractionEnabled=NO;
                        OtherInsuredSwitch.on=NO;
                        
                        // hide desc
                        
                        btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
                        btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, DescImgView.frame.origin.y+10, btnDelete.frame.size.width, btnDelete.frame.size.height);
                        
                        DescImgView.hidden=YES;
                        lblDescription.hidden=YES;
                        txtVwDescription.hidden=YES;
                        lblDescTop.hidden=YES;
                    }
                    else
                    {
                        btnIsOtherInsure.selected=YES;
                        //   Isinsured=@"1";
                      //  btnIsInsured.userInteractionEnabled=NO;
                        IsOtherInsureImg.frame=CGRectMake(IsOtherInsureImg.frame.origin.x+20, IsOtherInsureImg.frame.origin.y, IsOtherInsureImg.frame.size.width, IsOtherInsureImg.frame.size.height);
                        OtherInsuredSwitch.on=YES;
                        //show desc
                        
                        btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
                        btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnDelete.frame.size.width, btnDelete.frame.size.height);
                        
                        
                        DescImgView.hidden=NO;
                        lblDescription.hidden=YES;
                        txtVwDescription.hidden=NO;
                        lblDescTop.hidden=NO;
                    }

                    txtVwDescription.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"]];
                    if (txtVwDescription.text.length==0)
                    {
                      //  lblDescription.hidden=NO;
                    }
                    else{
                     //   lblDescription.hidden=YES;
                    }
                    
                    //category
                    for (int i=0; i<[ArrCategory count]; i++)
                    {
                       //  NSLog(@"category=%@",[[ArrCategory objectAtIndex:i] valueForKey:@"CategoryCode"]);
                      //   NSLog(@"category code=%@",CategoryCode);
                        if ([CategoryCode isEqualToString:[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:i] valueForKey:@"CategoryCode"]]]) {
                           
                            lblProductType.text=[[ArrCategory objectAtIndex:i] valueForKey:@"CategoryName"];
                            break;
                        }
                    }
                    mainscroll.hidden=NO;
                    
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
                    
                   [self ProductViewUrl];
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if (self.view.frame.size.height==480)
    {
        if(textField==txtPurchaseValue)
        {
            lblDescription.hidden=YES;
            [mainscroll setContentOffset:CGPointMake(0.0f,130.0f) animated:YES];
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
            [mainscroll setContentOffset:CGPointMake(0.0f,280.0f) animated:YES];
        }
    }
    else
    {
    if(textView==txtVwDescription)
    {
        lblDescription.hidden=YES;
        [mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
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


-(void)countryViewcontrollerDismissedwithCategoryName:(NSString *)categoryyName categoryCode:(NSString *)categoryCode
{


    lblProductType.text=categoryyName;
    
    CategoryCode=categoryCode;

}



- (IBAction)ProductTypeClk:(id)sender
{
    [txtProductNmae resignFirstResponder];
    
    
    countryViewController *countryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"country"];
    
    countryVC.myDelegate=self;
    
    countryVC.ArrCategory=ArrCategory;
    
    [self presentViewController:countryVC animated:YES completion:^{
        
        
        
        countryVC.headerLbl1.text=@"Product";
        countryVC.headerLbl2.text=@"category";
        
        
        
    }];
    
    
    /*
    if (btnProductType.selected==NO)
    {
        btnProductType.selected=YES;
        //  [mainscroll setContentOffset:CGPointMake(0,20) animated:YES];
        if (btnIsOtherInsure.selected==YES)
        {
            
            if (self.view.frame.size.width==320)
            {
                [mainscroll setContentOffset:CGPointMake(0,70) animated:YES];
            }
            else
            {
                [mainscroll setContentOffset:CGPointMake(0,40) animated:YES];
            }
        }
        else
        {
            [mainscroll setContentOffset:CGPointMake(0,20) animated:YES];
        }
        [Producttypeview removeFromSuperview];
        
        
    //    Producttypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, btnSubmit.frame.origin.y+btnSubmit.frame.size.height+10, self.view.frame.size.width,200)];
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
        btnProductType.selected=NO;
        [Producttypeview removeFromSuperview];
        
    }*/
    
}

- (IBAction)PurchaseDtClk:(id)sender
{
    [txtProductNmae resignFirstResponder];
    mainscroll.scrollEnabled=NO;
    [PurchaseDateview resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,50.0f) animated:YES];
        PurchaseDateview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [PurchaseDateview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:PurchaseDateview];
        
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
        calendar.frame = CGRectMake(40,150, PurchaseDateview.frame.size.width-80,PurchaseDateview.frame.size.height);
        [PurchaseDateview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 110, 30, 30);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [PurchaseDateview addSubview:btnCross];
    }
    
    else if (self.view.frame.size.width==320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
        PurchaseDateview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [PurchaseDateview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:PurchaseDateview];

        
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
        calendar.frame = CGRectMake(20,110, PurchaseDateview.frame.size.width-40,PurchaseDateview.frame.size.height);
        [PurchaseDateview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 80, 30, 30);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [PurchaseDateview addSubview:btnCross];
        
        
        
        
    }
    if (self.view.frame.size.height==480)
    {
        [PurchaseDateview removeFromSuperview];
        PurchaseDateview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [PurchaseDateview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:PurchaseDateview];

        
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
        
        calendar.frame = CGRectMake(20,110, PurchaseDateview.frame.size.width-40,PurchaseDateview.frame.size.height);
        calendar.layer.cornerRadius=0.0f;
        calendar.backgroundColor=[UIColor whiteColor];
        [PurchaseDateview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 80, 30, 30);
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [PurchaseDateview addSubview:btnCross];
        
        
        
        
    }
}
-(void)CrossClick
{
    [PurchaseDateview removeFromSuperview];
    mainscroll.scrollEnabled=YES;
}
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    //  TODO: play with the coloring if we want to...
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
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
    [PurchaseDateview removeFromSuperview];
    
}



- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    
    return YES;
}
-(void)producttypepickerCancel
{
    btnProductType.selected=NO;
    [Producttypeview removeFromSuperview];
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
-(void)producttypepickerChange
{
    
    if (ProductType.length==0) {
        
       // lblProductType.text=[ArrProductType objectAtIndex:0];
        lblProductType.text=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryName"];
        CategoryCode=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryCode"];
    }
    else
    {
        lblProductType.text=ProductType;
    }
    lblProductType.textColor=[UIColor blackColor];
    ProductType=@"";
    btnProductType.selected=NO;
    [Producttypeview removeFromSuperview];
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
-(IBAction)InsuredPortSwitched:(id)sender{
    NSLog(@"Switch current state %@", InsuredPortSwitch.on ? @"On" : @"Off");
    if (InsuredPortSwitch.on==YES) {
        btnIsInsured.selected=YES;
      //  IsInsureImg.frame=CGRectMake(IsInsureImg.frame.origin.x+20, IsInsureImg.frame.origin.y, IsInsureImg.frame.size.width, IsInsureImg.frame.size.height);
        Isinsured=@"1";
    }
    else if (InsuredPortSwitch.on==NO) {
        btnIsInsured.selected=NO;
     //   IsInsureImg.frame=CGRectMake(IsInsureImg.frame.origin.x-20, IsInsureImg.frame.origin.y, IsInsureImg.frame.size.width, IsInsureImg.frame.size.height);
        Isinsured=@"0";
    }
}
- (IBAction)IsInsuredPortClk:(id)sender
{
    if (btnIsInsured.selected==NO) {
        btnIsInsured.selected=YES;
        IsInsureImg.frame=CGRectMake(IsInsureImg.frame.origin.x+20, IsInsureImg.frame.origin.y, IsInsureImg.frame.size.width, IsInsureImg.frame.size.height);
        Isinsured=@"1";
    }
    else if (btnIsInsured.selected==YES) {
        btnIsInsured.selected=NO;
        IsInsureImg.frame=CGRectMake(IsInsureImg.frame.origin.x-20, IsInsureImg.frame.origin.y, IsInsureImg.frame.size.width, IsInsureImg.frame.size.height);
        Isinsured=@"0";
    }
}
-(IBAction)OtherInsuredSwitched:(id)sender{
    NSLog(@"Switch current state %@", OtherInsuredSwitch.on ? @"On" : @"Off");
    if (OtherInsuredSwitch.on==YES) {
        btnIsOtherInsure.selected=YES;
      //  IsOtherInsureImg.frame=CGRectMake(IsOtherInsureImg.frame.origin.x+20, IsOtherInsureImg.frame.origin.y, IsOtherInsureImg.frame.size.width, IsOtherInsureImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=YES;
        Isotherinsured=@"1";
        
        // show desc
        [UIView animateWithDuration:0.5 animations:^{
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnDelete.frame.size.width, btnDelete.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            DescImgView.hidden=NO;
            lblDescription.hidden=NO;
            txtVwDescription.hidden=NO;
            lblDescTop.hidden=NO;
        }];
    }
    else if (OtherInsuredSwitch.on==NO) {
        btnIsOtherInsure.selected=NO;
     //   IsOtherInsureImg.frame=CGRectMake(IsOtherInsureImg.frame.origin.x-20, IsOtherInsureImg.frame.origin.y, IsOtherInsureImg.frame.size.width, IsOtherInsureImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=NO;
        Isotherinsured=@"0";
        txtVwDescription.text=@"";
        [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        //   lblDescription.hidden=NO;
        //  lblDescription.textColor=[UIColor blackColor];
        
        // hide desc
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, DescImgView.frame.origin.y+10, btnDelete.frame.size.width, btnDelete.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
            lblDescTop.hidden=YES;
        }];
    }
}
- (IBAction)IsOtherInsureClk:(id)sender
{
    /*
    if (btnIsOtherInsure.selected==NO)
    {
        btnIsOtherInsure.selected=YES;
        IsOtherInsureImg.frame=CGRectMake(IsOtherInsureImg.frame.origin.x+20, IsOtherInsureImg.frame.origin.y, IsOtherInsureImg.frame.size.width, IsOtherInsureImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=YES;
        Isotherinsured=@"1";
        
        // show desc
        [UIView animateWithDuration:0.5 animations:^{
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+DescImgView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, btnSubmit.frame.origin.y+btnSubmit.frame.size.height+10, btnDelete.frame.size.width, btnDelete.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            DescImgView.hidden=NO;
            lblDescription.hidden=NO;
            txtVwDescription.hidden=NO;
            lblDescTop.hidden=NO;
        }];

    }
    else if (btnIsOtherInsure.selected==YES) {
        btnIsOtherInsure.selected=NO;
        IsOtherInsureImg.frame=CGRectMake(IsOtherInsureImg.frame.origin.x-20, IsOtherInsureImg.frame.origin.y, IsOtherInsureImg.frame.size.width, IsOtherInsureImg.frame.size.height);
        txtVwDescription.userInteractionEnabled=NO;
        Isotherinsured=@"0";
        txtVwDescription.text=@"";
        [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
     //   lblDescription.hidden=NO;
      //  lblDescription.textColor=[UIColor blackColor];
        
        // hide desc
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DescImgView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            btnDelete.frame=CGRectMake(btnDelete.frame.origin.x, btnSubmit.frame.origin.y+btnSubmit.frame.size.height+10, btnDelete.frame.size.width, btnDelete.frame.size.height);
            DescImgView.hidden=YES;
            lblDescription.hidden=YES;
            txtVwDescription.hidden=YES;
            lblDescTop.hidden=YES;
        }];
        

    }
     */
}

- (IBAction)SubmitClk:(id)sender
{
    if(txtProductNmae.text.length==0)
    {
        /*
        txtProductNmae.text=@"";
        txtProductNmae.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Product Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Product Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    else if (lblProductType.text.length==0 || [lblProductType.text isEqualToString:@"Product Type"])
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
    else if(txtPurchaseValue.text.length==0)
    {
        /*
        txtPurchaseValue.text=@"";
        txtPurchaseValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Purchase Value" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Purchase Value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if (txtVwDescription.text.length==0 && btnIsOtherInsure.selected==YES)
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
        
        [self EditProductUrl];
        
    }

}
-(void)EditProductUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:ProductCode,@"ProductCode",txtProductNmae.text, @"ProductName",@"1", @"ProductTypeCode",CategoryCode,@"CategoryCode",PortfolioCode,@"PortfolioCode", lblPurchaseDt.text, @"PurchaseDate",txtPurchaseValue.text,@"PurchaseValue",Isinsured,@"IsInsuredWithPortfolio",Isotherinsured,@"IsOtherInsured",txtVwDescription.text,@"Description",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UpdateProduct/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
    
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
                if ([Isinsured isEqualToString:@"1"])
                {
                    //  portfoliocode=[result valueForKey:@"ResultInfo"];
                    //   NSLog(@"port code=%@",portfoliocode);
                    
                }
                else
                {
                    
                    
                }
             //   UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Product Updated Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
              
             //   [aler show];
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

- (IBAction)DeleteClick:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do you want to Delete This Product?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else
    {
        [self DeleteProductUrl];
        
        
    }
    
    
}
-(void)DeleteProductUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeleteProduct/%@?CustomerCode=%@&ProductCode=%@",URL_LINK,AuthToken,CustomerCode,ProductCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                NSLog(@"array=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /* UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [aler show];
                     */
                   // [self.navigationController popViewControllerAnimated: YES];
                    ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"viewcontroller"];
                    // obj.taskid=[[arrtask objectAtIndex:indexPath.row] valueForKey:@"id"];
                    [self.navigationController pushViewController:obj animated:YES];
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

@end
