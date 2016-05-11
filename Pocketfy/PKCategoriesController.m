//
//  PKCategoriesController.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKCategoriesController.h"
#import "PKAddController.h"
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
@interface PKCategoriesController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
//123
//114
//94
//76
@implementation PKCategoriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CATEGORIES";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[self imageWithImage:[UIImage imageNamed:@"goBack.png"] scaledToSize:CGSizeMake(25,25)]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
    leftButton.tintColor = [self colorFromHexString:@"#2c3e50"];
    [self animateTable];
}
- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"FOOD";
            cell.backgroundColor = [self colorFromHexString:@"#c53b2d"];
            break;
        }
        case 1:{
            cell.textLabel.text = @"TRANSPORT";
            cell.backgroundColor = [self colorFromHexString:@"#f39c12"];
            break;
        }
        case 2:{
            cell.textLabel.text = @"CLOTHES";
            cell.backgroundColor = [self colorFromHexString:@"#2980b9"];
            break;
        }
        case 3:{
            cell.textLabel.text = @"LEISURE";
            cell.backgroundColor = [self colorFromHexString:@"#27ae60"];
            break;
        }
        case 4:{
            cell.textLabel.text = @"OTHER";
            cell.backgroundColor = [self colorFromHexString:@"#1abc9c"];
            break;
        }
        default:
            break;
    }
    CGSize size = {55,55};
    cell.imageView.image = [self imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] scaledToSize:size];
    UILabel *headerBackgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,500,8)];
    headerBackgroundLabel.backgroundColor = [UIColor whiteColor];
    [cell addSubview:headerBackgroundLabel];
    
    cell.textLabel.textColor = [self colorFromHexString:@"#2c3e50"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:22];
    cell.layer.cornerRadius = 10;
    cell.clipsToBounds = YES;

    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE_4) {
        return 76;
    }
    if (IS_IPHONE_5) {
        return 92;
    }
    if (IS_IPHONE_6) {
        return 114;
    }
    if (IS_IPHONE_6_PLUS) {
        return 123;
    }
    return 10;
}
- (void)animateTable{
    [_tableView reloadData];
    NSArray *cells = _tableView.visibleCells;
    ;
    for (UITableViewCell  *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, _tableView.bounds.size.height);
    }
    int index = 0;
    for (UITableViewCell  *cell in cells) {
        [UIView animateWithDuration:1.0f delay:0.05f * index
             usingSpringWithDamping:0.8f initialSpringVelocity:0.0f
                            options:0 animations:^{
                                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                            } completion:nil];
        index++;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    PKAddController *addPay = [[PKAddController alloc] initWithNibName:@"PKAddController" bundle:nil];
    addPay.category = indexPath.row;
    [self.navigationController pushViewController:addPay animated:YES];
}

@end
