//
//  PMStudent.h
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    PMMan,
    PMWoman
} PMGender;

@interface PMStudent : NSObject

@property (weak, nonatomic) PMStudent *friend;


@property (strong,nonatomic) NSString* firstName;
@property (strong,nonatomic) NSString* lastName;
@property (strong,nonatomic) NSDate* dateOfBirth;
@property (assign,nonatomic) double grade;
@property (assign,nonatomic) PMGender  gender;

-(void) deleteAll;

@end
