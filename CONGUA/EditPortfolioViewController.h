//
//  EditPortfolioViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "CKCalendarView.h"
@interface EditPortfolioViewController : UIViewController
{
    NSString *portType,*CustomerCode,*AuthToken,*Isinsured,*PortfolioCode,*IsPriviouslyInsured;
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    UIDatePicker *picker;
    UIBarButtonItem *rightBtn;
    UIView *myview;
    NSMutableArray *ArrPortDetail,*ArrInsureDetail;
    UIPickerView *mypicker;
    bool start;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextField *txtPortfolioName;
@property (weak, nonatomic) IBOutlet UITextView *txtvwAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPostCode;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolioType;
@property (weak, nonatomic) IBOutlet UILabel *lblPortfolioType;
@property (weak, nonatomic) IBOutlet UIButton *btnHasInsure;
@property (weak, nonatomic) IBOutlet UIImageView *HasInsureImg;
@property (weak, nonatomic) IBOutlet UITextField *txtInsureName;
@property (weak, nonatomic) IBOutlet UITextView *txtvwInsureDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblInsureDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtValueCovered;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIView *InsuranceView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UISwitch *IsInsuredSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *homeImg;
@property (weak, nonatomic) IBOutlet UIImageView *businessImg;
@property (weak, nonatomic) IBOutlet UIImageView *personalImg;
@property (weak, nonatomic) IBOutlet UIImageView *otherImg;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnBusiness;
@property (weak, nonatomic) IBOutlet UIButton *btnPersonal;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;




- (IBAction)HomeClick:(id)sender;
- (IBAction)BusinessClick:(id)sender;
- (IBAction)PersonalClick:(id)sender;
- (IBAction)OtherClick:(id)sender;



- (IBAction)PortfolioTypeClk:(id)sender;
- (IBAction)HasInsureClk:(id)sender;
- (IBAction)StartDateClk:(id)sender;
- (IBAction)EndDateClk:(id)sender;

- (IBAction)SubmitClk:(id)sender;




- (IBAction)BackClk:(id)sender;

@end
