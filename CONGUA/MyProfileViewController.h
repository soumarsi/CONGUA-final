//
//  MyProfileViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 15/09/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "countryViewController.h"
#import "ViewController.h"
@interface MyProfileViewController : UIViewController<UITextFieldDelegate>
{
    UrlconnectionObject *urlobj;
    NSString *CustomerCode,*AuthToken,*CountryCode,*TitleCode;
    NSMutableArray *ArrCountryName,*ArrCountryCode,*ArrTitleName,*ArrTitleCode;
    UIView *loader_shadow_View;
    NSDictionary *tempDict;
}
- (IBAction)BackClick:(id)sender;
- (IBAction)SaveClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextField *txtpcode;
@property (weak, nonatomic) IBOutlet UITextField *txtaddr2;
@property (weak, nonatomic) IBOutlet UITextField *txtph;
@property (weak, nonatomic) IBOutlet UITextField *txtaddr1;

@property (weak, nonatomic) IBOutlet UITextField *txtemail;
@property (weak, nonatomic) IBOutlet UITextField *txtlname;
@property (weak, nonatomic) IBOutlet UITextField *txtfname;
@property (weak, nonatomic) IBOutlet UITextField *txttitle;
- (IBAction)TitleClick:(id)sender;
- (IBAction)CountryClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;

@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (assign, nonatomic) BOOL goprofile;
@end
