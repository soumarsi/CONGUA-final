//
//  MyProfileViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 15/09/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController
@synthesize txtaddr1,txtaddr2,txtemail,txtfname,txtlname,txtpcode,txtph,txttitle,mainscroll,txtCountry,dataDic,goprofile;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    if(self.view.frame.size.width==320)
    {
      
        
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1100)];
    }
    else
    {
        [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1200)];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    ArrCountryName=[[NSMutableArray alloc]init];
    ArrCountryCode=[[NSMutableArray alloc]init];
    ArrTitleCode=[[NSMutableArray alloc]init];
    ArrTitleName=[[NSMutableArray alloc]init];
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txttitle.leftView = paddingView1;
    txttitle.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtfname.leftView = paddingView2;
    txtfname.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtlname.leftView = paddingView3;
    txtlname.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtemail.leftView = paddingView4;
    txtemail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtph.leftView = paddingView5;
    txtph.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtaddr1.leftView = paddingView6;
    txtaddr1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtaddr2.leftView = paddingView7;
    txtaddr2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtpcode.leftView = paddingView8;
    txtpcode.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtCountry.leftView = paddingView9;
    txtCountry.leftViewMode = UITextFieldViewModeAlways;
    
    UIToolbar *toolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar1.barStyle=UIBarStyleDefault;
    //    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView)];
    //    // Add buttons to the toolbar
    [toolbar1 setItems:[NSArray arrayWithObjects:flexibleSpace1, barButtonItem1, nil]];
    // Set the toolbar as accessory view of an UITextField object
    txtph.inputAccessoryView = toolbar1;
    
    if (goprofile==YES)
    {
        txttitle.text=[dataDic valueForKey:@"title"];
        TitleCode=[dataDic valueForKey:@"titleCode"];
        txtfname.text=[dataDic valueForKey:@"FirstName"];
        txtlname.text=[dataDic valueForKey:@"LastName"];
        txtemail.text=[dataDic valueForKey:@"Email"];
        txtaddr1.text=[dataDic valueForKey:@"Address"];
        txtaddr2.text=[dataDic valueForKey:@"AltAddress"];
        txtpcode.text=[dataDic valueForKey:@"Pcode"];
        txtph.text=[dataDic valueForKey:@"Phone"];
//        _passtxt.text=[dataDic valueForKey:@"Password"];
//        _cpasstxt.text=[dataDic valueForKey:@"Cpassword"];
        txtCountry.text=[dataDic valueForKey:@"country"];
        CountryCode=[dataDic valueForKey:@"countryCode"];
        [self TitleShowUrl];
    }
    else
    {
    
    [self CustomerDetailViewUrl];
    }
}
-(void)resetView
{
    [txtph resignFirstResponder];
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     //options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
-(void)CustomerDetailViewUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@GetCustomerInfoDetail/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    
                    
                  //  txttitle.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Title"];
                    TitleCode=[[result objectForKey:@"ResultInfo"] valueForKey:@"Title"];

                    txtfname.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"FirstName"];
                   
                    txtlname.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"LastName"];
                    
                    txtemail.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Email"];
                   
                    txtph.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Phone"];
                    
                    txtaddr1.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Address1"];
                    
                    txtaddr2.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Address2"];
                    
                    txtpcode.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"PostCode"];
                    
                    CountryCode=[[result objectForKey:@"ResultInfo"] valueForKey:@"CountryCode"];
                   
                   // temporary
                    if ([CountryCode isEqualToString:@"UK"])
                    {
                        txtCountry.text=@"United Kingdom";
                    }
                    
                    //temporary
                  //  TitleCode=@"1";
                    [self TitleShowUrl];
                    
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
-(void)TitleShowUrl
{
    @try {
        
        [ArrTitleName removeAllObjects];
        [ArrTitleCode removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetTitleInfoList",URL_LINK];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrTitleName addObject:[tempDict1 valueForKey:@"TitleName"]];
                        [ArrTitleCode addObject:[tempDict1 valueForKey:@"TitleCode"]];
                        if ([[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"TitleCode"]] isEqualToString:TitleCode])
                        {
                            txttitle.text=[tempDict1 valueForKey:@"TitleName"];
                            break;
                        }
                    }
                    
                    // NSLog(@"country name=%@",ArrTitleName);
                    [self CountryShowUrl];
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
-(void)CountryShowUrl
{
    @try {
        
        [ArrCountryName removeAllObjects];
        [ArrCountryCode removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetCountryInfoList",URL_LINK];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrCountryName addObject:[tempDict1 valueForKey:@"CountryName"]];
                        [ArrCountryCode addObject:[tempDict1 valueForKey:@"CountryCode"]];
                        if ([[NSString stringWithFormat:@"%@",[tempDict1 valueForKey:@"CountryCode"]]  isEqualToString:CountryCode])
                        {
                            txtCountry.text=[tempDict1 valueForKey:@"CountryName"];
                            break;
                        }
                    }
                }
                //   NSLog(@"country name=%@",ArrCountryName);
                
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

- (IBAction)BackClick:(id)sender
{
    ViewController *countryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewcontroller"];
    [self.navigationController pushViewController:countryVC animated:YES];
   // [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveClick:(id)sender
{
    if([self myvalidation])
    {
        [self EditProfileUrl];
    }
}
-(void)EditProfileUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:TitleCode, @"Title",txtfname.text, @"FirstName",txtlname.text,@"LastName",txtemail.text,@"Email",txtph.text, @"Phone",txtaddr1.text, @"Address1",txtaddr2.text,@"Address2",txtpcode.text,@"PostCode",CountryCode,@"CountryCode",  nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UpdateCustomer/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode]; //api done
    NSLog(@"edit url=%@",loginstring);
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
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
            {
                
                
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Profile Updated Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                
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
- (IBAction)TitleClick:(id)sender
{
    if (ArrTitleCode.count>0) {
        
        
        countryViewController *countryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"country"];
        
        //all data put in dic so when back to this page all the kept
        dataDic=[[NSMutableDictionary alloc]init];
        [dataDic setObject:txttitle.text forKey:@"title"];
        [dataDic setObject:TitleCode forKey:@"titleCode"];
        [dataDic setObject:txtfname.text forKey:@"FirstName"];
        [dataDic setObject:txtlname.text forKey:@"LastName"];
        [dataDic setObject:txtemail.text forKey:@"Email"];
        [dataDic setObject:txtph.text forKey:@"Phone"];
        [dataDic setObject:txtaddr1.text forKey:@"Address"];
        [dataDic setObject:txtaddr2.text forKey:@"AltAddress"];
        [dataDic setObject:txtpcode.text forKey:@"Pcode"];
        [dataDic setObject:@"" forKey:@"Password"];
        [dataDic setObject:@"" forKey:@"Cpassword"];
        [dataDic setObject:txtCountry.text forKey:@"country"];
        [dataDic setObject:CountryCode forKey:@"countryCode"];
        NSLog(@" data dic=%@",dataDic);
        countryVC.SignDic=dataDic;
        countryVC.ArrTitleName=ArrTitleName;
        countryVC.ArrTitleCode=ArrTitleCode;
        countryVC.TitleCheck=@"YES";
        goprofile=YES;
        //for back to splash screen to login
        if (goprofile==YES) {
            countryVC.myprofile=YES;
        }
        [self.navigationController pushViewController:countryVC animated:YES];
    }

}

- (IBAction)CountryClick:(id)sender
{
    if (ArrCountryCode.count>0) {
        
        
        countryViewController *countryVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"country"];
        
        //all data put in dic so when back to this page all the kept
        dataDic=[[NSMutableDictionary alloc]init];
        [dataDic setObject:txttitle.text forKey:@"title"];
        [dataDic setObject:TitleCode forKey:@"titleCode"];
        [dataDic setObject:txtfname.text forKey:@"FirstName"];
        [dataDic setObject:txtlname.text forKey:@"LastName"];
        [dataDic setObject:txtemail.text forKey:@"Email"];
        [dataDic setObject:txtph.text forKey:@"Phone"];
        [dataDic setObject:txtaddr1.text forKey:@"Address"];
        [dataDic setObject:txtaddr2.text forKey:@"AltAddress"];
        [dataDic setObject:txtpcode.text forKey:@"Pcode"];
        [dataDic setObject:@"" forKey:@"Password"];
        [dataDic setObject:@"" forKey:@"Cpassword"];
        [dataDic setObject:txtCountry.text forKey:@"country"];
        [dataDic setObject:CountryCode forKey:@"countryCode"];
        NSLog(@" data dic=%@",dataDic);
        countryVC.SignDic=dataDic;
        countryVC.ArrCountryName=ArrCountryName;
        countryVC.ArrCountryCode=ArrCountryCode;
        goprofile=YES;
        //for back to splash screen to login
        if (goprofile==YES) {
            countryVC.myprofile=YES;
        }
        [self.navigationController pushViewController:countryVC animated:YES];
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
   
    
    if(self.view.frame.size.width>=375)
    {
        if(textField==txtaddr1)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             // delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f,190.0f
                                                                               ) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txttitle)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 //  self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==txtph)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f,150.0f
                                                                               ) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        
        if(textField==txtemail)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             // delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 50.0f
                                                                               ) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txtlname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             // delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 //  self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
        }
        if(textField==txtfname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //delay:0.1f
             //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 // self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
        }
        
        if(textField==txtaddr2)
        {
            // self.alteraddrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             // delay:0.1f
             // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f,280.0f
                                                                               ) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-60.0f);
            
        }
        if(textField==txtpcode)
        {
            //self.pcodetxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             // delay:0.1f
             // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f,340.0f
                                                                               ) animated:YES];                          }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-100.0f);
        }
        
    }
    else if (self.view.frame.size.width==320)
    {
        if(textField==txttitle)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //  delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 //  self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==txtph)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //   delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 250.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        
        if(textField==txtemail)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 150.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txtlname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //   options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 60.0f) animated:YES];                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txtfname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 // self.regview.frame=CGRectOffset(f,0.0f,50.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==txtaddr1)
        {
            // self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //        delay:0.1f
             //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 280.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            // self.regview.frame=CGRectOffset(f,0.0f,-50.0f);
        }
        if(textField==txtaddr2)
        {
            txtaddr2.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //       delay:0.1f
             //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 370.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            //self.regview.frame=CGRectOffset(f,0.0f,-90.0f);
        }
        if(textField==txtpcode)
        {
            //self.pcodetxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //     delay:0.1f
             //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 450.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
            //self.regview.frame=CGRectOffset(f,0.0f,-130.0f);
        }
        
    }
    
    if (self.view.frame.size.height==480)
    {
        if(textField==txttitle)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //  delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 //  self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==txtph)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //   delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 340.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        
        if(textField==txtemail)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 220.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txtlname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //   options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 140.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==txtfname)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //    delay:0.1f
             //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 80.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==txtaddr1)
        {
            // self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //        delay:0.1f
             //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 370.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            // self.regview.frame=CGRectOffset(f,0.0f,-50.0f);
        }
        if(textField==txtaddr2)
        {
            txtaddr2.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //       delay:0.1f
             //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f,450.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            //self.regview.frame=CGRectOffset(f,0.0f,-90.0f);
        }
        if(textField==txtpcode)
        {
            //self.pcodetxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
             //     delay:0.1f
             //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 [self.mainscroll setContentOffset:CGPointMake(0.0f, 520.0f) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
            //self.regview.frame=CGRectOffset(f,0.0f,-130.0f);
        }
            }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         [self.mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
    return  YES;
}
-(BOOL)myvalidation
{
    if([self textFieldBlankorNot:txttitle.text].length==0)
    {
        /*
         self.titletxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _titletxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Title can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:txtfname.text].length==0)
    {
        /*
         self.fnametxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _fnametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Firstname can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"First name can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:txtlname.text].length==0)
    {
        /*
         self.lnametxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _lnametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Lastame can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Last name can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    
    BOOL r=[self validateEmailWithString:txtemail.text];
    if (r==NO)
    {
        /*
         self.emailtxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Put Proper Email Address" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Put Proper Email Address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    
    if([self myMobileNumberValidate:txtph.text]==FALSE)
    {
        /*  self.phnotxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _phnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Put Proper Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Put Proper Phone Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:txtaddr1.text].length==0)
    {
        /*
         self.addrtxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _addrtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Address can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:txtpcode.text].length==0)
    {
        /*
         self.pcodetxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postal Code can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Postal Code can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        
        return NO;
    }
    
    
    if([self textFieldBlankorNot:txtCountry.text].length==0)
    {
        /*
         self.passtxt.text=Nil;
         UIColor *color = [UIColor redColor];
         _passtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Country name can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    return YES;
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}

-(BOOL)validateEmailWithString:(NSString*)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)myMobileNumberValidate:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

@end
