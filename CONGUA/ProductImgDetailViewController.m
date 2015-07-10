//
//  ProductImgDetailViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ProductImgDetailViewController.h"

@interface ProductImgDetailViewController ()<UIAlertViewDelegate>

@end

@implementation ProductImgDetailViewController
@synthesize lblDesc,WebView,ProductImgCode,lblUserName,mainscroll,ProductImg;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    mainscroll.contentSize=CGSizeMake(0, 489);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
    NSLog(@"product image code=%@",ProductImgCode);
    [[NSUserDefaults standardUserDefaults] setObject:ProductImgCode forKey:@"ProductImgCode"];
    urlobj=[[UrlconnectionObject alloc]init];
    
    [self ProductImgUrl];
}
-(void)ProductImgUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@GetProductImageInfoDetail/%@?ProductCode=%@&ProductImageCode=%@",URL_LINK,AuthToken,ProductCode,ProductImgCode];
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
                    
                   
                    
                    lblDesc.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"];
                    //dynamic height of label
                    NSString *str=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"]];
                    
                    NSInteger rw=ceil(str.length/65.0);
                    NSInteger len=rw*25;
                    
                    
                    lblDesc.frame=CGRectMake(lblDesc.frame.origin.x, lblDesc.frame.origin.y,lblDesc.frame.size.width, len);
                    
                    
                    
                    
                    
                    FileName=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"FileName"]];
                    
                    if (FileName.length==0)
                    {
                       
                    }
                    else
                    {
                      //  WebView.hidden=NO;
                        [self DownloadUrl];
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
-(void)DownloadUrl
{
    @try {
        
        //  FileName=@"34.png";
        NSString *str=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
        NSLog(@"str=%@",str);
        
        
  //      NSURL *url = [NSURL URLWithString:str];
  //      NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
 //       [WebView loadRequest:requestObj];
        
        [ProductImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        ProductImg.contentMode=UIViewContentModeScaleAspectFit;
        /*
         BOOL net=[urlobj connectedToNetwork];
         if (net==YES) {
         [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
         
         NSLog(@"result=%@",result);
         if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
         {
         
         
         
         
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
         */
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
    }
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        [self DeleteDocumentUrl];
        
        
    }
    
    
}

-(void)DeleteDocumentUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeleteProductImage/%@?ProductCode=%@&ProductImageCode=%@",URL_LINK,AuthToken,ProductCode,ProductImgCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                NSLog(@"array=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    
                    [self.navigationController popViewControllerAnimated: YES];
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

- (IBAction)EditClick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EditProductImgViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"EditProductImgViewControllersid"];
    
    
    [self.navigationController pushViewController:pv2vc animated:YES];
}

- (IBAction)BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
