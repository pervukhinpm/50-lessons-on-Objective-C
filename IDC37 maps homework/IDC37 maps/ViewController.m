//
//  ViewController.m
//  IDC37 maps
//
//  Created by Петр Первухин on 18.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "PMMapAnnotation.h"
#import "MKAnnotationView.h"

@interface ViewController () <MKMapViewDelegate>

@property(strong, nonatomic) CLGeocoder* geocoder;
@property(strong,nonatomic) MKDirections* directions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];

    UIBarButtonItem* searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showAll:)];
    self.navigationItem.rightBarButtonItems = @[searchButton,addButton];
    self.geocoder = [[CLGeocoder alloc] init];
}

-(void) dealloc{
    [self.geocoder cancelGeocode];
}

-(void)addButton:(UIBarButtonItem*)sender{
    
    PMMapAnnotation* annotation = [[PMMapAnnotation alloc] init];
    annotation.title = @"title";
    annotation.subtitle = @"subtitle";
    annotation.coordinate = self.mapView.region.center;
    [self.mapView addAnnotation:annotation];
    
}

-(void) showAll:(UIBarButtonItem*)sender{
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations){
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 20000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta*2, delta*2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 100, 100) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    static NSString* identifier = @"Annotation";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.animatesDrop = YES;
        pin.draggable = YES;
        pin.canShowCallout = YES;
        
        UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = descriptionButton;
        
        UIButton* dirrection = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [dirrection addTarget:self action:@selector(actionDirrection:) forControlEvents:UIControlEventTouchUpInside];
        pin.leftCalloutAccessoryView = dirrection;
        
        
    } else {
        pin.annotation = annotation;
    }
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState{
    
}

-(void) showAlertWithTitle : (NSString*) title  andMessage:(NSString*) message{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void) actionDescription : (UIButton*) sender{
    
    MKAnnotationView* annotationView = [sender superAnnotationView];
    
    if (!annotationView){
        return;
    }
    
    CLLocationCoordinate2D cordinate = annotationView.annotation.coordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:cordinate.latitude
                                                      longitude:cordinate.longitude];
    
    if ([self.geocoder isGeocoding]) {
        
        [self.geocoder cancelGeocode];
        
    }
    
    [self.geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray*  placemarks, NSError * _Nullable error) {
                       NSString * message = nil;
                       if (error){
                           message = [error localizedDescription];
                       }else{
                           if (placemarks.count > 0){
                               MKPlacemark* placeMark = [placemarks firstObject];
                               message = [placeMark.addressDictionary description];
                           }else{
                               NSLog(@"no placemarks found");
                           }
                       }
                       [self showAlertWithTitle:@"location" andMessage:message];
                   }];
}

- (void) actionDirrection : (UIButton*) sender{

    MKAnnotationView* annotationView = [sender superAnnotationView];
    
    if (!annotationView){
        return;
    }
    
    if ([self.directions isCalculating]) {
        
        [self.directions cancel];
        
    }
    CLLocationCoordinate2D cordinate = annotationView.annotation.coordinate;
    
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:cordinate
                                                   addressDictionary:nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    request.destination = destination;

    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    request.requestsAlternateRoutes = YES;
    
    self.directions = [[MKDirections alloc] initWithRequest:request];
    
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            [self showAlertWithTitle:@"Error" andMessage: [error localizedDescription]];
        }else if (response.routes == 0){
            [self showAlertWithTitle:@"Error" andMessage:@"No routs found"];
        }else{
            [self.mapView removeOverlays:[self.mapView overlays]];
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            for (MKRoute* rout in response.routes) {
                [array addObject:rout.polyline];
            }
            [self.mapView addOverlays:array level:MKOverlayLevelAboveRoads];
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(10_9, 7_0){
    if ([overlay isKindOfClass:[ MKPolyline class]]){
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor colorWithRed:0.f green:0.5f blue:1.f alpha:0.9f];
        return renderer;
    }
    return nil;
}


/*
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"regionWillChangeAnimated");
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChangeAnimated");

}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapViewWillStartLoadingMap");

}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapViewDidFinishLoadingMap");

}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"mapViewDidFailLoadingMap");

}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView NS_AVAILABLE(10_9, 7_0){
    NSLog(@"mapViewWillStartRenderingMap");

}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    NSLog(@"mapViewDidFinishRenderingMap");

}
*/

@end
