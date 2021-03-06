//
//  AddPortfolioDocViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 13/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
@protocol PopView_delegate7<NSObject>
@optional
-(void)Popaction_method7;
@end
@interface AddPortfolioDocViewController : UIViewController
{
    UIView *loader_shadow_View,*Doctypeview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*DocType,*DocType1,*FileName;
    NSMutableArray *ArrDocType;
    UIPickerView *Doctypepicker;
    UIButton *btnDoctypesave,*btnDoctypeCancel;
    UIActionSheet *actionsheet;
}
@property(assign)id<PopView_delegate7>PopDelegate7;
@property (weak, nonatomic) IBOutlet UITextField *txtDocName;
@property (weak, nonatomic) IBOutlet UIButton *btnDocType;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;
@property (weak, nonatomic) IBOutlet UITextView *txtvwDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIImageView *DocImage;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDoc;
@property (strong, nonatomic) UIImage *documentImage;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnInsureCertificate;
@property (weak, nonatomic) IBOutlet UIButton *btnPurchaseReceipt;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;
@property (weak, nonatomic) IBOutlet UIView *DocView;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotoLib;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;
- (IBAction)SegmentClick:(id)sender;


- (IBAction)CameraClick:(id)sender;
- (IBAction)PhotoLibClick:(id)sender;

- (IBAction)InsureCertificateClick:(id)sender;
- (IBAction)PurchaseReceiptClick:(id)sender;
- (IBAction)OtherClick:(id)sender;


- (IBAction)BackClk:(id)sender;
- (IBAction)DocTypeClk:(id)sender;
- (IBAction)AddDocClk:(id)sender;
- (IBAction)SubmitClk:(id)sender;



@end
