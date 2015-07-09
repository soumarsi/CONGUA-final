//
//  AddProductImgViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
@interface AddProductImgViewController : UIViewController
{
    UIView *loader_shadow_View,*Doctypeview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*DocType,*DocType1,*ProductCode,*FileName;
    NSMutableArray *ArrDocType;
    UIPickerView *Doctypepicker;
    UIButton *btnDoctypesave,*btnDoctypeCancel;
    UIActionSheet *actionsheet;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextView *txtvwDesc;
@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIView *DocView;

- (IBAction)AddImageClk:(id)sender;
- (IBAction)SubmitClk:(id)sender;
- (IBAction)BackClk:(id)sender;
- (IBAction)CameraClick:(id)sender;
- (IBAction)PhotoLibClick:(id)sender;


@end
