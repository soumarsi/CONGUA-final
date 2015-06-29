//
//  EditPortfolioViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "EditPortfolioViewController.h"

@interface EditPortfolioViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation EditPortfolioViewController
@synthesize lblEndDate,lblInsureDetail,lblPortfolioType,lblStartDate,mainscroll,txtInsureName,txtPortfolioName,txtPostCode,txtValueCovered,txtvwAddress,txtvwInsureDetail,btnEndDate,btnHasInsure,btnPortfolioType,btnStartDate,lblAddress,HasInsureImg,btnSubmit,InsuranceView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
   
    mypicker.delegate=self;
    mypicker.dataSource=self;
    
    //myarr=[NSMutableArray arrayWithObjects:@"KOLKATA",@"MUMBAI",@"CHENNAI",@"DELHI",@"JAIPUR",nil];
    
    if(self.view.frame.size.width==320)
    {
        //  [self.mainscroll setContentSize:CGSizeMake(320.0f,480.0f)];
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 520)];
    }
    //[self.mainscroll setFrame:CGRectMake(0, 60, 320, 875)];
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        //_mainscroll.frame = CGRectMake(0,90,320,875);
        //[self.mainscroll setFrame:CGRectMake(0, 60, 320, 875)];
        [self.mainscroll setContentSize:CGSizeMake(320.0f,600.0f)];
        //   [_mainscroll setFrame:CGRectMake(0, 90,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        
    }
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtPortfolioName.leftView = paddingView1;
    txtPortfolioName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtPostCode.leftView = paddingView2;
    txtPostCode.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtInsureName.leftView = paddingView3;
    txtInsureName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtValueCovered.leftView = paddingView4;
    txtValueCovered.leftViewMode = UITextFieldViewModeAlways;
    
    txtInsureName.userInteractionEnabled=NO;
    txtvwInsureDetail.userInteractionEnabled=NO;
    self.btnStartDate.userInteractionEnabled=NO;
    self.btnEndDate.userInteractionEnabled=NO;
    txtValueCovered.userInteractionEnabled=NO;
    
    
    
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio code=%@",PortfolioCode);
    Isinsured=@"0";
    ArrPortDetail=[[NSMutableArray alloc]init];
    ArrInsureDetail=[[NSMutableArray alloc]init];
    
    txtPortfolioName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtPostCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtInsureName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtValueCovered.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblStartDate.textColor=[UIColor grayColor];
    lblEndDate.textColor=[UIColor grayColor];
    lblAddress.textColor=[UIColor grayColor];
    lblInsureDetail.textColor=[UIColor grayColor];
    lblPortfolioType.textColor=[UIColor grayColor];
    
    [self PortfolioViewUrl];
}

