//
//  ViewController.m
//  IDC31
//
//  Created by Петр Первухин on 08.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import "PMGroup.h"
#import "PMStudent.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) UITableView* tableView;
@property (strong,nonatomic) NSMutableArray* groupsArray;

@end

@implementation ViewController

-(void)loadView  {
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.navigationItem.title = @"Students";
   
    self.tableView.allowsSelectionDuringEditing = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.groupsArray = [NSMutableArray array];
    /*
 
    for (int i = 0; i < ((arc4random() % 6) + 5); i++) {
            
        PMGroup* group = [[PMGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group №%d", i];
    
        NSMutableArray* array = [NSMutableArray array];
            
        for (int j = 0; j < ((arc4random() % 11) + 15); j++) {
            [array addObject:[PMStudent randomStudent]];
        }
            
        group.students = array;
        
        [self.groupsArray addObject:group];
    }
        
    [self.tableView reloadData];
    
    NSLog(@"%ld",self.groupsArray.count);
   */

    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addButton:)];
    self.navigationItem.leftBarButtonItem = addButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - action

-(void) actionEdit:(UIBarButtonItem*) sender{
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:(!isEditing) animated:YES];
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    if (self.tableView.editing){
        item = UIBarButtonSystemItemDone;
    }
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
}

-(void) addButton:(UIBarButtonItem*) sender{
    PMGroup* group = [[PMGroup alloc] init];
    group.name = [NSString stringWithFormat:@"Group №%ld", [self.groupsArray count] + 1];
    group.students = @[[PMStudent randomStudent] , [PMStudent randomStudent]];
    NSInteger newSectionIndex = 0;
    [self.groupsArray insertObject:group atIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    NSIndexSet* insertSection = [NSIndexSet indexSetWithIndex:newSectionIndex];
    [self.tableView insertSections:insertSection withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];

    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ( [[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.groupsArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.groupsArray objectAtIndex:section] name];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    PMGroup* group = [self.groupsArray objectAtIndex:section];
    
   return [group.students count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.row == 0 ){
        static NSString* identifierAddStudent = @"Add Student";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierAddStudent];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierAddStudent];
        }
        cell.textLabel.text = @"Add Student";
        cell.textLabel.textColor = [UIColor blueColor];
        return cell;
    }else{
        static NSString* identifier = @"Cell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        PMGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        PMStudent* student = [group.students objectAtIndex:indexPath.row - 1];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
        if (student.averageGrade >= 4.0) {
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else if (student.averageGrade >= 3.0) {
            cell.detailTextLabel.textColor = [UIColor orangeColor];
        } else {
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    PMGroup* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    PMStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray: sourceGroup.students];

    if (sourceIndexPath.section == destinationIndexPath.section){
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
    }else{
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        PMGroup* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        PMGroup* sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
        PMStudent* student = [sourceGroup.students objectAtIndex:indexPath.row - 1];
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray: sourceGroup.students];
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row > 0 ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    
    if (proposedDestinationIndexPath.row == 0){
        return sourceIndexPath;
    }else{
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0){
        PMGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        NSMutableArray* tempArray = nil;
        if (group.students) {
            tempArray = [NSMutableArray arrayWithArray:group.students];
        }else{
            tempArray = [NSMutableArray array];
        }
        NSInteger newStudentIndex = 0;
        [tempArray insertObject:[PMStudent randomStudent] atIndex:newStudentIndex];
        group.students = tempArray;
        [self.tableView beginUpdates];
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ( [[UIApplication sharedApplication] isIgnoringInteractionEvents]){
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    }
}
@end
