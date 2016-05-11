//
//  PKSpendController.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKSpendController.h"
#import "PKSpendCell.h"
#import "PKCategoriesController.h"
#import "PKLoginController.h"
@interface PKSpendController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnUpload;
@property (strong, nonatomic) NSMutableArray *expenses;
@property (weak, nonatomic)  UIRefreshControl *refreshControl;

@end

@implementation PKSpendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[self colorFromHexString:@"#F84151"], NSForegroundColorAttributeName, [UIFont fontWithName:@"ProximaNova-Regular" size:20], NSFontAttributeName, nil];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                      initWithImage:[self imageWithImage:[UIImage imageNamed:@"logot.png"] scaledToSize:CGSizeMake(25,25)]
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(goStatics)];
    UIBarButtonItem *rigthButton = [[UIBarButtonItem alloc]
                                  initWithImage:[self imageWithImage:[UIImage imageNamed:@"add.png"] scaledToSize:CGSizeMake(25,25)]
                                  style:UIBarButtonItemStyleDone
                                  target:self
                                  action:@selector(addExpense)];
    self.navigationItem.rightBarButtonItem = rigthButton;
    self.navigationItem.leftBarButtonItem = leftButton;
    leftButton.tintColor = [self colorFromHexString:@"#2c3e50"];
    rigthButton.tintColor = [self colorFromHexString:@"#2c3e50"];

    _tableView.separatorColor = [self colorFromHexString:@"#7f8c8d"];
    _btnUpload.layer.cornerRadius = 10;
    _btnUpload.clipsToBounds = YES;
    [[_btnUpload layer] setBorderWidth:1.0f];
    [[_btnUpload layer] setBorderColor:[self colorFromHexString:@"#3498db"].CGColor];
    self.title = @"EXPENSES";

    
    [self customizeViewInterface];
}
- (void)refreshInfo:(UIRefreshControl *) sender {
    [sender endRefreshing];

}
- (void)customizeViewInterface {
    UIRefreshControl *refreshControl= [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self
                       action:@selector(refreshInfo:)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl =refreshControl;
    self.refreshControl.tintColor = [self colorFromHexString:@"#F84151"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.refreshControl beginRefreshing];
    [self refreshInfo:self.refreshControl];
    [self animateTable];

}
- (void)goStatics{
    PKLoginController *loginController = [[PKLoginController alloc]initWithNibName:@"PKLoginController" bundle:nil];
    [self.navigationController pushViewController:loginController animated:YES];
}
- (void)addExpense{
    PKCategoriesController *categoriesController = [[PKCategoriesController alloc]initWithNibName:@"PKCategoriesController" bundle:nil];
    [self.navigationController pushViewController:categoriesController animated:YES];
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
    static NSString *identifierCustom = @"PKSpendCell";
    
    PKSpendCell *cell = (PKSpendCell *)[tableView dequeueReusableCellWithIdentifier:identifierCustom];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierCustom owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *payment = _expenses[indexPath.row];
    NSLog(@"%@",payment);
    cell.imgKind.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[payment valueForKey:@"category"]]];
    UILabel *subHeader2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,125)];
    switch ([[payment valueForKey:@"category"] integerValue]) {
        case 0:{
            subHeader2.backgroundColor = [self colorFromHexString:@"#c53b2d"];
            break;
        }
        case 1:{
            subHeader2.backgroundColor = [self colorFromHexString:@"#f39c12"];
            break;
        }
        case 2:{
            subHeader2.backgroundColor = [self colorFromHexString:@"#2980b9"];
            break;
        }
        case 3:{
            subHeader2.backgroundColor = [self colorFromHexString:@"#27ae60"];
            break;
        }
        case 4:{
            subHeader2.backgroundColor = [self colorFromHexString:@"#1abc9c"];
            break;
        }
        default:
            break;
    }
    cell.lblMoney.textColor = [self colorFromHexString:@"#F84151"];
    cell.lblMoney.text = [NSString stringWithFormat:@"$ %@",[payment valueForKey:@"amount"]];
    cell.lblDate.text = [payment valueForKey:@"date"];
    cell.lblTitle.text = [payment valueForKey:@"description"];
    subHeader2.layer.cornerRadius = 2;
    subHeader2.clipsToBounds = YES;
    [cell addSubview:subHeader2];
    
    cell.layer.cornerRadius = 10;
    cell.clipsToBounds = YES;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

        [_expenses removeObjectAtIndex:indexPath.row];
        
        [user setObject:_expenses forKey:@"expenses"];
        [user synchronize];
        [_tableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return _expenses.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)animateTable{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    _expenses = [[user valueForKey:@"expenses"] mutableCopy];
    [_tableView reloadData];
    NSArray *cells = _tableView.visibleCells;
    ;
    for (UITableViewCell  *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, _tableView.bounds.size.height);
    }
    int index = 0;
    for (UITableViewCell  *cell in cells) {
        [UIView animateWithDuration:1.5f delay:0.05f * index
             usingSpringWithDamping:0.8f initialSpringVelocity:0.0f
                            options:0 animations:^{
                                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                            } completion:nil];
        index++;
    }
}
@end
