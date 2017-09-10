//
//  DirectoryViewController.m
//  IDC33 file manager
//
//  Created by Петр Первухин on 11.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@property (strong,nonatomic) NSArray* contents;

@end

@implementation DirectoryViewController

- (id) initWithFolderPath:(NSString*) path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
       /*
        NSError* error = nil;
        
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                            error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
        */
    }
    return self;
}

-(void) setPath:(NSString *)path{
    _path = path;
    
    NSError* error = nil;

    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                        error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self.tableView reloadData];
    self.navigationItem.title = [self.path lastPathComponent];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    if (!self.path){
        self.path = @"Users/petrpervuhin/Desktop/Objective C skutorenko study";
    }
    
    [self sortedArray];
    [self removeHiddenFiles];
}

-(void)sortedArray{
    NSMutableArray *foldersArray = [NSMutableArray array];
    NSMutableArray *filesArray = [NSMutableArray array];
    
    for (int i = 0; i < [self.contents count]; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        if ([self isDirectoryAtIndexPath:indexPath]) {
            [foldersArray addObject:[self.contents objectAtIndex:i]];
            
        } else if (![self isDirectoryAtIndexPath:indexPath]){
            [filesArray addObject: [self.contents objectAtIndex:i]];
        }
    }
    
    [foldersArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2] == NSOrderedDescending;
    }];
    
    [filesArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2] == NSOrderedDescending;
    }];
    
    self.contents = [foldersArray arrayByAddingObjectsFromArray:filesArray];

}
- (void) removeHiddenFiles {
    
    for (NSString *item in self.contents) {
        NSInteger itemIndex = [self.contents indexOfObject:item];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
        
        if (![self isDirectoryAtIndexPath:indexPath] && [item isEqualToString:@".DS_Store"]) {
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contents];
            [tempArray removeObject:item];
            self.contents = tempArray;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) backToRoot: (UIBarButtonItem*) sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void) viewWillAppear:(BOOL)animated{
    if ([self.navigationController.viewControllers count] > 1){
        UIBarButtonItem* rootButton = [[UIBarButtonItem alloc] initWithTitle:@"Root"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backToRoot:)];
        self.navigationItem.rightBarButtonItem = rootButton;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath{
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    NSString* filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    cell.textLabel.text = fileName;

    if ([self isDirectoryAtIndexPath:indexPath]){
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"file"];
    }
    
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    if ([self isDirectoryAtIndexPath:indexPath]){
        
        NSString* fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        
       // DirectoryViewController* vc = [[DirectoryViewController alloc] initWithFolderPath:path];
        //[self.navigationController pushViewController:vc animated:YES];
     
       /* DirectoryViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryViewController"];
        vc.path = path;
        [self.navigationController pushViewController:vc animated:YES];
    */
        self.selectedPath = path;
        [self performSegueWithIdentifier:@"navigateDeep" sender:nil];
        
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender NS_AVAILABLE_IOS(6_0){
    NSLog(@"shouldPerformSegueWithIdentifier %@",identifier);
    return YES;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue %@",segue.identifier);
    DirectoryViewController* vc = segue.destinationViewController;
    vc.path = self.selectedPath;

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
