//
//  PKAddController.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "PKAddController.h"
#import "MKInputBoxView.h"
#import "MMNumberKeyboard.h"
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "JSImagePickerViewController.h"

@interface PKAddController ()<MMNumberKeyboardDelegate,JSImagePickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) NSMutableDictionary *spent;
@property (strong, nonatomic) UIImage *imgTicket;
@end

@implementation PKAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DETAILS";
    
    _spent = [[NSMutableDictionary alloc] init];
    [_spent setObject:[NSString stringWithFormat:@"%d",_category] forKey:@"category"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[self imageWithImage:[UIImage imageNamed:@"goBack.png"] scaledToSize:CGSizeMake(25,25)]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rigthButton = [[UIBarButtonItem alloc]
                                    initWithImage:[self imageWithImage:[UIImage imageNamed:@"luxury.png"] scaledToSize:CGSizeMake(30,30)]
                                    style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(goHome)];
    self.navigationItem.rightBarButtonItem = rigthButton;
    rigthButton.tintColor = [self colorFromHexString:@"#2c3e50"];
    leftButton.tintColor = [self colorFromHexString:@"#2c3e50"];
    
    [_btnAmount setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnAmount.backgroundColor = [UIColor whiteColor];
    _btnAmount.layer.cornerRadius = 10;
    _btnAmount.clipsToBounds = YES;
    [[_btnAmount layer] setBorderWidth:2.0f];
    [[_btnAmount layer] setBorderColor:[self colorFromHexString:@"#F84151"].CGColor];
    
    [_btnDescription setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnDescription.backgroundColor = [UIColor whiteColor];
    _btnDescription.layer.cornerRadius = 10;
    _btnDescription.clipsToBounds = YES;
    [[_btnDescription layer] setBorderWidth:2.0f];
    [[_btnDescription layer] setBorderColor:[self colorFromHexString:@"#F84151"].CGColor];
    
    
    [_btnPhoto setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnPhoto.backgroundColor = [UIColor whiteColor];
    _btnPhoto.layer.cornerRadius = 10;
    _btnPhoto.clipsToBounds = YES;
    [[_btnPhoto layer] setBorderWidth:2.0f];
    [[_btnPhoto layer] setBorderColor:[self colorFromHexString:@"#F84151"].CGColor];
    
    [_btnAdd setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    _btnAdd.backgroundColor = [UIColor whiteColor];
    _btnAdd.layer.cornerRadius = 10;
    _btnAdd.clipsToBounds = YES;
    [[_btnAdd layer] setBorderWidth:2.0f];
    [[_btnAdd layer] setBorderColor:[self colorFromHexString:@"#16a085"].CGColor];
}
- (BOOL)numberKeyboardShouldReturn:(MMNumberKeyboard *)numberKeyboard{
    return YES;
}

- (IBAction)addAmount:(id)sender {
    // Create and configure the keyboard.
    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
    keyboard.allowsDecimalPoint = YES;
    keyboard.delegate = self;
    
    MKInputBoxView *inputBoxView = [MKInputBoxView boxOfType:PlainTextInput];
    [inputBoxView setTitle:@"How much did you spent?"];
    [inputBoxView setMessage:@"Enter the quantity in the textbox"];
    inputBoxView.customise = ^(UITextField *textField) {
        textField.inputView = keyboard;
        return textField;
    };
    [inputBoxView show];
    inputBoxView.onSubmit = ^(NSString *value,NSString *other) {
        NSLog(@"user: %@", value);
        [_spent setObject:value forKey:@"amount"];
        [_btnAmount setTitle:@"DONE" forState:UIControlStateNormal];
        [_btnAmount setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
        [[_btnAmount layer] setBorderColor:[self colorFromHexString:@"#16a085"].CGColor];

    };
}
- (IBAction)addDescription:(id)sender {
    // Create and configure the keyboard.
    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
    keyboard.allowsDecimalPoint = YES;
    keyboard.delegate = self;
    
    MKInputBoxView *inputBoxView = [MKInputBoxView boxOfType:PlainTextInput];
    [inputBoxView setTitle:@"Add a little description"];
    
    [inputBoxView show];
    inputBoxView.onSubmit = ^(NSString *value,NSString *other) {
        NSLog(@"user: %@", value);
        [_spent setObject:value forKey:@"description"];
        [_btnDescription setTitle:@"DONE" forState:UIControlStateNormal];
        [_btnDescription setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
        [[_btnDescription layer] setBorderColor:[self colorFromHexString:@"#16a085"].CGColor];
        
    };
}
- (IBAction)addPhoto:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}
#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePicker:(JSImagePickerViewController *)imagePicker didSelectImage:(UIImage *)image {
    _imgTicket = image;
//    [_spent setObject:_imgTicket forKey:@"image"];
    [_btnPhoto setTitle:@"DONE" forState:UIControlStateNormal];
    [_btnPhoto setTitleColor:[self colorFromHexString:@"#2c3e50"] forState:UIControlStateNormal];
    [[_btnPhoto layer] setBorderColor:[self colorFromHexString:@"#16a085"].CGColor];
}
- (IBAction)savePay:(id)sender {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *expenses = [[user valueForKey:@"expenses"] mutableCopy];

    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy h:mm a"];
    [_spent setObject:[formatter stringFromDate:now] forKey:@"date"];
    
    [expenses addObject:_spent];
    
    [user setObject:expenses forKey:@"expenses"];
    [user synchronize];
    
    if(status == NotReachable){
        NSLog(@"No internet");
    }
    else if (status == ReachableViaWiFi){
        NSLog(@"Wifi, sincornizar");
    }
    [self goHome];
}
- (void)goHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 720;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
@end
