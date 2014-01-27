//
//  AppDelegate.m
//  Demo FAQ
//
//  Created by Cam Roth on 1/27/2014.
//  Copyright (c) 2014 CamRoth. All rights reserved.
//

#import "AppDelegate.h"
#import "CRFAQTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// custom initializer
	CRFAQTableViewController *faqViewController = [[CRFAQTableViewController alloc] initWithQuestions:@[
		@[@"Does it cost money to use Facebook? Is it true that Facebook is going to charge to use the site?", @"Facebook is a free site and will never require that you pay to continue using the site. You do, however, have the option of making purchases related to games, apps and gifts. In addition, if you choose to use Facebook from your mobile phone, keep in mind that you will be responsible for any fees associated with internet usage and/or text messaging as determined by your mobile carrier."],
		@[@"How old do you have to be to sign up for Facebook?", @"In order to be eligible to sign up for Facebook, you must be at least 13 years old."],
		@[@"Can I create a joint Facebook account or share a Facebook account with someone else?", @"Facebook accounts are for individual use. This means that we don't allow joint accounts. Additionally, you can only sign up for one Facebook account per email address.\n\nSince each account belongs to one person, we require everyone to use their real name on their account. This way, you always know who you're connecting with. Learn more about our name policies.\n\nAfter you create an account, you can use Friendship Pages to see your interactions with any friend, all in one place."]
	]];
	
	// adding questions after initialization
	[faqViewController addQuestion:@"Why am I getting a Facebook invitation email from a friend?" withAnswer:@"You received this email because a Facebook member is inviting you to join Facebook. Facebook allows people to send invitations to their contacts by entering an email address or by uploading their contacts.\n\nIf you're already registered for Facebook, your friend may have used an email address of yours that isn't currently linked to your Facebook account. If you'd like, you can add this email address to your existing Facebook account to ensure that you won't get Facebook invitations sent to that address in the future.\n\nIf you don't have a Facebook account and would like to create one, you can use this email to start the registration process.\n\nIf you don't want to receive invites from your friends, you can use the unsubscribe link in the footer of the email."];
	[faqViewController addQuestion:@"How do I sign up for Facebook?" withAnswer:@"If you don't have a Facebook account, you can sign up for one in a few easy steps. To sign up for a new account, enter your name, birthday, gender and email address into the form at www.facebook.com. Then pick a password.\n\nAfter you complete the sign up form, we'll send an email to the address you provided. Just click the confirmation link to complete the sign up process."];
	
	faqViewController.title = @"FAQ";
	
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:faqViewController];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
