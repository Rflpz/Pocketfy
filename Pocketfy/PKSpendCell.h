//
//  PKSpendCell.h
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKSpendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgKind;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;

@end
