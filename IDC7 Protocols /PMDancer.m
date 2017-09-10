//
//  PMDancer.m
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDancer.h"

@implementation PMDancer

- (void) dance{
    
}

-(BOOL) areYouOk{
    BOOL ok=arc4random()%2;
    NSLog(@"is dancer %@ yours eggs ok?%@",self.name, ok? @"YES": @"NO" );
    return ok;
}
-(void) takePill{
    NSLog(@"Dancer %@ take pill",self.name);
}
-(void) makeShot{
    NSLog(@"Dancer %@ is made shot",self.name);
    
}



@end
