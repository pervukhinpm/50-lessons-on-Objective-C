//
//  ViewController.m
//  IDC39 UIWebView
//
//  Created by Петр Первухин on 02.08.17.
//  Copyright © 2017 Петр Первухин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   /*
    NSString* urlString = @"https://vk.com/iosdevcourse";
   
    NSURL* url = [[ NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
   */
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"junior" ofType:@"pdf"];
    
    /*
    NSData* fileData = [NSData dataWithContentsOfFile:filePath];
    
    [self.webView loadData:fileData MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
    */
    
    NSURL* fileUrl = [NSURL fileURLWithPath:filePath];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:fileUrl];
    
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"shouldStartLoadWithRequest %@", [request debugDescription]);
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
    [self.indicator startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidFinishLoad");

    [self.indicator stopAnimating];
    
    [self refreshButtons];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"didFailLoadWithError");

    [self.indicator stopAnimating];
    
    [self refreshButtons];

}

#pragma mark - Action


- (IBAction)actionBack:(UIBarButtonItem *)sender {
    if ([self.webView canGoBack]){
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction)actionRefresh:(UIBarButtonItem *)sender{
    [self.webView stopLoading];
    [self.webView reload];
}
- (IBAction)actionForward:(UIBarButtonItem *)sender{
    if ([self.webView canGoForward]){
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

#pragma mark - Help functions

-(void) refreshButtons{
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
}

@end
