#import "AFGetImageOperation.h"

@implementation AFGetImageOperation

- (id)initWithIndex:(int)imageIndex viewController:(UIViewController *)viewController 
{
    if (self = [super init]) 
	{
		photoIndex = imageIndex;
		mainViewController = [viewController retain];
    }
    return self;
}

- (void)dealloc 
{
	[mainViewController release];
    [super dealloc];
}

- (void)main 
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//	
//	NSString *imagePath = [[FileManagerController documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",kPlatDuJourPath,[[(SUSHIDOAppDelegate *)[[UIApplication sharedApplication] delegate] sharedPlatDuJourArray] objectAtIndex:photoIndex]]];
//	UIImage *theImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
//
//	if (theImage) {
//		[mainViewController performSelectorOnMainThread:@selector(imageDidLoad:) 
//											 withObject:[NSArray arrayWithObjects:theImage, [NSNumber numberWithInt:photoIndex], nil] 
//										  waitUntilDone:YES];
//	}
//	else
//		NSLog(@"Unable to find the image: %@", imagePath);
//	
//	[theImage release];
	
	[pool release];
}

@end