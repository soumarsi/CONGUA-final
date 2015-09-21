//
//  ViewController.m
//  CONGUA
//
//  Created by Soumen on 26/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ViewController.h"
#import "headerview.h"
#import "prototypecell.h"
#import "AddPortfolioViewController.h"
#import "portfoliodetailpageViewController.h"
#import "menu.h"

NSInteger flag=0;
menu *menuview;

@interface ViewController ()

@end

@implementation ViewController
@synthesize tabview,searchbar,btnsearch,btnsearchicon,contentview,lblUserName,lblNoresultFound;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    NSLog(@"Customer Code=%@",CustomerCode);
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    urlobj=[[UrlconnectionObject alloc]init];
    ArrSummary=[[NSMutableArray alloc]init];
      ArrFilter=[[NSMutableArray alloc]init];
    Issearch=0;
    searchbar.text=nil;
    [self SummaryShowUrl];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    /*
        [self.tabview setFrame:CGRectMake(0,154, self.view.frame.size.width, self.view.frame.size.height-154)];
    if (self.view.frame.size.width==375 && self.view.frame.size.height==667) {
        [self.tabview setFrame:CGRectMake(0,167, self.view.frame.size.width, self.view.frame.size.height-167)];
    }
    if (self.view.frame.size.width==414 && self.view.frame.size.height==736) {
        [self.tabview setFrame:CGRectMake(0,200, self.view.frame.size.width, self.view.frame.size.height-200)];
    }
*/
    UIColor *color = [UIColor colorWithRed:(33.0f/255.0f) green:(32.0f/255.0f) blue:(32.0f/255.0f) alpha:0.65f];
    _searchtextbox.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];

    
    
    [searchbar setBackgroundColor:[UIColor clearColor]];
    //   searchbar.barTintColor = [UIColor colorWithRed:(35/255.0f) green:(154/255.0f) blue:(242/255.0f) alpha:1];
    UITextField *searchField = [searchbar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor blackColor];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    //    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"custom_srchbar_new"]forState:UIControlStateNormal];
    
    //hides search icon from left of bar
