//
//  PortFolio2ViewController.m
//  CONGUA
//
//  Created by Soumen on 30/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "PortFolio2ViewController.h"
#import "PortFolio2PrototypeTableViewCell.h"

@interface PortFolio2ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,PopView_delegate,PopView_delegate1,PopView_delegate2>

@end

@implementation PortFolio2ViewController
@synthesize ProductCode,portfoliotabview,tblDoc,tblPhoto,lblUserName,mainscroll,btnPhoto,btnPhotoPlus,photoUpperLineView,lblPhoto,PopDelegate5;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"product Code.......%@",ProductCode);
    [[NSUserDefaults standardUserDefaults] setObject:ProductCode forKey:@"ProductCode"];
    self.portfoliotabview.delegate=self;
    self.portfoliotabview.dataSource=self;
    
    //   AddProductDocViewController *doc=[[AddProductDocViewController alloc]init];
    //   doc.PopDelegate=self;
    mainscroll.hidden=YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    
    urlobj=[[UrlconnectionObject alloc]init];
    ArrProductDetail=[[NSMutableArray alloc]init];
    ArrDoc=[[NSMutableArray alloc]init];
    ArrImage=[[NSMutableArray alloc]init];
    
    if ([UIScreen mainScreen].bounds.size.width==320)
    {
        mainscroll.contentSize = CGSizeMake(0, 450);
    }
    else if([UIScreen mainScreen].bounds.size.width>320)
    {
        mainscroll.contentSize = CGSizeMake(0, 540);
    }
    [self ProductViewUrl];
   
    // Do any additional setup after loading the view.
}
-(void)Popaction_method
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)Popaction_method1
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)Popaction_method2
{
    NSLog(@"pop view called");
    mainscroll.hidden=YES;
    [self viewDidLoad];
}
-(void)ProductViewUrl
{
    @try {
        
        
        [ArrProductDetail removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetProductInfoDetail/%@?CustomerCode=%@&ProductCode=%@",URL_LINK,AuthToken,CustomerCode,ProductCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                 NSLog(@"array=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                   /*
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrProductDetail addObject:tempDict1];
                        
                    }
                    NSLog(@"array=%@",ArrProductDetail);
                    */
                 //   [portfoliotabview reloadData];
                    PurchaseValue=[@"£ " stringByAppendingString:[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PurchaseValue"]]];
                    NSLog(@"purchase value=%@",PurchaseValue);
                    purchaseDate=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"PurchaseDate"]];
                    purchaseDate = [purchaseDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                    /*
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                    NSDate *dateFromString = [dateFormatter dateFromString:purchaseDate];
                       purchaseDate = [NSString stringWithFormat:@"%@",dateFromString];
                     */
                   ProductName=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"ProductName"]];
                    [portfoliotabview reloadData];
                    [self DocShowUrl];
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
-(void)DocShowUrl
{
    @try {
        
        
        [ArrDoc removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetProductDocInfoList/%@?ProductCode=%@",URL_LINK,AuthToken,ProductCode];
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
                  //  mainscroll.hidden=NO;
                    NSLog(@"summary name=%@",ArrDoc);
                    [tblDoc reloadData];
                    [self ImageShowUrl];
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
-(void)ImageShowUrl
{
    @try {
        
        
        [ArrImage removeAllObjects];
        NSString *str=[NSString stringWithFormat:@"%@GetProductImageInfoList/%@?ProductCode=%@",URL_LINK,AuthToken,ProductCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                    {
                        [ArrImage addObject:tempDict1];
                        
                    }
                    
                    NSLog(@"summary name=%@",ArrImage);
                    [tblPhoto reloadData];
                    if ([UIScreen mainScreen].bounds.size.width==320)
                    {
                        if (ArrDoc.count>2)
                        {
                            
                            mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+44*ArrDoc.count-2*44);
                            tblDoc.frame=CGRectMake(tblDoc.frame.origin.x, tblDoc.frame.origin.y, tblDoc.frame.size.width,44*ArrDoc.count);
                            photoUpperLineView.frame=CGRectMake(photoUpperLineView.frame.origin.x, tblDoc.frame.origin.y+tblDoc.frame.size.height+5, photoUpperLineView.frame.size.width,photoUpperLineView.frame.size.height);
                            btnPhoto.frame=CGRectMake(btnPhoto.frame.origin.x, photoUpperLineView.frame.origin.y+3, btnPhoto.frame.size.width,btnPhoto.frame.size.height);
                            lblPhoto.frame=CGRectMake(lblPhoto.frame.origin.x, photoUpperLineView.frame.origin.y+7, lblPhoto.frame.size.width,lblPhoto.frame.size.height);
                            btnPhotoPlus.frame=CGRectMake(btnPhotoPlus.frame.origin.x, photoUpperLineView.frame.origin.y+10, btnPhotoPlus.frame.size.width,btnPhotoPlus.frame.size.height);
                            tblPhoto.frame=CGRectMake(tblPhoto.frame.origin.x, btnPhoto.frame.origin.y+btnPhoto.frame.size.height+5, tblPhoto.frame.size.width,tblPhoto.frame.size.height);
                            if (ArrImage.count>2)
                            {
                                mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+44*ArrImage.count-2*44);
                                tblPhoto.frame=CGRectMake(tblPhoto.frame.origin.x, tblPhoto.frame.origin.y, tblPhoto.frame.size.width,44*ArrImage.count);
                            }
                            
                        }
                    }
                    else if([UIScreen mainScreen].bounds.size.width>320)
                    {
                        if (ArrDoc.count>3)
                        {
                            
                            mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+44*ArrDoc.count-3*44);
                            tblDoc.frame=CGRectMake(tblDoc.frame.origin.x, tblDoc.frame.origin.y, tblDoc.frame.size.width,44*ArrDoc.count);
                            photoUpperLineView.frame=CGRectMake(photoUpperLineView.frame.origin.x, tblDoc.frame.origin.y+tblDoc.frame.size.height+5, photoUpperLineView.frame.size.width,photoUpperLineView.frame.size.height);
                             btnPhoto.frame=CGRectMake(btnPhoto.frame.origin.x, photoUpperLineView.frame.origin.y+3, btnPhoto.frame.size.width,btnPhoto.frame.size.height);
                             lblPhoto.frame=CGRectMake(lblPhoto.frame.origin.x, photoUpperLineView.frame.origin.y+7, lblPhoto.frame.size.width,lblPhoto.frame.size.height);
                            btnPhotoPlus.frame=CGRectMake(btnPhotoPlus.frame.origin.x, photoUpperLineView.frame.origin.y+10, btnPhotoPlus.frame.size.width,btnPhotoPlus.frame.size.height);
                           tblPhoto.frame=CGRectMake(tblPhoto.frame.origin.x, btnPhoto.frame.origin.y+btnPhoto.frame.size.height+5, tblPhoto.frame.size.width,tblPhoto.frame.size.height);
                            if (ArrImage.count>2)
                            {
                                mainscroll.contentSize = CGSizeMake(0, mainscroll.contentSize.height+44*ArrImage.count-2*44);
                                tblPhoto.frame=CGRectMake(tblPhoto.frame.origin.x, tblPhoto.frame.origin.y, tblPhoto.frame.size.width,44*ArrImage.count);
                            }
                            
                        }
                        
                        
                    }
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tblDoc)
    {
        return [ArrDoc count];
    }
    else if (tableView==tblPhoto)
    {
        return [ArrImage count];
    }
    else if (tableView==portfoliotabview)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid=@"myprototype";
    PortFolio2PrototypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (tableView==tblDoc)
    {
        if (ArrDoc.count>0)
        {
            static NSString* cellid=@"PortfolioDocCell";
            PortfolioDocCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSLog(@"doc name=%@",[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocName"]]);
            cell.lblDocName.text=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocName"]];
            return  cell;
        }
        
    }
    else if (tableView==tblPhoto)
    {
        if (ArrImage.count>0)
        {
            static NSString* cellid=@"PortfolioDocCell";
            PortfolioDocCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lblDocName.text=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"Description"]];
            return  cell;
        }
        
    }
    else if (tableView==portfoliotabview)
    {
        static NSString* cellid=@"myprototype";
        PortFolio2PrototypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.purpricelbl.text=PurchaseValue;
        cell.purdtlbl.text=purchaseDate;
        cell.curvallbl.text=PurchaseValue;
        cell.photoframelbl.text=ProductName;
        return  cell;
    }
 //   cell.photoframelbl.text=_itemheader;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblDoc)
    {
    
    if (ArrDoc.count>0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        ProductDocDetailViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDocDetailViewControllersid"];
        pv2vc.ProductDocCode=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"ProductDocCode"]];
        
        [self.navigationController pushViewController:pv2vc animated:YES];
    }
    }
    else if (tableView==tblPhoto)
    {
        
        if (ArrImage.count>0)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            ProductImgDetailViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductImgDetailViewControllersid"];
            pv2vc.ProductImgCode=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"ProductImageCode"]];
            
            [self.navigationController pushViewController:pv2vc animated:YES];
        }
    }
    
    
    
}
- (IBAction)BACKFROMPORFOLIO2:(id)sender
{
    [PopDelegate5 Popaction_method5];
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)AddDocumentClk:(id)sender
{
    AddProductDocViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AddProductDocViewControllersid"];
   // obj.taskid=[[arrtask objectAtIndex:indexPath.row] valueForKey:@"id"];
    obj.PopDelegate=self;
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)AddPhotoClk:(id)sender
{
    AddProductImgViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AddProductImgViewControllersid"];
    obj.PopDelegate1=self;
    // obj.taskid=[[arrtask objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:obj animated:YES];
}
- (IBAction)DeleteClk:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do you want to Delete This Product?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}

- (IBAction)EditClk:(id)sender
{
    EditProductViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"EditProductViewControllersid"];
    obj.PopDelegate2=self;
    // obj.taskid=[[arrtask objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:obj animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else
    {
        [self DeleteProductUrl];
        
        
    }
    
    
}
-(void)DeleteProductUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeleteProduct/%@?CustomerCode=%@&ProductCode=%@",URL_LINK,AuthToken,CustomerCode,ProductCode];
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

@end
