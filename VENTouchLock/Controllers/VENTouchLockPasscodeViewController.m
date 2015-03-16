#import "VENTouchLockPasscodeViewController.h"
#import "VENTouchLockPasscodeView.h"
#import "VENTouchLockPasscodeCharacterView.h"
#import "UIViewController+VENTouchLock.h"
#import "VENTouchLock.h"

//static const NSInteger VENTouchLockViewControllerPasscodeLength = 4;

@interface VENTouchLockPasscodeViewController () <UITextFieldDelegate>

@property (assign, nonatomic) BOOL shouldIgnoreTextFieldDelegateCalls;

@end

@implementation VENTouchLockPasscodeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _touchLock = [VENTouchLock sharedInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    self.view.backgroundColor = [self.touchLock appearance].passcodeViewControllerBackgroundColor;
    [self configurePasscodeView];
    [self configureInvisiblePasscodeField];
    [self configureNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.passcodeView.pwTextField isFirstResponder]) {
        [self.passcodeView.pwTextField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.passcodeView.pwTextField isFirstResponder]) {
        [self.passcodeView.pwTextField resignFirstResponder];
    }
}

- (void)configureInvisiblePasscodeField
{
    self.passcodeView.pwTextField.secureTextEntry = YES;
    self.passcodeView.pwTextField.delegate = self;
    [self.passcodeView.pwTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passcodeView.unlockButton setEnabled:NO];
    [self.passcodeView.unlockButton addTarget:self action:@selector(hitUnlockButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureNavigationItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self.touchLock appearance].cancelBarButtonItemTitle style:UIBarButtonItemStylePlain target:self action:@selector(userTappedCancel)];
}

- (void)configurePasscodeView
{
    VENTouchLockPasscodeView *passcodeView = [[VENTouchLockPasscodeView alloc] init];
    passcodeView.titleColor = self.touchLock.appearance.passcodeViewControllerTitleColor;
    passcodeView.characterColor = self.touchLock.appearance.passcodeViewControllerCharacterColor;
    [self.view addSubview:passcodeView];
    self.passcodeView = passcodeView;
}

- (void)userTappedCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishWithResult:(BOOL)success animated:(BOOL)animated
{
    [self.passcodeView.pwTextField resignFirstResponder];
    if (self.willFinishWithResult) {
        self.willFinishWithResult(success);
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

- (UINavigationController *)embeddedInNavigationController
{
    return [super ventouchlock_embeddedInNavigationController];
}

- (void)hitUnlockButton:(id)sender{
    [self performSelector:@selector(enteredPasscode:) withObject:self.passcodeView.pwTextField.text afterDelay:0.3];
//    [self enteredPasscode:self.passcodeView.pwTextField.text];
}

- (void)enteredPasscode:(NSString *)passcode
{
    self.shouldIgnoreTextFieldDelegateCalls = NO;
}

- (void)clearPasscode
{
//    UITextField *textField = self.invisiblePasscodeField;
    self.passcodeView.pwTextField.text = @"";
    [self.passcodeView.unlockButton setEnabled:NO];
//    for (VENTouchLockPasscodeCharacterView *characterView in self.passcodeView.characters) {
//        characterView.isEmpty = YES;
//    }
}

#pragma mark - UIKeyboard Delegate

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect newKeyboardFrame = [(NSValue *)[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat passcodeLockViewHeight = CGRectGetHeight(self.view.frame) - CGRectGetHeight(newKeyboardFrame);
    CGFloat passcodeLockViewWidth = CGRectGetWidth(self.view.frame);
    self.passcodeView.frame = CGRectMake(0, 0, passcodeLockViewWidth, passcodeLockViewHeight);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hitUnlockButton:nil];
    return YES;
}


#pragma mark - UITextField Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.shouldIgnoreTextFieldDelegateCalls) {
        return NO;
    }
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSUInteger newLength = [newString length];
//    if (newLength > VENTouchLockViewControllerPasscodeLength) {
//        [self.passcodeView shakeAndVibrateCompletion:nil];
//        textField.text = @"";
//        return NO;
//    }
//    else {
//        for (VENTouchLockPasscodeCharacterView *characterView in self.passcodeView.characters) {
//            NSUInteger index = [self.passcodeView.characters indexOfObject:characterView];
//            characterView.isEmpty = (index >= newLength);
//        }
//        return YES;
//    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.shouldIgnoreTextFieldDelegateCalls) {
        return;
    }
    NSString *newString = textField.text;
    NSUInteger newLength = [newString length];
    [self.passcodeView.unlockButton setEnabled:newLength];
//
//    if (newLength == VENTouchLockViewControllerPasscodeLength) {
//        self.shouldIgnoreTextFieldDelegateCalls = YES;
//        textField.text = @"";
//        [self performSelector:@selector(enteredPasscode:) withObject:newString afterDelay:0.3];
//    }
}

@end
