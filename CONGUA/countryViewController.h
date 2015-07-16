//
//  countryViewController.h
//  CONGUA
//
//  Created by IOS2 on 16/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol countryDelegate <NSObject>

-(void)countryViewcontrollerDismissedwithCategoryName:(NSString *)categoryyName categoryCode:(NSString *)categoryCode;

@end

@interface countryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{

 id   _myDelegate;
    
}
//


@property (nonatomic, weak) id<countryDelegate>    myDelegate;

//

@property (strong, nonatomic) IBOutlet UILabel *headerLbl1;


@property (strong, nonatomic) IBOutlet UILabel *headerLbl2;



 @property(nonatomic,strong)NSMutableArray *ArrCountryName;
    
  @property(nonatomic,strong)NSMutableArray *ArrCountryCode;

@property(nonatomic,strong)NSMutableArray *ArrCategory;

@property(nonatomic,strong)UITableView *listTable;


@end
