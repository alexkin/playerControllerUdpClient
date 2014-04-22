//
//  playerControllerUdpViewController.m
//  playerControllerUdpClient
//
//  Created by stone on 14-4-18.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "playerControllerUdpViewController.h"
#import "setIpAndPortPage.h"
#import "secondPopViewIP_iPad.h"
#import "secondPopViewIP_iPhone.h"
#import "dateDelegate.h"
#import "GCDAsyncUdpSocket.h"
#import "DDLog.h"

//static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#define FORMAT(format,...) [NSString stringWithFormat:(format),##__VA_ARGS__]


#define runAs_iPad  secondPopViewIP_iPad
#define runAs_iPhone    secondPopViewIP_iPhone

@interface playerControllerUdpViewController (){
    long tag;
    GCDAsyncUdpSocket *udpSocket;
    
    NSMutableString *log;
}

@end

@implementation playerControllerUdpViewController{
    bool boolBtnPlayPause,boolBtnMute,boolBtnPlayStop,boolBtnVoiceAdd,boolBtnVoiceMult;
    int intStateMent;
    
}

@synthesize myTextIp;
@synthesize myTextPort;

@synthesize playPause;
@synthesize mute;
@synthesize playStop;
@synthesize voiceAdd;
@synthesize voiceMult;

-(void)passValue:(dateDelegate *)value{
    self.myTextIp = value.textIp;
    self.myTextPort = value.textPort;
    
    //NSLog(@"myTextIp here: %@",value.textIp);
    
    if (udpSocket == nil) {
        [self setupSocket];
    }
}

//Socket设置
-(void)setupSocket{
    udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    
    if (![udpSocket bindToPort:0 error:&error]) {
        [self logEror:FORMAT(@"Error binding:%@",error)];
        return;
    }
    if (![udpSocket beginReceiving:&error]) {
        [self logEror:FORMAT(@"Error receiving:%@",error)];
        return;
    }
    [self logInfo:@"Ready"];
}


-(IBAction)showSetIpAndPort:(id)sender{
    
#ifdef runAs_iPad
    runAs_iPad *secondView = [[runAs_iPad alloc]initWithNibName:@"secondPopViewIP_iPad" bundle:[NSBundle mainBundle]];
#else
    runAs_iPhone *secondView = [[runAs_iPhone alloc]initWithNibName:@"secondPopViewIP_iPhone" bundle:[NSBundle mainBundle]];
#endif
    
    //----------------------------------
    secondView.delegate = self;
    
    //controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController pushViewController:secondView animated:YES];
    
    //[self presentViewController:controller animated:YES completion:nil];
    
    //controller.delegate = self;
    //[self.navigationController pushViewController:controller animated:YES];
    //controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //controller.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //controller.modalTransitionStyle = UIModalPresentationPageSheet;
    //[self presentViewController:controller animated:YES completion:nil];
}

-(void)setInitValue{
    boolBtnPlayPause = false;
    boolBtnMute = false;
    boolBtnPlayStop = false;
    boolBtnVoiceAdd = false;
    boolBtnVoiceMult = false;
    
    intStateMent = -1;
}

//select content
-(IBAction)button0:(id)sender{
    intStateMent = 0;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    //NSLog(@"here is the report:%@",myTextIp);
    //NSLog(@"ahahhahaha %@",self.myTextPort);
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
    //send intStatement
}

