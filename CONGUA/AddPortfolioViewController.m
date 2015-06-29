//
//  ViewController.m
//  Congua
//
//  Created by Saptarshi's iMAC on 26/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "AddPortfolioViewController.h"

@interface AddPortfolioViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UIDatePicker* picker;
    UIBarButtonItem* rightBtn;
    UIView *myview;
    
}
@end

@implementation AddPortfolioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.portnmtxt.delegate=self;
    self.pcodetxt.delegate=self;
    self.inametxt.delegate=self;
    self.vcovertxt.delegate=self;
    self.idetail.delegate=self;
    self.addrtxt.delegate=self;
    
    if(self.view.frame.size.width==320)
    {
        [self.mainscroll setContentSize:CGSizeMake(320.0f,875.0f)];
    }
    //[self.mainscroll setFrame:CGRectMake(0, 60, 320, 875)];
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        //_mainscroll.frame = CGRectMake(0,90,320,875);
        //[self.mainscroll setFrame:CGRectMake(0, 60, 320, 875)];
        [self.mainscroll setContentSize:CGSizeMake(320.0f,875.0f)];
        [_mainscroll setFrame:CGRectMake(0, 90,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //UITextField *yourTextField;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textField==self.inametxt)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 230.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 330.0f) animated:YES];
        }
    }
    if(textField==self.vcovertxt)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 440.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f, 545.0f) animated:YES];
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
            [self.mainscroll setContentOffset:CGPointMake(0.0f,210.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,290.0f) animated:YES];
        }
    }
    
    if(textField==self.inametxt)
    {
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,190.0f) animated:YES];
        }
        else
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,290.0f) animated:YES];
        }
    }
    //    self.emailtxt.placeholder=@"Enter Your Email";
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==self.idetail)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,340.0f) animated:YES];
    }
    // _addrlbl.hidden=YES;
    
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
                [self.mainscroll setContentOffset:CGPointMake(0.0f,200.0f) animated:YES];
            }
            else
            {
                [self.mainscroll setContentOffset:CGPointMake(0.0f,290.0f) animated:YES];
            }
        }
        if(textView==self.addrtxt)
        {
            [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
        }
        
    }
    return YES;
}

- (IBAction)startdate:(id)sender
{
    if(self.view.frame.size.width==375)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,350.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,375,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.9]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(115,240,150,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(355,0,20,20)];
        dot.image=[UIImage imageNamed:@"cross"];
        [myview addSubview:dot];
        
        UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(355,0,20,20)];
        [myview addSubview:mybtn];
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,375,10)];
        [myview addSubview:picker];
        [_mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [mybtn addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if (self.view.frame.size.width==320)
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,320,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.9]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(88,240,150,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(300,0,20,20)];
        dot.image=[UIImage imageNamed:@"cross"];
        [myview addSubview:dot];
        
        UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(300,0,20,20)];
        [myview addSubview:mybtn];
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [_mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [mybtn addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
        myview = [[UIView alloc] initWithFrame:CGRectMake(0,620,414,280)];
        [myview setBackgroundColor: [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.9]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(128,240,150,35)];
        btn.backgroundColor=[UIColor colorWithRed:(235.0f/255.0f) green:(64.0f/255.0f) blue:(38.0f/255.0f) alpha:1];
        [btn setTitle: @"OK" forState: UIControlStateNormal];
        [myview addSubview:btn];
        
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(394,0,20,20)];
        dot.image=[UIImage imageNamed:@"cross"];
        [myview addSubview:dot];
        
        UIButton *mybtn=[[UIButton alloc]initWithFrame:CGRectMake(394,0,20,20)];
        [myview addSubview:mybtn];
        picker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,20,200,10)];
        [myview addSubview:picker];
        [_mainscroll addSubview:myview];
        
        [picker setBackgroundColor: [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1]];
        
        picker.datePickerMode=UIDatePickerModeDate;
        //    picker.hidden=NO;
        picker.date=[NSDate date];
        [picker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
        [mybtn addTarget:self action:@selector(buttoncross:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)buttonInfo:(id)sender
{
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}
-(void)buttoncross:(id)sender
{
    _startdatelbl.text=NULL;
    self.navigationItem.rightBarButtonItem=nil;
    [myview removeFromSuperview];
    
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:picker.date]];
    _startdatelbl.text=str;
    //[picker removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
