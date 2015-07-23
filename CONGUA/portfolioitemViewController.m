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


@interface portfolioitemViewController ()<UIAlertViewDelegate,PopView_delegate3,PopView_delegate4,PopView_delegate5>
{
    NSString *lbltext;
}

@end

@implementation portfolioitemViewController
@synthesize mytabview,lblAddress,lblportfilioName,logoimage,lblUserName,mainscroll,AddProductView,PopDelegateFromItem,dicBtn,dicTab,prev;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainscroll.hidden=YES;
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
    
    
    dicTab=[[NSMutableDictionary alloc]init];
    
    dicBtn=[[NSMutableDictionary alloc]init];
    
    tappedRow=5000;
    showAllSections = NO;
    
    
    
    [self CategoryShowUrl];
   
}
-(void)Popaction_method3
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)Popaction_method4
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)Popaction_method5
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)Popaction_methodFromAddProduct
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
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
                    
                    else
                    {
                        mytabview.frame=CGRectMake(mytabview.frame.origin.x, mytabview.frame.origin.y, mytabview.frame.size.width,50.0*[ArrCategory count]);
                        AddProductView.frame=CGRectMake(AddProductView.frame.origin.x, mytabview.frame.origin.y+mytabview.frame.size.height+3, AddProductView.frame.size.width,AddProductView.frame.size.height);
                    }
                    
                //    NSLog(@"product name=%@",ArrProduct);
                    [mytabview reloadData];
                    mainscroll.hidden=NO;
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
  //  if(ArrShowProduct.count>0)
  //  {
        NSString *sectionNo=[NSString stringWithFormat:@"%ld",(long)section];
        if([dicTab valueForKey:sectionNo])
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
            j=0;
        
        
 //   }
    
    
    return j;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIden=[NSString stringWithFormat:@"Cell for section %ld",(long)indexPath.section];
    
    
    
    
  //  UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellIden];
    UITableViewCell *myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    
    //    if (indexPath.row % 2)
    //    {
    //        myCell.backgroundColor=[UIColor grayColor];
    //    }
    //
    
    
    
    if(myCell==nil)
        
    {
        myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        //
        //        if (indexPath.row % 2) {
        //            myCell.backgroundColor=[UIColor blueColor];
        //        }
        //
        
    }
    
    
    
    
    myCell.backgroundColor=[UIColor clearColor];
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, mytabview.frame.size.width, 50)];
    headerView.backgroundColor=[UIColor colorWithRed:(245.0/255.0) green:(245.0/255.0) blue:(245.0/255.0) alpha:1.0];
    [myCell addSubview:headerView];
    
    UILabel *productLbl=[[UILabel alloc]initWithFrame:CGRectMake(22, 15, 200, 25)];
    //   headLbl.text=[NSString stringWithFormat:@"Section %ld",(long)section];
    
    productLbl.text=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductName"]];;
    productLbl.textColor=[UIColor blackColor];
    [productLbl setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Th" size:16]];
    [headerView addSubview:productLbl];
    
    UILabel *costLbl=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width-120, 15, 100, 25)];
    //   headLbl.text=[NSString stringWithFormat:@"Section %ld",(long)section];
    
    costLbl.text=[@"£ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductValue"]]];
    costLbl.textAlignment=NSTextAlignmentRight;
    costLbl.textColor=[UIColor blackColor];
    [costLbl setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Th" size:16]];
    [headerView addSubview:costLbl];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-1, mytabview.frame.size.width, 1)];
    lineView.backgroundColor=[UIColor colorWithRed:(220.0/255.0) green:(220.0/255.0) blue:(220.0/255.0) alpha:1.0];
    [headerView addSubview:lineView];
 //   myCell.textLabel.text=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductName"]];
    /*
    if (ArrShowProduct.count>0)
    {
        cell.framelbl.text=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductName"]];
        cell.lblProductCost.text=[@"£ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductValue"]]];
    }
    */
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
    
    
     return myCell;
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
    hScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mytabview.frame.size.width, 59)];
    hScroll.backgroundColor=[UIColor clearColor];
    hScroll.tag=section;
    hScroll.showsHorizontalScrollIndicator=NO;
    hScroll.showsVerticalScrollIndicator=NO;
