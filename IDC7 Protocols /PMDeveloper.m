//
//  PMDeveloper.m
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDeveloper.h"

@implementation PMDeveloper

-(void) work {
    
}

-(BOOL) areYouOk{
    BOOL ok=arc4random()%2;
    NSLog(@"is developer %@ ok?%@",self.name, ok? @"YES": @"NO" );
    return ok;
}
-(void) takePill{
    NSLog(@"Developer %@ take pill",self.name);
}
-(void) makeShot{
    NSLog(@"Developer %@ is made shot",self.name);

}


@end
