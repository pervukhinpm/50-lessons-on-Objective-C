//
//  PMDateViewController.m
//  IDC40 KVC
//
//  Created by Петр Первухин on 03.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDateViewController.h"
#import "PMStudent.h"


@interface PMDateViewController ()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation PMDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    self.formatter = formatter;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)actionDateChanged:(UIDatePicker *)sender {
    NSString *stringDate = [self.formatter stringFromDate:sender.date];
    self.delegate.dateOfBirthField.text = stringDate;
    self.delegate.student.dateOfBirth = sender.date;

    
}

- (IBAction)actionDonePressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