-(void)PortfolioViewUrl
{
    @try {
        
        
   //     [ArrPortDetail removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioInfoDetail/%@?CustomerCode=%@&PortfolioCode=%@",URL_LINK,AuthToken,CustomerCode,PortfolioCode];
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
                    txtPortfolioName.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioName"];
                    lblAddress.hidden=YES;
                    txtvwAddress.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Address1"];
                    txtPostCode.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PostCode"]];
                    
                    lblPortfolioType.textColor=[UIColor blackColor];
                    if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
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
                    
                    IsPriviouslyInsured=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"IsInsured"]];
                    if ([IsPriviouslyInsured isEqualToString:@"0"])
                    {
                        btnHasInsure.selected=NO;
                        Isinsured=@"0";
                        
                        //insurance view hide
                        
                        btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
                        InsuranceView.hidden=YES;
                    }
                    else
                    {
                        btnHasInsure.selected=YES;
                        Isinsured=@"1";
                        btnHasInsure.userInteractionEnabled=NO;
                        HasInsureImg.frame=CGRectMake(HasInsureImg.frame.origin.x+20, HasInsureImg.frame.origin.y, HasInsureImg.frame.size.width, HasInsureImg.frame.size.height);
                        txtInsureName.userInteractionEnabled=YES;
                        txtvwInsureDetail.userInteractionEnabled=YES;
                        btnStartDate.userInteractionEnabled=YES;
                        btnEndDate.userInteractionEnabled=YES;
                        txtValueCovered.userInteractionEnabled=YES;
                        
                        //insurance view show
                        
                        btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+InsuranceView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
                        InsuranceView.hidden=NO;
                        
                        [self InsuranceViewUrl];
                        
                       
                        
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


-(void)InsuranceViewUrl
{
    @try {
        
        
      //  [ArrInsureDetail removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioInsuranceInfo/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result1, NSError *error,BOOL completed) {
                
                if ([[result1 valueForKey:@"IsSuccess"] integerValue]==1)
                {
 
                  /*   for ( NSDictionary *tempDict1 in  [result1 objectForKey:@"ResultInfo"])
                     {
                     [ArrInsureDetail addObject:tempDict1];
                     
                     }*/
                    txtInsureName.text=[[result1 objectForKey:@"ResultInfo"] valueForKey:@"InsuranceName"];
 txtvwInsureDetail.text=[[result1 objectForKey:@"ResultInfo"] valueForKey:@"InsuranceDetail"];
                    lblInsureDetail.hidden=YES;
                    lblStartDate.textColor=[UIColor blackColor];
                    lblEndDate.textColor=[UIColor blackColor];
                    lblStartDate.text=[[result1 objectForKey:@"ResultInfo"] valueForKey:@"StartDate"];
                    lblEndDate.text=[[result1 objectForKey:@"ResultInfo"] valueForKey:@"EndDate"];
                    txtValueCovered.text=[NSString stringWithFormat:@"%@",[[result1 objectForKey:@"ResultInfo"] valueForKey:@"ValueCovered"]];
                   
                }
                else if ([[result1 valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
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
    //UITextField *yourTextField;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if(textField==txtInsureName)
    {
        [myview removeFromSuperview];
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            //  [self.mainscroll setContentOffset:CGPointMake(0.0f, 100.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 100.0f) animated:YES];
        }
    }
    
    if(textField==txtValueCovered)
    {
        [myview removeFromSuperview];
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 150.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 200.0f) animated:YES];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField==txtValueCovered)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        }
    }
    
    if(textField==txtInsureName)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        }
    }
    
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [myview removeFromSuperview];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==txtvwInsureDetail)
    {
        lblInsureDetail.hidden=YES;
        [self.mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
    }
    // _addrlbl.hidden=YES;
    if(textView==txtvwAddress)
    {
        lblAddress.hidden=YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==txtvwInsureDetail)
        {
            if ([UIScreen mainScreen].bounds.size.width>320)
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            }
            else
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            }
            if (txtvwInsureDetail.text.length==0)
            {
                lblInsureDetail.hidden=NO;
            }
        }
        if(textView==txtvwAddress)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            if (txtvwAddress.text.length==0)
            {
                lblAddress.hidden=NO;
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

- (IBAction)PortfolioTypeClk:(id)sender
{
    ArrPortDetail=[NSMutableArray arrayWithObjects:@"Home",@"Business",@"Personal",@"Other",nil];
    //  myarr=[NSMutableArray arrayWithObjects:@"KOLKATA",@"MUMBAI",@"CHENNAI",@"DELHI",@"JAIPUR",nil];
    
    /*
    if(self.view.frame.size.width==414)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,0,(self.view.frame.size.width),(self.view.frame.size.height))];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.7]];
        [self.view addSubview:myview];
        mypicker = [[UIPickerView alloc] initWithFrame:CGRectMake(40, 210, 330, 320)];
        [mypicker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [myview addSubview:mypicker];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10,175,100,35)];
        //btn.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(275,175,100,35)];
        //btn1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn1.backgroundColor=[UIColor clearColor];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        //[btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn1];
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(self.view.frame.size.width==375)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,0,(self.view.frame.size.width),(self.view.frame.size.height))];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.7]];
        [self.view addSubview:myview];
        mypicker = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 210, 280, 280)];
        [mypicker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [myview addSubview:mypicker];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(250,175,100,35)];
        //btn.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle: @"Save" forState: UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(25,175,100,35)];
        //btn1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn1.backgroundColor=[UIColor clearColor];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitle: @"Cancel" forState: UIControlStateNormal];
        //[btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn1];
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(self.view.frame.size.width==320)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,0,(self.view.frame.size.width),(self.view.frame.size.height))];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.7]];
        [self.view addSubview:myview];
        mypicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 175, 260, 220)];
        [mypicker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [myview addSubview:mypicker];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(215,140,100,35)];
        //btn.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle: @"Save" forState: UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(8,140,100,35)];
        //btn1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn1.backgroundColor=[UIColor clearColor];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitle: @"Cancel" forState: UIControlStateNormal];
        //btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn1];
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
*/
    
    
    [txtPostCode resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
        
        if (btnHasInsure.selected==NO) {
            //  [self.mainscroll setContentOffset:CGPointMake(0.0f,20.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,350,375,237)];
        }
        else if (btnHasInsure.selected==YES)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,210.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,540,375,237)];
        }
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,200,187,35)];
        btn.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,200,187,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        mypicker =[[UIPickerView alloc]initWithFrame:CGRectMake(0,20,375,10)];
        [myview addSubview:mypicker];
        [mainscroll addSubview:myview];
        
        [mypicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        if (btnHasInsure.selected==NO) {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,20.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,265,320,237)];
        }
        else if (btnHasInsure.selected==YES)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,220.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,479,320,237)];
        }
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,200,160,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(160,200,160,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        
        mypicker =[[UIPickerView alloc]initWithFrame:CGRectMake(35,10,250,10)];
        [myview addSubview:mypicker];
        [mainscroll addSubview:myview];
        
        [mypicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,414,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,207,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(207,235,207,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        mypicker =[[UIPickerView alloc]initWithFrame:CGRectMake(0,20,414,10)];
        [myview addSubview:mypicker];
        [mainscroll addSubview:myview];
        
        [mypicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)HasInsureClk:(id)sender
{
    if (btnHasInsure.selected==NO) {
        btnHasInsure.selected=YES;
        Isinsured=@"1";
        HasInsureImg.frame=CGRectMake(HasInsureImg.frame.origin.x+20, HasInsureImg.frame.origin.y, HasInsureImg.frame.size.width, HasInsureImg.frame.size.height);
        txtInsureName.userInteractionEnabled=YES;
        txtvwInsureDetail.userInteractionEnabled=YES;
        btnStartDate.userInteractionEnabled=YES;
        btnEndDate.userInteractionEnabled=YES;
        txtValueCovered.userInteractionEnabled=YES;
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+InsuranceView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
            InsuranceView.hidden=NO;
        }];

    }
    else if (btnHasInsure.selected==YES) {
        btnHasInsure.selected=NO;
        Isinsured=@"0";
        HasInsureImg.frame=CGRectMake(HasInsureImg.frame.origin.x-20, HasInsureImg.frame.origin.y, HasInsureImg.frame.size.width, HasInsureImg.frame.size.height);
        txtInsureName.userInteractionEnabled=NO;
        txtvwInsureDetail.userInteractionEnabled=NO;
        btnStartDate.userInteractionEnabled=NO;
        btnEndDate.userInteractionEnabled=NO;
        txtValueCovered.userInteractionEnabled=NO;
        
        // hide insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            
            btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            InsuranceView.hidden=YES;
        }];
    }
}

