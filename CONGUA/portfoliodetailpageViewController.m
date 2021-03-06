//
//  portfoliodetailpageViewController.m
//  CONGUA
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "portfoliodetailpageViewController.h"
#import "portfolioitemViewController.h"

@interface portfoliodetailpageViewController ()<UITableViewDataSource,UITableViewDelegate,PopView_delegate6,PopView_delegate7,PopView_delegateFromItem>

@end

@implementation portfoliodetailpageViewController
@synthesize PortfolioCode,lbladdress,lblTitle,lblexpiryDate,lblinsureexpiry,lblNoOfItem,lbltotalcover,lbltotalValue,iconImage,tblDoc,lblUserName,mainscroll,lblTolalValuable,lblTotalCover1,dividerImg,AddDocView,lblNoPortfolioDoc;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    if ([UIScreen mainScreen].bounds.size.width==320)
    {
        mainscroll.contentSize = CGSizeMake(0, 500);
    }
    else if([UIScreen mainScreen].bounds.size.width>320)
    {
        mainscroll.contentSize = CGSizeMake(0, 590);
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
     */
    // Do any additional setup after loading the view.
    
    mainscroll.hidden=YES;
    if ([UIScreen mainScreen].bounds.size.width==320)
    {
        mainscroll.contentSize = CGSizeMake(0, 500);
    }
    else if([UIScreen mainScreen].bounds.size.width>320)
    {
        mainscroll.contentSize = CGSizeMake(0, 590);
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
 //   NSLog(@"before=%@",didappear);
    [self PortfolioViewUrl];
   didappear=1;
   lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
     
    
}
-(void)Popaction_method6
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
   
    [self viewDidLoad];
     didappear=0;
}
-(void)Popaction_method7
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
   
    [self viewDidLoad];
     didappear=0;
}
-(void)Popaction_methodFromItem
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    
    [self viewDidLoad];
    didappear=0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PUSHTOPORTFOLIOITEM:(id)sender
{
    portfolioitemViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"portfolioitemviewcontroller"];
    pdvc.PopDelegateFromItem=self;
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
                    
                    
                    lblTitle.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"PortfolioName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"PortfolioName"]  forKey:@"PortfolioName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"PortfolioTypeCode"]  forKey:@"PortfolioTypeCode"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[result valueForKey:@"ResultInfo"] valueForKey:@"Address1"]  forKey:@"Address1"];
                    lbladdress.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Address1"];
                //    lblNoOfItem.text=[NSString stringWithFormat:@"You have "@"%@"@" items in your portfolio",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductCount"]];
                    lblNoOfItem.text=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductCount"]];
                    
                    // thousand comma separetor
                    NSNumberFormatter *numberFormatter1 = [[NSNumberFormatter alloc] init];
                    [numberFormatter1 setGroupingSeparator:@","];
                    [numberFormatter1 setGroupingSize:3];
                    [numberFormatter1 setUsesGroupingSeparator:YES];
                    [numberFormatter1 setDecimalSeparator:@"."];
                    [numberFormatter1 setNumberStyle:NSNumberFormatterDecimalStyle];
                    [numberFormatter1 setMaximumFractionDigits:2];
                    NSString *theString1 = [numberFormatter1 stringFromNumber:[NSNumber numberWithDouble:[[[result objectForKey:@"ResultInfo"] valueForKey:@"TotalCover"] doubleValue]]];
                    lbltotalcover.text=[@"£ " stringByAppendingString:theString1];
                    
                 //   lbltotalcover.text=[@"£ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"TotalCover"]]];
                    
                    // thousand comma separetor
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    [numberFormatter setGroupingSeparator:@","];
                    [numberFormatter setGroupingSize:3];
                    [numberFormatter setUsesGroupingSeparator:YES];
                    [numberFormatter setDecimalSeparator:@"."];
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    [numberFormatter setMaximumFractionDigits:2];
                    NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[[[result objectForKey:@"ResultInfo"] valueForKey:@"TotalValue"] doubleValue]]];
                    lbltotalValue.text=[@"£ " stringByAppendingString:theString];
                   
                    
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
                    
                //    mainscroll.hidden=NO;
                    if ([insured isEqualToString:@"0"])
                    {
                        lblinsureexpiry.hidden=YES;
                        lblexpiryDate.hidden=YES;
                        if (didappear)
                        {
                            lbltotalValue.frame=CGRectMake(lbltotalValue.frame.origin.x, lbltotalValue.frame.origin.y+12, lbltotalValue.frame.size.width, lbltotalValue.frame.size.height);
                            lblTolalValuable.frame=CGRectMake(lblTolalValuable.frame.origin.x, lblTolalValuable.frame.origin.y+12, lblTolalValuable.frame.size.width, lblTolalValuable.frame.size.height);
                            lbltotalcover.frame=CGRectMake(lbltotalcover.frame.origin.x, lbltotalcover.frame.origin.y+12, lbltotalcover.frame.size.width, lbltotalcover.frame.size.height);
                            lblTotalCover1.frame=CGRectMake(lblTotalCover1.frame.origin.x, lblTotalCover1.frame.origin.y+12, lblTotalCover1.frame.size.width, lblTotalCover1.frame.size.height);
                            dividerImg.frame=CGRectMake(dividerImg.frame.origin.x, dividerImg.frame.origin.y+12, dividerImg.frame.size.width, dividerImg.frame.size.height);
                            didappear=0;
                        }
                        
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
                        
                    }                     login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
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
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioDocInfoList/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    [ArrDoc removeAllObjects];
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrDoc addObject:tempDict1];
                        
                    }
                    //  ArrFilter = [NSMutableArray arrayWithCapacity:[ArrSummary count]];
                    NSLog(@"summary name=%@",ArrDoc);
                    if (ArrDoc.count>0)
                    {
                        lblNoPortfolioDoc.hidden=YES;
                        tblDoc.frame=CGRectMake(tblDoc.frame.origin.x, tblDoc.frame.origin.y, tblDoc.frame.size.width,43.0*[ArrDoc count]);
                        AddDocView.frame=CGRectMake(AddDocView.frame.origin.x, tblDoc.frame.origin.y+tblDoc.frame.size.height+3, AddDocView.frame.size.width,AddDocView.frame.size.height);
                        mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+43.0*[ArrDoc count]-86.0);
                        [tblDoc reloadData];
                    }
                    else
                    {
                        lblNoPortfolioDoc.hidden=NO;
                    }
                    mainscroll.hidden=NO;
                    
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
                        
                    }                     login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
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
    NSString *doctype=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocTypeCode"]];
    if ([doctype isEqualToString:@"1"])
    {
        cell.DoctypeImg.image=[UIImage imageNamed:@"Purchase-receipt"];
    }
    else if ([doctype isEqualToString:@"2"])
    {
        cell.DoctypeImg.image=[UIImage imageNamed:@"icon1-1"];
    }
    else if ([doctype isEqualToString:@"99"])
    {
        cell.DoctypeImg.image=[UIImage imageNamed:@"otherDoc"];
    }
    return cell;
  
    
   
    
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (ArrDoc.count>0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        PortfolioDocDetailViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"PortfolioDocDetailViewControllersid"];
        pv2vc.DocCode=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"PortfolioDocCode"]];
        pv2vc.index=indexPath.row;
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
    addportvc.PopDelegate7=self;
    [self.navigationController  pushViewController:addportvc animated:YES];
   
    /*
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
     */
 }

- (IBAction)EditPortfolioClk:(id)sender
{
    EditPortfolioViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditPortfolioViewControllersid"];
    pdvc.PopDelegate6=self;
    [self.navigationController  pushViewController:pdvc animated:YES];
}
@end