-(IBAction)button1:(id)sender{
    intStateMent = 1;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    
    //**************************
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)button2:(id)sender{
    intStateMent = 2;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)button3:(id)sender{
    intStateMent = 3;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)button4:(id)sender{
    intStateMent = 4;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)button5:(id)sender{
    intStateMent = 5;
    
    //------------------------
    boolBtnPlayPause = false;
    [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
    //------------------------
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

//set property of video
-(IBAction)playPause:(id)sender{
    //send
    intStateMent = 6;
    //[playPause setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    
    //[playPause setBackgroundImage:[UIImage imageNamed:@"play-blue.png"] forState:UIControlStateHighlighted];
    
    
    boolBtnPlayPause = !boolBtnPlayPause;
    if (boolBtnPlayPause) {
        NSLog(@"zhe shi yi ge ce shi : %d",boolBtnPlayPause);
        [playPause setBackgroundImage:[UIImage imageNamed:@"noTouchPlay.png"] forState:UIControlStateNormal];
        //[playPause setBackgroundImage:nil forState:UIControlStateNormal];
    }
    else{
        [playPause setBackgroundImage:[UIImage imageNamed:@"yesTouchPlay.png"] forState:UIControlStateNormal];
        NSLog(@"zhe shi yi ge ce shi : %d",boolBtnPlayPause);
    }
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
    
    
    //UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"1" message:@"2" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //[alertView show];
    
    
}

-(IBAction)mute:(id)sender{
    intStateMent = 7;
    
    //----------
    boolBtnMute = !boolBtnMute;
    if (boolBtnMute) {
        [mute setBackgroundImage:[UIImage imageNamed:@"yesTouchMute.png"] forState:UIControlStateNormal];
        //[playPause setBackgroundImage:nil forState:UIControlStateNormal];
    }
    else{
        [mute setBackgroundImage:[UIImage imageNamed:@"noTouchMute.png"] forState:UIControlStateNormal];
    }
    //----------
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)playStop:(id)sender{
    intStateMent = 8;
    
    //[playStop setBackgroundImage:[UIImage imageNamed:@"noTouchStop.png"] forState:UIControlStateNormal];
    
    [playStop setBackgroundImage:[UIImage imageNamed:@"yesTouchStop.png"] forState:UIControlStateHighlighted];
    
    [playPause setBackgroundImage:[UIImage imageNamed:@"noTouchPlay.png"] forState:UIControlStateNormal];
    
    boolBtnPlayPause = !boolBtnPlayPause;
    //----------
    boolBtnPlayStop = !boolBtnPlayStop;
    /* if (boolBtnPlayStop) {
     [playStop setBackgroundImage:[UIImage imageNamed:@"yesTouchStop.png"] forState:UIControlStateNormal];
     //[playPause setBackgroundImage:nil forState:UIControlStateNormal];
     }
     else{
     [playStop setBackgroundImage:[UIImage imageNamed:@"noTouchStop.png"] forState:UIControlStateNormal];
     }
     */
    //----------
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)voiceAdd:(id)sender{
    intStateMent = 9;
    
    [voiceAdd setBackgroundImage:[UIImage imageNamed:@"noTouchAdd.png"] forState:UIControlStateNormal];
    [voiceAdd setBackgroundImage:[UIImage imageNamed:@"yesTouchAdd.png"] forState:UIControlStateHighlighted];
    //[playPause setBackgroundImage:nil forState:UIControlStateNormal];
    //----------
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(IBAction)voiceMult:(id)sender{
    intStateMent = 10;
    
    
    [voiceMult setBackgroundImage:[UIImage imageNamed:@"yesTouchMult.png"] forState:UIControlStateHighlighted];
    [voiceMult setBackgroundImage:[UIImage imageNamed:@"noTouchMult.png"] forState:UIControlStateNormal];
    
    
    NSString *host = self.myTextIp;
    if ([host length] == 0) {
        [self logEror:@"Address required"];
        return;
    }
    
    int port = [self.myTextPort intValue];
    if (port <= 0 || port > 65535) {
        [self logEror:@"Valid port required"];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%d",intStateMent];
    if ([msg length] == 0) {
        [self logEror:@"Message required"];
        return;
    }
    
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:tag];
    
    [self logMessage:FORMAT(@"SNT (%i): %@",(int)tag,msg)];
    tag ++;
}

-(void)logEror:(NSString *)msg{
    NSString *prefix = @"<font color =\"#B40404\">";
    NSString *suffix = @"</font><br/>";
    
    [log appendFormat:@"%@%@%@\n",prefix,msg,suffix];
}

-(void)logMessage:(NSString *)msg{
    NSString *prefix = @"<font color=\"#000000\">";
    NSString *suffix = @"</font><br/>";
    
    [log appendFormat:@"%@%@%@\n",prefix,msg,suffix];
}

- (void)logInfo:(NSString *)msg
{
	NSString *prefix = @"<font color=\"#6A0888\">";
	NSString *suffix = @"</font><br/>";
	
	[log appendFormat:@"%@%@%@\n", prefix, msg, suffix];
}


- (void)viewDidLoad
{
    [voiceAdd setBackgroundImage:[UIImage imageNamed:@"noTouchAdd.png"] forState:UIControlStateNormal];
    [voiceMult setBackgroundImage:[UIImage imageNamed:@"noTouchMult.png"] forState:UIControlStateNormal];
    
<<<<<<< HEAD
    [playPause setBackgroundImage:[UIImage imageNamed:@"noTouchPlay.png"] forState:UIControlStateNormal];
    [mute setBackgroundImage:[UIImage imageNamed:@"noTouchMute.png"] forState:UIControlStateNormal];
    [playStop setBackgroundImage:[UIImage imageNamed:@"noTouchStop.png"] forState:UIControlStateNormal];
    
=======
>>>>>>> FETCH_HEAD
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setInitValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
