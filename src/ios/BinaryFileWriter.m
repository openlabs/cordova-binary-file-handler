#import "BinaryFileWriter.h"
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Cordova/CDV.h>

@implementation BinaryFileWriter

- (void)quickLookFile:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* result = nil;
    
    NSString *path = [command.arguments objectAtIndex:0];

    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *fileURL = [NSURL URLWithString:path];
    UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    
    controller.delegate = self;
    // controller.UTI = uti;
    
    BOOL menuOpenened = [controller presentPreviewAnimated:YES];
    
    CDVPluginResult* pluginResult;
    if (!menuOpenened) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @""];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @""];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


- (void)writeToFile:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* result = nil;
    int errCode = 0;
    BOOL success = NO;
    BOOL isDirectory = YES;
    int bytesWritten = 0;
    NSError* error;
    
    // File path
    NSString* path = [command.arguments objectAtIndex:0];
    
    // Base 64 encoded data
    NSString* data = [command.arguments objectAtIndex:1];
    NSData* encData = [[NSData alloc] initWithBase64EncodedString:data options:NSDataBase64DecodingIgnoreUnknownCharacters];

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];

    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory isDirectory:&isDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
    }
    
    NSLog(@"Documents directory: %@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
                                                                                          error:&error]);
    NSString* dataPath = [documentsDirectory stringByAppendingPathComponent:path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        success = [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];
    
    }
    success = [[NSFileManager defaultManager] createFileAtPath:dataPath
                                                contents:encData
                                                    attributes:nil];
    if (success) {
         NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:dataPath];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[fileURL absoluteString]];
    }
    if (!result) {
        // was an error
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:errCode];
    }

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *) controller {
    return self.viewController;
}

@end
