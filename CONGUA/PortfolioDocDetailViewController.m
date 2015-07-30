//
//  PortfolioDocDetailViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 24/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "PortfolioDocDetailViewController.h"

@interface PortfolioDocDetailViewController ()<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation PortfolioDocDetailViewController
@synthesize lblUserName,DocCode,DocCollectionView,index,btnEdit;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 //   [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 489)];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio doc code=%@",DocCode);
    
    
    
    
    urlobj=[[UrlconnectionObject alloc]init];
    ArrDoc=[[NSMutableArray alloc]init];
    
    
    [self DocShowUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
                        
                        [DocCollectionView reloadData];
                        
                        
                        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                        [DocCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                    }
                    else
                    {
                        
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do you want to Delete This Document?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
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
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeletePortfolioDoc/%@?PortfolioCode=%@&PortfolioDocCode=%@",URL_LINK,AuthToken,PortfolioCode,DocCode];
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

- (IBAction)EditClick:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:DocCode  forKey:@"PortfolioDocCode"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EditPortfolioDocViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"EditPortfolioDocViewControllersid"];
    [self.navigationController pushViewController:pv2vc animated:YES];
}

- (IBAction)BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)DownloadClick:(id)sender
{
    if (FileName.length==0)
    {
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"File not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else
    {
      //  WebView.hidden=NO;
        [self DownloadUrl];
    }
    
}
-(void)DownloadUrl
{
    @try {
        
      //  FileName=@"34.png";
        NSString *str=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
        NSLog(@"str=%@",str);
        
        // 1
        
        NSURL *url = [NSURL URLWithString:str];
        
        
        
        // 2
        
        NSURLSessionDownloadTask *downloadPhotoTask =[[NSURLSession sharedSession]
                                                      
                                                      downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                          
                                                          
                                                          
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          // 3
                                                          
                                                          UIImage *downloadedImage = [UIImage imageWithData:
                                                                                      
                                                                                      [NSData dataWithContentsOfURL:location]];
                                                          
                                                          
                                                          
                                                          // Handle the downloaded image
                                                          
                                                          
                                                          
                                                          // Save the image to your Photo Album
                                                          
                                                          ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                                                          [library saveImage:downloadedImage toAlbum:@"ConguaFile" withCompletionBlock:^(NSError *error) {
                                                              
                                                              if (error!=nil)
                                                              {
                                                                  NSLog(@"Noooo error: %@", [error description]);
                                                                  
                                                                  //  [busyview removeFromSuperview];
                                                              }
                                                              else{
                                                                  
                                                              }
                                                          }];

                                                          
                                                          
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              
                                                              NSLog(@"updating UIImageView");
                                                              
                                                              UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Image saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                                              [alert show];

                                                         
                                                              
                                                          });
                                                          
                                                      }];
        
        
        
        // 4
        
        [downloadPhotoTask resume];
#if 0
        UIImageView *downloadimg=[[UIImageView alloc]init];
        [downloadimg sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library saveImage:downloadimg.image toAlbum:@"ConguaFile" withCompletionBlock:^(NSError *error) {
            
            if (error!=nil)
            {
                NSLog(@"Noooo error: %@", [error description]);
                
                //  [busyview removeFromSuperview];
            }
            else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Image saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }
        }];
#endif
        
    //    NSURL *url = [NSURL URLWithString:str];
   //     NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //    [WebView loadRequest:requestObj];
        
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
   
        return [ArrDoc count];
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
   
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"DocDetailCell" forIndexPath:indexPath];
 //    cell.frame=CGRectMake(cell.frame.origin.x, 0, [UIScreen mainScreen].bounds.size.width, DocCollectionView.frame.size.height);
 //   cell.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*indexPath.row, 0, [UIScreen mainScreen].bounds.size.width, DocCollectionView.frame.size.height);
  //  NSLog(@"x=%f",cell.frame.origin.x);
//    cell.mainscroll.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, DocCollectionView.frame.size.height);
   [cell.mainscroll setContentSize:CGSizeMake(self.view.frame.size.width, 500)];
    
    cell.lblDocName.text=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocName"]];
   
  
    if ([[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocTypeCode"] integerValue] ==1)
    {
        cell.lblDocType.text=@"Purchase Receipt";
         cell.docTypeImg.image=[UIImage imageNamed:@"Purchase-receipt"];
    }
    else if ([[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocTypeCode"] integerValue] ==2)
    {
         cell.lblDocType.text=@"Insurance Certificate";
        cell.docTypeImg.image=[UIImage imageNamed:@"icon1-1"];
    }
    else if ([[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"DocTypeCode"] integerValue] ==99)
    {
         cell.lblDocType.text=@"Others";
        cell.docTypeImg.image=[UIImage imageNamed:@"otherDoc"];
    }
    cell.lblDesc.text=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"Description"]];
    
    //dynamic height of label
    NSString *str=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"Description"]];
    
    NSInteger rw=ceil(str.length/60.0);
    NSInteger len=rw*25;
    
    
    cell.lblDesc.frame=CGRectMake(cell.lblDesc.frame.origin.x, cell.lblDesc.frame.origin.y,cell.lblDesc.frame.size.width, len);
    if (len>270)
    {
        cell.mainscroll.contentSize = CGSizeMake(0, cell.mainscroll.contentSize.height+cell.DocImage.frame.size.height+len-270);
    }
    DocCode=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"PortfolioDocCode"]];
    FileName=[NSString stringWithFormat:@"%@",[[ArrDoc objectAtIndex:indexPath.row] valueForKey:@"FileName"]];
    
    NSString *str1=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
    [cell.DocImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str1]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    cell.DocImage.contentMode=UIViewContentModeScaleAspectFit;
    cell.DocImage.clipsToBounds=YES;
    
    cell.DocImage.frame=CGRectMake(cell.DocImage.frame.origin.x, cell.lblDesc.frame.origin.y+cell.lblDesc.frame.size.height+10,cell.DocImage.frame.size.width, cell.DocImage.frame.size.height);
    
   
   // btnEdit.tag=indexPath.row;
        return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(DocCollectionView.frame.size.width, DocCollectionView.frame.size.height);
}
@end
