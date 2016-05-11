//
//  AppDelegate.m
//  Pocketfy
//
//  Created by Rafael Lopez on 3/8/16.
//  Copyright © 2016 Rflpz. All rights reserved.
//

#import "AppDelegate.h"
#import "PKSpendController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    PKSpendController *spendController = [[PKSpendController alloc]initWithNibName:@"PKSpendController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:spendController];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setTintColor:[self colorFromHexString:@"#F84151"]];
    NSUserDefaults *usuario = [NSUserDefaults standardUserDefaults];
    if (![[usuario valueForKey:@"expensesOpt"]isEqualToString:@"1"]) {
        NSLog(@"Array no inicializado");
        NSMutableArray *expenses = [[NSMutableArray alloc] init];
        [usuario setObject:expenses forKey:@"expenses"];
        [usuario setObject:@"1" forKey:@"expensesOpt"];
        [usuario synchronize];
    }else{
        NSLog(@"Array inicializado");
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
