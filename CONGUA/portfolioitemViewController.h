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
#import "EditCategoryViewController.h"
@protocol PopView_delegateFromItem<NSObject>
@optional
-(void)Popaction_methodFromItem;
@end
@interface portfolioitemViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PopView_delegateFromAddProduct>
{
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*categoryCode;
    NSMutableArray *ArrCategory,*ArrProduct,*ArrShowProduct;
    UrlconnectionObject *urlobj;
    NSMutableDictionary *ProductDic;
    BOOL showAllSections;
    NSInteger tappedRow;
 //   NSMutableIndexSet *expandedSections;
}
@property(assign)id<PopView_delegateFromItem>PopDelegateFromItem;
@property (strong, nonatomic) IBOutlet UITableView *mytabview;
@property (weak, nonatomic) IBOutlet UILabel *lblportfilioName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIView *AddProductView;



- (IBAction)AddCategoryClk:(id)sender;
- (IBAction)AddCategoryPlusClick:(id)sender;

@end
