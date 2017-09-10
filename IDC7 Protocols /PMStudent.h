//
//  PMStudent.h
//  Protocols
//
//  Created by Петр Первухин on 27.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPatient.h"

@interface PMStudent : NSObject <PMPatient>
@property (strong,nonatomic) NSString* name;
@property (strong, nonatomic) NSString* universityName;


-(void) study;

@end
