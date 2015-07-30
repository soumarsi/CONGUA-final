//
//  EditCategoryViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 01/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "EditCategoryViewController.h"

@interface EditCategoryViewController ()

@end

@implementation EditCategoryViewController
@synthesize txtCategoryName,CategoryCode,PopDelegate4;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"category code=%@",CategoryCode);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
   
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
  
    /*
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtCategoryName.leftView = paddingView1;
    txtCategoryName.leftViewMode = UITextFieldViewModeAlways;
     */
    
 //   txtCategoryName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Category Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    [self CategoryViewUrl];
}
-(void)CategoryViewUrl
{
    @try {
        
        
       
        NSString *str=[NSString stringWithFormat:@"%@GetCategoryInfoDetail/%@?PortfolioCode=%@&CategoryCode=%@",URL_LINK,AuthToken,PortfolioCode,CategoryCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    
                    
                    txtCategoryName.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"CategoryName"];
                    CategoryCode=[[result objectForKey:@"ResultInfo"] valueForKey:@"CategoryCode"];
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

- (IBAction)BackClk:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}
- (IBAction)SubmitClk:(id)sender
{
    if ([self textFieldBlankorNot:txtCategoryName.text].length==0)
    {
        
      //  txtCategoryName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Category" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Category" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else
    {
        [self UpdateCategoryUrl];
    }
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
-(void)UpdateCategoryUrl
{
    [self checkLoader];
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:CategoryCode, @"CategoryCode",txtCategoryName.text, @"CategoryName", nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UpdateCategory/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode]; //api done
    
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
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
        //    NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                
                [self checkLoader];
                //    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Category Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //    [aler show];
                [PopDelegate4 Popaction_method4];
                [self dismissViewControllerAnimated:YES completion:nil];
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
        [self checkLoader];
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
