//
//  MailHelp.m
//  SunboxApp_Standard_IPad
//
//  Created by apple on 13-5-6.
//  Copyright (c) 2013年 Raik. All rights reserved.
//

#import "MailHelp.h"
#import "UIImage-Extensions.h"

@implementation MailHelp

static MailHelp *_sharedInst = nil;

@synthesize viewController;
@synthesize recipients;
@synthesize isShowScreenShot;



+ (id) sharedService
{
	@synchronized(self){
		if(_sharedInst == nil)
		{
			_sharedInst = [[self alloc] init];
		}
	}
	return _sharedInst;
}

- (id) init
{
	if (self = [super init])
	{
		self.isShowScreenShot = YES;
	}
	
	return self;
}

- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
	return _sharedInst;
}

- (id)autorelease{
	return _sharedInst;
}

- (void) restore{
	
}

-(void) dealloc
{
	//[viewController release];
    [recipients release];
	[super dealloc];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Called once the email is sent
	// Remove the email view controller
	[viewController dismissModalViewControllerAnimated:YES];
    if ([viewController respondsToSelector:selector])
    {
        [viewController performSelector:selector];
    }
}

- (UIImage *)getScreen1WithView:(UIView *)view
{
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 1);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return uiImage;
}

- (void)sendMailWithPresentViewController:(UIViewController *)presentVC andReturnSel:(SEL)aSelector
{
    selector = aSelector;
    self.viewController = presentVC;
    
    UIImage *image = [self getScreen1WithView:presentVC.view];
	
	image = [image imageAtRect:CGRectMake(0, 0, image.size.width, image.size.height-0)];
	NSData *data = UIImagePNGRepresentation(image);
	
	[self emailImageWithImageData:data andPresentViewController:presentVC];
}

- (void)sendMailWithPresentViewController:(UIViewController *)presentVC
{
    
    [self sendMailWithPresentViewController:presentVC andReturnSel:nil];
}

- (void)emailImageWithImageData:(NSData *)data andPresentViewController:(UIViewController *)presentVC
{
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		if ([mailClass canSendMail])
		{
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			
			// Set the subject of email
			//[picker setSubject:@"Picture from my iPhone!"];
			
			// Add email addresses
			// Notice three sections: "to" "cc" and "bcc"
            if (recipients) {
                [picker setToRecipients:recipients];
                self.recipients = nil;
            }

			//[picker setToRecipients:[NSArray arrayWithObjects:@"emailaddress1@domainName.com", @"emailaddress2@domainName.com", nil]];
			//[picker setCcRecipients:[NSArray arrayWithObject:@"emailaddress3@domainName.com"]];
			//[picker setBccRecipients:[NSArray arrayWithObject:@"emailaddress4@domainName.com"]];
			
			//    Fill out the email body text
			//NSString *emailBody = @"I just took this picture, check it out.";
			
			// This is not an HTML formatted email
			//[picker setMessageBody:emailBody isHTML:NO];
			
			// Attach image data to the email
			// 'CameraImage.png' is the file name that will be attached to the email
            if (self.isShowScreenShot) {
                [picker addAttachmentData:data mimeType:@"image/png" fileName:@"CameraImage.png"];
            }
			// Show email view
			[presentVC presentModalViewController:picker animated:YES];
			
			// Release picker
			[picker release];
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"请设置邮箱账户",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

@end
