//
//  PMStudent.h
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    PMWoman,
    PMMan
} PMGender;

@interface PMStudent : NSObject <MKAnnotation>

@property (strong,nonatomic) NSString* firstName;
@property (strong,nonatomic) NSString* lastName;
@property (strong,nonatomic) NSString* date;
@property (assign,nonatomic) PMGender gender;

@property (assign,nonatomic) CLLocationCoordinate2D coordinate;
@property (assign,nonatomic) double latitude;
@property (assign,nonatomic) double longitude;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@property (assign, nonatomic) BOOL meetingState;
@property (strong, nonatomic) NSString *meetingDistance;

@end


