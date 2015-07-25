//
//  ViewController.h
//  CONGUA
//
//  Created by Soumen on 26/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prototypecell.h"
#import "UrlconnectionObject.h"
#import "LeftMenuView.h"
#import "login.h"
@interface ViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,leftDelegate>
{
    NSString *CustomerCode,*AuthToken;
    NSInteger Issearch;
    NSMutableArray *ArrSummary,*ArrFilter;
    UrlconnectionObject *urlobj;
    LeftMenuView *leftView;
}
@property (strong, nonatomic) IBOutlet UIView *contentview;
@property (strong, nonatomic) IBOutlet UITextField *searchtextbox;
@property (strong, nonatomic) IBOutlet UITableView *tabview;
@property (strong, nonatomic) IBOutlet prototypecell *tabviewcell;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UIButton *btnsearch;
- (IBAction)SearchClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsearchicon;
- (IBAction)searchiconclick:(id)sender;
- (IBAction)LeftMenuClk:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblNoresultFound;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@end