//    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setLeftViewMode:UITextFieldViewModeNever];

}
- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
      //  NSLog(@"screen size");
   // tabview.frame = CGRectMake(0,140,self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height-135);
    }
    else
    {
        tabview.frame = CGRectMake(0,119,self.view.frame.size.width,self.view.frame.size.height-119);
    }
}
-(void)leftclk:(NSInteger)sender
{
   
        if (sender==0) {
       
            MyProfileViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
            [self.navigationController  pushViewController:pdvc animated:YES];
       
    }
    else if (sender==1) {
        
        
        [self LogOutUrl];
        
    }
    
}
-(void)LogOutUrl
{
    @try {
        
        NSString *email,*password,*remember;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if ([[prefs valueForKey:@"remember"] isEqualToString:@"1"])
        {
            email=[prefs valueForKey:@"email"];
            password=[prefs valueForKey:@"password"];
            remember=[prefs valueForKey:@"remember"];
            
        }
        
        NSString *str=[NSString stringWithFormat:@"%@Logout/%@",URL_LINK,AuthToken];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            //    NSLog(@"result=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
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

-(void)SummaryShowUrl
{
    @try {
        
       
        [ArrSummary removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetPortfolioInfoList/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrSummary addObject:tempDict1];
                        
                    }
                   //  ArrFilter = [NSMutableArray arrayWithCapacity:[ArrSummary count]];
                 //   NSLog(@"summary name=%@",ArrSummary);
                    [tabview reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count=%lu",(unsigned long)[ArrSummary count]);
    if (Issearch==0)
    {
        return [ArrSummary count];
    }
      else if (Issearch==1)
      {
          return [ArrFilter count];
      }
      else
      {
          return 0;
      }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"prototypecell";
    prototypecell *cell=(prototypecell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (Issearch==0)
    {
        if (ArrSummary.count>0)
        {
            static NSString *cellid=@"prototypecell";
            prototypecell *cell=(prototypecell *)[tableView dequeueReusableCellWithIdentifier:cellid];
            
            cell.addrImg.hidden=NO;
        cell.celltitlelbl.text=[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioName"];
        cell.celladdresslbl.text=[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"Address1"];
           
            if([[NSString stringWithFormat:@"%@",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"ProductCount"]] isEqualToString:@"1"])
            {
                 cell.lblactive.text=[NSString stringWithFormat:@"%@ %@ %@",@"Total",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"ProductCount"],@"item"];
            }
            else
            {
                 cell.lblactive.text=[NSString stringWithFormat:@"%@ %@ %@",@"Total",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"ProductCount"],@"items"];
            }
       
            if([[NSString stringWithFormat:@"%@",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"IsInsured"]] isEqualToString:@"0"])
            {
                 cell.lblinsured.text=@"Not Insured";
                cell.lblinsured.textColor=[UIColor blackColor];
                cell.tickImg.hidden=YES;
              //  cell.lblinsured.textAlignment=NSTextAlignmentRight;
            }
            else if([[NSString stringWithFormat:@"%@",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"IsInsured"]] isEqualToString:@"1"])
            {
                cell.lblinsured.text=@"Insured";
             //   cell.lblinsured.textColor=[UIColor colorWithRed:(137.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
             //   cell.lblinsured.textAlignment=NSTextAlignmentRight;
                cell.lblinsured.textColor=[UIColor colorWithRed:(32.0/255.0) green:(138.0/255.0) blue:(83.0/255.0) alpha:1.0];
                cell.tickImg.hidden=NO;
            }
         
     //   cell.lblinsured.text=[NSString stringWithFormat:@"%@",[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"IsInsured"]];
        
        if ([[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
            cell.cellIcon.image=[UIImage imageNamed:@"home"];
        }
        else if ([[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==2) {
            cell.cellIcon.image=[UIImage imageNamed:@"business"];
        }
        else if ([[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==3) {
            cell.cellIcon.image=[UIImage imageNamed:@"personal"];
        }
        else if ([[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==4) {
            cell.cellIcon.image=[UIImage imageNamed:@"other"];
        }
            return cell;
        }
        
        
    }
    else if (Issearch==1)
    {
        if (ArrFilter.count>0)
        {
            static NSString *cellid=@"ProductCell";
            ProductCell *cell=(ProductCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
            
          
            cell.lblName.text=[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"ProductName"];
            cell.lblDate.text=[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PurchaseDate"];
            cell.lblValue.text=[ NSString stringWithFormat:@"%@",[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PurchaseValue"]];

            
            if([[NSString stringWithFormat:@"%@",[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"IsInsuredWithPortfolio"]] isEqualToString:@"0"])
            {
                cell.lblInsured.text=@"Not Insured";
                cell.lblInsured.textColor=[UIColor blackColor];
                cell.insureImg.hidden=YES;
            }
            else if([[NSString stringWithFormat:@"%@",[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"IsInsuredWithPortfolio"]] isEqualToString:@"1"])
            {
                cell.lblInsured.text=@"Insured";
                cell.lblInsured.textColor=[UIColor colorWithRed:(32.0/255.0) green:(138.0/255.0) blue:(83.0/255.0) alpha:1.0];
                cell.insureImg.hidden=NO;
            }
            
//            if ([[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
//                cell.cellIcon.image=[UIImage imageNamed:@"home"];
//            }
//            else if ([[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==2) {
//                cell.cellIcon.image=[UIImage imageNamed:@"business"];
//            }
//            else if ([[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==3) {
//                cell.cellIcon.image=[UIImage imageNamed:@"personal"];
//            }
//            else if ([[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PortfolioTypeCode"] integerValue] ==4) {
//                cell.cellIcon.image=[UIImage imageNamed:@"other"];
//            }
            return cell;
        }
        else
        {
        }
       
    }
   
    return cell;
}
- (IBAction)PUSHTOADDPORTFOLIO:(id)sender {
    
    
    AddPortfolioViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"addportfolio"];
    
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (Issearch==0)
    {
        
        
        if (ArrSummary.count>0)
        {
           
            
             [[NSUserDefaults standardUserDefaults] setObject:[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioCode"]  forKey:@"PortfolioCode"];
            
           
            
            
            portfoliodetailpageViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"portfoliodetailpageviewcontroller"];
         //   pdvc.PortfolioCode=[[ArrSummary objectAtIndex:indexPath.row] valueForKey:@"PortfolioCode"];
            [self.navigationController  pushViewController:pdvc animated:YES];
        }
        
       
    }
    else if (Issearch==1)
    {
        
        if (ArrFilter.count>0)
        {
//        portfoliodetailpageViewController * pdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"portfoliodetailpageviewcontroller"];
//        [[NSUserDefaults standardUserDefaults] setObject:[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"PortfolioCode"]  forKey:@"PortfolioCode"];
//        [self.navigationController  pushViewController:pdvc animated:YES];
      
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            PortFolio2ViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"portfolio2viewcontroller"];
            pv2vc.ProductCode=[NSString stringWithFormat:@"%@",[[ArrFilter objectAtIndex:indexPath.row] valueForKey:@"ProductCode"]];
         //   pv2vc.PopDelegate5=self;
            [self.navigationController pushViewController:pv2vc animated:YES];
        }
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


- (IBAction)SearchClick:(id)sender
{
    if (btnsearch.selected==NO)
    {
        btnsearch.selected=YES;
        searchbar.hidden=NO;
        btnsearch.hidden=YES;
        btnsearchicon.hidden=YES;
        
    }
}
- (IBAction)searchiconclick:(id)sender
{
    if (btnsearch.selected==NO)
    {
        btnsearch.selected=YES;
        searchbar.hidden=NO;
        btnsearch.hidden=YES;
        btnsearchicon.hidden=YES;
        
    }

}

- (IBAction)LeftMenuClk:(id)sender
{
  //  [self LogOutUrl];
   
  //  [self.navigationController popViewControllerAnimated:YES];
    if(contentview.center.x==self.view.frame.size.width/2)
    {
      
        [searchbar resignFirstResponder];
      
        //     [mainscroll setContentOffset:CGPointMake(0,0) animated:YES];
        
        [leftView removeFromSuperview];
        leftView = [LeftMenuView leftmenu];
        NSLog(@"left menu");
        [leftView leftmenumethod];
        [leftView tapCheck:1];
        
        leftView.frame = CGRectMake(-160, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
        leftView.leftDelegate=self;
    //    [leftView.btnprofImg addTarget:self action:@selector(ProfilebuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftView];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            contentview.center = CGPointMake([[UIScreen mainScreen] bounds].size.width+60,self.view.center.y);
            
            leftView.frame = CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
        // [UIView commitAnimations];
    }
    else
    {
        //            [UIView beginAnimations:@"ToggleViews" context:nil];
        //            [UIView setAnimationRepeatCount:1];
        //            [UIView setAnimationRepeatAutoreverses:NO];
        //            mainview.center = CGPointMake(self.view.center.x,
        //                                          self.view.center.y);
        //    leftView.frame=CGRectMake(self.view.frame.origin.x-[[UIScreen mainScreen] bounds].size.width/2-60, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            contentview.center = CGPointMake(self.view.center.x,self.view.center.y);
            
            leftView.frame = CGRectMake(-leftView.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/2+60, self.view.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [leftView removeFromSuperview];
            [UIView commitAnimations];
        }];
        
        
        
        
        
        
        
        
        
        
        
    }
     
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
   
    tabview.hidden=YES;
    Issearch=1;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
    searchBar.text=@"";
    lblNoresultFound.hidden=YES;
        Issearch=0;
    [tabview reloadData];
    tabview.hidden=NO;
        [searchbar resignFirstResponder];
 //   searchbar.hidden=YES;
 //   btnsearch.hidden=NO;
 //   btnsearchicon.hidden=NO;
 //   btnsearch.selected=NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
   
    
    if(searchBar.text.length > 0) {
        NSLog(@"searchbar is");
        
        Issearch=1;
        [searchBar setShowsCancelButton:YES];
        [ArrFilter removeAllObjects];
        [self ProductShowUrl:searchText];
        // Filter the array using NSPredicate
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"PortfolioName contains[c] %@",searchText];
//        ArrFilter = [NSMutableArray arrayWithArray:[ArrSummary filteredArrayUsingPredicate:predicate]];
        
        
    }
    else {
        NSLog(@"searchbar is NOT");
        
        //    arrtask = [appDelegate.searchArray copy];
        //    [tbltask reloadData];
        
    }
    
    
   
    
}
-(void)ProductShowUrl:(NSString *)text
{
    @try {
        
        
        [ArrFilter removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@SearchProductInfoList/%@?CustomerCode=%@&Keyword=%@",URL_LINK,AuthToken,CustomerCode,text];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
              //  NSLog(@"result=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                  //  NSLog(@"result=%@",[result objectForKey:@"ResultInfo"]);
                    for ( NSDictionary *tempDict2 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrFilter addObject:tempDict2];
                        
                    }
                   
                    if (ArrFilter.count==0)
                    {
                        lblNoresultFound.hidden=NO;
                    }
                    else
                    {
                        lblNoresultFound.hidden=YES;
                        
                    }
                    [tabview reloadData];
                    tabview.hidden=NO;
                    //         [tabview reloadData];
                    //        tabview.hidden=NO;
                    NSLog(@"filter=%@",ArrFilter);
                    
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

@end
