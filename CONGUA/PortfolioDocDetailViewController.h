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
@interface PortfolioDocDetailViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*FileName;
    NSMutableArray *ArrPortDetail,*ArrInsureDetail,*ArrDoc;
    UrlconnectionObject *urlobj;
}
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;

@property (weak, nonatomic) IBOutlet UIImageView *DocImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;

@property (weak, nonatomic) IBOutlet UILabel *lblDocDesc;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIImageView *DocTypeImg;

@property (strong, nonatomic)  NSString *DocCode;
- (IBAction)DeleteClick:(id)sender;
- (IBAction)EditClick:(id)sender;


- (IBAction)BackClick:(id)sender;
- (IBAction)DownloadClick:(id)sender;

@end
