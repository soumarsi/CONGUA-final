//
//  ForgotPasswordViewController.m
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "login.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize txtemail;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    urlobj=[[UrlconnectionObject alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)PUSHTOSIGNIN:(id)sender
{
    
    login * loginvc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController  pushViewController:loginvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SubmitClk:(id)sender
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if (txtemail.text.length==0)
    {
        
        txtemail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email Id" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    }
    else if ([emailTest evaluateWithObject:txtemail.text] == NO)
    {
        txtemail.text=@"";
        txtemail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Not a valid email" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
       
    }
    else
    {
        [self ForgetPasswordUrl];
    }
}
-(void)ForgetPasswordUrl
{
    
    NSString *str=[NSString stringWithFormat:@"%@ResetPassword?LoginName=%@",URL_LINK,[self.txtemail.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"str=%@",str);
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES) {
        [self checkLoader];
        [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            
            
            
            
            NSLog(@"values:%@",[result valueForKey:@"IsSuccess"]);
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                [self checkLoader];
                     UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Mail sent successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [aler show];
                login * loginvc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                [self.navigationController  pushViewController:loginvc animated:YES];
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
@end