//    NSLog(@"scroll height=%f",hScroll.frame.size.height);
    //headerView.alpha=0.4;
    
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(22, 15, 200, 25)];
    //   headLbl.text=[NSString stringWithFormat:@"Section %ld",(long)section];
    headLbl.text=[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryName"];
    headLbl.textColor=[UIColor colorWithRed:(219.0/255.0) green:(53.0/255.0) blue:(43.0/255.0) alpha:1.0];
    [headLbl setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Th" size:20]];
    //headLbl.backgroundColor=[UIColor whiteColor];
    
    headerButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 15, 25, 25)];
    dropdownButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 2, self.view.bounds.size.width-10, hScroll.bounds.size.height-2)];
    // _headerButton.backgroundColor=[UIColor blackColor];
    headerButton.tag=section;
    dropdownButton.tag=section;
    
    EditButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, 59, 59)];
    [EditButton setImage:[UIImage imageNamed:@"Edit-1"] forState:UIControlStateNormal];
    EditButton.hidden=YES;
    [hScroll addSubview:EditButton];
    
    DeleteButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width+59, 0, 59, 59)];
    [DeleteButton setImage:[UIImage imageNamed:@"delete-1"] forState:UIControlStateNormal];
    DeleteButton.hidden=YES;
    [hScroll addSubview:DeleteButton];
    
    NSString *key=[NSString stringWithFormat:@"%ld",(long)section];
    
    
    
    
    [UIView animateWithDuration:2.0 animations:^{
        
        if(![dicBtn valueForKey:key])
            
            [headerButton setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        
        else
            
            [headerButton setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [dropdownButton addTarget:self action:@selector(DropDownClk:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        
        [hScroll addSubview:headerButton];
        [hScroll addSubview:headLbl];
        [hScroll addSubview:dropdownButton];
        
    }];
    
    // NSLog(@"Button for section %ld is created",(long)section);
    
    
  
    
    
    if (ArrCategory.count>0) {
        
    
    
  
    if([[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue]==0)
    {
        EditButton.hidden=YES;
        DeleteButton.hidden=YES;
    }
    else
    {
    //scroll on header to show edit and delete
     [hScroll setContentSize:CGSizeMake(self.view.frame.size.width+EditButton.frame.size.width+DeleteButton.frame.size.width,40)];
  //  headerCell.btnEdit.frame=CGRectMake(self.view.frame.size.width, 0, headerCell.btnEdit.frame.size.width, headerCell.btnEdit.frame.size.height);
  //   headerCell.btnDelete.frame=CGRectMake(self.view.frame.size.width+headerCell.btnEdit.frame.size.width, 0, headerCell.btnDelete.frame.size.width, headerCell.btnDelete.frame.size.height);
    
    
        EditButton.hidden=NO;
        DeleteButton.hidden=NO;
    EditButton.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
    [EditButton addTarget:self action:@selector(EditCategoryClk:) forControlEvents:UIControlEventTouchUpInside];
    
    DeleteButton.tag=[[[ArrCategory objectAtIndex:section] valueForKey:@"CategoryCode"] integerValue];
   
    [DeleteButton addTarget:self action:@selector(DeleteCategoryClk:) forControlEvents:UIControlEventTouchUpInside];
    }
    }
    return hScroll;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ArrCategory.count>0)
    {
        
        NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:indexPath.section] valueForKey:@"CategoryCode"]];
        NSLog(@"cat code=%@",catCode);
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
   
    if (ArrShowProduct.count>0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        PortFolio2ViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"portfolio2viewcontroller"];
        pv2vc.ProductCode=[NSString stringWithFormat:@"%@",[[ArrShowProduct objectAtIndex:indexPath.row] valueForKey:@"ProductCode"]];
        pv2vc.PopDelegate5=self;
        [self.navigationController pushViewController:pv2vc animated:YES];
    }
    
   
     
}

