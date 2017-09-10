//
//  PMStudent.h
//  IDC31
//
//  Created by Петр Первухин on 08.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMStudent : NSObject

@property(strong,nonatomic) NSString* firstName;
@property(strong,nonatomic) NSString* lastName;
@property(assign,nonatomic) double averageGrade;

+(PMStudent*) randomStudent;

@end
