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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pressedSignUp:(id)sender {
    BOOL accepted = [self validateFields];
    if (accepted) {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.email = self.emailField.text;
    //TODO: figure out why the below is not working!
    //newUser.fullName = self.fullNameField.text;
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self createAlert:@"Unable to complete user registration. Please choose a unique username or check your internet connection!" error:@"Unable to Register User"];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"SignUpToFeed" sender:nil];
            // manually segue to logged in view
        }
    }];
    }
}
- (IBAction)pressedLogIn:(id)sender {
    [self performSegueWithIdentifier:@"LogIn" sender:nil];
}

- (void) createAlert: (NSString *)message error:(NSString*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error
                                                                               message:message
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    // show alert
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