- (IBAction)StartDateClk:(id)sender
{
    [txtvwInsureDetail resignFirstResponder];
    [txtInsureName resignFirstResponder];
    [txtPortfolioName resignFirstResponder];
    [txtPostCode resignFirstResponder];
    [txtvwAddress resignFirstResponder];
    [txtvwInsureDetail resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,280.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,540,375,340)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,187,35)];
        btn.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,235,187,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,375,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,300.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,500,320,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,160,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(160,235,160,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,414,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,207,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(207,235,207,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (IBAction)EndDateClk:(id)sender
{
    [txtvwInsureDetail resignFirstResponder];
    [txtInsureName resignFirstResponder];
    [txtPortfolioName resignFirstResponder];
    [txtPostCode resignFirstResponder];
    [txtvwAddress resignFirstResponder];
    [txtvwInsureDetail resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,280.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,540,375,340)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,187,35)];
        btn.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(187,235,187,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,375,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle1:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo1:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,300.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,500,320,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,160,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(160,235,160,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        
        
        
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle1:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo1:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross1:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,414,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,235,207,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(207,235,207,35)];
        btn1.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        [myview addSubview:btn1];
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        
        NSDate *currDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"ddMMyyyy"];
        //    NSString *dateString = [dateFormatter stringFromDate:currDate];
        //    NSLog(@"%@",dateString);
        
        [picker setMinimumDate:currDate];
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle1:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo1:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttoncross1:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //NSLog(@"ok");
    return [ArrPortDetail count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //NSLog(@"ok");
    return [ArrPortDetail objectAtIndex:row];
}

-(void)buttonInfo:(id)sender
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
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    lblStartDate.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblStartDate.textColor=[UIColor blackColor];
    lblStartDate.text=str;
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}
-(void)buttonInfo1:(id)sender
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
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    lblEndDate.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblEndDate.textColor=[UIColor blackColor];
    lblEndDate.text=str;
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}

