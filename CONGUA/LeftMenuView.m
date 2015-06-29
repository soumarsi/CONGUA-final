//
//  LeftMenuView.m
//  TaskAroo
//
//  Created by Prosenjit Kolay on 13/05/15.
//  Copyright (c) 2015 Prosenjit Kolay. All rights reserved.
//

#import "LeftMenuView.h"

@implementation LeftMenuView
@synthesize tblmenu,leftDelegate,txtusername,userimage,btnprofImg;
+ (id)leftmenu
{
    LeftMenuView *customView = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuView" owner:nil options:nil] lastObject];
    
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[LeftMenuView class]])
        return customView;
    else
        return nil;
    
    
}
-(void)leftmenumethod
{
    
    collector=-1;
    
 //   arrmenuname = [[NSMutableArray alloc] initWithObjects:@"Post a Task",@"Financial Details",@"My Transactions",@"Refer a Friend",@"Logout", nil];
     arrmenuname = [[NSMutableArray alloc] initWithObjects:@"Logout", nil];
    tblmenu.backgroundColor=[UIColor clearColor];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    txtusername.text=[prefs valueForKey:@"FullName"];
     NSString *img=[prefs valueForKey:@"smalluserimage"];
    if (img==nil)
    {
        userimage.image=[UIImage imageNamed:@"no image available"];
    }
    else
    {
        userimage.layer.cornerRadius = userimage.frame.size.height/2;
        userimage.clipsToBounds = YES;
        userimage.userInteractionEnabled=YES;
        userimage.layer.borderColor=[UIColor whiteColor].CGColor;
        userimage.layer.borderWidth=1.5;
        userimage.contentMode=UIViewContentModeScaleAspectFill;
    //    [userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",img]] placeholderImage:[UIImage imageNamed:@"no image available"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
       
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return 40.0;
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
        return [arrmenuname count];
  
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 //   NSLog(@"table view delegate");
    static NSString *indentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    //  if(!cell)
    //  {
   
         bgview =[[UIView alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width,cell.frame.size.height)];
        bgview.backgroundColor=[UIColor clearColor];
        [cell addSubview:bgview];
   
   UIView *selectedbgview =[[UIView alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width,cell.frame.size.height)];
    selectedbgview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bg"]];
    [cell setSelectedBackgroundView:selectedbgview];
  /*
   UILabel *selectedlblmenu = [[UILabel alloc]initWithFrame:CGRectMake(30,10, 120, 15)];
    selectedlblmenu.font = [UIFont fontWithName:@"OpenSans-Semibold" size:13]; //custom font
    selectedlblmenu.backgroundColor = [UIColor clearColor];
    selectedlblmenu.textColor = [UIColor blueColor];
    selectedlblmenu.textAlignment = NSTextAlignmentLeft;
    selectedlblmenu.text=[NSString stringWithFormat:@"%@",arrmenuname[indexPath.row]];
    [selectedbgview addSubview:selectedlblmenu];
    */
            lblmenu = [[UILabel alloc]initWithFrame:CGRectMake(30,10, 120, 20)];
        lblmenu.font = [UIFont fontWithName:@"Helvetica Neue" size:17]; //custom font
        lblmenu.backgroundColor = [UIColor clearColor];
        lblmenu.textColor = [UIColor colorWithRed:(221.0/255.0) green:(52.0/255.0) blue:(24.0/255.0) alpha:1.0];
        lblmenu.textAlignment = NSTextAlignmentLeft;
        lblmenu.text=[NSString stringWithFormat:@"%@",arrmenuname[indexPath.row]];
        [bgview addSubview:lblmenu];
        
        cell.backgroundColor=[UIColor clearColor];
    
    cell.selectionStyle=YES;
    
    cell.tag=indexPath.row;
    if (indexPath.row==collector)
    {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bg"]];
        collector=-1;
    }
    
    
   
        
        return cell;
  
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // lblmenu.textColor = [UIColor blueColor];
  //  NSLog(@"left menu table selected.");
    
   
    
    [leftDelegate leftclk:indexPath.row];
}

-(void)tapCheck:(int)sender
{
  //  NSLog(@"sender=%d",sender);
    if (sender==0)
    {
        collector=0;
    
    }
    if (sender==1)
    {
        collector=1;
        
    }
    if (sender==2)
    {
        collector=2;
        
    }
    if (sender==3)
    {
        collector=3;
        
    }
   
}
@end
