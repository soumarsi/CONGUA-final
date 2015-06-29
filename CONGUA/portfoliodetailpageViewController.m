//
//  portfoliodetailpageViewController.m
//  CONGUA
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "portfoliodetailpageViewController.h"
#import "portfolioitemViewController.h"

@interface portfoliodetailpageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation portfoliodetailpageViewController
@synthesize PortfolioCode,lbladdress,lblTitle,lblexpiryDate,lblinsureexpiry,lblNoOfItem,lbltotalcover,lbltotalValue,iconImage,tblDoc,lblUserName,mainscroll;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.width==320)
    {
    mainscroll.contentSize = CGSizeMake(0, 450);
    }
    else if([UIScreen mainScreen].bounds.size.width>320)
    {
        mainscroll.contentSize = CGSizeMake(0, 530);
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio code=%@",PortfolioCode);
    
    urlobj=[[UrlconnectionObject alloc]init];
    ArrPortDetail=[[NSMutableArray alloc]init];
    ArrInsureDetail=[[NSMutableArray alloc]init];
    ArrDoc=[[NSMutableArray alloc]init];
    [self PortfolioViewUrl];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PUSHTOPORTFOLIOITEM:(id)sender
{
    portfolioitemViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"portfolioitemviewcontroller"];
    [self.navigationController  pushViewController:pdvc animated:YES];

}

- (IBAction)backtoviewcontroller:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)PortfolioViewUrl
{
    @try {
        
        
        [ArrPortDetail removeAllObjects];
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
                    
                    lblTitle.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"PortfolioName"]  forKey:@"PortfolioName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"]  forKey:@"PortfolioTypeCode"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"Address1"]  forKey:@"Address1"];
                    lbladdress.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Address1"];
                    lblNoOfItem.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductCount"]];
                    lbltotalcover.text=[@"$" stringByAppendingString:[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"TotalCover"]]];
                    lbltotalValue.text=[@"$" stringByAppendingString:[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"TotalValue"]]];
                    
                    if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
                        iconImage.image=[UIImage imageNamed:@"home"];
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==2) {
                        iconImage.image=[UIImage imageNamed:@"business"];
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==3) {
                        iconImage.image=[UIImage imageNamed:@"personal"];
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"] integerValue] ==4) {
                        iconImage.image=[UIImage imageNamed:@"other"];
                    }
                    
                    NSString *insured=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"IsInsured"]];
                    if ([insured isEqualToString:@"0"])
                    {
                        lblinsureexpiry.hidden=YES;
                        lblexpiryDate.hidden=YES;
                        [self DocShowUrl];
                    }
                    else
                    {
                        lblinsureexpiry.hidden=NO;
                        lblexpiryDate.hidden=NO;
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
        
        
        [ArrPortDetail removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioInsuranceInfo/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result1, NSError *error,BOOL completed) {
                
                if ([[result1 valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /*
                     for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                     {
                     [ArrPortDetail addObject:tempDict1];
                     
                     }
                     */
                    lblexpiryDate.text=[[result1 objectForKey:@"ResultInfo"] valueForKey:@"EndDate"];
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                //    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
                    [dateFormat setDateFormat:@"dd-MM-yyyy"];
                    NSDate *date = [dateFormat dateFromString:lblexpiryDate.text];
                    
                    lblexpiryDate.text = [dateFormat stringFromDate:date];
                    [self DocShowUrl];
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
-(void)DocShowUrl
{
    @try {
        
        
        [ArrDoc removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioDocInfoList/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrDoc addObject:tempDict1];
                        
                    }
                    //  ArrFilter = [NSMutableArray arrayWithCapacity:[ArrSummary count]];
                    NSLog(@"summary name=%@",ArrDoc);
                    tblDoc.frame=CGRectMake(tblDoc.frame.origin.x, tblDoc.frame.origin.y, tblDoc.frame.size.width,43.0*[ArrDoc count]);
                    mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+43.0*[ArrDoc count]-86.0);
                    [tblDoc reloadData];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  NSLog(@"count=%lu",(unsigned long)[ArrSummary count]);
    
        return [ArrDoc count];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid=@"PortfolioDocCell";
    
    PortfolioDocCell *cell=(PortfolioDocCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    cell.lblDocName.text=[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocName"];
    
    return cell;
  
    
   
    
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (ArrDoc.count>0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        PortfolioDocDetailViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"PortfolioDocDetailViewControllersid"];
        pv2vc.DocCode=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"PortfolioDocCode"]];
        
        [self.navigationController pushViewController:pv2vc animated:YES];
    }
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)leftClk:(id)sender
{
    ViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"viewcontroller"];
    [self.navigationController popToViewController:pdvc animated:YES];
}
- (IBAction)PortfolioDetailClk:(id)sender
{
    /*
    PortFolio2ViewController *pdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"portfolio2viewcontroller"];
     [self.navigationController  pushViewController:pdvc animated:YES];
    */
    
}

- (IBAction)AddDocumentClk:(id)sender
{
    AddPortfolioDocViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPortfolioDocViewControllersid"];
    [self.navigationController  pushViewController:addportvc animated:YES];
 //   [self presentViewController:addportvc
  //                     animated:YES
   //                  completion:NULL];
}

- (IBAction)EditPortfolioClk:(id)sender
{
    EditPortfolioViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditPortfolioViewControllersid"];
    [self.navigationController  pushViewController:pdvc animated:YES];
}
@end
