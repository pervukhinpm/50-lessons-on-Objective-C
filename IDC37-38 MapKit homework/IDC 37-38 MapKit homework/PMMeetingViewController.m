//
//  PMMeetingViewController.m
//  IDC 37-38 MapKit homework
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMMeetingViewController.h"
#import "PMMeetingViewCell.h"
#import "PMStudent.h"

@interface PMMeetingViewController ()

@end

@implementation PMMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [NSString stringWithFormat:@"0 - 2 km, %ld person(s)", [self.delegate.firstCircleStudents count]];
    } else if (section == 1) {
        return [NSString stringWithFormat:@"2 - 5 km, %ld person(s)", [self.delegate.secondCircleStudents count]];
    } else if (section == 2) {
        return [NSString stringWithFormat:@"5 - 8.5 km, %ld person(s)", [self.delegate.thirdCircleStudents count]];
    } else {
        return [NSString stringWithFormat:@"8.5 - ... km, %ld person(s)", [self.delegate.withoutCircleStudents count]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.delegate.firstCircleStudents count];
    } else if (section == 1) {
        return [self.delegate.secondCircleStudents count];
    } else if (section == 2) {
        return [self.delegate.thirdCircleStudents count];
    } else {
        return [self.delegate.withoutCircleStudents count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    PMMeetingViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    PMStudent *student;
    
    if (indexPath.section == 0) {
        student = [self.delegate.firstCircleStudents objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        student = [self.delegate.secondCircleStudents objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        student = [self.delegate.thirdCircleStudents objectAtIndex:indexPath.row];
    } else {
        student = [self.delegate.withoutCircleStudents objectAtIndex:indexPath.row];
    }
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.distanceLabel.text = student.meetingDistance;
    
    if (student.meetingState) {
        cell.statusImage.image = [UIImage imageNamed:@"good"];
    } else {
        cell.statusImage.image = [UIImage imageNamed:@"bad"];
    }
    
    return cell;
}

- (IBAction)actionOKPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
