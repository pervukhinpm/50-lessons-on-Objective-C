//
//  PMDoctor.m
//  delegati peredelanoe
//
//  Created by Петр Первухин on 20.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDoctor.h"

@implementation PMDoctor

- (void) goToDoc:(PMPatient *)patient{

    NSNumber* organ= [[NSNumber alloc] init];

    switch (patient.pain) {
    
            
        case head:
            NSLog(@"Doctor:%@ hurts head, you have gangrena,need a surgery", patient.name);
            [patient makeSurgery];
            organ=[NSNumber numberWithInt:head];
            self.raport[patient.name]=organ;
            break;
            
        case leg:
            NSLog(@"Doctor:%@ hurts leg,take a pill",patient.name);
            [patient takePill];
            [self.raport setObject:[NSNumber numberWithInt:leg] forKey: patient.name];
            
            break;
        
        case stomache:
            NSLog(@"Doctor:%@ hurts stomache,lets made a shot",patient.name);
            [patient makeShot];
            [self.raport setObject:[NSNumber numberWithInt:stomache] forKey: patient.name];
            break;
            
        default:
            NSLog(@"WRONG");
            break;
    }
    
    
    
}

@end
