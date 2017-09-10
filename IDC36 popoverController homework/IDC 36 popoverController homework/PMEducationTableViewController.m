//
//  PMEducationTableViewController.m
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 26.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMEducationTableViewController.h"

@interface PMEducationTableViewController () 

@end

@implementation PMEducationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (IBAction)doneAction:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   /*
    NSString *education = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    self.delegate.educationTextField.text = education;
    
    NSLog(@" = %@",education);
*/
    
    switch (indexPath.row) {
        case 0:
            self.delegate.educationTextField.text = @"Среднее";
            break;
        case 1:
            self.delegate.educationTextField.text = @"Неполное высшее";
            break;
        case 2:
            self.delegate.educationTextField.text = @"Высшее";
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end



