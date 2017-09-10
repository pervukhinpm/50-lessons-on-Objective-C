//
//  PMAddStudentTableViewController.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 10.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMAddStudentTableViewController.h"
#import "PMStudentsTableViewController.h"
#import "PMStudentCell.h"
#import "PMAddStudentCell.h"
#import "PMImageCell.h"
#import "PMStudent+CoreDataClass.h"


@interface PMAddStudentTableViewController ()

@end

typedef enum {
    
    PMSectionImage,
    PMSectionInfo
    
} PMSection;

typedef enum {
    
    PMRowFirstName,
    PMRowLastName,
    PMRowEmail
    
} PMRow;

static NSString *kNewStudent = @"New Student";
static NSString *kEditStudent = @"Edit Info";

@implementation PMAddStudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleName;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == PMSectionImage) {
        return 175;
    }
    return 45;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == PMSectionImage) {
        return 1;
    } else if (section == PMSectionInfo) {
        return 3;
    } else {
        return 0;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == PMSectionImage && [self.titleName isEqualToString:kNewStudent]) {
        
        return @"Please, Enter Student's First Name,\nLast Name and E-Mail Address";
        
    } else if (section == PMSectionImage && [self.titleName isEqualToString:kEditStudent]) {
        
        return @"You can Edit Student's Information Here";
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *imageCell      = @"imageCell";
    static NSString *firstNameCell  = @"firstNameCell";
    static NSString *lastNameCell   = @"lastNameCell";
    static NSString *emailCell      = @"emailCell";
    
    PMImageCell *cell = nil;
    
    PMAddStudentCell *addCell = nil;
    
    if (indexPath.section == PMSectionImage) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        cell.imageStudent.image = [UIImage imageNamed:@"student-1.png"];
        
        if (self.editCell) {
            cell.imageStudent.image = [UIImage imageNamed:@"editStudent"];
        }
        
        return cell;
        
    } else if (indexPath.section == PMSectionInfo) {
        
        switch (indexPath.row) {
                
            case PMRowFirstName:
                
                addCell = [tableView dequeueReusableCellWithIdentifier:firstNameCell
                                                                  forIndexPath:indexPath];
                self.studentfirstName = addCell;
                
                if (self.editCell) {
                    self.studentfirstName.firstNameTextField.text = [[self.editCell.fullNameLabel.text
                                                                  componentsSeparatedByString:@" "] objectAtIndex:0];
                }
                
                return addCell;
                
            case PMRowLastName:
                
                addCell = [tableView dequeueReusableCellWithIdentifier:lastNameCell
                                                                  forIndexPath:indexPath];
                self.studentLastName = addCell;
                
                if (self.editCell) {
                    self.studentLastName.lastNameTextField.text = [[self.editCell.fullNameLabel.text
                                                                componentsSeparatedByString:@" "] objectAtIndex:1];
            
                }
                
                return addCell;
                
            case PMRowEmail:
                
                addCell = [tableView dequeueReusableCellWithIdentifier:emailCell
                                                                  forIndexPath:indexPath];
                self.studentEmail = addCell;
                
                if (self.editCell) {
                    self.studentEmail.emailTextField.text = self.editCell.emailLabel.text;
                                   }
                return addCell;
            default:
                break;
        }
    }
    return cell;
}




#pragma mark - Action

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    if ([self.titleName isEqualToString:kNewStudent]) {
        
     //   if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            PMStudentsTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            PMStudent *student = [[PMStudent alloc] initWithContext:context];
            
            // If appropriate, configure the new managed object.
            student.firstName = self.studentfirstName.firstNameTextField.text;
            student.lastName = self.studentLastName.lastNameTextField.text;
            student.email = self.studentEmail.emailTextField.text;
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        //}
    } else if ([self.titleName isEqualToString:kEditStudent]) {
        
    //    if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            PMStudentsTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            
            NSIndexPath *indexPath = [vc.tableView indexPathForCell:(UITableViewCell *)self.editCell];
            PMStudent *student = [vc.fetchedResultsController objectAtIndexPath:indexPath];
            
            // If appropriate, configure the new managed object.
        student.firstName = self.studentfirstName.firstNameTextField.text;
        student.lastName = self.studentLastName.lastNameTextField.text;
        student.email = self.studentEmail.emailTextField.text;
        
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        //}
        
    }
}
@end
