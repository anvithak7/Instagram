//
//  NewUserViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/7/21.
//

#import "NewUserViewController.h"
#import "Parse/Parse.h"

@interface NewUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation NewUserViewController

// This view controller is associated with registering a new user to Instagram.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// The core functionality of this view controller. Given fields of information, they are validated and then sent to the Parse database to be added as a new user.
- (IBAction)pressedSignUp:(id)sender {
    BOOL accepted = [self validateFields];
    if (accepted) {
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.email = self.emailField.text;
        newUser[@"fullName"] = self.fullNameField.text;
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                [self createAlert:error.localizedDescription error:@"Unable to Register User"];
                //@"Unable to complete user registration. Please enter a valid email address, choose a unique username, or check your internet connection!"
                // I changed the above because the error descriptions are pretty useful instead of a generic catch-all statement.
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"SignUpToFeed" sender:nil];
                // manually segue to logged in view
            }
        }];
    }
}

// This allows the user to switch between a login and sign up page.
- (IBAction)pressedLogIn:(id)sender {
    [self performSegueWithIdentifier:@"LogIn" sender:nil];
}

// A function to create alerts, so I don't have to reuse all this code again within functions.
- (void) createAlert: (NSString *)message error:(NSString*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error message:message preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    // handle response here.
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    // show alert
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}

// The below method checks all of the fields and calls out errors in case any of the fields are blank. Parse seems to validate emails and valid strings, so I didn't have to do that here.
- (BOOL) validateFields {
    if ([self.emailField.text isEqual:@""]) {
        [self createAlert:@"Please enter a valid email and try again!" error:@"Unable to Register User"];
        return NO;
    } else if ([self.fullNameField.text isEqual:@""]) {
        [self createAlert:@"Please enter your full name and try again!" error:@"Unable to Register User"];
        return NO;
    } else if ([self.usernameField.text isEqual:@""]) {
        [self createAlert:@"Please choose a username and try again!" error:@"Unable to Register User"];
        return NO;
    } else if ([self.passwordField.text isEqual:@""]) {
        [self createAlert:@"Please enter a password and try again!" error:@"Unable to Register User"];
        return NO;
    }
    return YES;
}

- (IBAction)onTapAnywhere:(id)sender {
    [self.view endEditing:true];
}

/*The below is from StackOverflow - https://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
    However, it turns out I don't really need this because Parse seems to check for valid emails. But the regex is useful, so leaving it here for the future. */
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
   BOOL stricterFilter = NO;
   NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
   NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
   NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
   NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
   return [emailTest evaluateWithObject:checkString];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
