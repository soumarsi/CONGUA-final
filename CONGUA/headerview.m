//
//  headerview.m
//  CONGUA
//
//  Created by Soumen on 26/05/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "headerview.h"

@implementation headerview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _headerrightimgbtn.image = [UIImage imageNamed:@"plus"];
    if (self) {
        
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"headerview"
                                                          owner:self
                                                        options:nil];
        
        UIView* mainView = (UIView*)[nibViews objectAtIndex:0];
        
        [self addSubview:mainView];
    }
    return self;
}
@end
