//
//  PMDoctor.m
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDoctor.h"
#import "PMGoverment.h"

@implementation PMDoctor

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter* nc= [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(salaryChangedNotification:)
                   name:PMGovermentSalaryDidChangeNotification
                 object:nil];
       
        [nc addObserver:self
               selector:@selector(averagePriceChangedNotification:)
                   name:PMGovermentAveragePriceDidChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(applicationDidEnterBackground:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    
        [nc addObserver:self
               selector:@selector(applicationWillEnterForeground:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
    
    }
    return self;
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) salaryChangedNotification : (NSNotification*) notification{
    
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentSalaryUserInfoKey];
    
    NSInteger salary = [value integerValue];
    
    if (salary > self.salary) {
        NSLog(@"Doctor happy salary grow up");
    }else{
        NSLog(@"Doctor unhappy salary fall down");
    }
    
    self.salary = salary;
}


- (void) averagePriceChangedNotification : (NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentAveragePriceUserInfoKey];
    
    NSInteger averagePrice = [value integerValue];
    
    if (averagePrice > self.averagePrice) {
        NSLog(@"Doctor unhappy average grow up");
    }else{
        NSLog(@"Doctor happy average fall");
    }
    
    self.averagePrice = averagePrice;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Doctor went to sleep");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Doctor woke up");
}


@end
