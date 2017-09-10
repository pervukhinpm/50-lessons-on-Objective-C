//
//  ViewController.h
//  IDC30 UITableview Dinamic
//
//  Created by Петр Первухин on 07.07.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end

