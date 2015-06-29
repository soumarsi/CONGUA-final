//
//  ViewController.m
//  Congua
//
//  Created by Saptarshi's iMAC on 26/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "AddPortfolioViewController.h"

@interface AddPortfolioViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIDatePicker* picker;
    UIBarButtonItem* rightBtn;
    UIView *myview;
    NSArray *myarr;
    UIPickerView *mypicker;
    
}
- (IBAction)HasInsureClk:(id)sender;

@end

@implementation AddPortfolioViewController
@synthesize lbladdress,lblinsureDetail,btnhasInsure,toggleimg,btnenddate,btnstartdate,InsuranceView,btnSubmit;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.portnmtxt.delegate=self;
    self.pcodetxt.delegate=self;
    self.inametxt.delegate=self;
    self.vcovertxt.delegate=self;
    self.idetail.delegate=self;
    self.addrtxt.delegate=self;
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
    self.portnmtxt.leftView = paddingView1;
    self.portnmtxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    self.pcodetxt.leftView = paddingView2;
    self.pcodetxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    self.inametxt.leftView = paddingView3;
    self.inametxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    self.vcovertxt.leftView = paddingView4;
    self.vcovertxt.leftViewMode = UITextFieldViewModeAlways;
    
    self.inametxt.userInteractionEnabled=NO;
    self.idetail.userInteractionEnabled=NO;
    self.btnstartdate.userInteractionEnabled=NO;
    self.btnenddate.userInteractionEnabled=NO;
    self.vcovertxt.userInteractionEnabled=NO;
    
    
    
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    Isinsured=@"0";
    
    
    self.portnmtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.inametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.vcovertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.startdatelbl.textColor=[UIColor grayColor];
     self.enddatelbl.textColor=[UIColor grayColor];
     self.lbladdress.textColor=[UIColor grayColor];
     self.lblinsureDetail.textColor=[UIColor grayColor];
     self.ptypelbl.textColor=[UIColor grayColor];
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
  //  _mainscroll.frame = CGRectMake(0,88,self.view.frame.size.width,787);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //UITextField *yourTextField;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if(textField==self.inametxt)
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
     
    if(textField==self.vcovertxt)
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
    
    if(textField==self.vcovertxt)
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
   
    if(textField==self.inametxt)
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
    if(textView==self.idetail)
    {
        lblinsureDetail.hidden=YES;
        [self.mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
    }
    // _addrlbl.hidden=YES;
    if(textView==self.addrtxt)
    {
        lbladdress.hidden=YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==self.idetail)
        {
            if ([UIScreen mainScreen].bounds.size.width>320)
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            }
            else
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            }
            if (self.idetail.text.length==0)
            {
                lblinsureDetail.hidden=NO;
            }
        }
        if(textView==self.addrtxt)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            if (self.addrtxt.text.length==0)
            {
                lbladdress.hidden=NO;
            }
        }
        
    }
    return YES;
}

- (IBAction)startdate:(id)sender
{
    [self.idetail resignFirstResponder];
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
        [_mainscroll addSubview:myview];
        
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
        [_mainscroll addSubview:myview];
        
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
        [_mainscroll addSubview:myview];
        
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

- (IBAction)enddate:(id)sender
{
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
        [_mainscroll addSubview:myview];
        
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
        [_mainscroll addSubview:myview];
        
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
        [_mainscroll addSubview:myview];
        
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

- (IBAction)dropdown:(id)sender
{
    
    myarr=[NSMutableArray arrayWithObjects:@"KOLKATA",@"MUMBAI",@"CHENNAI",@"DELHI",@"JAIPUR",nil];
    
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
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(20,175,100,35)];
    //btn.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle: @"OK" forState: UIControlStateNormal];
    //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myview addSubview:btn];
    
 UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(240,175,100,35)];
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
    else if(self.view.frame.size.width==320)
    {
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,0,(self.view.frame.size.width),(self.view.frame.size.height))];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.7]];
        [self.view addSubview:myview];
        mypicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 175, 260, 220)];
        [mypicker setBackgroundColor: [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [myview addSubview:mypicker];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(3,140,100,35)];
        //btn.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(200,140,100,35)];
        //btn1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.1];
        btn1.backgroundColor=[UIColor clearColor];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitle: @"CANCEL" forState: UIControlStateNormal];
        //btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn1];
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
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
    return [myarr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //NSLog(@"ok");
    return [myarr objectAtIndex:row];
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
    _startdatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _startdatelbl.textColor=[UIColor blackColor];
    _startdatelbl.text=str;
    
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
    _enddatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _enddatelbl.textColor=[UIColor blackColor];
    _enddatelbl.text=str;
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

    _ptypelbl.text=ww;
    _ptypelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        _ptypelbl.textColor=[UIColor blackColor];
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
    _ptypelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
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
    _startdatelbl.text=@"Start Date";
    _startdatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _startdatelbl.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
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
    _enddatelbl.text=@"End Date";
    _enddatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _enddatelbl.textColor=[UIColor colorWithRed:(193.0/255.0) green:(193.0/255.0) blue:(193.0/255.0) alpha:1];
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    _startdatelbl.font = [UIFont fontWithName:@"Helvetica Neue Light" size:14];
     _startdatelbl.textColor=[UIColor blackColor];
    _startdatelbl.text=str;
    
    
    //[picker removeFromSuperview];
}
-(void)LabelTitle1:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    _enddatelbl.font = [UIFont fontWithName:@"Helvetica Neue Light" size:14];
     _enddatelbl.textColor=[UIColor blackColor];
    _enddatelbl.text=str;
    
    //[picker removeFromSuperview];
}

