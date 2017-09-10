//
//  PMTableViewController.m
//  IDC 36 popoverController homework
//
//  Created by Петр Первухин on 25.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMTableViewController.h"
#import "PMInfoViewController.h"
#import "PMDateViewController.h"
#import "PMEducationTableViewController.h"

@interface PMTableViewController () <UIPopoverPresentationControllerDelegate , UITextFieldDelegate>

@end

@implementation PMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNameTextField.delegate = self.lastNameTextField.delegate = self;
    self.dateTextField.delegate = self.educationTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)infoButtonAction:(UIBarButtonItem *)sender {
    

   PMInfoViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PMInfoViewController"];
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController* popover = [vc popoverPresentationController];
    
    popover.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    
    popover.barButtonItem = sender;
    
    popover.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"Info popover created");

}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"PMDateViewController"]) {
        
        PMDateViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
        
   } else if ([segue.identifier isEqualToString:@"PMEducationTableViewController"]) {
        
        PMEducationTableViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameTextField]){
        
        [textField resignFirstResponder];
        
    } else if ([textField isEqual:self.lastNameTextField]){
        
        [textField resignFirstResponder];
        
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.dateTextField]) {
        
        [self performSegueWithIdentifier:@"PMDateViewController" sender:textField];
        
        return NO;
    } else if ([textField isEqual:self.educationTextField]) {
        
        [self performSegueWithIdentifier:@"PMEducationTableViewController" sender:textField];
        
        return NO;
    }
    return YES;
}


#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}


@end
