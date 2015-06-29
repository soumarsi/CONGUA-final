//
//  LeftMenuView.h
//  TaskAroo
//
//  Created by Prosenjit Kolay on 13/05/15.
//  Copyright (c) 2015 Prosenjit Kolay. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImageView+WebCache.h"
@protocol leftDelegate <NSObject>
@required
-(void)leftclk:(NSInteger)sender;
@end
@interface LeftMenuView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrmenuname;
    UITableViewCell *cell;
    UIView *bgview;
    UILabel *lblmenu;
    
    int collector;
    
}
+ (id)leftmenu;
-(void)leftmenumethod;

-(void)tapCheck:(int)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblmenu;
@property (weak, nonatomic) IBOutlet UILabel *txtusername;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UIButton *btnprofImg;


@property(assign)id<leftDelegate>leftDelegate;
@end
