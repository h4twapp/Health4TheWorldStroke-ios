//
//  HomeViewController.m
//  H4TWStrokeHope
//
//  Created by Rachel on 3/25/17.
//  Copyright © 2017 Rachel. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "HomeButton.h"
#import "HelpMeSpeakViewController.h"
#import "ExercisesViewController.h"
#import "LearnViewController.h"
#import "RemindersViewController.h"
#import "GeneralInfoViewController.h"
#import "SurveysViewController.h"
#import "ChatBotViewController.h"
#import "EnterViewController.h"
#import "FeedbackViewController.h"
#import "AWSDynamoDBHelper.h"
#import <MessageUI/MessageUI.h>

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *btnFeedback;
@property (weak, nonatomic) IBOutlet UIButton *btnTellStory;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HomeViewController

-(void)viewDidDisappear:(BOOL)animated{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"All.backButton", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:WHITE_BACK_BUTTON];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn setContentMode:UIViewContentModeCenter];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(10, 0, 15, 25);
     */
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backButton;
//    [self createLogoutButton];
//    [self createRateButton];
    self.title = [NSLocalizedString(@"Home.title", nil) uppercaseString];
    // User table
  /*  NSArray *userData = @[[NSNumber numberWithInteger:101],@"10/31/2017",@"10/31/2017",@"abc@gmail.com",@"abc",@"xyz",@"abcxyz"];
    [self insertUserData: userData];
   */
    self.btnFeedback.backgroundColor = HFTW_PRIMARY;
    self.btnTellStory.backgroundColor = HFTW_PRIMARY;
    self.btnFeedback.layer.cornerRadius = 5;
    self.btnTellStory.layer.cornerRadius = 5;
    [self.btnFeedback setTitle: NSLocalizedString(@"Feedback.title", nil) forState:UIControlStateNormal] ;
    [self.btnTellStory setTitle: NSLocalizedString(@"Feedback.Story", nil) forState:UIControlStateNormal ];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setUpView];
}

//- (void) createRateButton {
//    UIButton *rateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    rateBtn.frame = CGRectMake(0, 0, 25, 25);
//    [rateBtn setTitle:@"Rate" forState: UIControlStateNormal];
//    [rateBtn addTarget:self action:@selector(ratePressed) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rateBtnButton = [[UIBarButtonItem alloc] initWithCustomView:rateBtn];
//    self.navigationItem.rightBarButtonItem = rateBtnButton;
//}
//-(void)ratePressed{
//    if (@available(iOS 10.3, *)) {
//        [SKStoreReviewController requestReview];
//    }
//}

- (void) createLogoutButton {
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    logoutBtn.frame = CGRectMake(0, 0, 35, 25);
    [logoutBtn setTitle: [NSLocalizedString(@"Home.LogoutButtontitle", nil) uppercaseString] forState: UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithCustomView:logoutBtn];
    self.navigationItem.rightBarButtonItem = logoutButton;
}

