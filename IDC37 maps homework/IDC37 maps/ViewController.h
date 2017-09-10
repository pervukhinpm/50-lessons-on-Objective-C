//
//  ViewController.h
//  IDC37 maps
//
//  Created by Петр Первухин on 18.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView ;

@interface ViewController : UIViewController

@property (weak,nonatomic) IBOutlet MKMapView* mapView;

@end

