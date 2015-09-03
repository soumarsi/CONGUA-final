//
//  ViewController.m
//  Congua
//
//  Created by Saptarshi's iMAC on 26/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "AddPortfolioViewController.h"

@interface AddPortfolioViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CKCalendarDelegate>
{
    UIDatePicker* picker;
    UIBarButtonItem* rightBtn;
    UIView *myview;
    NSArray *myarr;
    UIPickerView *mypicker;
    
}
- (IBAction)HasInsureClk:(id)sender;


- (IBAction)SegmentClick:(id)sender;


@end

@implementation AddPortfolioViewController
@synthesize lbladdress,lblinsureDetail,btnhasInsure,toggleimg,btnenddate,btnstartdate,InsuranceView,btnSubmit,InsuredSwitch,btnOther,btnPersonal,btnBusiness,businessImg,btnHome,homeImg,personalImg,otherImg,PopDelegateFromAddPort,SegmentControl,lblAddress2,txtvwAddress2;
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
        if (self.view.frame.size.height==480)
        {
            [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 480)];
        }
    }
    //[self.mainscroll setFrame:CGRectMake(0, 60, 320, 875)];
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,550.0f)];
    
        
        
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
    
    [self.portnmtxt.layer setBorderColor:[[UIColor colorWithRed:(202.0f/255.0f) green:(202.0f/255.0f) blue:(202.0f/255.0f) alpha:1] CGColor]];
    self.portnmtxt.layer.borderWidth=0.5;
    self.portnmtxt.layer.cornerRadius=5.0;
    
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    Isinsured=@"0";
    
    
 //   self.portnmtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
 //   self.pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Post Code" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
//    self.inametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
//    self.vcovertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    self.startdatelbl.textColor=[UIColor grayColor];
     self.enddatelbl.textColor=[UIColor grayColor];
     self.lbladdress.textColor=[UIColor grayColor];
     self.lblinsureDetail.textColor=[UIColor grayColor];
     self.ptypelbl.textColor=[UIColor grayColor];
    
    InsuredSwitch.on=NO;
    [InsuredSwitch addTarget:self action:@selector(switched:)
       forControlEvents:UIControlEventValueChanged];
    
    homeImg.image=[UIImage imageNamed:@"redioOn"];
    btnHome.selected=YES;
    portType=@"1";
    
    //done button on numberic keyboard
    UIToolbar *toolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar1.barStyle=UIBarStyleDefault;
    //    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView1)];
    //    // Add buttons to the toolbar
    [toolbar1 setItems:[NSArray arrayWithObjects:flexibleSpace1, barButtonItem1, nil]];
    // Set the toolbar as accessory view of an UITextField object
    self.vcovertxt.inputAccessoryView = toolbar1;
    
   

}
-(void)resetView1
{
    [self.vcovertxt resignFirstResponder];
    [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
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
    
    if(textField==self.pcodetxt)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 120.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 220.0f) animated:YES];
        }
    }
    if(textField==self.inametxt)
    {
        [myview removeFromSuperview];
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 260.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 450.0f) animated:YES];
        }
    }
     
    if(textField==self.vcovertxt)
    {
        [myview removeFromSuperview];
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 500.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 680.0f) animated:YES];
        }
    }
    
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];

                     }
                     completion:^(BOOL finished){
                         
                     }
     ];

    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [myview removeFromSuperview];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==self.idetail)
    {
       // lblinsureDetail.hidden=YES;
        [self.mainscroll setContentOffset:CGPointMake(0.0f,500.0f) animated:YES];
    }
    // _addrlbl.hidden=YES;
    if(textView==self.addrtxt)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
        lbladdress.hidden=YES;
    }
    if(textView==txtvwAddress2)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,160.0f) animated:YES];
        lblAddress2.hidden=YES;
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
               // lblinsureDetail.hidden=NO;
            }
        }
        if(textView==self.addrtxt)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            if (self.addrtxt.text.length==0)
            {
                lbladdress.hidden=YES;
            }
        }
        if(textView==txtvwAddress2)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            
        }
        
    }
    return YES;
}

