//
//  ASChild.m
//  parentstudy
//
//  Created by Петр Первухин on 26.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ASChild.h"

@implementation ASChild
- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Child class is initialized");
    }
    return self;
}


-(NSString*) sayData{
    return @"Data";
}

-(NSString*) saySomething{
    return [self sayData];
}

@end
