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


@interface portfolioitemViewController ()<UIAlertViewDelegate>
{
    NSString *lbltext;
}

@end

@implementation portfolioitemViewController
@synthesize mytabview,lblAddress,lblportfilioName,logoimage,lblUserName,mainscroll,AddProductView;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.width==320)
    {
        mainscroll.contentSize = CGSizeMake(0, 491);
    }
    else if([UIScreen mainScreen].bounds.size.width>320)
    {
        mainscroll.contentSize = CGSizeMake(0, 590);
    }
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
                    NSMutableDictionary *tempDict2=[[NSMutableDictionary alloc]init];
                    [tempDict2 setObject:@"0" forKey:@"CategoryCode"];
                    [tempDict2 setObject:@"Other" forKey:@"CategoryName"];
                    [ArrCategory addObject:tempDict2];
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
                    if (ArrCategory.count>7) {
                        mytabview.frame=CGRectMake(mytabview.frame.origin.x, mytabview.frame.origin.y, mytabview.frame.size.width,50.0*[ArrCategory count]);
                        AddProductView.frame=CGRectMake(AddProductView.frame.origin.x, mytabview.frame.origin.y+mytabview.frame.size.height+3, AddProductView.frame.size.width,AddProductView.frame.size.height);
                        mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+50.0*[ArrCategory count]-330.0);
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
        cell.lblProductCost.text=[@"£ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductValue"]]];
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
    
    /*
    UIButton *BtnAdd=(UIButton *)[headerCell viewWithTag:2];
    
    BtnAdd.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
    [BtnAdd addTarget:self action:@selector(AddProductClk:) forControlEvents:UIControlEventTouchUpInside];
   */
    UILabel *lbl=(UILabel *)[headerCell viewWithTag:1];
    
    lbl.text=[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryName"];
  
    if([[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue]==0)
    {
        headerCell.btnEdit.hidden=YES;
        headerCell.btnDelete.hidden=YES;
    }
    else
    {
    //scroll on header to show edit and delete
     [headerCell.headerCellScroll setContentSize:CGSizeMake(self.view.frame.size.width+headerCell.btnEdit.frame.size.width+headerCell.btnDelete.frame.size.width,headerCell.frame.size.height)];
    headerCell.btnEdit.frame=CGRectMake(self.view.frame.size.width, 0, headerCell.btnEdit.frame.size.width, headerCell.btnEdit.frame.size.height);
     headerCell.btnDelete.frame=CGRectMake(self.view.frame.size.width+headerCell.btnEdit.frame.size.width, 0, headerCell.btnDelete.frame.size.width, headerCell.btnDelete.frame.size.height);
    
    
        headerCell.btnEdit.hidden=NO;
        headerCell.btnDelete.hidden=NO;
    headerCell.btnEdit.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
    [headerCell.btnEdit addTarget:self action:@selector(EditCategoryClk:) forControlEvents:UIControlEventTouchUpInside];
    
    headerCell.btnDelete.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
   
    [headerCell.btnDelete addTarget:self action:@selector(DeleteCategoryClk:) forControlEvents:UIControlEventTouchUpInside];
    }
    /*
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft );
    [headerCell addGestureRecognizer:swipeGesture];
   */
    return headerCell;
}
/*
- (void)swipedScreen:(UISwipeGestureRecognizer*)gesture
{
    
        NSLog(@"left swipe");
        //Get the cell out of the table view
       portfolioitemprototyoecellheader  * cell1 = [mytabview dequeueReusableCellWithIdentifier:@"portfolioitemprototyoecellheader"];
    
        if(cell1.center.x==160)
        {
            
            [UIView beginAnimations:@"ToggleViews" context:nil];
            [UIView setAnimationRepeatCount:1];
            [UIView setAnimationRepeatAutoreverses:NO];
            cell1.center = CGPointMake(cell1.center.x-70,cell1.center.y);
            NSLog(@"cell center=%f",cell1.center.x);
            [UIView commitAnimations];
            UIView *swipeview = [[UIView alloc] initWithFrame: CGRectMake (250,0,70,70)];
            [cell1.contentView addSubview: swipeview];
            swipeview.backgroundColor=[UIColor redColor];
            UIButton  *btncelldelete = [UIButton buttonWithType:UIButtonTypeCustom];
            btncelldelete.frame = CGRectMake(0, 0,70, 70);
            [btncelldelete setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
          //  btncelldelete.tag=indexPath.row;
            [btncelldelete addTarget:self action:@selector(celldelete:) forControlEvents:UIControlEventTouchUpInside];
            [swipeview addSubview:btncelldelete];
            
            
            UIButton *btncelledit = [UIButton buttonWithType:UIButtonTypeCustom];
            btncelledit.frame = CGRectMake(70, 0,70, 70);
            [btncelledit setBackgroundImage:[UIImage imageNamed:@"pencis.png"] forState:UIControlStateNormal];
          //  btncelledit.tag=indexPath.row;
            [btncelledit addTarget:self action:@selector(celledit:) forControlEvents:UIControlEventTouchUpInside];
            [swipeview addSubview:btncelledit];
        }
    

}
*/
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
-(void)DeleteCategoryUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeleteCategory/%@?PortfolioCode=%@&CategoryCode=%@",URL_LINK,AuthToken,PortfolioCode,categoryCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                NSLog(@"array=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /* UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [aler show];
                     */
                  //  [self.navigationController popViewControllerAnimated: YES];
                    [self CategoryShowUrl];
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
-(void)EditCategoryClk:(UIButton *)sender
{
    categoryCode=[NSString stringWithFormat:@"%d",sender.tag];
    //  NSLog(@"OKkkkkk");
    
     EditCategoryViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditCategoryViewControllersid"];
     addportvc.CategoryCode=[NSString stringWithFormat:@"%d",sender.tag];
     [self presentViewController:addportvc
     animated:YES
     completion:NULL];
    
}
-(void)DeleteCategoryClk:(UIButton *)sender
{
    categoryCode=[NSString stringWithFormat:@"%d",sender.tag];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do you want to Delete This Category?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else
    {
        [self DeleteCategoryUrl];
        
        
    }
    
    
}
-(void)AddProductClk:(UIButton *)sender
{
  //  NSLog(@"OKkkkkk");
    /*
    AddProductViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
    addportvc.CategoryCode=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
*/
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
    
    //add product
    AddProductViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
  //  addportvc.CategoryCode=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}

- (IBAction)AddCategoryPlusClick:(id)sender
{
    AddCategoryViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCategoryViewControllersid"];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}
@end
