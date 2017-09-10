//
//  ViewController.m
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 31.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "PMStudent.h"
#import "PMStudentDescription.h"
#import "UIView+MKAnnotationView.h"
#import "PMMeetingViewController.h"
#import "PMMeetingPoint.h"
#import "PMMeetingViewCell.h"


@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKDirections *direction;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSMutableArray *meetings;
@property (strong, nonatomic) NSMutableArray *circles;
@property (strong, nonatomic) NSMutableArray *polylines;

@property (strong, nonatomic) NSMutableArray *withoutCircleStudents;
@property (strong, nonatomic) NSMutableArray *firstCircleStudents;
@property (strong, nonatomic) NSMutableArray *secondCircleStudents;
@property (strong, nonatomic) NSMutableArray *thirdCircleStudents;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    self.geoCoder = [[CLGeocoder alloc] init];
    [self authorizationOfTheLocation];
    
    self.students = [[NSMutableArray alloc] init];
    self.meetings = [[NSMutableArray alloc] init];
    self.circles = [[NSMutableArray alloc] init];
    
    self.firstCircleStudents = [[NSMutableArray alloc] init];
    self.secondCircleStudents = [[NSMutableArray alloc] init];
    self.thirdCircleStudents = [[NSMutableArray alloc] init];
    self.withoutCircleStudents = [[NSMutableArray alloc] init];
    self.polylines = [[NSMutableArray alloc] init];

}


static double firstCircleRadius = 2000;
static double secondCircleRadius = 5000;
static double thirdCircleRadius = 8500;

-(void) dealloc{
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    if ([self.direction isCalculating]) {
        [self.direction cancel];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - help functions

- (void) authorizationOfTheLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void) makeRoutesForSender:(UIButton *)sender {
    
    MKAnnotationView *annotationView = [sender superAnnotationView];
    
    if (annotationView) {
        
        CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        request.requestsAlternateRoutes = NO;
        
        MKPlacemark *placemarkDestination = [[MKPlacemark alloc] initWithCoordinate:coordinate];
        request.destination = [[MKMapItem alloc] initWithPlacemark:placemarkDestination];
        
        [self removeAllRoutes];
        
        NSMutableArray *polylines = [[NSMutableArray alloc] init];
        
        for (PMStudent *student in self.students) {
            
            if (student.meetingState) {
                
                MKPlacemark *placemarkSource = [[MKPlacemark alloc] initWithCoordinate:student.coordinate];
                request.source = [[MKMapItem alloc] initWithPlacemark:placemarkSource];
                
                request.transportType = MKDirectionsTransportTypeAutomobile;
                
                if ([self.direction isCalculating]) {
                    [self.direction cancel];
                }
                
                self.direction = [[MKDirections alloc] initWithRequest:request];
                [self.direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response,
                                                                           NSError * _Nullable error) {
                    
                    if (error) {
                        NSLog(@"%@", error.localizedDescription);
                    } else if ([response.routes count] == 0) {
                        NSLog(@"Response routes is 0");
                    } else {
                        
                        for (MKRoute *route in response.routes) {
                            [polylines addObject:route.polyline];
                        }
                        
                        [self.mapView addOverlays:polylines level:MKOverlayLevelAboveRoads];
                    }
                }];
            }
        }
        
        self.polylines = polylines;
    }
}


-(void) popoverStudentDescription:(UIButton*) sender {
    
    PMStudentDescription *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PMStudentDescription"];
    
    [self synchronizeDescriptionInformationWith:sender and:vc];
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = [vc popoverPresentationController];
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    CGRect popoverRect = [sender convertRect:sender.frame toView:self.view];
    
    popover.sourceView = self.view;
    popover.sourceRect = popoverRect;

}

