//
//  RootViewController.m
//  MDEditor
//
//  Created by Tulakshana on 15/06/2012.
//  Copyright (c) 2012 Eugein. All rights reserved.
//

#import "RootViewController.h"

#import "renderers.h"
#import "markdown.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    [textView setText:@"test"];
    [self.view addSubview:textView];
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    [webView setDelegate:self];
    
    btnToggle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnToggle setTitle:@"preview" forState:UIControlStateNormal];
    [btnToggle addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [btnToggle setFrame:CGRectMake(200, 160, 100, 30)];
    [self.view addSubview:btnToggle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)toggle{
    if ([textView superview]) {
        [textView resignFirstResponder];
        [textView removeFromSuperview];
    }else {
        [btnToggle setTitle:@"preview" forState:UIControlStateNormal];
        [self.view addSubview:textView];
    }
    if ([webView superview]) {
        [webView removeFromSuperview];
    }else {
        [webView loadHTMLString:[self getHTMLString:textView.text] baseURL:nil];
        [btnToggle setTitle:@"source" forState:UIControlStateNormal];
        [self.view addSubview:webView];
    }
}

- (NSString *)getHTMLString:(NSString *)string{
    NSString *rawMarkdown = string;
    const char * prose = [rawMarkdown UTF8String];  
    struct buf *ib, *ob;       
    
    int length = rawMarkdown.length + 1;
    
    ib = bufnew(length);
    bufgrow(ib, length);
    memcpy(ib->data, prose, length);
    ib->size = length;
    
    ob = bufnew(64);
    markdown(ob, ib, &mkd_xhtml);
    
    NSString *shinyNewHTML = [NSString stringWithUTF8String: ob->data];
    NSLog(@"%@", shinyNewHTML);
    
    bufrelease(ib);
    bufrelease(ob);
    
    return shinyNewHTML;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *url = [request URL];
    NSString *urlString = [url description];
    NSLog(@"%@",urlString);
    if ([urlString isEqualToString:@"about:blank"]) {
        return TRUE;
    }else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    return FALSE;
}
@end
