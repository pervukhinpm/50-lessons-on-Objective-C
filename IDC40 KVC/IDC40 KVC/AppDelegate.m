//
//  AppDelegate.m
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "AppDelegate.h"
#import "PMStudent.h"
#import "PMGroup.h"

@interface AppDelegate ()

@property (strong,nonatomic) PMStudent* student;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
    PMStudent* student = [[PMStudent alloc] init];

    [student addObserver:self
           forKeyPath:@"name"
              options: NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld
              context:NULL];
    
    
    student.name = @"Petr";
    student.age = 25;
    
    NSLog(@"%@", student);
    
    [student setValue:@"Жора" forKey:@"name"];
    
    NSLog(@"%@", student);

    [student changeName];
    
    NSLog(@"%@", student);

    self.student = student;
    
    PMStudent* student1 = [[PMStudent alloc] init];
    student1.name = @"Justin Bibier";
    student1.age = 25;
    
    PMStudent* student2 = [[PMStudent alloc] init];
    student2.name = @"Corey Taylor";
    student2.age = 41;
    
    PMStudent* student3 = [[PMStudent alloc] init];
    student3.name = @"Kurt Cobain";
    student3.age = 27;
    
    PMStudent* student4 = [[PMStudent alloc] init];
    student4.name = @"Jim Morrison";
    student4.age = 27;
    
    PMGroup* group1 = [[PMGroup alloc] init];
    group1.students = @[student1,student2,student3,student4];
    
    NSLog(@" %@",group1.students);
    
    NSMutableArray* array = [group1 mutableArrayValueForKey:@"students"];
    
    [array removeLastObject];
    
    NSLog(@"array : %@",array);
    
    NSNumber* name = @6;
    
    NSError* error = nil;
    
    if(![self.student validateValue:&name forKey:@"name" error:&error]){
        NSLog(@"%@",error);
    }
    */
    
    return YES;
}

/*
- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(nullable void *)context{
    
    NSLog(@"observeValueForKeyPath:%@\nofObject:%@\nchange:%@",keyPath,object,change);
    
    
}
 */


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
