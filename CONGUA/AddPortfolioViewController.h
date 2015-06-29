//
//  AddPortfolioViewController.h
//  Congua
//
//  Created by Soumen on 27/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "ViewController.h"

@interface AddPortfolioViewController : UIViewController
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

- (IBAction)PortTypeClk:(id)sender;
@end
