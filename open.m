#import <Foundation/Foundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>

#import <stdio.h>

int main(int argc, char **argv, char **envp) {
    if(!argv[1]) {
        fprintf(stderr, "Usage: open com.application.identifier\n");
        return 1;
    }
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *identifier = [[NSString alloc] initWithUTF8String:argv[1]];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:identifier forKey:@"identifier"];

    CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.conradkramer.open.server"];
    NSDictionary *status = [messagingCenter sendMessageAndReceiveReplyName:@"open" userInfo:userInfo];
    int returnValue = [[status objectForKey:@"status"] intValue];
    
    [pool release];
    
    if (returnValue == 1) {
        fprintf(stderr, "Application with identifier %s not found\n", argv[1]);
    }
    
    return returnValue;
}

// vim:ft=objc
