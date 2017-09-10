//
//  PMCoursesTableViewController.m
//  IDC41-44 coreData
//
//  Created by Петр Первухин on 25.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "PMCoursesTableViewController.h"
#import "PMCourseCell.h"
#import "PMCourse+CoreDataClass.h"
#import "PMDataManager.h"
#import "PMStudent+CoreDataClass.h"
#import "PMCourseInformatonTableViewController.h"
#import "PMCourseOverallTableViewController.h"


@interface PMCoursesTableViewController ()

@end

@implementation PMCoursesTableViewController


@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.navigationItem.title = @"Courses";
    
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
    [NSEntityDescription entityForName:@"PMCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
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
-(void) configureCell:(PMCourseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    PMCourse* course
    = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.nameLabel.text = course.name;
    cell.teacherLabel.text = [NSString stringWithFormat:@"%@ %@", course.teachers.firstName, course.teachers.lastName];
    cell.numOfStudentsLabel.text = [NSString stringWithFormat:@"%ld", [course.students count]];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableView.isEditing) {
        
        PMCourseCell*cell = (PMCourseCell *)[tableView cellForRowAtIndexPath:indexPath];
        PMCourse *course = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
        
        PMCourseInformatonTableViewController *vc = [self.storyboard
                                                instantiateViewControllerWithIdentifier:@"PMCourseInformatonTableViewController"];
        
        vc.titleName = @"Edit Info";
        vc.editCell = cell;
        vc.editCourse = course;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
     
        PMCourseOverallTableViewController *vc = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"PMCourseOverallTableViewController"];
        
        vc.course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"newCourse"]) {
        
        PMCourseInformatonTableViewController *vc = [segue destinationViewController];
        vc.titleName = @"New Course";
        
    }
    
}




@end
