//
//  PMStudentsTableViewController.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 10.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMStudentsTableViewController.h"
#import "PMAddStudentTableViewController.h"
#import "PMDataManager.h"
#import "PMStudentCell.h"
#import "PMStudent+CoreDataClass.h"
#import "PMCourseOverallTableViewController.h"
#import "PMOverallTableViewController.h"

@interface PMStudentsTableViewController ()

@end

@implementation PMStudentsTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.navigationItem.title = @"Students";
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"PMStudent"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* firstNameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[firstNameDescription,lastNameDescription]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

# pragma mark - Table View
-(void) configureCell:(PMStudentCell *)cell atIndexPath:(NSIndexPath *)indexPath{
 
    PMStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:@"student-1"];
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.emailLabel.text = [NSString stringWithFormat:@"%@", student.email];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableView.isEditing){
        
        PMStudentCell *cell = (PMStudentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        PMAddStudentTableViewController *vc = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"PMAddStudentTableViewController"];
        
        vc.titleName = @"Edit Info";
       
        vc.editCell = cell;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        PMOverallTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PMOverallTableViewController"];
        
        vc.student = [self.fetchedResultsController objectAtIndexPath:indexPath];
       
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addStudent"]) {
        
        PMAddStudentTableViewController *vc = [segue destinationViewController];
        
        vc.titleName = @"New Student";
      
    }
    
}




@end
