//
//  HLLAppDelegate.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLAppDelegate.h"
#import "HLLHomeViewController.h"

@implementation HLLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBackgroundColor:[UIColor cyanColor]];
    [UINavigationBar appearance].tintColor = [UIColor orangeColor];
    
    HLLHomeViewController *homeVC = [HLLHomeViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    
    return YES;
}

@end
