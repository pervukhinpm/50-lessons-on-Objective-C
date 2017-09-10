//
//  ASParent.m
//  parentstudy
//
//  Created by Петр Первухин on 26.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ASParent.h"

@implementation ASParent

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Parent class is initialized");
    }
    return self;
}

-(void) sayHello {
    NSLog(@"Hello I'm parent");
}

-(void) say:(NSString*) string {
    NSLog(@"%@",string);
}

-(void) say:(NSString*) string1 and:(NSString*) string2 {
    NSLog(@"%@%@",string1,string2);
}

-(NSString*) sayData {
    
    return @"cmon";
}

-(NSString*) saySomething {
    NSString* string=[self sayData];
    
 return string;
}

@end
