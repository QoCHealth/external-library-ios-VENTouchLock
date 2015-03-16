#import <UIKit/UIKit.h>

@interface VENTouchLockPasscodeView : UIView

/**
 The title string directly on top of the passcode characters.
 */
@property (strong, nonatomic) NSString *title;

/**
 The color of the title text.
 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 The color of the passcode characters.
 */
@property (strong, nonatomic) UIColor *characterColor;

@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *unlockButton;

/**
 Creates a passcode view controller with the given title and frame.
 */
- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;

/**
 Creates a passcode view controller with the given title and frame.
 */
- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame titleColor:(UIColor *)titleColor characterColor:(UIColor *)characterColor;

/**
 Shakes the reciever and vibrates the device.
 @param completionBlock called after shake and vibrate complete
 */
- (void)shakeAndVibrateCompletion:(void (^)())completionBlock;

@end