- (void) synchronizeDescriptionInformationWith:(UIButton *)sender and:(PMStudentDescription *)vc {
    
    [vc.tableView reloadData];
    
    MKAnnotationView *annotationView = [sender superAnnotationView];
    
    if (annotationView) {
        
        CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                          longitude:coordinate.longitude];
        
        PMStudent *student = (PMStudent *)annotationView.annotation;
        
        vc.firstNameLabel.text = student.firstName;
        vc.lastNameLabel.text = student.lastName;
        
        if (student.gender == PMMan) {
            vc.genderLabel.text = @"Male";
        } else {
            vc.genderLabel.text = @"Female";
        }
        
        vc.dateLabel.text = student.date;
        
        if ([self.geoCoder isGeocoding]) {
            [self.geoCoder cancelGeocode];
        }
        __block NSString *message = nil;
        
        [self.geoCoder reverseGeocodeLocation:location
                            completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                                
                                if (error) {
                                    message = error.localizedDescription;
                                } else {
                                    
                                    if (placemarks && [placemarks count] > 0) {
                                        
                                        CLPlacemark *placemark = placemarks.firstObject;
                                        
                                        message = [self adressStringFromCLPlacemark:placemark];
                                        
                                    } else {
                                        message = @"No placemarks found";
                                    }
                                }
                                
                                vc.adressLabel.text = message;
                            }];
    }
    [vc.tableView reloadData];
}

- (void) popoverOrActionSheetMeetingInfo:(UIButton *)sender {
    
    PMMeetingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PMMeetingViewController"];
    vc.delegate = self;
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        vc.view.backgroundColor = [UIColor clearColor];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = [vc popoverPresentationController];
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    CGRect popoverRect = [sender convertRect:sender.frame toView:self.view];
    
    popover.sourceView = self.view;
    popover.sourceRect = popoverRect;
}

- (CGFloat) randomFromZeroToOne {
    return (arc4random() % 256) / 255.f;
}

- (UIColor *) randomColor {
    
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (NSString *) adressStringFromCLPlacemark:(CLPlacemark *)placemark {
    
    NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                         
                         [placemark name] ? [placemark name] : @"",
                         
                         [placemark name] && ([placemark locality] || [placemark administrativeArea]
                                              || [placemark country]) ? @",\n" : @"",
                         
                         [placemark locality] && ![[placemark locality] isEqualToString:[placemark name]]
                         ? [placemark locality] : @"",
                         
                         [placemark locality] && ([placemark administrativeArea] || [placemark country]) &&
                         ![[placemark locality] isEqualToString:[placemark name]] ? @",\n" : @"",
                         
                         [placemark administrativeArea] && ![[placemark administrativeArea]
                                                             isEqualToString:[placemark locality]]
                         && ![[placemark administrativeArea] isEqualToString:[placemark name]]
                         ? [placemark administrativeArea] : @"",
                         
                         [placemark administrativeArea] && [placemark country]
                         && ![[placemark administrativeArea]
                              isEqualToString:[placemark locality]]
                         && ![[placemark administrativeArea] isEqualToString:[placemark name]] ? @",\n" : @"",
                         
                         [placemark country] ? [placemark country] : @""];
    
    return message;
}

- (void) removeAllCirclesWithStudents {
    [self.firstCircleStudents removeAllObjects];
    [self.secondCircleStudents removeAllObjects];
    [self.thirdCircleStudents removeAllObjects];
    [self.withoutCircleStudents removeAllObjects];
}

- (void) removeAllRoutes {
    if ([self.polylines count] != 0) {
        [self.mapView removeOverlays:self.polylines];
        [self.polylines removeAllObjects];
    }
}



