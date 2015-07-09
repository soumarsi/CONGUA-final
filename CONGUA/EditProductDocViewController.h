//
//  EditProductDocViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "UIImageView+WebCache.h"
@interface EditProductDocViewController : UIViewController
{
    UIView *loader_shadow_View,*Doctypeview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*ProductCode,*DocType,*DocType1,*FileName,*ProductDocCode;
    NSMutableArray *ArrDocType;
    UIPickerView *Doctypepicker;
    UIButton *btnDoctypesave,*btnDoctypeCancel;
    UIActionSheet *actionsheet;
}
@property (weak, nonatomic) IBOutlet UITextField *txtDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UITextView *txtVwDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnDocType;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDoc;
@property (weak, nonatomic) IBOutlet UIButton *btnInsureCertificate;
@property (weak, nonatomic) IBOutlet UIButton *btnPurchaseReceipt;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;


@property (weak, nonatomic) IBOutlet UIImageView *DocImage;

- (IBAction)BackClick:(id)sender;
- (IBAction)AddDocClick:(id)sender;
- (IBAction)SubmitClick:(id)sender;
- (IBAction)DocTypeClick:(id)sender;
- (IBAction)InsureCertificateClk:(id)sender;
- (IBAction)PurchaseReceiptClick:(id)sender;
- (IBAction)OtherClick:(id)sender;

@end
