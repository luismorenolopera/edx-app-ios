//
//  OEXFindCoursesBaseViewController.m
//  edXVideoLocker
//
//  Created by Abhradeep on 04/02/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

#import "OEXRevealOptionsViewController+Protected.h"

#import "edX-Swift.h"
#import "OEXStyles.h"

NSString* const OEXFindCoursesLinkURLScheme = @"edxapp";

@interface OEXRevealOptionsViewController () <UIWebViewDelegate>

@end

@implementation OEXRevealOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.notReachableLabel.text = [Strings findCoursesOfflineMessage];
    [self setExclusiveTouches];
    self.dataInterface = [OEXInterface sharedInterface];
    [self setNavigationBar];

    self.showDownloadsButton.hidden = YES;
    self.customProgressBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    [self hideOfflineLabel:_dataInterface.reachable];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reachabilityDidChange:(NSNotification*)notification {
    id <Reachability> reachability = [notification object];
    _dataInterface.reachable = [reachability isReachable];
    [self hideOfflineLabel:_dataInterface.reachable];
}

- (void)setExclusiveTouches {
    self.customNavView.btn_Back.exclusiveTouch = YES;
    self.webView.exclusiveTouch = YES;
    self.view.exclusiveTouch = YES;
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.hidesBackButton = YES;

    [self.customProgressBar setProgressTintColor:PROGRESSBAR_PROGRESS_TINT_COLOR];
    [self.customProgressBar setTrackTintColor:PROGRESSBAR_TRACK_TINT_COLOR];
    [self.customProgressBar setProgress:_dataInterface.totalProgress animated:YES];
}

- (void)hideOfflineLabel:(BOOL)isOnline {
    //Minor Hack for matching the Spec right now.
    //TODO: Remove once refactoring with a navigation bar.
    self.customNavView.lbl_Offline.hidden = YES;
    self.customNavView.view_Offline.hidden = isOnline;
    self.notReachableLabel.hidden = isOnline;
    if(!isOnline) {
        self.webView.hidden = YES;
        [self.webView stopLoading];
    }
}

- (void)backPressed {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showDownloadButtonPressed:(id)sender {
    OEXDownloadViewController* downloadViewController = [[UIStoryboard storyboardWithName:@"OEXDownloadViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"OEXDownloadViewController"];
    [self.navigationController pushViewController:downloadViewController animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [OEXStyles sharedStyles].standardStatusBarStyle;
}

@end