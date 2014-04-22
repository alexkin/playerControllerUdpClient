//
//  secondPopViewIP_iPad.m
//  playerControllerUdpClient
//
//  Created by stone on 14-4-22.
//  Copyright (c) 2014年 stone. All rights reserved.
//

#import "secondPopViewIP_iPad.h"
#import "dateDelegate.h"

@interface secondPopViewIP_iPad ()

@end

@implementation secondPopViewIP_iPad
@synthesize textFieldIp;
@synthesize textFieldPort;
@synthesize delegate;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOk:(id)sender {
    dateDelegate *date_delegate_iPad = [[dateDelegate alloc]init];
    date_delegate_iPad.textIp = self.textFieldIp.text;
    date_delegate_iPad.textPort = self.textFieldPort.text;
    
    [self.delegate passValue:date_delegate_iPad];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
