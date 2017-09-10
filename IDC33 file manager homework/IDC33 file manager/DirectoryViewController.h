//
//  DirectoryViewController.h
//  IDC33 file manager
//
//  Created by Петр Первухин on 11.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryViewController : UITableViewController
@property (strong,nonatomic) NSString* path;
@property (strong,nonatomic) NSString* selectedPath;

-(id) initWithFolderPath:(NSString*) path;

@end