- (void)setUpView {
    static int SPACE_BETWEEN_CELLS = 10;
    float cellWidth = ([UIScreen mainScreen].bounds.size.width) - (SPACE_BETWEEN_CELLS) - (SPACE_BETWEEN_CELLS / 2);
    float startingY = SPACE_BETWEEN_CELLS + self.navigationController.navigationBar.frame.size.height + ([UIApplication sharedApplication].statusBarFrame.size.height);
    UIView *chatbotView = [[UIView alloc] initWithFrame: CGRectMake(SPACE_BETWEEN_CELLS, startingY, cellWidth, cellWidth/6)];
    UIImageView *chatbotMessageImage = [[UIImageView alloc] init];
    chatbotMessageImage.image = [UIImage imageNamed:@"Chat"];
    UIImageView *chatbotDoctorImage = [[UIImageView alloc] init];
    chatbotDoctorImage.image = [UIImage imageNamed:@"Doctor"];
    chatbotMessageImage.contentMode = UIViewContentModeScaleAspectFit;
    chatbotMessageImage.layer.masksToBounds =true;
    chatbotMessageImage.translatesAutoresizingMaskIntoConstraints = false;
    chatbotDoctorImage.contentMode = UIViewContentModeScaleAspectFit;
    chatbotDoctorImage.layer.masksToBounds =true;
    chatbotDoctorImage.translatesAutoresizingMaskIntoConstraints = false;
    
    UILabel *chatMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 0,0)];
    UIFont *labelFont = [UIFont fontWithName:@"Lato-regular" size:18.0];
    chatMessageLabel.text = NSLocalizedString(@"Home.chatmessage.label", nil);
    chatMessageLabel.textColor = [UIColor whiteColor];
    chatMessageLabel.font = labelFont;
    chatMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    chatMessageLabel.numberOfLines = 0;
    [chatMessageLabel sizeToFit];
    
    [chatbotMessageImage addSubview: chatMessageLabel];
    [chatbotView addSubview: chatbotMessageImage];
    [chatbotView addSubview: chatbotDoctorImage];
    
    //add constraints for  images
    NSDictionary *views = @{ @"chatbotMessageImage" :  chatbotMessageImage, @"chatbotDoctorImage" : chatbotDoctorImage};
    [chatbotView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|[chatbotDoctorImage][chatbotMessageImage(270)]|" options:0 metrics:nil views: views]];
    [chatbotView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|[chatbotMessageImage]|" options:0 metrics:nil views: views]];
       [chatbotView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|[chatbotDoctorImage]|" options:0 metrics:nil views: views]];
    
    //chatbot  smiley icons
    startingY += (cellWidth/6);
    UIView *chatbotView2 = [[UIView alloc] initWithFrame: CGRectMake(SPACE_BETWEEN_CELLS, startingY, cellWidth, (cellWidth/8))];
    chatbotView2 = [self smileyIconsSetup: chatbotView2];
    
    //Other home buttons
    cellWidth = ([UIScreen mainScreen].bounds.size.width / 2) - (SPACE_BETWEEN_CELLS) - (SPACE_BETWEEN_CELLS / 2);
    startingY += cellWidth/3;
    startingY += SPACE_BETWEEN_CELLS;
    
    HomeButton *helpMeSpeakButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.helpMeSpeak", nil) withFrame:CGRectMake(SPACE_BETWEEN_CELLS, startingY, cellWidth, cellWidth)];
    [helpMeSpeakButton addImageBottomRight:[UIImage imageNamed:HELP_ME_SPEAK_ICON]];
    [helpMeSpeakButton addTarget:self action:@selector(helpMeSpeakPressed) forControlEvents:UIControlEventTouchUpInside];
    
    HomeButton *exercisesButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.exercises", nil) withFrame:CGRectMake((self.view.frame.size.width / 2) + (SPACE_BETWEEN_CELLS / 2), startingY, cellWidth, cellWidth)];
    [exercisesButton addImageCentered:[UIImage imageNamed:EXERCISE_ICON]];
    [exercisesButton addTarget:self action:@selector(exercisePressed) forControlEvents:UIControlEventTouchUpInside];
    startingY += cellWidth;
    startingY += SPACE_BETWEEN_CELLS;
    
    HomeButton *learnButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.learn", nil) withFrame:CGRectMake(SPACE_BETWEEN_CELLS, startingY, cellWidth, cellWidth)];
    [learnButton addImageBottomRight:[UIImage imageNamed:LEARN_ICON]];
    [learnButton addTarget:self action:@selector(learnPressed) forControlEvents:UIControlEventTouchUpInside];
    HomeButton *remindersButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.reminders", nil) withFrame:CGRectMake((self.view.frame.size.width / 2) + (SPACE_BETWEEN_CELLS / 2), startingY, cellWidth, cellWidth)];
    [remindersButton addImageBottomRight:[UIImage imageNamed:REMINDERS_ICON]];
    [remindersButton addTarget:self action:@selector(remindersPressed) forControlEvents:UIControlEventTouchUpInside];
    startingY += cellWidth;
    startingY += SPACE_BETWEEN_CELLS;
    
   HomeButton *generalInfoButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.generalInfo", nil) withFrame:CGRectMake(SPACE_BETWEEN_CELLS, startingY, cellWidth, cellWidth)];
    [generalInfoButton addImageCentered:[UIImage imageNamed:GENERAL_INFO_ICON]];
    [generalInfoButton addTarget:self action:@selector(generalInfoPressed) forControlEvents:UIControlEventTouchUpInside];
    
    HomeButton *surveysButton = [[HomeButton alloc] initWithText:NSLocalizedString(@"Home.surveys", nil) withFrame:CGRectMake((self.view.frame.size.width / 2) + (SPACE_BETWEEN_CELLS / 2), startingY, cellWidth, cellWidth)];
    [surveysButton addImageBottomRight:[UIImage imageNamed:SURVEYS_ICON]];
    [surveysButton addTarget:self action:@selector(surveysPressed) forControlEvents:UIControlEventTouchUpInside];

    startingY += cellWidth;
    startingY += SPACE_BETWEEN_CELLS;
    
    [self.contentView addSubview:helpMeSpeakButton];
    [self.contentView addSubview:exercisesButton];
    [self.contentView addSubview:learnButton];
    [self.contentView addSubview:remindersButton];
    [self.contentView addSubview:generalInfoButton];
    [self.contentView addSubview:surveysButton];
    [self.contentView addSubview:chatbotView];
    [self.contentView addSubview:chatbotView2];
//    [self.contentView addSubview:rateButton];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, startingY);
    CGRect temp = self.btnTellStory.frame;
    temp.size.width = cellWidth;
    self.btnTellStory.frame = temp;
    self.btnFeedback.frame = temp;
    
//    self.btnFeedback.frame = CGRectMake(SPACE_BETWEEN_CELLS, startingY + 20, cellWidth, 20);
//    self.btnTellStory.frame = CGRectMake((self.view.frame.size.width / 2) + (SPACE_BETWEEN_CELLS / 2), startingY + 20, cellWidth, 20);

    
    /* Fixed width */
//    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: self.btnTellStory attribute:NSLayoutAttributeWidth                                        relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[UIScreen mainScreen].bounds.size.width - 15];
//    [self.btnTellStory addConstraints:@[widthConstraint]];
//    [self.btnFeedback addConstraints:@[widthConstraint]];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)backPressed {
    [self.navigationController popViewControllerAnimated:YES];
     /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"tap",@"back",@"Home"]];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)helpMeSpeakPressed {
    HelpMeSpeakViewController *vc = [[HelpMeSpeakViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Help Me Speak", @"Section"]];
}

- (void)exercisePressed {
    ExercisesViewController *vc = [[ExercisesViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Exercise", @"Section"]];
}

- (void)learnPressed {
    LearnViewController *vc = [[LearnViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Learn", @"Section"]];
}

- (void)remindersPressed {
    RemindersViewController *vc = [[RemindersViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Reminders", @"Section"]];
}

- (void)generalInfoPressed {
    GeneralInfoViewController *vc = [[GeneralInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"General Info", @"Section"]];
}

- (void)surveysPressed {
    SurveysViewController *vc = [[SurveysViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Surveys", @"Section"]];
}

// Smiley icons setup
- (UIView*) smileyIconsSetup: (UIView*) chatbotView2{
    // Setup welcome Icons
    self.chatbotsmiley1 = [self createButton:self.chatbotsmiley1 withImage:QUOTES_IMAGE1];
    self.chatbotsmiley1.translatesAutoresizingMaskIntoConstraints = false;
    [self.chatbotsmiley1 addTarget:self action:@selector(icon1Pressed) forControlEvents:UIControlEventTouchUpInside];
    self.chatbotsmiley1.contentMode = UIViewContentModeScaleAspectFit;
    self.chatbotsmiley1.layer.masksToBounds = true;
    
    self.chatbotsmiley2 = [self createButton:self.chatbotsmiley2 withImage:QUOTES_IMAGE2];
    self.chatbotsmiley2.translatesAutoresizingMaskIntoConstraints = false;
    [self.chatbotsmiley2 addTarget:self action:@selector(icon2Pressed) forControlEvents:UIControlEventTouchUpInside];
    self.chatbotsmiley2.contentMode = UIViewContentModeScaleAspectFit;
    self.chatbotsmiley2.layer.masksToBounds = true;
    
    self.chatbotsmiley3 = [self createButton:self.chatbotsmiley3 withImage:QUOTES_IMAGE3];
    self.chatbotsmiley3.translatesAutoresizingMaskIntoConstraints = false;
    [self.chatbotsmiley3 addTarget:self action:@selector(icon3Pressed) forControlEvents:UIControlEventTouchUpInside];
    self.chatbotsmiley3.contentMode = UIViewContentModeScaleAspectFit;
    self.chatbotsmiley3.layer.masksToBounds = true;
    
    self.chatbotsmiley4 = [self createButton:self.chatbotsmiley4 withImage:QUOTES_IMAGE4];
    self.chatbotsmiley4.translatesAutoresizingMaskIntoConstraints = false;
    [self.chatbotsmiley4 addTarget:self action:@selector(icon4Pressed) forControlEvents:UIControlEventTouchUpInside];
    self.chatbotsmiley4.contentMode = UIViewContentModeScaleAspectFit;
    self.chatbotsmiley4.layer.masksToBounds = true;
    
    self.chatbotsmiley5 = [self createButton:self.chatbotsmiley5 withImage:QUOTES_IMAGE5];
    self.chatbotsmiley5.translatesAutoresizingMaskIntoConstraints = false;
    [self.chatbotsmiley5 addTarget:self action:@selector(icon5Pressed) forControlEvents:UIControlEventTouchUpInside];
    self.chatbotsmiley5.contentMode = UIViewContentModeScaleAspectFit;
    self.chatbotsmiley5.layer.masksToBounds = true;
    
    [chatbotView2 addSubview:self.chatbotsmiley1];
    [chatbotView2 addSubview:self.chatbotsmiley2];
    [chatbotView2 addSubview:self.chatbotsmiley3];
    [chatbotView2 addSubview:self.chatbotsmiley4];
    [chatbotView2 addSubview:self.chatbotsmiley5];
    
    //Horizontal Constraints
    
    NSDictionary *viewsIconsButton = @{ @"icon1" : self.chatbotsmiley1, @"icon2" : self.chatbotsmiley2 ,@"icon3" : self.chatbotsmiley3, @"icon4" : self.chatbotsmiley4, @"icon5" : self.chatbotsmiley5};
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-35-[icon1(==icon2)]-20@750-[icon2(==icon3)]-20@750-[icon3(==icon4)]-20@750-[icon4(==icon5)]-20@750-[icon5(==icon1)]-20-|" options:0 metrics:nil views: viewsIconsButton]];
    
    //Vertical Constraints
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-3-[icon1(41)]-1-|" options:0 metrics:nil views: viewsIconsButton]];
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-3-[icon2(41)]-1-|" options:0 metrics:nil views: viewsIconsButton]];
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-3-[icon3(41)]-1-|" options:0 metrics:nil views: viewsIconsButton]];
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-3-[icon4(41)]-1-|" options:0 metrics:nil views: viewsIconsButton]];
    [chatbotView2 addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-3-[icon5(41)]-1-|" options:0 metrics:nil views: viewsIconsButton]];
    return chatbotView2;
}


// Smiley icon1 pressed
- (void) icon1Pressed {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    ChatBotViewController *vc = [[ChatBotViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.welcomeText = @"good";
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Smiley 1", @"Icon"]];
}

// Smiley icon2 pressed
- (void) icon2Pressed {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    ChatBotViewController *vc = [[ChatBotViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.welcomeText = @"good";
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Smiley 2", @"Icon"]];
}

// Smiley icon3 pressed
- (void) icon3Pressed {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    ChatBotViewController *vc = [[ChatBotViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.welcomeText = @"sad";
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Smiley 3", @"Icon"]];
}

// Smiley icon4 pressed
- (void) icon4Pressed {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    ChatBotViewController *vc = [[ChatBotViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.welcomeText = @"very sad";
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Smiley 4", @"Icon"]];
}

// Smiley icon5 pressed
- (void) icon5Pressed {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    ChatBotViewController *vc = [[ChatBotViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.welcomeText = @"painful";
    [self.navigationController pushViewController:vc animated:YES];
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Smiley 5", @"Icon"]];
}

// Custom icon creator for Container View
- (UIButton*) createButton: (UIButton*) button withImage: (NSString*) imageName{
    button = [UIButton buttonWithType: UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    button.clipsToBounds = YES;
    return button;
}

// Logout button pressed
- (void) logoutPressed {
    /* insert app usage info into table*/
    [AWSDynamoDBHelper detailedAppUsage: @[@"Tap",@"Logout", @"NA"]];
    /* calculate user session information and load everything in the database table*/
    [AWSDynamoDBHelper calcSessionUsage];
    [AWSDynamoDBHelper detailedChatLog];
    [AWSDynamoDBHelper clearSessionDataLog];
    
    // Navigate to Login page
//    EnterViewController *vc = [[EnterViewController alloc] init];
    [self.navigationController popToRootViewControllerAnimated:true ];
}

- (void) insertUserData: (NSArray*) data{
    [AWSDynamoDBHelper InsertDataIntoUsersTable:data];
}

- (IBAction)btnFeedbackTapped:(id)sender {
    NSLog(@"Feedback");
    FeedbackViewController *vc = [[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    FeedbackViewController *controller = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
//    controller.modalPresentationStyle = UIModalPresentationPopover;
//    controller.preferredContentSize = CGSizeMake(150, 300);
//    UIPopoverPresentationController *popover =  controller.popoverPresentationController;
//    popover.sourceView = self.view;
//    popover.sourceRect = self.view.frame;
//    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    // display the controller in the usual way
//    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)btnTell:(id)sender {
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Tell your story"];
        [mail setMessageBody:@"We would love to hear from you!" isHTML:NO];
        [mail setToRecipients:@[@"contact@health4theworld.org"]];
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else{
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
}
@end
