//
//  portfoliodetailpageViewController.h
//  CONGUA
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "ViewController.h"
#import "PortFolio2ViewController.h"
#import "AddPortfolioDocViewController.h"
#import "PortfolioDocCell.h"
#import "EditPortfolioViewController.h"
#import "PortfolioDocDetailViewController.h"
@interface portfoliodetailpageViewController : UIViewController
{
    NSString *CustomerCode,*AuthToken;
    NSMutableArray *ArrPortDetail,*ArrInsureDetail,*ArrDoc;
    UrlconnectionObject *urlobj;
    bool didappear;
    UIActionSheet *actionsheet;
    UIImage *docImage;
}
@property (strong, nonatomic)  NSString *PortfolioCode;
- (IBAction)leftClk:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbladdress;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalValue;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalcover;
@property (weak, nonatomic) IBOutlet UILabel *lblexpiryDate;

@property (weak, nonatomic) IBOutlet UILabel *lblinsureexpiry;

@property (weak, nonatomic) IBOutlet UILabel *lblNoOfItem;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITableView *tblDoc;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UILabel *lblTolalValuable;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCover1;
@property (weak, nonatomic) IBOutlet UIImageView *dividerImg;
@property (weak, nonatomic) IBOutlet UIView *AddDocView;


- (IBAction)PortfolioDetailClk:(id)sender;
- (IBAction)AddDocumentClk:(id)sender;
- (IBAction)EditPortfolioClk:(id)sender;

@end
