//
//  EditCategoryViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 01/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"

@interface EditCategoryViewController : UIViewController
{
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode;
}
- (IBAction)BackClk:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtCategoryName;
@property (weak, nonatomic) NSString *CategoryCode;
- (IBAction)SubmitClk:(id)sender;

@end
