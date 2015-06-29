//
//  SignUp.h
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"

@interface SignUp : UIViewController
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSMutableArray *ArrCountryName,*ArrCountryCode;
    UIButton *btnsave,*btncancel;
    UIPickerView *Countrypicker;
    UIView *CountryView;
    NSString *country,*countrycode;
}
@property (strong, nonatomic) IBOutlet UIView *regview;

@property (strong, nonatomic) IBOutlet UITextField *fnametxt;
@property (strong, nonatomic) IBOutlet UITextField *lnametxt;
@property (strong, nonatomic) IBOutlet UITextField *titletxt;
@property (strong, nonatomic) IBOutlet UITextField *emailtxt;

@property (strong, nonatomic) IBOutlet UITextField *phnotxt;

@property (strong, nonatomic) IBOutlet UITextField *addrtxt;
@property (strong, nonatomic) IBOutlet UITextField *alteraddrtxt;
@property (strong, nonatomic) IBOutlet UITextField *pcodetxt;
@property (strong, nonatomic) IBOutlet UITextField *passtxt;
@property (strong, nonatomic) IBOutlet UITextField *cpasstxt;
@property (weak, nonatomic) IBOutlet UIButton *btncountry;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
- (IBAction)CountryClk:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtcountry;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@end
