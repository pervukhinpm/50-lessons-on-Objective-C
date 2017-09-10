//
//  PMDateViewController.m
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 26.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMDateViewController.h"
#import "PMTableViewController.h"

@interface PMDateViewController ()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation PMDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM, yyyy"];
    self.formatter = formatter;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionDateChanged:(UIDatePicker *)sender {
    
    NSString *stringDate = [self.formatter stringFromDate:sender.date];
    self.delegate.dateTextField.text = stringDate;

}

- (IBAction)actionDonePressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


