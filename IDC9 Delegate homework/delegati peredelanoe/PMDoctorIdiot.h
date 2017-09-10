//
//  PMDoctorIdiot.h
//  delegati peredelanoe
//
//  Created by Петр Первухин on 21.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPatient.h"

@interface PMDoctorIdiot : NSObject <PMDoctorDelegate>

@property (strong,nonatomic) NSString* name;

@end

