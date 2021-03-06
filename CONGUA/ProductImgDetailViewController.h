//
//  ProductImgDetailViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "EditProductImgViewController.h"
#import "UIImageView+WebCache.h"
#import "ProductImgCell.h"
@interface ProductImgDetailViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*ProductCode,*FileName;
    UrlconnectionObject *urlobj;
    NSMutableArray *ArrImage;
    ProductImgCell *cell;
    UIView *imageview;
}
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (strong, nonatomic)  NSString *ProductImgCode;
@property (assign, nonatomic)  NSInteger productIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UICollectionView *ImgCollectionView;




- (IBAction)DeleteClick:(id)sender;
- (IBAction)EditClick:(id)sender;


- (IBAction)BackClick:(id)sender;

@end
