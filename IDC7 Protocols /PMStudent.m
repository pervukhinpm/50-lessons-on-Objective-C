//
//  PMStudent.m
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMStudent.h"

@implementation PMStudent

-(void) study{
    
}

-(BOOL) areYouOk{
    BOOL ok=arc4random()%2;
    NSLog(@"is student %@ ok?%@",self.name, ok? @"YES": @"NO" );
    return ok;
}
-(void) takePill{
    NSLog(@"student %@ take pill",self.name);
}
-(void) makeShot{
    NSLog(@"student %@ is made shot",self.name);
    
}

-(void) howisyourjob{
    NSLog(@"normal");
}
-(void) howisyourfamily{
    NSLog(@"shut up");
}



@end
