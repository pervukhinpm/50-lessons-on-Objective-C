//
//  PMMeetingPoint.m
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMMeetingPoint.h"

@interface PMMeetingPoint ()


@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@end

@implementation PMMeetingPoint

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        double plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _longitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLongitude;
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _latitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLatitude;
        
        _coordinate.longitude = _longitude;
        _coordinate.latitude = _latitude;
        
        _title = @"Meeting";
    }
    return self;
}

static double mainLatitude = 56.011644;
static double mainLongitude  = 37.473795;

@end