-(void)DropDownClk:(id)sender
{
    
    UIButton *tapped_button=(UIButton *)(id)sender;
    
    UIView *supView=[tapped_button superview];
    
    NSLog(@"Superview tag is: %ld and prev value is: %ld",(long)supView.tag,(long)prev);
    
    NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
    
    
    NSInteger section=supView.tag;
    
    
    
    if(![dicBtn valueForKey:key])
    {
        
        prev=supView.tag;
        
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        
        [dicTab setObject:@"YES" forKey:key];
        
        [dicBtn setObject:@"YES" forKey:key];
        
        
        if (ArrCategory.count>0)
        {
            
            NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:supView.tag] valueForKey:@"CategoryCode"]];
            NSLog(@"cat code=%@",catCode);
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
                    
                    // only for table height
                    row++;
                }
                
            }
            //    NSLog(@"show product=%@",ArrShowProduct);
                if(ArrShowProduct.count>0)
                {
            mytabview.frame=CGRectMake(mytabview.frame.origin.x, mytabview.frame.origin.y, mytabview.frame.size.width,50.0*[ArrCategory count]+40*row);
            AddProductView.frame=CGRectMake(AddProductView.frame.origin.x, mytabview.frame.origin.y+mytabview.frame.size.height+3, AddProductView.frame.size.width,AddProductView.frame.size.height);
            mainscroll.contentSize = CGSizeMake(0, AddProductView.frame.size.height+AddProductView.frame.origin.y);
                }
        }
        
        
        
    //    if(ArrShowProduct.count>0)
    //    {
            NSLog(@"reloading....");
        [mytabview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
   //     }
        
    }
    
    else
    {
        NSLog(@"Entering second condition...");
        
        if (ArrCategory.count>0)
        {
            
            NSString *catCode=[NSString stringWithFormat:@"%@",[[ArrCategory objectAtIndex:supView.tag] valueForKey:@"CategoryCode"]];
            NSLog(@"cat code=%@",catCode);
            [ArrShowProduct removeAllObjects];
            
            // only for table height
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
                    
                    // only for table height
                  //  [ArrAllProduct addObject:ProductDic];
                    row--;
                }
                
            }
        }
        if(ArrShowProduct.count>0)
        {
        mytabview.frame=CGRectMake(mytabview.frame.origin.x, mytabview.frame.origin.y, mytabview.frame.size.width,50.0*[ArrCategory count]+40*row);
        AddProductView.frame=CGRectMake(AddProductView.frame.origin.x, mytabview.frame.origin.y+mytabview.frame.size.height+3, AddProductView.frame.size.width,AddProductView.frame.size.height);
        mainscroll.contentSize = CGSizeMake(0, AddProductView.frame.size.height+AddProductView.frame.origin.y);
        }
        NSString *key=[NSString stringWithFormat:@"%ld",(long)supView.tag];
        
        
        [dicTab removeObjectForKey:key];
        
        [dicBtn removeObjectForKey:key];
        
   //     if(ArrShowProduct.count>0)
   //     {
        [mytabview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
  //      }
       
        
    }

   
    
 
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
    addportvc.PopDelegate4=self;
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
    [PopDelegateFromItem Popaction_methodFromItem];
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
    addportvc.PopDelegateFromAddProduct=self;
  //  addportvc.CategoryCode=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}

- (IBAction)AddCategoryPlusClick:(id)sender
{
    AddCategoryViewController *addportvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCategoryViewControllersid"];
    addportvc.PopDelegate3=self;
    [self presentViewController:addportvc
                       animated:YES
                     completion:NULL];
}
@end
