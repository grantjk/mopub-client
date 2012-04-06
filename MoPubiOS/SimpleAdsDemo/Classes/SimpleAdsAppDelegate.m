//
//  SimpleAdsAppDelegate.m
//  Copyright (c) 2010 MoPub Inc.
//
//

#import "SimpleAdsAppDelegate.h"
#import "SimpleAdsViewController.h"
#import "MPInterstitialAdController.h"
#import "MPAdConversionTracker.h"
#import "MPConstants.h"

@implementation SimpleAdsAppDelegate

@synthesize window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [[MPAdConversionTracker sharedConversionTracker] reportApplicationOpenForApplicationID:@"agltb3B1Yi1pbmNyCwsSA0FwcBii-wsM"];

    // Override point for customization after app launch
	[window addSubview:self.tabBarController.view]; 
    [window makeKeyAndVisible];
	
	return YES;
}
//simpleads://?size=300x250&adunitid=agltb3B1Yi1pbmNyDQsSBFNpdGUYs83YEQw
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
	NSArray *formats = [[NSArray alloc] initWithObjects:
							@"320x50", @"300x250",@"728x90", @"160x600", nil];
							  
	NSArray *queries = [[url query] componentsSeparatedByString:@"&"];
	NSString *size = @"size";
	NSString *adid = @"";
	NSString *include = @"";
	NSLog(@"reached");
	for (NSString *query_string in queries) {
		NSLog(@"%@", query_string);
		NSArray *query = [query_string componentsSeparatedByString:@"="];
		NSString *key = [query objectAtIndex:0];
		NSString *value = [query objectAtIndex:1];
		if ([key isEqualToString:@"size"]) {
			size = value;
		} else if ([key isEqualToString:@"adunitid"]) {
			NSLog(@"%@",value);
			adid = value;
		} else if ([key isEqualToString:@"include"]) {
			include = value;
		}
	}
			
	if (![size isEqualToString:@"size"]) {
		NSArray *infoDict = [[NSArray alloc] initWithObjects:adid, include, size, nil];
		if ([formats containsObject:size]) {
			[[NSNotificationCenter defaultCenter] 
			 postNotificationName:@"loadCustom" 
			 object:infoDict];
		} else {
			[[NSNotificationCenter defaultCenter] 
			 postNotificationName:@"loadCustomInter"
			 object:infoDict];
		}
		return TRUE;
	} else {
		return FALSE;
	}
}

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}


@end
