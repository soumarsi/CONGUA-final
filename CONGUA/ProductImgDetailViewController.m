//
//  ProductImgDetailViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ProductImgDetailViewController.h"

@interface ProductImgDetailViewController ()<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ProductImgDetailViewController
@synthesize lblDesc,WebView,ProductImgCode,lblUserName,mainscroll,ProductImg,ImgCollectionView,productIndex;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 //   mainscroll.contentSize=CGSizeMake(0, 489);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
    NSLog(@"product image code=%@",ProductImgCode);
    
    urlobj=[[UrlconnectionObject alloc]init];
    ArrImage=[[NSMutableArray alloc]init];
    [self ImageShowUrl];
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
                    
                  //  NSLog(@"summary name=%@",ArrImage);
                    [ImgCollectionView reloadData];
                   
                    NSIndexPath *path = [NSIndexPath indexPathForRow:productIndex inSection:0];
                    [ImgCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                    
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
-(void)DownloadUrl
{
    @try {
        
        //  FileName=@"34.png";
        NSString *str=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
        NSLog(@"str=%@",str);
        

        
        [ProductImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        ProductImg.contentMode=UIViewContentModeScaleAspectFit;
       
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return [ArrImage count];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductImgCell" forIndexPath:indexPath];
    
 //   [cell.mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 500)];
    
    
    cell.lbldesc.text=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"Description"]];
    
    //dynamic height of label
//    NSString *str=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"Description"]];
//    
//    NSInteger rw=ceil(str.length/60.0);
//    NSInteger len=rw*25;
    CGSize maximumLabelSize = CGSizeMake(cell.lbldesc.frame.size.width,9999);
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
    CGRect titleRect = [self rectForText:cell.lbldesc.text // <- your text here
                               usingFont:font
                           boundedBySize:maximumLabelSize];
    
    cell.lbldesc.frame=CGRectMake(cell.lbldesc.frame.origin.x, cell.lbldesc.frame.origin.y,cell.lbldesc.frame.size.width, titleRect.size.height);
  
        cell.mainscroll.contentSize = CGSizeMake(0, cell.lbldesc.frame.origin.y+cell.lbldesc.frame.size.height+20);
   
    ProductImgCode=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"ProductImageCode"]];
    [[NSUserDefaults standardUserDefaults] setObject:ProductImgCode forKey:@"ProductImgCode"];
    
   
    FileName=[NSString stringWithFormat:@"%@",[[ArrImage objectAtIndex:indexPath.row] valueForKey:@"FileName"]];
    
    
    NSString *str1=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
    NSLog(@"str=%@",str1);

    [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str1]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    cell.ProductImg.contentMode=UIViewContentModeScaleAspectFit;
   
    
    
    
    // btnEdit.tag=indexPath.row;
    return cell;
    
}
-(CGRect)rectForText:(NSString *)text
           usingFont:(UIFont *)font
       boundedBySize:(CGSize)maxSize
{
    NSAttributedString *attrString =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{ NSFontAttributeName:font}];
    
    return [attrString boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                    context:nil];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ImgCollectionView.frame.size.width, ImgCollectionView.frame.size.height);
}
@end
