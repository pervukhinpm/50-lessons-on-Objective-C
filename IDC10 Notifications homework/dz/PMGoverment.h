//
//  PMGoverment.h
//  dz
//
//  Created by Петр Первухин on 22.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const PMGovermentTaxLevelDidChangeNotification;
extern NSString* const PMGovermentPensionDidChangeNotification;
extern NSString* const PMGovermentSalaryDidChangeNotification;
extern NSString* const PMGovermentAveragePriceDidChangeNotification;

extern NSString* const PMGovermentTaxLevelUserInfoKey;
extern NSString* const PMGovermentPensionUserInfoKey;
extern NSString* const PMGovermentSalaryUserInfoKey;
extern NSString* const PMGovermentAveragePriceUserInfoKey;


@interface PMGoverment : NSObject

@property (assign,nonatomic) NSInteger taxLevel;
@property (assign,nonatomic) NSInteger pension;
@property (assign,nonatomic) NSInteger salary;
@property (assign,nonatomic) NSInteger averagePrice;





@end