- (IBAction)BACKFROMPORTFOLIO:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)PortTypeClk:(id)sender
{
    [self.pcodetxt resignFirstResponder];
     myarr=[NSMutableArray arrayWithObjects:@"Home",@"Business",@"Personal",@"Other",nil];
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
        [btn setTitle: @"Save" forState: UIControlStateNormal];
        //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myview addSubview:btn];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(275,175,100,35)];
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
    [self.pcodetxt resignFirstResponder];
    if(self.view.frame.size.width==375)
    {
        
        if (btnhasInsure.selected==NO) {
          //  [self.mainscroll setContentOffset:CGPointMake(0.0f,20.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,350,375,237)];
        }
        else if (btnhasInsure.selected==YES)
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
        [_mainscroll addSubview:myview];
        
        [mypicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        if (btnhasInsure.selected==NO) {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,20.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,265,320,237)];
        }
        else if (btnhasInsure.selected==YES)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,210.0f) animated:YES];
            myview = [[UIView alloc] initWithFrame:CGRectMake(0,467,320,237)];
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
        [_mainscroll addSubview:myview];
        
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
        [_mainscroll addSubview:myview];
        
        [mypicker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
       
        mypicker.delegate = self;
        mypicker.dataSource=self;
        
        [btn addTarget:self action:@selector(buttonInfo2:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonInfo3:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)SubmitClk:(id)sender
{
    if ([_ptypelbl.text isEqualToString:@"Home"])
    {
        portType=@"1";
    }
     else if ([_ptypelbl.text isEqualToString:@"Business"])
    {
        portType=@"2";
    }
     else if ([_ptypelbl.text isEqualToString:@"Personal"])
     {
         portType=@"3";
     }
     else if ([_ptypelbl.text isEqualToString:@"Other"])
     {
         portType=@"4";
     }
    if(self.portnmtxt.text.length==0)
    {
        self.portnmtxt.text=@"";
        self.portnmtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
      //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (self.addrtxt.text.length==0)
    {
        self.addrtxt.text=@"";
        lbladdress.hidden=NO;
        lbladdress.text=@"Enter Address";
        lbladdress.textColor=[UIColor redColor];
    }
    
    else if (self.pcodetxt.text.length==0)
    {
        self.pcodetxt.text=@"";
        self.pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Postal Code" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
      //  [Main_acroll setContentOffset:CGPointMake(0,160) animated:YES];
    }
    else if (self.ptypelbl.text.length==0 || [self.ptypelbl.text isEqualToString:@"Portfolio Type"])
    {
        self.ptypelbl.text=@"Portfolio Type";
        self.ptypelbl.textColor=[UIColor redColor];
    }
    else if(self.inametxt.text.length==0 && btnhasInsure.selected==YES)
    {
        self.inametxt.text=@"";
        self.inametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (self.idetail.text.length==0 && btnhasInsure.selected==YES)
    {
        self.idetail.text=@"";
        self.lblinsureDetail.hidden=NO;
        self.lblinsureDetail.text=@"Enter Details";
        self.lblinsureDetail.textColor=[UIColor redColor];
    }
    else if ((self.startdatelbl.text.length==0 || [self.startdatelbl.text isEqualToString:@"Start Date"]) && btnhasInsure.selected==YES)
    {
        self.startdatelbl.text=@"Start Date";
        self.startdatelbl.textColor=[UIColor redColor];
    }
    else if ((self.enddatelbl.text.length==0 || [self.enddatelbl.text isEqualToString:@"End Date"]) && btnhasInsure.selected==YES)
    {
        self.enddatelbl.text=@"End Date";
        self.enddatelbl.textColor=[UIColor redColor];
    }
    else
    {
        NSComparisonResult result;
        if(btnhasInsure.selected==YES)
        {
        NSDateFormatter *dt = [[NSDateFormatter alloc] init];
        [dt setDateFormat:@"dd-MM-yyyy"];
        NSDate *startDate = [dt dateFromString:self.startdatelbl.text];
        NSDate *endDate = [dt dateFromString:self.enddatelbl.text];
        
        
        result = [startDate compare:endDate];
        }
        
        if(result== NSOrderedDescending && btnhasInsure.selected==YES)
        {
            
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"End date can't be less than Start date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
            
            
        }
        else if(result == NSOrderedSame && btnhasInsure.selected==YES)
        {
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"End date can't be same as Start date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
            
            
        }
        else if (self.vcovertxt.text.length==0 && btnhasInsure.selected==YES)
        {
            self.vcovertxt.text=@"";
            self.vcovertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            //  [Main_acroll setContentOffset:CGPointMake(0,160) animated:YES];
        }
        else
        {
            [self AddPortfolioUrl];
          //    [self AddInsuranceUrl];
        }
    }
    
    

}

-(void)AddPortfolioUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0", @"PortfolioCode",self.portnmtxt.text, @"PortfolioName",self.addrtxt.text,@"Address1",@"",@"Address2",self.pcodetxt.text, @"PostCode",Isinsured, @"IsInsured",portType,@"PortfolioTypeCode",  nil];
      NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolio/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode]; //api done
    
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
                    portfoliocode=[result valueForKey:@"ResultInfo"];
                    NSLog(@"port code=%@",portfoliocode);
                    [self AddInsuranceUrl];
                }
                else
                {
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Portfolio Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //   login * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    //   [self.navigationController  pushViewController:vc animated:YES];
                    [aler show];
                     [self dismissViewControllerAnimated:YES completion:nil];

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
-(void)AddInsuranceUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:self.inametxt.text, @"InsuranceName",self.idetail.text, @"InsuranceDetail",self.startdatelbl.text,@"StartDate",self.enddatelbl.text,@"EndDate",self.vcovertxt.text, @"ValueCovered",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolioInsurance/%@?PortfolioCode=%@",URL_LINK,AuthToken,portfoliocode]; //api done
    
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
                
            //    [[NSUserDefaults standardUserDefaults] setObject:[result valueForKey:@"ResultInfo"] forKey:@"CustomerCode"];
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Portfolio Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
- (IBAction)HasInsureClk:(id)sender
{
    if (btnhasInsure.selected==NO) {
        btnhasInsure.selected=YES;
        Isinsured=@"1";
        toggleimg.frame=CGRectMake(toggleimg.frame.origin.x+20, toggleimg.frame.origin.y, toggleimg.frame.size.width, toggleimg.frame.size.height);
        self.inametxt.userInteractionEnabled=YES;
        self.idetail.userInteractionEnabled=YES;
        self.btnstartdate.userInteractionEnabled=YES;
        self.btnenddate.userInteractionEnabled=YES;
        self.vcovertxt.userInteractionEnabled=YES;
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
             btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+InsuranceView.frame.size.height+20, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
             InsuranceView.hidden=NO;
        }];
       
       
    }
    else if (btnhasInsure.selected==YES) {
        btnhasInsure.selected=NO;
        Isinsured=@"0";
        toggleimg.frame=CGRectMake(toggleimg.frame.origin.x-20, toggleimg.frame.origin.y, toggleimg.frame.size.width, toggleimg.frame.size.height);
        self.inametxt.userInteractionEnabled=NO;
        self.idetail.userInteractionEnabled=NO;
        self.btnstartdate.userInteractionEnabled=NO;
        self.btnenddate.userInteractionEnabled=NO;
        self.vcovertxt.userInteractionEnabled=NO;
        
        // hide insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
           
            
            
            
            
        } completion:^(BOOL finished) {
            
            
             btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            InsuranceView.hidden=YES;
        }];

       
            }
}
@end
