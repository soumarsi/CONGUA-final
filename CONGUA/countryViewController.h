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

@property (assign, nonatomic) BOOL signin;
@property (nonatomic, weak) id<countryDelegate>    myDelegate;

//

@property (strong, nonatomic) IBOutlet UILabel *headerLbl1;


@property (strong, nonatomic) IBOutlet UILabel *headerLbl2;
@property (strong, nonatomic) NSString *header1;
@property (strong, nonatomic) NSString *header2;
@property(nonatomic,strong)NSString *categoryCheck,*countryCheck,*TitleCheck;

 @property(nonatomic,strong)NSMutableArray *ArrCountryName;
    
  @property(nonatomic,strong)NSMutableArray *ArrCountryCode;

@property(nonatomic,strong)NSMutableArray *ArrTitleName;

@property(nonatomic,strong)NSMutableArray *ArrTitleCode;

@property(nonatomic,strong)NSMutableArray *ArrCategory;

@property(nonatomic,strong)UITableView *listTable;
@property (strong, nonatomic) NSMutableDictionary *SignDic;

@end
