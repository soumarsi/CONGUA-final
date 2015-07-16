//
//  EditCategoryViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 01/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
@protocol PopView_delegate4<NSObject>
@optional
-(void)Popaction_method4;
@end
@interface EditCategoryViewController : UIViewController
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode;
}
@property(assign)id<PopView_delegate4>PopDelegate4;
- (IBAction)BackClk:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtCategoryName;
@property (weak, nonatomic) NSString *CategoryCode;
- (IBAction)SubmitClk:(id)sender;

@end
