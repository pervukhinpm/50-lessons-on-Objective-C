//
//  AppDelegate.m
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "AppDelegate.h"
#import "PMPatient.h"
#import "PMDancer.h"
#import "PMDeveloper.h"
#import "PMStudent.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    PMStudent* student1=[[PMStudent alloc] init];
    PMStudent* student2=[[PMStudent alloc] init];
    PMStudent* student3=[[PMStudent alloc] init];
    
    student1.name=@"student1";
    student2.name=@"student2";
    student3.name=@"student3";
    
    PMDancer* dancer1=[[PMDancer alloc] init];
    PMDancer* dancer2=[[PMDancer alloc] init];
    
    dancer1.name=@"dancer1";
    dancer2.name=@"dancer2";
    
    PMDeveloper* developer1=[[PMDeveloper alloc] init];
    
    developer1.name=@"Bill Gates";
    
    NSArray* patients=[NSArray arrayWithObjects: student1,student2,dancer1,dancer2,student3,developer1,nil];
    
    
    for (id <PMPatient> patient in patients) {
        NSLog(@"patient name=%@",patient.name);
        if (![patient areYouOk]) {
            [patient takePill];
        
        if (![patient areYouOk]) {
            [patient makeShot];
        }
    
    }
        if ([patient respondsToSelector:@selector(howisyourfamily)]){
            [patient howisyourfamily];
}
        if ([patient respondsToSelector:@selector(howisyourjob)]){
            [patient howisyourjob];

    }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
