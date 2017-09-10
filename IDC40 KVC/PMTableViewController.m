//
//  PMTableViewController.m
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMTableViewController.h"
#import "PMStudent.h"
#import "PMDateViewController.h"

@interface PMTableViewController () <UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@end

NSString *kfirstName = @"firstName";
NSString *klastName = @"lastName";
NSString *kdateOfBirth = @"dateOfBirth";
NSString *kgender = @"gender";
NSString *kgrade = @"grade";

@implementation PMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.student = [[PMStudent alloc] init];
    
    [self.student addObserver:self
                   forKeyPath:kfirstName
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:klastName
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kdateOfBirth
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kgender
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kgrade
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    /*
     
     //                                     *** MASTER && SUPERMAN ***
     
     RTStudent *student1 = [[RTStudent alloc] init];
     RTStudent *student2 = [[RTStudent alloc] init];
     RTStudent *student3 = [[RTStudent alloc] init];
     RTStudent *student4 = [[RTStudent alloc] init];
     
     student4.friend = student3;
     student3.friend = student2;
     student2.friend = student1;
     student1.friend = self.student;
     self.student.friend = student4;
     
     NSArray *students = @[ student4, student3, student2, student1, self.student ];
     
     for (RTStudent *student in students) {
     [student setValue:@"kek" forKeyPath:@"friend.lastName"];
     }
     
     NSArray *studentNames = [students valueForKeyPath:@"@distinctUnionOfObjects.firstName"];
     NSDate *minBirth = [students valueForKeyPath:@"@min.dateOfBirth"];
     NSDate *maxBirth = [students valueForKeyPath:@"@max.dateOfBirth"];
     double avgGrade = [[students valueForKeyPath:@"@avg.grade"] doubleValue];
     double sumAllGrade = [[students valueForKeyPath:@"@sum.grade"] doubleValue];
     
     
     NSLog(@"\n\nALL NAMES: %@\n\n", studentNames);
     NSLog(@"MIN BIRTH: %@\n\n", minBirth);
     NSLog(@"MAX BIRTH: %@\n\n", maxBirth);
     NSLog(@"AVG GRADE: %f\n\n", avgGrade);
     NSLog(@"SUM ALL GRADE: %f\n\n", sumAllGrade);
     
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Observing

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                        context:(void *)context {
    
    NSLog(@"\n\nobserveValueForKeyPath: %@\nobject: %@\nchange: %@\n", keyPath, object, change);
    
}

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(UITextField *)sender {
    
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"showDateOfBirth"]) {
        
        PMDateViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        
        CGRect popoverRect = [sender convertRect:sender.frame toView:self.view];
        
        popover.sourceView = self.view;
        popover.sourceRect = popoverRect;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else {
        [self.lastNameField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.dateOfBirthField]) {
        
        [self performSegueWithIdentifier:@"showDateOfBirth" sender:textField];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        self.student.firstName = textField.text;
    } else if ([textField isEqual:self.lastNameField]) {
        self.student.lastName = textField.text;
    }
    
    return YES;
}

#pragma mark - Actions

- (IBAction)actionGenderChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case PMWoman:
            self.student.gender = PMWoman;
            break;
        case PMMan:
            self.student.gender = PMMan;
            break;
        default:
            break;
    }
    
}



- (IBAction)actionReset:(UIButton *)sender {
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.genderSegmentedControl.selectedSegmentIndex = 0;
    self.dateOfBirthField.text = @"";
    self.gradeField.text = @"0";
    
    [self.student deleteAll];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

@end
