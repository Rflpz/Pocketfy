//
//  PKSpendCell.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKSpendCell.h"

@implementation PKSpendCell
@synthesize lblDate = _lblDate;
@synthesize lblTitle = _lblTitle;
@synthesize imgKind = _imgKind;
@synthesize lblMoney = _lblMoney;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