-(void)buttonInfo2:(id)sender
{
    NSUInteger num = [[mypicker dataSource] numberOfComponentsInPickerView:mypicker];
    //NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [mypicker selectedRowInComponent:i];
        NSString *ww = [[mypicker delegate] pickerView:mypicker titleForRow:selectRow forComponent:i];
        
        lblPortfolioType.text=ww;
        lblPortfolioType.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        lblPortfolioType.textColor=[UIColor blackColor];
    }
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
    [myview removeFromSuperview];
    
}

-(void)buttonInfo3:(id)sender
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
    
    self.navigationItem.rightBarButtonItem=nil;
    //  _ptypelbl.text=@"Portfolio Type";
    lblPortfolioType.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    //   _ptypelbl.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
    [myview removeFromSuperview];
    
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
    lblStartDate.text=@"Start Date";
    lblStartDate.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblStartDate.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}
-(void)buttoncross1:(id)sender
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
    lblEndDate.text=@"End Date";
    lblEndDate.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lblEndDate.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    lblStartDate.font = [UIFont fontWithName:@"Helvetica Neue Light" size:14];
    lblStartDate.textColor=[UIColor blackColor];
    lblStartDate.text=str;
    
    
    //[picker removeFromSuperview];
}
-(void)LabelTitle1:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    lblEndDate.font = [UIFont fontWithName:@"Helvetica Neue Light" size:14];
    lblEndDate.textColor=[UIColor blackColor];
    lblEndDate.text=str;
    
    //[picker removeFromSuperview];
}

