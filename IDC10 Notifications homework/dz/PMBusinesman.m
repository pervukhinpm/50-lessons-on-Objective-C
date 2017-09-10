//
//  PMBusinesman.m
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMBusinesman.h"
#import "PMGoverment.h"

@implementation PMBusinesman

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(taxLevelChangedNotification:)
                   name:PMGovermentTaxLevelDidChangeNotification
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


- (void) taxLevelChangedNotification :(NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentTaxLevelUserInfoKey];
    
    NSInteger taxLevel = [value integerValue];
    
    if (taxLevel > self.taxLevel) {
        NSLog(@"Businesman unhappy taxLevel grow up");
    }else{
        NSLog(@"Businesman happy taxLevel fall down");
    }
    
    self.taxLevel = taxLevel;
    

}


- (void) averagePriceChangedNotification : (NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:PMGovermentAveragePriceUserInfoKey];
    
    NSInteger averagePrice = [value integerValue];
    
    if (averagePrice > self.averagePrice) {
        NSLog(@"Businesman unhappy average grow up");
    }else{
        NSLog(@"Businesman happy average fall");
    }
    
    self.averagePrice = averagePrice;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Businesman went to sleep");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Businesman woke up");
}

@end
