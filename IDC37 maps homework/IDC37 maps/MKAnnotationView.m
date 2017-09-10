//
//  MKAnnotationView.m
//  IDC37 maps
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

-(MKAnnotationView*) superAnnotationView{
    
    if ([self isKindOfClass:[MKAnnotationView class]]){
        return (MKAnnotationView*)self ;
    }
    if (!self.superview){
        return nil;
    }
    return [self.superview superAnnotationView];
}

@end
