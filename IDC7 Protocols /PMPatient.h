//
//  PMPatient.h
//  Protocols
//
//  Created by Петр Первухин on 29.04.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMPatient <NSObject>

@property (strong,nonatomic) NSString* name;

-(BOOL) areYouOk;
-(void) takePill;
-(void) makeShot;


@optional
-(void) howisyourjob;
-(void) howisyourfamily;

@end