- (IBAction)SubmitClk:(id)sender
{
    if ([lblPortfolioType.text isEqualToString:@"Home"])
    {
        portType=@"1";
    }
    else if ([lblPortfolioType.text isEqualToString:@"Business"])
    {
        portType=@"2";
    }
    else if ([lblPortfolioType.text isEqualToString:@"Personal"])
    {
        portType=@"3";
    }
    else if ([lblPortfolioType.text isEqualToString:@"Other"])
    {
        portType=@"4";
    }
    if(txtPortfolioName.text.length==0)
    {
        txtPortfolioName.text=@"";
        txtPortfolioName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (txtvwAddress.text.length==0)
    {
        txtvwAddress.text=@"";
        lblAddress.hidden=NO;
        lblAddress.text=@"Enter Address";
        lblAddress.textColor=[UIColor redColor];
    }
    
    else if (txtPostCode.text.length==0)
    {
        txtPostCode.text=@"";
        txtPostCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Postal Code" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,160) animated:YES];
    }
    else if (lblPortfolioType.text.length==0 || [lblPortfolioType.text isEqualToString:@"Portfolio Type"])
    {
        lblPortfolioType.text=@"Portfolio Type";
        lblPortfolioType.textColor=[UIColor redColor];
    }
    else if(txtInsureName.text.length==0 && btnHasInsure.selected==YES)
    {
        txtInsureName.text=@"";
        txtInsureName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (txtvwInsureDetail.text.length==0 && btnHasInsure.selected==YES)
    {
        txtvwInsureDetail.text=@"";
        lblInsureDetail.hidden=NO;
        lblInsureDetail.text=@"Enter Details";
        lblInsureDetail.textColor=[UIColor redColor];
    }
    else if ((lblStartDate.text.length==0 || [lblStartDate.text isEqualToString:@"Start Date"]) && btnHasInsure.selected==YES)
    {
        lblStartDate.text=@"Start Date";
        lblStartDate.textColor=[UIColor redColor];
    }
    else if ((lblEndDate.text.length==0 || [lblEndDate.text isEqualToString:@"End Date"]) && btnHasInsure.selected==YES)
    {
        lblEndDate.text=@"End Date";
        lblEndDate.textColor=[UIColor redColor];
    }
    else
    {
        NSComparisonResult result;
        if(btnHasInsure.selected==YES)
        {
            NSDateFormatter *dt = [[NSDateFormatter alloc] init];
            [dt setDateFormat:@"dd-MM-yyyy"];
            NSDate *startDate = [dt dateFromString:lblStartDate.text];
            NSDate *endDate = [dt dateFromString:lblEndDate.text];
            
            
            result = [startDate compare:endDate];
        }
        
        if(result==NSOrderedDescending && btnHasInsure.selected==YES)
        {
            
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"End date can't be less than Start date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
            
            
        }
        else if(result == NSOrderedSame && btnHasInsure.selected==YES)
        {
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"End date can't be same as Start date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
            
            
        }
        else if (txtValueCovered.text.length==0 && btnHasInsure.selected==YES)
        {
            txtValueCovered.text=@"";
            txtValueCovered.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            //  [Main_acroll setContentOffset:CGPointMake(0,160) animated:YES];
        }
        else
        {
            [self EditPortfolioUrl];
            //    [self AddInsuranceUrl];
        }
    }
    

}
-(void)EditPortfolioUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:PortfolioCode, @"PortfolioCode",txtPortfolioName.text, @"PortfolioName",txtvwAddress.text,@"Address1",@"",@"Address2",txtPostCode.text, @"PostCode",Isinsured, @"IsInsured",portType,@"PortfolioTypeCode",  nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UpdatePortfolio/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode]; //api done
    
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
                    [self UpdateInsuranceUrl];
                }
                else
                {
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Portfolio Updated Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //   login * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    //   [self.navigationController  pushViewController:vc animated:YES];
                    [aler show];
                    
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

-(void)UpdateInsuranceUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:txtInsureName.text, @"InsuranceName",txtvwInsureDetail.text, @"InsuranceDetail",lblStartDate.text,@"StartDate",lblEndDate.text,@"EndDate",txtValueCovered.text, @"ValueCovered",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring;
    if ([IsPriviouslyInsured isEqualToString:@"1"])
    {
         loginstring = [NSString stringWithFormat:@"%@UpdatePortfolioInsurance/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
    }
   else if ([IsPriviouslyInsured isEqualToString:@"0"])
   {
       loginstring = [NSString stringWithFormat:@"%@InsertPortfolioInsurance/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
   }
    
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
                
                [[NSUserDefaults standardUserDefaults] setObject:[result valueForKey:@"ResultInfo"] forKey:@"CustomerCode"];
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Portfolio Updated Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
