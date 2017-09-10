//
//  PMTeachersTableViewController.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 28.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMTeachersTableViewController.h"
#import "PMCourse+CoreDataClass.h"
#import "PMStudent+CoreDataProperties.h"
#import "PMTeacherInfoCell.h"
#import "PMOverallTableViewController.h"


@interface PMTeachersTableViewController ()

@end

@implementation PMTeachersTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Teachers";
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
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PMCourse"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set sort descriptors
    NSSortDescriptor *studyBranchDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studyBranch" ascending:YES];
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"teachers.firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"teachers.lastName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[ studyBranchDescriptor, firstNameDescriptor, lastNameDescriptor ]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:@"studyBranch"
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(PMTeacherInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    PMCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", course.teachers.firstName, course.teachers.lastName];
    cell.numberOfCoursesLabel.text = [NSString stringWithFormat:@"%ld", [course.teachers.teachingCourses count]];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PMOverallTableViewController *vc = [self.storyboard
                                               instantiateViewControllerWithIdentifier:@"PMOverallTableViewController"];
    
    PMCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    vc.student = course.teachers;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end


