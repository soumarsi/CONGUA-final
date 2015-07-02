//
//  ProductDocDetailViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "EditProductDocViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIImageView+WebCache.h"
@interface ProductDocDetailViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*ProductCode,*FileName;
    UrlconnectionObject *urlobj;
}

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (strong, nonatomic)  NSString *ProductDocCode;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;


- (IBAction)BackClick:(id)sender;
- (IBAction)downloadClick:(id)sender;
- (IBAction)DeleteClick:(id)sender;
- (IBAction)EditClick:(id)sender;



@end
