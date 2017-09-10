//
//  PMDoctor.h
//  delegati peredelanoe
//
//  Created by Петр Первухин on 20.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPatient.h"


@interface PMDoctor : NSObject <PMDoctorDelegate>

@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSMutableDictionary* raport;

@end
