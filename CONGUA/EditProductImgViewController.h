//
//  EditProductImgViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 26/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
@interface EditProductImgViewController : UIViewController
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*ProductCode,*DocType1,*FileName,*ProductImgCode;
    UIActionSheet *actionsheet;
}
@property (weak, nonatomic) IBOutlet UIImageView *ProductImgView;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UITextView *txtVwDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImg;
@property (weak, nonatomic) IBOutlet UIButton *btnImg;


- (IBAction)BackClick:(id)sender;
- (IBAction)SubmitClick:(id)sender;
- (IBAction)ImageClick:(id)sender;

@end
