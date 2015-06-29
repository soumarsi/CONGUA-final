//
//  PortFolio2ViewController.h
//  CONGUA
//
//  Created by Soumen on 30/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductDocViewController.h"
#import "AddProductImgViewController.h"
#import "PortfolioDocCell.h"
#import "EditProductViewController.h"
#import "UrlconnectionObject.h"
#import "ProductDocDetailViewController.h"
#import "ProductImgDetailViewController.h"
@interface PortFolio2ViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken,*ProductName,*PurchaseValue,*purchaseDate;
    NSMutableArray *ArrProductDetail,*ArrImage,*ArrDoc;
    UrlconnectionObject *urlobj;
}
@property (strong, nonatomic) IBOutlet UITableView *portfoliotabview;
@property (strong,nonatomic) NSString *itemheader;
@property (strong,nonatomic) NSString *ProductCode;
- (IBAction)AddDocumentClk:(id)sender;
- (IBAction)AddPhotoClk:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblDoc;
@property (weak, nonatomic) IBOutlet UITableView *tblPhoto;
- (IBAction)DeleteClk:(id)sender;
- (IBAction)EditClk:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;



@end