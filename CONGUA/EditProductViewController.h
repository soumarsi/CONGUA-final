//
//  EditProductViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "CKCalendarView.h"
#import "ViewController.h"
#import "portfolioitemViewController.h"
@protocol PopView_delegate2<NSObject>
@optional
-(void)Popaction_method2;
@end
@interface EditProductViewController : UIViewController
{
    UIView *loader_shadow_View,*Producttypeview,*PurchaseDateview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*ProductCode,*ProductType,*Isinsured,*Isotherinsured,*CategoryCode,*PortfolioCode;
    NSMutableArray *ArrProductType,*ArrProductDetail,*ArrCategory;
    UIPickerView *producttypepicker;
    UIDatePicker *datepicker;
    UIButton *btnProducttypesave,*btnproducttypeCancel;
}
@property(assign)id<PopView_delegate2>PopDelegate2;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextField *txtProductNmae;
@property (weak, nonatomic) IBOutlet UILabel *lblProductType;
@property (weak, nonatomic) IBOutlet UIButton *btnProductType;
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseDt;
@property (weak, nonatomic) IBOutlet UIButton *btnPurchaseDt;
@property (weak, nonatomic) IBOutlet UITextField *txtPurchaseValue;
@property (weak, nonatomic) IBOutlet UIButton *btnIsInsured;
@property (weak, nonatomic) IBOutlet UIImageView *IsInsureImg;
@property (weak, nonatomic) IBOutlet UIButton *btnIsOtherInsure;
@property (weak, nonatomic) IBOutlet UIImageView *IsOtherInsureImg;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UITextView *txtVwDescription;
@property (strong, nonatomic) NSString *CategoryCode;
- (IBAction)ProductTypeClk:(id)sender;
- (IBAction)PurchaseDtClk:(id)sender;

- (IBAction)IsInsuredPortClk:(id)sender;
- (IBAction)IsOtherInsureClk:(id)sender;
- (IBAction)SubmitClk:(id)sender;
- (IBAction)BackClk:(id)sender;
- (IBAction)DeleteClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIImageView *DescImgView;
@property (weak, nonatomic) IBOutlet UISwitch *InsuredPortSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *OtherInsuredSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lblDescTop;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property (weak, nonatomic) IBOutlet UIImageView *ArrowImg;


@end
