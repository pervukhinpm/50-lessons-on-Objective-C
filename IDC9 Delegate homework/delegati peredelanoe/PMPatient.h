//
//  PMPatient.h
//  delegati peredelanoe
//
//  Created by Петр Первухин on 20.05.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  PMDoctorDelegate;

typedef enum {leg,
    hand,
    stomache,
    head
}PMBodyParts;

@interface PMPatient : NSObject

@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger temperature;
@property (assign,nonatomic) PMBodyParts pain;
@property (weak,nonatomic) id <PMDoctorDelegate> delegate;
@property (assign,nonatomic) BOOL markForDoc;
@property (assign,nonatomic) NSInteger whichDoc;
- (void) feelBad;

//Doctor methods

- (void) takePill;
- (void) makeShot;
- (void) makeSurgery;

//Doctor Idiot methods

-(void) smokeWeed;

@end

@protocol PMDoctorDelegate <NSObject>

- (void) goToDoc : (PMPatient*) patient;

@end