- (IBAction)startdate:(id)sender
{
  
    start=1;
    [self.idetail resignFirstResponder];
    [myview removeFromSuperview];
    if(self.view.frame.size.width>320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
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
        btnCross.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
    }
    
    else if (self.view.frame.size.width==320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,300.0f) animated:YES];
       
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
          btnCross.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
        
        
    }
    if (self.view.frame.size.height==480)
    {
        [myview removeFromSuperview];
    
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,380.0f) animated:YES];
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
        calendar.frame = CGRectMake(20,100, myview.frame.size.width-40,myview.frame.size.height);
        [myview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 60, 30, 30);
          btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
        
        
    }
    
}
-(void)CrossClick
{
    [myview removeFromSuperview];
    _mainscroll.scrollEnabled=YES;
}
- (IBAction)enddate:(id)sender
{
   //  _mainscroll.scrollEnabled=NO;
    start=0;
    [self.idetail resignFirstResponder];
    [myview removeFromSuperview];
    if(self.view.frame.size.width>320)
    {
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
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
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30,110, 30, 30);
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
    }
    
    else if (self.view.frame.size.width==320)
    {
       // [self.mainscroll setContentOffset:CGPointMake(0.0f,300.0f) animated:YES];
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
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
        
        
    }
    if (self.view.frame.size.height==480)
    {
        [myview removeFromSuperview];
       
      //  [self.mainscroll setContentOffset:CGPointMake(0.0f,380.0f) animated:YES];
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
        calendar.frame = CGRectMake(20,100, myview.frame.size.width-40,myview.frame.size.height);
        [myview addSubview:calendar];
        
        UIButton *btnCross = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCross.frame = CGRectMake(calendar.frame.origin.x+calendar.frame.size.width-30, 60, 30, 30);
         btnCross.imageEdgeInsets = UIEdgeInsetsMake(5,5, 5, 5);
        [btnCross addTarget:self action:@selector(CrossClick) forControlEvents:UIControlEventTouchUpInside];
        [btnCross setImage:[UIImage imageNamed:@"crossWhite"] forState:UIControlStateNormal];
        [myview addSubview:btnCross];
        
        
    }
}
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    //  TODO: play with the coloring if we want to...
    
   
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
 
    //show priviously selected date
    if (_startdatelbl.text.length>0)
    {
        
        NSDate *selectedDate = [[NSDate alloc] init];
        selectedDate = [formatter dateFromString:_startdatelbl.text];
        
        NSComparisonResult result;
        result=[selectedDate compare:date];
        if (result==NSOrderedSame)
        {
            dateItem.backgroundColor = [UIColor yellowColor];
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
    
    
    if (_enddatelbl.text.length>0)
    {
        
        NSDate *selectedDate = [[NSDate alloc] init];
        selectedDate = [formatter dateFromString:_enddatelbl.text];
        
        NSComparisonResult result;
        result=[selectedDate compare:date];
        if (result==NSOrderedSame)
        {
            dateItem.backgroundColor = [UIColor grayColor];
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
    
    
}





- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
  /*   _mainscroll.scrollEnabled=YES;
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
   */
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:date]];
    
    if (start) {
        self.startdatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        self.startdatelbl.textColor=[UIColor blackColor];
        self.startdatelbl.text=str;
    }
    else
    {
        self.enddatelbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        self.enddatelbl.textColor=[UIColor blackColor];
        self.enddatelbl.text=str;
    }
    
    
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}



- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    
    return YES;
}
/*
- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}
*/
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
    if(self.view.frame.size.width>320)
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
    /*
    [self.pcodetxt resignFirstResponder];
     myarr=[NSMutableArray arrayWithObjects:@"Home",@"Business",@"Personal",@"Other",nil];
 
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
     */
}

