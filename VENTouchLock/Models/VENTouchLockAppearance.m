#import "VENTouchLockAppearance.h"

@implementation VENTouchLockAppearance

- (instancetype)init
{
    self = [super init];
    if (self) { // Set default values
        _passcodeViewControllerTitleColor = [UIColor blackColor];
        _passcodeViewControllerCharacterColor = [UIColor blackColor];
        _passcodeViewControllerBackgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0f];
        _cancelBarButtonItemTitle = NSLocalizedString(@"Cancel", nil);
        _createPasscodeInitialLabelText = NSLocalizedString(@"Enter a new password", nil);
        _createPasscodeConfirmLabelText = NSLocalizedString(@"Please re-enter your password", nil);
        _createPasscodeMismatchedLabelText = NSLocalizedString(@"Passwords did not match. Try again", nil);
        _createPasscodeViewControllerTitle = NSLocalizedString(@"Set Password", nil);
        _enterPasscodeInitialLabelText = NSLocalizedString(@"Enter your password", nil);
        _enterPasscodeIncorrectLabelText = NSLocalizedString(@"Incorrect password. Try again.", nil);
        _enterPasscodeViewControllerTitle = NSLocalizedString(@"Enter Password", nil);
        _splashShouldEmbedInNavigationController = NO;
    }
    return self;
}

@end
