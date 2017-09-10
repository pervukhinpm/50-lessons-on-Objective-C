//
//  ViewController.m
//  IDC45 API test
//
//  Created by Петр Первухин on 09.09.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"
#import "PMServerManager.h"
#import "PMUser.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray* friendsArray;

@end

@implementation ViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendsArray = [NSMutableArray array];
    
    [self getFriendsFromServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - API

-(void) getFriendsFromServer{
    [[PMServerManager sharedManager] getFriendsWithOffSet:self.friendsArray.count
                                                    count:friendsInRequest
                                                onSuccess:^(NSArray *friends) {
                                                    
    // [self.tableView reloadData];
                                                    
    [self.friendsArray addObjectsFromArray:friends];
    NSMutableArray* newPaths = [NSMutableArray array];
    
    for (int i =(int)[self.friendsArray count] - (int)[friends count]; i < self.friendsArray.count; i++ ) {
        [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        
    }
                                                     
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
    
    [self.tableView endUpdates];
     
    
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error =%@ code = %ld",[error localizedDescription], (long)statusCode);
    }];
    
}

#pragma mark - UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"identifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [self.friendsArray count]) {
        
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
        
    } else {
    
    PMUser* friend = [self.friendsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];

    NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
    
    __weak UITableViewCell* weakCell = cell;
  
    cell.imageView.image = nil;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       weakCell.imageView.image = image;
                                       [weakCell layoutSubviews];
                                   }
                                   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       
                                   }];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
}


@end
