//
//  ForgotPasswordViewController.h
//  CONGUA
//
//  Created by Soumen on 28/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
}
@property (weak, nonatomic) IBOutlet UITextField *txtemail;
- (IBAction)SubmitClk:(id)sender;

@end
