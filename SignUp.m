//
//  SignUp.m
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//





#import "SignUp.h"
#import "login.h"

@interface SignUp()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CGRect f;
}
@end


@implementation SignUp
@synthesize btncountry,imgArrow,txtcountry;
-(void)viewDidLoad
{
    [super viewDidLoad];
    f = _regview.frame;
    self.titletxt.delegate=self;
    self.fnametxt.delegate=self;
    self.lnametxt.delegate=self;
    self.emailtxt.delegate=self;
    self.phnotxt.delegate=self;
    self.addrtxt.delegate=self;
    self.alteraddrtxt.delegate=self;
    self.pcodetxt.delegate=self;
    self.passtxt.delegate=self;
    self.cpasstxt.delegate=self;
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIToolbar *toolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar1.barStyle=UIBarStyleDefault;
    //    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    // Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resetView)];
    //    // Add buttons to the toolbar
    [toolbar1 setItems:[NSArray arrayWithObjects:flexibleSpace1, barButtonItem1, nil]];
    // Set the toolbar as accessory view of an UITextField object
    self.phnotxt.inputAccessoryView = toolbar1;
    
    ArrCountryName=[[NSMutableArray alloc]init];
    ArrCountryCode=[[NSMutableArray alloc]init];
    [self CountryShowUrl];

    
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
                    }
                }
                NSLog(@"country name=%@",ArrCountryName);
      
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
-(void)resetView
{
    [self.phnotxt resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    if(textField==self.titletxt)
//    {
//        self.titletxt.placeholder=Nil;
//        
//    }
//    if(textField==self.fnametxt)
//    {
//        self.fnametxt.placeholder=Nil;
//        
//    }
//    if(textField==self.lnametxt)
//    {
//        self.lnametxt.placeholder=Nil;
//        
//    }
//    if(textField==self.emailtxt)
//    {
//        self.emailtxt.placeholder=Nil;
//        
//    }
//    if(textField==self.phnotxt)
//    {
//        self.phnotxt.placeholder=Nil;
//        
//    }
   
    if(self.view.frame.size.width>=375)
    {
        if(textField==self.phnotxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                 // delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.titletxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                  //delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }

        if(textField==self.phnotxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                  //delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-30.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }

        
        if(textField==self.emailtxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                 // delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];

//            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.lnametxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                 // delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.fnametxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                  //delay:0.1f
                                //options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }

        if(textField==self.alteraddrtxt)
        {
           // self.alteraddrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                 // delay:0.1f
                               // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-60.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];

//            self.regview.frame=CGRectOffset(f,0.0f,-60.0f);
            
        }
        if(textField==self.pcodetxt)
        {
            //self.pcodetxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                 // delay:0.1f
                               // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-100.0f);                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];

            
//            self.regview.frame=CGRectOffset(f,0.0f,-100.0f);
        }
        if(textField==self.passtxt)
        {
            //self.passtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                               //   delay:0.1f
                               // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                self.regview.frame=CGRectOffset(f,0.0f,-145.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
//            self.regview.frame=CGRectOffset(f,0.0f,-145.0f);
        }
        if(textField==self.cpasstxt)
        {
            //self.cpasstxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                //  delay:0.1f
                              //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-180.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            //self.regview.frame=CGRectOffset(f,0.0f,-180.0f);
        }
    }
    else if (self.view.frame.size.width==320)
    {
        if(textField==self.phnotxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                               //   delay:0.1f
                               // options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.titletxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                                //  delay:0.1f
                              //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        if(textField==self.phnotxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                               //   delay:0.1f
                              //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-30.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        
        
        if(textField==self.emailtxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                              //    delay:0.1f
                              //  options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.lnametxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                              //    delay:0.1f
                             //   options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }
        if(textField==self.fnametxt)
        {
            //self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                              //    delay:0.1f
                            //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,0.0f);}
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            //            self.regview.frame=CGRectOffset(f,0.0f,-20.0f);
        }

        if(textField==self.addrtxt)
        {
           // self.addrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                          //        delay:0.1f
                           //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-50.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];

           // self.regview.frame=CGRectOffset(f,0.0f,-50.0f);
        }
        if(textField==self.alteraddrtxt)
        {
            self.alteraddrtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                           //       delay:0.1f
                           //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-90.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            //self.regview.frame=CGRectOffset(f,0.0f,-90.0f);
        }
        if(textField==self.pcodetxt)
        {
            //self.pcodetxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                             //     delay:0.1f
                            //    options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-130.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];

            
            //self.regview.frame=CGRectOffset(f,0.0f,-130.0f);
        }
        if(textField==self.passtxt)
        {
            //self.passtxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                           //       delay:0.1f
                           //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-160.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
//            self.regview.frame=CGRectOffset(f,0.0f,-160.0f);
        }
        if(textField==self.cpasstxt)
        {
            //self.cpasstxt.placeholder=Nil;
            [UIView animateWithDuration:0.4f
                             //     delay:0.1f
                           //     options:UIViewAnimationTransitionNone
                             animations:^{
                                 
                                 self.regview.frame=CGRectOffset(f,0.0f,-190.0f);
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
//            self.regview.frame=CGRectOffset(f,0.0f,-190.0f);
        }
    }
}

-(BOOL)myvalidation
{
    if([self textFieldBlankorNot:_titletxt.text].length==0)
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
    if([self textFieldBlankorNot:_fnametxt.text].length==0)
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
    if([self textFieldBlankorNot:_lnametxt.text].length==0)
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
    
    BOOL r=[self validateEmailWithString:self.emailtxt.text];
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
    
    if([self myMobileNumberValidate:_phnotxt.text]==FALSE)
    {
      /*  self.phnotxt.text=Nil;
        UIColor *color = [UIColor redColor];
        _phnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Put Proper Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
       */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Put Proper Phone Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:_addrtxt.text].length==0)
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
    if([self textFieldBlankorNot:_pcodetxt.text].length==0)
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
    
    if([self textFieldBlankorNot:_passtxt.text].length==0)
    {
        /*
        self.passtxt.text=Nil;
        UIColor *color = [UIColor redColor];
        _passtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password can't Left Blank" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password can't Left Blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    
    if(![_passtxt.text isEqualToString:_cpasstxt.text])
    {
        /*
        self.cpasstxt.text=Nil;
        UIColor *color = [UIColor redColor];
        _cpasstxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password Mismatch" attributes:@{NSForegroundColorAttributeName: color}];
         */
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password Mismatch." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
        return NO;
    }
    if([self textFieldBlankorNot:txtcountry.text].length==0)
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

- (IBAction)signupbtn:(id)sender
{
    if([self myvalidation])
    {
        [_btnSignUp setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btnSignUp.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(44.0/255.0) blue:(17.0/255.0) alpha:1.0];
        [_btnSignUp setTitle:@"Signing Up..." forState:UIControlStateNormal];
        _btnSignUp.userInteractionEnabled=NO;
        [self SignUpUrl];
       
    }


}
-(void)SignUpUrl
{
    
    
    
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:self.titletxt.text, @"Title",self.fnametxt.text, @"FirstName",self.lnametxt.text,@"LastName",self.emailtxt.text,@"Email",self.phnotxt.text, @"Phone",self.addrtxt.text, @"Address1",self.alteraddrtxt.text, @"Address2",self.pcodetxt.text, @"PostCode",self.passtxt.text, @"Password",countrycode,@"CountryCode",  nil];
  //  NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@InsertCustomer",URL_LINK]; //api done
    
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
    if (net==YES) {
     //   [self checkLoader];
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
               NSLog(@"event result----- %@", result);
        //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[result valueForKey:@"ResultInfo"] forKey:@"CustomerCode"];
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Account Created Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                login * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController  pushViewController:vc animated:YES];
                [aler show];
                /*
                UIViewController * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"viewcontroller"];
                [self.navigationController  pushViewController:vc animated:YES];
                [aler show];
                 */
            }
            else
            {
              //  [self checkLoader];
                [_btnSignUp setImage:[UIImage imageNamed:@"landinSignUp"] forState:UIControlStateNormal];
                _btnSignUp.userInteractionEnabled=YES;
                
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [_btnSignUp setImage:[UIImage imageNamed:@"landinSignUp"] forState:UIControlStateNormal];
        _btnSignUp.userInteractionEnabled=YES;
        
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([_titletxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _titletxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_fnametxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _fnametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_lnametxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _lnametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_emailtxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_phnotxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _phnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_addrtxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _addrtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_alteraddrtxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _alteraddrtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Alternate Address" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_pcodetxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _pcodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Postal Code" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_passtxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _passtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    if([_cpasstxt.text isEqual:@""])
    {
        UIColor *color1 = [UIColor lightGrayColor];
        _cpasstxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color1}];
    }
    //self.regview.frame=CGRectOffset(f,0.0f,0.0f);
    [UIView animateWithDuration:0.4f
                         // delay:0.1f
                       // options:UIViewAnimationTransitionNone
                     animations:^{

                         self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                     }
                     completion:^(BOOL finished){
                        
                     }
     ];
    
    return  YES;
}


- (IBAction)BACKFROMSIGNUP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)CountryClk:(id)sender
{
    [self.cpasstxt resignFirstResponder];
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         self.regview.frame=CGRectOffset(f,0.0f,-200.0f);
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    if(btncountry.selected==NO)
    {
        btncountry.selected=YES;
        //    [mainscroll setContentOffset:CGPointMake(0,priceview.frame.origin.y+50) animated:YES];
        [CountryView removeFromSuperview];
        
        CountryView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-200, self.view.frame.size.width,200)];
        [CountryView setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1]];
        [self.view addSubview:CountryView];

        
        
        
        //picker create
        
        Countrypicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 10, 250,150)];
        //   amtpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width,150)];
        Countrypicker.delegate=self;
        Countrypicker.dataSource=self;
        [Countrypicker setBackgroundColor:[UIColor whiteColor]];
        [CountryView addSubview:Countrypicker];
        
        btnsave=[[UIButton alloc] initWithFrame:CGRectMake(0,CountryView.frame.size.height-35.0,self.view.frame.size.width/2,35)];
        btnsave.backgroundColor=[UIColor colorWithRed:(250.0f/255.0f) green:(58.0f/255.0f) blue:(47.0f/255.0f) alpha:1];
        [btnsave setTitle: @"OK" forState: UIControlStateNormal];
        

        btnsave.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        [btnsave addTarget:self action:@selector(CountrySave) forControlEvents:UIControlEventTouchUpInside];
        [CountryView addSubview:btnsave];
        
        btncancel=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,CountryView.frame.size.height-35,self.view.frame.size.width/2,35)];
        btncancel.backgroundColor=[UIColor colorWithRed:(20.0f/255.0f) green:(123.0f/255.0f) blue:(250.0f/255.0f) alpha:1];
        [btncancel setTitle: @"CANCEL" forState: UIControlStateNormal];
        btncancel.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        [btncancel addTarget:self action:@selector(CountryCancel) forControlEvents:UIControlEventTouchUpInside];
        [CountryView addSubview:btncancel];
        
    }
    else
    {
        btncountry.selected=NO;
        [CountryView removeFromSuperview];
        
    }
}
-(void)CountrySave
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                        self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    if (country.length==0) {
        
        txtcountry.text=[ArrCountryName objectAtIndex:0];
        countrycode=[ArrCountryCode objectAtIndex:0];
    }
    else
    {
        txtcountry.text=country;
    }
    country=@"";
    btncountry.selected=NO;
    [CountryView removeFromSuperview];
}
-(void)CountryCancel
{
    [UIView animateWithDuration:0.4f
     // delay:0.1f
     // options:UIViewAnimationTransitionNone
                     animations:^{
                         
                         self.regview.frame=CGRectOffset(f,0.0f,0.0f);
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    btncountry.selected=NO;
    [CountryView removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==Countrypicker)
    {
        return ArrCountryName.count;
    }
    else
    {
        return 0;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==Countrypicker)
    {
        return ArrCountryName[row];
    }
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==Countrypicker)
    {
        
        country= ArrCountryName[row];
        countrycode=ArrCountryCode[row];
        
    }
    else
    {
        
    }
}
@end
