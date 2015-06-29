//
//  AddPortfolioViewController.h
//  Congua
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ViewController.h"
#import "UrlconnectionObject.h"
@interface AddPortfolioViewController : UIViewController
{
    NSString *portType,*CustomerCode,*AuthToken,*Isinsured,*portfoliocode;
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
}
@property (strong, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (strong, nonatomic) IBOutlet UITextField *portnmtxt;
@property (strong, nonatomic) IBOutlet UITextField *pcodetxt;
@property (strong, nonatomic) IBOutlet UITextField *inametxt;
@property (strong, nonatomic) IBOutlet UITextField *vcovertxt;
@property (strong, nonatomic) IBOutlet UITextView *idetail;
@property (strong, nonatomic) IBOutlet UITextView *addrtxt;
@property (strong, nonatomic) IBOutlet UILabel *startdatelbl;
@property (strong, nonatomic) IBOutlet UILabel *enddatelbl;
@property (strong, nonatomic) IBOutlet UILabel *ptypelbl;
@property (weak, nonatomic) IBOutlet UILabel *lbladdress;
@property (weak, nonatomic) IBOutlet UILabel *lblinsureDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnhasInsure;
@property (weak, nonatomic) IBOutlet UIImageView *toggleimg;

- (IBAction)PortTypeClk:(id)sender;

- (IBAction)SubmitClk:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnstartdate;

@property (weak, nonatomic) IBOutlet UIButton *btnenddate;

@property (weak, nonatomic) IBOutlet UIView *InsuranceView;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


@end
