//
//  SimpleAdsViewController.m
//  Copyright (c) 2010 MoPub Inc.
//

#import "SimpleAdsViewController.h"
#import "MPAdView.h"
#import <CoreLocation/CoreLocation.h>

@implementation SimpleAdsViewController

@synthesize keyword;
@synthesize mpAdView, mpMrectView;
@synthesize adView, mrectView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCustom:)
												 name:@"loadCustom" object:nil];
	
	// 320x50 size
	mpAdView = [[MPAdView alloc] initWithAdUnitId:PUB_ID_320x50 size:MOPUB_BANNER_SIZE];
	mpAdView.delegate = self;
	[mpAdView loadAd];
	[self.adView addSubview:mpAdView];
	
	// MRect size
	mpMrectView = [[MPAdView alloc] initWithAdUnitId:PUB_ID_300x250 size:MOPUB_MEDIUM_RECT_SIZE];
	mpMrectView.delegate = self;
	[mpMrectView loadAd];
	[self.mrectView addSubview:mpMrectView];	
}

- (IBAction) refreshAd {
	[keyword resignFirstResponder];
	
	// update ad 
	self.mpAdView.keywords = keyword.text;
	[self.mpAdView refreshAd];
	
	// update mrect
	self.mpMrectView.keywords = keyword.text;
	[self.mpMrectView refreshAd];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self refreshAd];
	return YES;
}

- (void)loadCustom:(NSNotification *)notification {
	NSArray *info = [[NSArray alloc] initWithArray:[notification object]];
	if ([[info objectAtIndex:2] isEqualToString:@"320x50"]) {
		self.mpAdView = [[MPAdView alloc] initWithAdUnitId:[info objectAtIndex:0]
													  size:MOPUB_BANNER_SIZE];
		self.mpAdView.include = [info objectAtIndex:1];
		self.mpAdView.delegate = self;
		[self.mpAdView loadAd];
	} else { 
		self.mpMrectView = [[MPAdView alloc] initWithAdUnitId:[info objectAtIndex:0]
														 size:MOPUB_MEDIUM_RECT_SIZE];
		self.mpMrectView.include = [info objectAtIndex:1];
		[self.mpMrectView loadAd];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[mpAdView release];
	[mpMrectView release];
	[super dealloc];
}

- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}

@end
