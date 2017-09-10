//
//  AppFakeDelegate.m
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "AppFakeDelegate.h"

@implementation AppFakeDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(applicationWillResignActive:)
                   name:UIApplicationWillResignActiveNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(applicationDidEnterBackground:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(applicationWillEnterForeground:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(applicationDidBecomeActive:)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(applicationWillTerminate:)
                   name:UIApplicationWillTerminateNotification
                 object:nil];
        
    }
    return self;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"AppFakeDelegate: applicationWillResignActive will run");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"AppFakeDelegate: applicationDidEnterBackground will run");

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"AppFakeDelegate: applicationWillEnterForeground will run");

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"AppFakeDelegate: applicationDidBecomeActive will run");

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"AppFakeDelegate: applicationWillTerminate will run");

}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
