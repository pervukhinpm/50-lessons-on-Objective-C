//
//  PMPatient.m
//  delegati peredelanoe
//
//  Created by Петр Первухин on 20.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMPatient.h"

@implementation PMPatient

- (void) feelBad {
    BOOL feel = NO;//arc4random()%2;
    if (feel) {
        NSLog(@"patinet %@ feel good",self.name);
    }else{
        NSLog(@"patient %@ feel bad,%@ to doctor", self.name , self.name);
        [self.delegate goToDoc:self];
    }
}


- (void) takePill{
    NSLog(@"Patient %@ take pill",self.name);
}

-(void) makeShot{
    NSLog(@"patient %@ make shot",self.name);
}

-(void) makeSurgery{
    NSLog(@"patient %@ make surgery", self.name);
}

- (void) smokeWeed{
    NSLog(@"patient %@ smoke weed", self.name);
}


@end