- (IBAction)SubmitClk:(id)sender
{
   
    if([self textFieldBlankorNot:self.portnmtxt.text].length==0)
    {
        /*
        self.portnmtxt.text=@"";
        self.portnmtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Portfolio Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
      //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Portfolio Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ([self textFieldBlankorNot:self.addrtxt.text].length==0)
    {
        /*
        self.addrtxt.text=@"";
        lbladdress.hidden=NO;
        lbladdress.text=@"Enter Address";
        lbladdress.textColor=[UIColor redColor];
         */
        lbladdress.hidden=YES;
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    else if ([self textFieldBlankorNot:self.pcodetxt.text].length==0)
    {
        /*
        self.pcodetxt.text=@"";
        self.pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Postal Code" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
     */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Postal Code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }

    else if([self textFieldBlankorNot:self.inametxt.text].length==0 && btnhasInsure.selected==YES)
    {
        /*
        self.inametxt.text=@"";
        self.inametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Insurance Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Insurance Company Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ([self textFieldBlankorNot:self.idetail.text].length==0 && btnhasInsure.selected==YES)
    {
        /*
        self.idetail.text=@"";
        self.lblinsureDetail.hidden=NO;
        self.lblinsureDetail.text=@"Enter Details";
        self.lblinsureDetail.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Insurance Details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ((self.startdatelbl.text.length==0 || [self.startdatelbl.text isEqualToString:@"Start Date"]) && btnhasInsure.selected==YES)
    {
        /*
        self.startdatelbl.text=@"Start Date";
        self.startdatelbl.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Start Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else if ((self.enddatelbl.text.length==0 || [self.enddatelbl.text isEqualToString:@"End Date"]) && btnhasInsure.selected==YES)
    {
        /*
        self.enddatelbl.text=@"End Date";
        self.enddatelbl.textColor=[UIColor redColor];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter End Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
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
        else if ([self textFieldBlankorNot:self.vcovertxt.text].length==0 && btnhasInsure.selected==YES)
        {
            /*
            self.vcovertxt.text=@"";
            self.vcovertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Value Covered" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
            */
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Value Covered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
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
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0", @"PortfolioCode",self.portnmtxt.text, @"PortfolioName",self.addrtxt.text,@"Address1",txtvwAddress2.text,@"Address2",self.pcodetxt.text, @"PostCode",Isinsured, @"IsInsured",portType,@"PortfolioTypeCode",  nil];
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
                    [PopDelegateFromAddPort Popaction_methodFromAddPort];
                     [self dismissViewControllerAnimated:YES completion:nil];

                }
                
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
-(IBAction)switched:(id)sender
{
    [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f)];
    NSLog(@"Switch current state %@", InsuredSwitch.on ? @"On" : @"Off");
    
    if (InsuredSwitch.on==NO)
    {
       
        btnhasInsure.selected=NO;
        Isinsured=@"0";
    //    toggleimg.frame=CGRectMake(toggleimg.frame.origin.x-10, toggleimg.frame.origin.y, toggleimg.frame.size.width, toggleimg.frame.size.height);
        self.inametxt.userInteractionEnabled=NO;
        self.idetail.userInteractionEnabled=NO;
        self.btnstartdate.userInteractionEnabled=NO;
        self.btnenddate.userInteractionEnabled=NO;
        self.vcovertxt.userInteractionEnabled=NO;
        
        // hide insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            _mainscroll.contentSize = CGSizeMake(0, _mainscroll.contentSize.height-InsuranceView.frame.size.height);
//            if(self.view.frame.size.width==320)
//            {
//                
//                _mainscroll.contentSize = CGSizeMake(0, _mainscroll.contentSize.height-200);
//               
//            }
//            
//            
//            
//            if ([UIScreen mainScreen].bounds.size.width>320)
//            {
//                
//               
//                _mainscroll.contentSize = CGSizeMake(0, _mainscroll.contentSize.height-200);
//            }
            
            
            
            
        } completion:^(BOOL finished) {
            
            
        
            InsuranceView.hidden=YES;
        }];

    }
    else if (InsuredSwitch.on==YES)
    {
        [self.pcodetxt resignFirstResponder];
        [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        btnhasInsure.selected=YES;
        Isinsured=@"1";
    //    toggleimg.frame=CGRectMake(toggleimg.frame.origin.x+20, toggleimg.frame.origin.y, toggleimg.frame.size.width, toggleimg.frame.size.height);
        self.inametxt.userInteractionEnabled=YES;
        self.idetail.userInteractionEnabled=YES;
        self.btnstartdate.userInteractionEnabled=YES;
        self.btnenddate.userInteractionEnabled=YES;
        self.vcovertxt.userInteractionEnabled=YES;
        
        // show insurance view
        [UIView animateWithDuration:0.5 animations:^{
            
            _mainscroll.contentSize = CGSizeMake(0, _mainscroll.contentSize.height+InsuranceView.frame.size.height);
         
//            if(self.view.frame.size.width==320)
//            {
//                
//                
//                
//            }
//            
//            
//            
//            if ([UIScreen mainScreen].bounds.size.width>320)
//            {
//                
//               
//                _mainscroll.contentSize = CGSizeMake(0, _mainscroll.contentSize.height+200);
//            }
            
            
        } completion:^(BOOL finished) {
            
            InsuranceView.hidden=NO;
        }];

    }
}

- (IBAction)HasInsureClk:(id)sender
{
    /*
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
            
             btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, InsuranceView.frame.origin.y+InsuranceView.frame.size.height+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
            
            
            
        } completion:^(BOOL finished) {
            
             InsuranceView.hidden=NO;
        }];
       
       
    }
    else if (btnhasInsure.selected==YES) {
        btnhasInsure.selected=NO;
        Isinsured=@"0";
        toggleimg.frame=CGRectMake(toggleimg.frame.origin.x-10, toggleimg.frame.origin.y, toggleimg.frame.size.width, toggleimg.frame.size.height);
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
     */
}



- (IBAction)SegmentClick:(id)sender
{
    switch (SegmentControl.selectedSegmentIndex) {
        case 0:
          portType=@"1";
            break;
        case 1:
            portType=@"2";
            break;
        case 2:
            portType=@"3";
            break;
        case 3:
            portType=@"4";
            break;
        default:
            portType=@"1";
            break;
    }
}

@end
