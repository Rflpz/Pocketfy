//
//  PKRegisterController.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/14/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKRegisterController.h"

@interface PKRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@end

@implementation PKRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SING UP";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[self imageWithImage:[UIImage imageNamed:@"goBack.png"] scaledToSize:CGSizeMake(25,25)]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
    leftButton.tintColor = [self colorFromHexString:@"#2c3e50"];
    
    [_btnSignUp setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnSignUp.backgroundColor = [UIColor whiteColor];
    _btnSignUp.layer.cornerRadius = 10;
    _btnSignUp.clipsToBounds = YES;
    [[_btnSignUp layer] setBorderWidth:2.0f];
    [[_btnSignUp layer] setBorderColor:[self colorFromHexString:@"#ff4a38"].CGColor];

}
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
@end
