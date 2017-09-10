//
//  MKAnnotationView.h
//  IDC37 maps
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

-(MKAnnotationView*) superAnnotationView;

@end
