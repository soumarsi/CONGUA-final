//
//  portfolioitemViewController.m
//  CONGUA
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "portfolioitemViewController.h"
#import "portfolioitemprototypecell.h"
#import "portfolioitemprototyoecellheader.h"
#import "PortFolio2ViewController.h"


@interface portfolioitemViewController ()
{
    NSString *lbltext;
}

@end

@implementation portfolioitemViewController
@synthesize mytabview,lblAddress,lblportfilioName,logoimage,lblUserName;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    lblportfilioName.text=[prefs valueForKey:@"PortfolioName"];
    lblAddress.text=[prefs valueForKey:@"Address1"];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    
    if ([[prefs valueForKey:@"PortfolioTypeCode"] integerValue] ==1) {
        logoimage.image=[UIImage imageNamed:@"home"];
    }
    else if ([[prefs valueForKey:@"PortfolioTypeCode"] integerValue] ==2) {
        logoimage.image=[UIImage imageNamed:@"business"];
    }
    else if ([[prefs valueForKey:@"PortfolioTypeCode"] integerValue] ==3) {
        logoimage.image=[UIImage imageNamed:@"personal"];
    }
    else if ([[prefs valueForKey:@"PortfolioTypeCode"] integerValue] ==4) {
        logoimage.image=[UIImage imageNamed:@"other"];
    }

   
    urlobj=[[UrlconnectionObject alloc]init];
    ArrCategory=[[NSMutableArray alloc]init];
    ArrProduct=[[NSMutableArray alloc]init];
    ArrShowProduct=[[NSMutableArray alloc]init];
    
    tappedRow=5000;
    showAllSections = NO;
    
    [self CategoryShowUrl];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}
-(void)CategoryShowUrl
{
    @try {
        
        
        [ArrCategory removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetCategoryInfoList/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrCategory addObject:tempDict1];
                        
                    }
                   
                 //   NSLog(@"category name=%@",ArrCategory);
                    [self ProductShowUrl];
                  //  [mytabview reloadData];
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
-(void)ProductShowUrl
{
    @try {
        
        
        [ArrProduct removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetProductInfoList/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrProduct addObject:tempDict1];
                        
                    }
                   
                //    NSLog(@"product name=%@",ArrProduct);
                    [mytabview reloadData];
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
    int j=0;
 if(ArrShowProduct.count>0)
 {
    if((tappedRow == section)  && (showAllSections==YES))
    {
        
        
       //  NSLog(@"section selected=%ld",(long)section);
        NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"]];
        //  NSLog(@"catcode=%@",catCode);
        for (int i=0; i<[ArrProduct count]; i++)
        {
            
            NSString *Code=[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:i] valueForKey:@"CategoryCode"]];
            //   NSLog(@"code=%@",Code);
            if ([catCode isEqualToString:Code])
            {
                j++;
            }
            //  NSLog(@"j=%d",j);
        }
    }
    else
    {
     //   NSLog(@"section not selected=%ld",(long)section);
        j=0;
        
    }
    
 }
   
   
    return j;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid=@"portfolioitemprototyoecell";
    portfolioitemprototypecell *cell=(portfolioitemprototypecell *)[tableView dequeueReusableCellWithIdentifier:cellid];
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (ArrShowProduct.count>0)
    {
        cell.framelbl.text=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductName"]];
        cell.lblProductCost.text=[@"$ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductValue"]]];
    }
    
    /*
    NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:indexPath.section] valueForKey:@"CategoryCode"]];
     NSLog(@"cat code=%@",catCode);
    NSString *Code=[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"]];
    if ([catCode isEqualToString:Code])
    {
        NSLog(@"entry");
        
        cell.framelbl.text=[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:indexPath.row] valueForKey:@"ProductName"]];
        cell.lblProductCost.text=[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:indexPath.row] valueForKey:@"PurchaseValue"]];
    }
    */
    
    
     return cell;
}
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    
   //  if (section>0) return YES;
    NSLog(@"header");
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  portfolioitemprototyoecellheader  * headerCell = [tableView dequeueReusableCellWithIdentifier:@"portfolioitemprototyoecellheader"];
    
    headerCell.btndropdown.tag=section;
 //   categoryCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"]];
    [headerCell.btndropdown addTarget:self action:@selector(DropDownClk:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *BtnAdd=(UIButton *)[headerCell viewWithTag:2];
    
    BtnAdd.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
    [BtnAdd addTarget:self action:@selector(AddProductClk:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *lbl=(UILabel *)[headerCell viewWithTag:1];
    
    lbl.text=[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryName"];
    
  
    return headerCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    if (ArrShowProduct.count>0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        PortFolio2ViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"portfolio2viewcontroller"];
        pv2vc.ProductCode=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductCode"]];
        
        [self.navigationController pushViewController:pv2vc animated:YES];
    }
    
   
     
}

-(void)DropDownClk:(UIButton *)sender
{
    /*
    if (sender.selected==YES && showAllSections)
    {
        sender.selected=NO;
       showAllSections=NO;
    }
    else
    {
        sender.selected=YES;
        NSLog(@"selected");
       showAllSections=YES;
    }
    */
    [UIView animateWithDuration:0.5 animations:^{
        
    if(!showAllSections){
        
        showAllSections=YES;
        sender.selected=YES;
        if (ArrCategory.count>0)
        {
            
            NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:sender.tag] valueForKey:@"CategoryCode"]];
            //    NSLog(@"cat code=%@",catCode);
            [ArrShowProduct removeAllObjects];
            
            for (int i=0; i<[ArrProduct count]; i++)
            {
                ProductDic=[[NSMutableDictionary alloc]init];
                NSString *Code=[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:i] valueForKey:@"CategoryCode"]];
                if ([catCode isEqualToString:Code])
                {
                    //   NSLog(@"code=%@",Code);
                    //    NSLog(@"product name=%@",[[ArrProduct objectAtIndex:i] valueForKey:@"ProductName"]);
                    [ProductDic setObject:[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:i] valueForKey:@"ProductCode"]] forKey:@"ProductCode"];
                    [ProductDic setObject:[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:i] valueForKey:@"PurchaseValue"]] forKey:@"ProductValue"];
                    [ProductDic setObject:[NSString stringWithFormat:@"%@",[[ArrProduct objectAtIndex:i] valueForKey:@"ProductName"]] forKey:@"ProductName"];
                    
                    [ArrShowProduct addObject:ProductDic];
                }
                
            }
            //    NSLog(@"show product=%@",ArrShowProduct);
        }
        
        
        
    }else{
        
        showAllSections=NO;
        sender.selected=NO;
    }
        tappedRow = sender.tag;
        //  NSLog(@"tag=========================================%ld",(long)tappedRow);
        [mytabview reloadData];
   
    } completion:^(BOOL finished) {
        
       
    }];
   
    
 
}
-(void)AddProductClk:(UIButton *)sender
{
  //  NSLog(@"OKkkkkk");
    AddProductViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
    addportvc.CategoryCode=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];

}

- (IBAction)backtoportdetail:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ArrCategory count];
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

- (IBAction)AddCategoryClk:(id)sender {
    
    AddCategoryViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCategoryViewControllersid"];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}
@end
