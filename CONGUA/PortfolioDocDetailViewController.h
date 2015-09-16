//
//  PortfolioDocDetailViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 24/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "EditPortfolioDocViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIImageView+WebCache.h"
#import "DocDetailCell.h"
@interface PortfolioDocDetailViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*FileName;
    NSMutableArray *ArrPortDetail,*ArrInsureDetail,*ArrDoc;
    UrlconnectionObject *urlobj;
    DocDetailCell *cell;
    UIView *imageview;
}
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UICollectionView *DocCollectionView;

@property (strong, nonatomic)  NSString *DocCode;
@property (assign, nonatomic)  NSInteger index;
- (IBAction)DeleteClick:(id)sender;
- (IBAction)EditClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIPageControl *PageControl;


- (IBAction)BackClick:(id)sender;
- (IBAction)DownloadClick:(id)sender;

@end
