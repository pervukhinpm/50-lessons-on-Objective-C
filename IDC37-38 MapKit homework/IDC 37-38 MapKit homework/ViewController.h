//
//  ViewController.h
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)addStudentAction:(UIBarButtonItem *)sender;
- (IBAction)deleteAllAction:(UIBarButtonItem *)sender;
- (IBAction)showAll:(UIBarButtonItem *)sender;
- (IBAction)addMeetingAction:(UIBarButtonItem *)sender;


@end

