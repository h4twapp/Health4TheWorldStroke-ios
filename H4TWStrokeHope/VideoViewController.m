//
//  VideoViewController.m
//  H4TWStrokeHope
//
//  Created by Premnath Ramanathan on 4/13/17.
//  Copyright © 2017 Rachel. All rights reserved.
//

#import "VideoViewController.h"
#import "Constants.h"

@interface VideoViewController ()
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerViewController *controller;
@property (nonatomic,strong) AVQueuePlayer *queue;
@end

@implementation VideoViewController
@synthesize player;
@synthesize controller;
@synthesize queue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Back button */
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:WHITE_BACK_BUTTON]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 15, 25);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpVideo: (NSString *) videoName{
    
    // Set URL to the video
    NSURL *url = [[NSBundle mainBundle] URLForResource:videoName withExtension:nil];

    [self videoPlayerSetup:url];
}

-(void) videoPlayerSetup: (NSURL *) url{
    // Create an AVPlayer Item
    AVPlayerItem *video = [[AVPlayerItem alloc] initWithURL:url];
    
    //Create a AVplayer Queue
    self.queue = [[AVQueuePlayer alloc] init];
    [self.queue insertItem:video afterItem:nil];
    
    self.player = self.queue;
    
    // create a player view controller
    self.controller = [[AVPlayerViewController alloc] init];
    
    
    self.controller.player = self.player;
    self.controller.showsPlaybackControls = YES;
    self.player.closedCaptionDisplayEnabled = NO;
    [self.player play];
    
    
    [self addChildViewController:self.controller];
    [self.view addSubview:self.controller.view];
    self.controller.view.frame = self.view.frame;
    
    // PLay video on a loop
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        AVPlayerItem *video = [[AVPlayerItem alloc] initWithURL:url];
        [self.queue insertItem:video afterItem:nil];
        [self.player play];
    }];
}

- (AVPlayerViewController *)setUpCustomVideo: (NSString *) videoName withFrame: (CGRect *) frame{
    
    // Set URL to the video
    NSURL *url = [[NSBundle mainBundle] URLForResource:videoName withExtension:nil];
    
    // Create an AVPlayer Item
    AVPlayerItem *video = [[AVPlayerItem alloc] initWithURL:url];
    
    //Create a AVplayer Queue
    self.queue = [[AVQueuePlayer alloc] init];
    [self.queue insertItem:video afterItem:nil];
    
    self.player = self.queue;
    
    // create a player view controller
    self.controller = [[AVPlayerViewController alloc] init];
    
    self.controller.player = self.player;
    self.controller.showsPlaybackControls = NO;
    self.player.closedCaptionDisplayEnabled = NO;
    [self.player play];
    
    // PLay video on a loop
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        AVPlayerItem *video = [[AVPlayerItem alloc] initWithURL:url];
        [self.queue insertItem:video afterItem:nil];
        [self.player play];
    }];
     
    return controller;
}


-(void) viewWillDisappear:(BOOL)animated{
    [self.player pause];
    [self.queue removeAllItems];
    //[self.player removeTimeObserver:AVPlayerItemDidPlayToEndTimeNotification];
    self.player = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.player =nil;
}

@end
