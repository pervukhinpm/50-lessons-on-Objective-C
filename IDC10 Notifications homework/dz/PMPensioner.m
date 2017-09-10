//
//  PMPensioner.m
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMPensioner.h"
#import "PMGoverment.h"

@implementation PMPensioner

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(pensionChangedNotification:)
                   name:PMGovermentPensionDidChangeNotification
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


- (void) pensionChangedNotification : (NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentPensionUserInfoKey];
    
    NSInteger pension = [value integerValue];
    
    if (pension > self.pension) {
        NSLog(@"Pensioner happy pension grow up");
    }else{
        NSLog(@"Pensioner unhappy pension fall");
    }
    
    self.pension = pension;
}



- (void) averagePriceChangedNotification : (NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentAveragePriceUserInfoKey];
    
    NSInteger averagePrice = [value integerValue];
    
    if (averagePrice > self.averagePrice) {
        NSLog(@"Pensioner unhappy average grow up");
    }else{
        NSLog(@"Pensioner happy average fall");
    }
    
    self.averagePrice = averagePrice;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Pensioner went to sleep");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Pensioner woke up");
}


@end
