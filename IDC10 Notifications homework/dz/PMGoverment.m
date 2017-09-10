//
//  PMGoverment.m
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMGoverment.h"

NSString* const PMGovermentTaxLevelDidChangeNotification = @"PMGovermentTaxLevelDidChangeNotification";
NSString* const PMGovermentPensionDidChangeNotification = @"PMGovermentPensionDidChangeNotification";
NSString* const PMGovermentSalaryDidChangeNotification = @"PMGovermentSalaryDidChangeNotification";
NSString* const PMGovermentAveragePriceDidChangeNotification = @"PMGovermentAveragePriceDidChangeNotification";

NSString* const PMGovermentTaxLevelUserInfoKey = @"PMGovermentTaxLevelUserInfoKey";
NSString* const PMGovermentPensionUserInfoKey = @"PMGovermentPensionUserInfoKey";
NSString* const PMGovermentSalaryUserInfoKey = @"PMGovermentSalaryUserInfoKey";
NSString* const PMGovermentAveragePriceUserInfoKey = @"PMGovermentAveragePriceUserInfoKey";


@implementation PMGoverment

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taxLevel = 20;
        _pension = 2;
        _averagePrice = 2;
        _salary = 22;
    
    }
    return self;
}

-(void) setTaxLevel:(NSInteger)taxLevel{
    _taxLevel= taxLevel;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:taxLevel] forKey:PMGovermentTaxLevelUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMGovermentTaxLevelDidChangeNotification
                    object:nil
                    userInfo:dictionary];
    
}

-(void) setSalary:(NSInteger)salary{
    _salary= salary;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:salary] forKey:PMGovermentSalaryUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMGovermentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}

-(void) setPension:(NSInteger)pension{
    _pension= pension;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:pension] forKey:PMGovermentPensionUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMGovermentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}

-(void) setAveragePrice:(NSInteger)averagePrice{
    _averagePrice= averagePrice;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:averagePrice] forKey:PMGovermentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMGovermentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}



@end
