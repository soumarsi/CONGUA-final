//
//  AddCategoryViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 11/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
@protocol PopView_delegate3<NSObject>
@optional
-(void)Popaction_method3;
@end
@interface AddCategoryViewController : UIViewController
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode;
}
@property(assign)id<PopView_delegate3>PopDelegate3;
@property (weak, nonatomic) IBOutlet UITextField *txtcategoryName;
- (IBAction)SubmitClk:(id)sender;
- (IBAction)BackClk:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;

@end
