//
//  PKLoginController.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/9/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKLoginController.h"
#import "PKRegisterController.h"
@interface PKLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@end

@implementation PKLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LOGIN";
    [self.navigationItem setHidesBackButton:YES];
    [_btnSignIn setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnSignIn.backgroundColor = [UIColor whiteColor];
    _btnSignIn.layer.cornerRadius = 10;
    _btnSignIn.clipsToBounds = YES;
    [[_btnSignIn layer] setBorderWidth:2.0f];
    [[_btnSignIn layer] setBorderColor:[self colorFromHexString:@"#F84151"].CGColor];
    
    [_btnSignUp setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnSignUp.backgroundColor = [UIColor whiteColor];
    _btnSignUp.layer.cornerRadius = 10;
    _btnSignUp.clipsToBounds = YES;
    [[_btnSignUp layer] setBorderWidth:2.0f];
    [[_btnSignUp layer] setBorderColor:[self colorFromHexString:@"#F84151"].CGColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[self imageWithImage:[UIImage imageNamed:@""] scaledToSize:CGSizeMake(25,25)]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (IBAction)hideKeyboard:(id)sender {
    [self resignFirstResponder];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (IBAction)login:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)singup:(id)sender {
    PKRegisterController *registerController = [[PKRegisterController alloc]initWithNibName:@"PKRegisterController" bundle:nil];
    [self.navigationController pushViewController:registerController animated:YES];
}

@end