- (void) meetingStateOfStudents {
    
    PMMeetingPoint *meeting = [self.meetings firstObject];
    
    CLLocation *meetingLocation = [[CLLocation alloc] initWithLatitude:meeting.coordinate.latitude
                                                             longitude:meeting.coordinate.longitude];
    
    for (PMStudent *student in self.students) {
        
        student.meetingState = NO;
        
        CLLocation *studentLocation = [[CLLocation alloc] initWithLatitude:student.coordinate.latitude
                                                                 longitude:student.coordinate.longitude];
        
        CLLocationDistance dist = [meetingLocation distanceFromLocation:studentLocation];
        NSInteger random = arc4random() % 1000;
        
        student.meetingDistance = [NSString stringWithFormat:@"%1.1f km", dist / 1000.f];
        
        if (dist < firstCircleRadius) {
            [self.firstCircleStudents addObject:student];
            if (random < 800) {
                student.meetingState = YES;
            }
            continue;
        }
        
        if (dist < secondCircleRadius) {
            [self.secondCircleStudents addObject:student];
            if (random < 500) {
                student.meetingState = YES;
            }
            continue;
        }
        
        if (dist < thirdCircleRadius) {
            [self.thirdCircleStudents addObject:student];
            if (random < 300) {
                student.meetingState = YES;
            }
            continue;
        }
        [self.withoutCircleStudents addObject:student];
    }
}


#pragma mark - Actions

- (void) actionRoutesToMeeting:(UIButton *)sender {
    
    [self makeRoutesForSender:sender];
}

- (void) actionMeetingInfo:(UIButton *)sender {
    
    [self popoverOrActionSheetMeetingInfo:sender];
}

- (IBAction)addStudentAction:(UIBarButtonItem *)sender {
    
    PMStudent *student = [[PMStudent alloc] init];
    
    [self.students addObject:student];
    
    [self.mapView addAnnotation:student];
}

- (IBAction)deleteAllAction:(UIBarButtonItem *)sender {
    
    
    NSLog(@"delete");
    
    
    [self.mapView removeAnnotations:self.students];
    [self.mapView removeAnnotations:self.meetings];
    [self.mapView removeOverlays:self.circles];
    
    [self.students removeAllObjects];
    [self.meetings removeAllObjects];
    [self removeAllRoutes];
    [self removeAllCirclesWithStudents];
    

    NSLog(@" %ld",self.students.count);
}

- (IBAction)showAll:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations){
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 50;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta*2, delta*2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 100, 100) animated:YES];
    
}

- (IBAction)addMeetingAction:(UIBarButtonItem *)sender {
    
    PMMeetingPoint *meeting = [[PMMeetingPoint alloc] init];
    [self.meetings addObject:meeting];
    
    if ([self.meetings count] > 1) {
        
        [self.mapView removeAnnotation:[self.meetings objectAtIndex:0]];
        [self.meetings removeObjectAtIndex:0];
        [self removeAllRoutes];
    }
    
    [self.mapView addAnnotation:meeting];
    [self addCircleRadiusesWithCenterPointIn:meeting.coordinate];
    [self meetingStateOfStudents];
    
}

-(void) actionDescription:(UIButton*) sender{
    [self popoverStudentDescription:sender];
}

#pragma mark - MKMapViewDelegate


- (void) addCircleRadiusesWithCenterPointIn:(CLLocationCoordinate2D)center {
    
    [self removeAllCirclesWithStudents];
    
    if ([self.circles count] != 0) {
        [self.mapView removeOverlays:self.circles];
        [self.circles removeAllObjects];
    }
    
    MKCircle *firstCircle = [MKCircle circleWithCenterCoordinate:center radius:firstCircleRadius];
    MKCircle *secondCircle = [MKCircle circleWithCenterCoordinate:center radius:secondCircleRadius];
    MKCircle *thirdCircle = [MKCircle circleWithCenterCoordinate:center radius:thirdCircleRadius];
    
    [self.circles addObjectsFromArray:@[ firstCircle, secondCircle, thirdCircle ]];
    [self.mapView addOverlays:@[ firstCircle, secondCircle, thirdCircle ] level:MKOverlayLevelAboveRoads];
}



- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]] ) {
        return nil;
    }
    
    static NSString *identifierStudent = @"student";
    static NSString *identifierMeeting = @"meeting";
    
    if ([annotation isKindOfClass:[PMStudent class]]) {
        
        MKAnnotationView *tempAnnotation = (MKAnnotationView *)[mapView
                                                                dequeueReusableAnnotationViewWithIdentifier:identifierStudent];
        
        PMStudent *student = (PMStudent *)annotation;
        
        if (!tempAnnotation) {
            
            tempAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierStudent];
            
            BOOL random = arc4random() % 2;
            
            if (student.gender == PMMan) {
                if (random) {
                    tempAnnotation.image = [UIImage imageNamed:@"man1.png"];
                }else{
                    tempAnnotation.image = [UIImage imageNamed:@"man3.png"];
                }
            } else {
                if (random) {
                    tempAnnotation.image = [UIImage imageNamed:@"woman1.png"];
                }else{
                    tempAnnotation.image = [UIImage imageNamed:@"woman2.png"];
                }
            }
            
            tempAnnotation.canShowCallout = YES;
            
            UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
            
            tempAnnotation.rightCalloutAccessoryView = descriptionButton;
            
        } else {
            
            tempAnnotation.annotation = annotation;
       
        }
        
        return tempAnnotation;
    }
    
    
    if ([annotation isKindOfClass:[PMMeetingPoint class]]) {
        
        MKAnnotationView *tempAnnotation = (MKAnnotationView *)[mapView
                                                                dequeueReusableAnnotationViewWithIdentifier:identifierMeeting];
        if (!tempAnnotation) {
            
            tempAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierMeeting];
            tempAnnotation.draggable = YES;
            tempAnnotation.image = [UIImage imageNamed:@"Meetings.png"];
            
            tempAnnotation.canShowCallout = YES;
            
            UIButton *meetingInformationButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [meetingInformationButton addTarget:self action:@selector(actionMeetingInfo:)
                               forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *routesToMeetingButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [routesToMeetingButton addTarget:self action:@selector(actionRoutesToMeeting:)
                            forControlEvents:UIControlEventTouchUpInside];
            
            tempAnnotation.rightCalloutAccessoryView = meetingInformationButton;
            tempAnnotation.leftCalloutAccessoryView = routesToMeetingButton;
            
        } else {
            tempAnnotation.annotation = annotation;
        }
        
        return tempAnnotation;
    }
    
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState{
    
    if ([view.annotation isKindOfClass:[PMMeetingPoint class]]) {
        
        if (newState == MKAnnotationViewDragStateStarting) {
            
            [UIView animateWithDuration:0.3f animations:^{
                
                view.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
                view.alpha = 0.75f;
            }];
            //NSLog(@"start coordinate: { %f, %f }, isDraggable = %d", view.annotation.coordinate.latitude,
            //      view.annotation.coordinate.longitude, view.isDraggable);
        } else if (newState == MKAnnotationViewDragStateCanceling || newState == MKAnnotationViewDragStateEnding) {
            
            [UIView animateWithDuration:0.3f animations:^{
                
                view.transform = CGAffineTransformIdentity;
                view.alpha = 1.f;
                view.dragState = MKAnnotationViewDragStateNone;
            }];
            
            [self addCircleRadiusesWithCenterPointIn:view.annotation.coordinate];
            [self meetingStateOfStudents];
            [self removeAllRoutes];
            //NSLog(@"end coordinate: { %f, %f }, isDraggable = %d", view.annotation.coordinate.latitude,
            //      view.annotation.coordinate.longitude, view.isDraggable);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    __block MKCircleRenderer *circleRender;
    __block MKPolylineRenderer *polylineRenderer;
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        [UIView animateWithDuration:0.3f animations:^{
            circleRender = [[MKCircleRenderer alloc] initWithCircle:overlay];
            circleRender.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1f];
            circleRender.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
            [circleRender setLineWidth:1.f];
        }];
        
        return circleRender;
    }
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        [UIView animateWithDuration:0.3f animations:^{
            polylineRenderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
            polylineRenderer.lineWidth = 4.f;
            polylineRenderer.strokeColor = [self randomColor];
        }];
        
        return polylineRenderer;
    }
    
    return nil;
}


@end
