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
#import "DocDetailCell.h"
@interface ProductDocDetailViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*ProductCode,*FileName;
    UrlconnectionObject *urlobj;
    NSMutableArray *ArrDoc;
    DocDetailCell *cell;
    UIView *imageview;
}

@property (weak, nonatomic) IBOutlet UICollectionView *DocCollectionView;
@property (assign, nonatomic)  NSInteger index;
@property (strong, nonatomic)  NSString *ProductDocCode;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnEditTop;



- (IBAction)BackClick:(id)sender;
- (IBAction)downloadClick:(id)sender;
- (IBAction)DeleteClick:(id)sender;
- (IBAction)EditClick:(id)sender;



@end
