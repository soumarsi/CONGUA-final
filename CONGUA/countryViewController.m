//
//  countryViewController.m
//  CONGUA
//
//  Created by IOS2 on 16/07/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "countryViewController.h"
#import "SignUp.h"
#import "AddProductViewController.h"

@interface countryViewController ()


//{BOOL categoryCheck,countryCheck;}

@property (strong, nonatomic) IBOutlet UIView *topBarView;





@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property(nonatomic,strong)NSString *categoryCheck,*countryCheck;


@end

@implementation countryViewController

@synthesize myDelegate;

@synthesize ArrCountryCode,ArrCountryName,backBtn,topBarView,listTable,ArrCategory,categoryCheck,countryCheck,headerLbl1,headerLbl2;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    headerLbl1.adjustsFontSizeToFitWidth=YES;
    
    headerLbl2.adjustsFontSizeToFitWidth=YES;
    
    
    topBarView.layer.borderColor=[[UIColor grayColor]CGColor];
    
    topBarView.clipsToBounds=YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Category array table values.....%@",ArrCategory);
    
    
    if(ArrCountryName.count>0)
    {
        listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, topBarView.frame.origin.y+topBarView.bounds.size.height, self.view.bounds.size.width, ArrCountryName.count*50)];
        
        countryCheck=@"YES";
        
    }
    
    else if (ArrCategory.count>0)
    {
        
        NSLog(@"Category table creating....");
        
        listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, topBarView.frame.origin.y+topBarView.bounds.size.height, self.view.bounds.size.width, ArrCategory.count*50)];
        
        categoryCheck=@"YES";
        
    }
    
    listTable.delegate=self;
    listTable.dataSource=self;
    
    listTable.backgroundColor=[UIColor clearColor];
    
    listTable.separatorColor=[UIColor clearColor];
    
    [self.view addSubview:listTable];
    
 
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([countryCheck isEqualToString:@"YES"])
        return ArrCountryName.count;
    else if ([categoryCheck isEqualToString:@"YES"])
    {
        NSLog(@"Category table no of rows....%lu",(long)ArrCategory.count);
        
        return ArrCategory.count;
    }
    else return 0;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   static NSString *cellID=@"countryCell";
    
    UITableViewCell *countryTableCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if(countryTableCell==NULL)
    {
    
        countryTableCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    }
    
    if([countryCheck isEqualToString:@"YES"])
      countryTableCell.textLabel.text=[ArrCountryName objectAtIndex:indexPath.row];
    
    else if ([categoryCheck isEqualToString:@"YES"])
        countryTableCell.textLabel.text=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryName"];
    
    countryTableCell.layer.shadowColor=[[UIColor grayColor] CGColor];
    
    countryTableCell.layer.shadowOpacity=0.3;
    
    countryTableCell.layer.shadowOffset=CGSizeMake(0, 3);
    
    countryTableCell.layer.shadowRadius=3.0;
    
    NSLog(@"Cell creating....");
    
    return countryTableCell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([countryCheck isEqualToString:@"YES"])
    {
    
    SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
    
    signupVC.country=[ArrCountryName objectAtIndex:indexPath.row];
    
    signupVC.countrycode=[ArrCountryCode objectAtIndex:indexPath.row];
    
    [ArrCountryName removeAllObjects];
    
    [ArrCountryCode removeAllObjects];
    
    [self.navigationController pushViewController:signupVC animated:YES];
        
      //  countryCheck=NO;
        
    }
    
    else if ([categoryCheck isEqualToString:@"YES"])
    {
    
        AddProductViewController *productVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
        
        productVC.ProductType=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryName"];
        
        productVC.catCode=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"];
        
        
        if([self.myDelegate respondsToSelector:@selector(countryViewcontrollerDismissedwithCategoryName:categoryCode:)])
        {
        
            [self.myDelegate countryViewcontrollerDismissedwithCategoryName:productVC.ProductType categoryCode: productVC.catCode];
        
        
        }
        
       
        
        categoryCheck=@"NO";
        
        [self dismissViewControllerAnimated:productVC completion:^{
            
            productVC.catCode=[[ArrCategory objectAtIndex:indexPath.row] valueForKey:@"CategoryCode"];

            productVC.lblProductType.text=productVC.ProductType;
            
            NSLog(@"Product type value in table...%@", productVC.ProductType);
            
            
        }];
        
        //  lblProductType.text=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryName"];
        //CategoryCode=[[ArrCategory objectAtIndex:0] valueForKey:@"CategoryCode"];
        
       // [self.navigationController pushViewController:productVC animated:YES];
       // categoryCheck=NO;
    
    
    }

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtnFunc:(id)sender
{
    if([countryCheck isEqualToString:@"YES"])
    {
    
    SignUp *signupVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"signup"];
    
    [ArrCountryName removeAllObjects];
    
    [ArrCountryCode removeAllObjects];
    
    countryCheck=@"NO";
    
    [self.navigationController pushViewController:signupVC animated:YES];
        
    }
    
    else if ([categoryCheck isEqualToString:@"YES"])
    {
        
        AddProductViewController *addVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddProductViewControllersid"];
        
        categoryCheck=@"NO";
    
        [self dismissViewControllerAnimated:addVC completion:^{
            
            
            
            
        }];
    
    
    }

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
