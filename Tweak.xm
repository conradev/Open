/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.
*/

#import <SpringBoard/SpringBoard.h>

#import "DSDisplayController.h"

%hook SBApplicationController

- (id)init {
    if ((self = %orig)) {
        CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.conradkramer.open.server"];
        [messagingCenter runServerOnCurrentThread];

        [messagingCenter registerForMessageName:@"open" target:self selector:@selector(handleOpenCommand:withUserInfo:)];
    }
    return self;
}

%new(@@:@@)
- (NSDictionary *)handleOpenCommand:(NSString *)name withUserInfo:(NSDictionary *)userInfo {
    NSString *identifier = [userInfo objectForKey:@"identifier"];
    SBApplication *application = [self applicationWithDisplayIdentifier:identifier];
    
    if (application) {
        [[DSDisplayController sharedInstance] activateApplication:application animated:YES];
        return [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"status"];
    } else {
        return [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:@"status"];
    }
}

%end