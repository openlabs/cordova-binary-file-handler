#import <Cordova/CDV.h>

@interface BinaryFileWriter : CDVPlugin <UIDocumentInteractionControllerDelegate>

- (void)writeToFile:(CDVInvokedUrlCommand*)command;
- (void)quickLookFile:(CDVInvokedUrlCommand*)command;

@end

