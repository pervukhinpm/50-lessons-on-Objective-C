//
//  ViewController.h
//  IDC39 UIWebView
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (weak,nonatomic) IBOutlet UIBarButtonItem* backButtonItem;
@property (weak,nonatomic) IBOutlet UIBarButtonItem* forwardButtonItem;


- (IBAction)actionForward:(UIBarButtonItem *)sender;
- (IBAction)actionBack:(UIBarButtonItem *)sender;
- (IBAction)actionRefresh:(UIBarButtonItem *)sender;

@end

