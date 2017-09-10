//
//  PMDoctorIdiot.m
//  delegati peredelanoe
//
//  Created by Петр Первухин on 21.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDoctorIdiot.h"

@implementation PMDoctorIdiot

-(void) goToDoc:(PMPatient *)patient{
    
    NSLog(@"Doctor idiot: hmmm maybe you need relax?");
    [patient smokeWeed];
    
}


@end
