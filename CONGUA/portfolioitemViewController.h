//
//  portfolioitemViewController.h
//  CONGUA
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCategoryViewController.h"
#import "AddProductViewController.h"
@interface portfolioitemViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*categoryCode;
    NSMutableArray *ArrCategory,*ArrProduct,*ArrShowProduct;
    UrlconnectionObject *urlobj;
    NSMutableDictionary *ProductDic;
    BOOL showAllSections;
    NSInteger tappedRow;
 //   NSMutableIndexSet *expandedSections;
}
@property (strong, nonatomic) IBOutlet UITableView *mytabview;
@property (weak, nonatomic) IBOutlet UILabel *lblportfilioName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;



- (IBAction)AddCategoryClk:(id)sender;

@end
