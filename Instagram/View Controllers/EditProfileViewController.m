//
//  EditProfileViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UIButton *changeProfilePhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *bioField;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;

@end

@implementation EditProfileViewController

// This view controller allows a user to change the information on their own profile page.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // All the information from a user's profile is pre-populated on the screen text fields, so they can see what it was before they change it.
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.nameField.text = self.user[@"fullName"];
    self.usernameField.text = self.user.username;
    self.bioField.text = self.user[@"bioText"];
    self.profilePictureView.file = self.user[@"profileImage"];
    [self.profilePictureView loadInBackground];
}

// In case a user wants to change their photo, we make more options appear so that they can choose how they want to add a photo. This is otherwise hidden for clean design.
- (IBAction)onTapChangeProfilePhoto:(id)sender {
    // The buttons to open the image picker come in with an animation to not make it too jarring.
    [UIView animateWithDuration:0.2 animations:^{
        self.takePhotoButton.alpha = 1;
        self.choosePhotoButton.alpha = 1;
    }];
}

// The below two methods give the user more power to pick or change the image they selected for their profile, or in case they accidentally closed out of the image picker.
// The below is what happens when a user clicks from camera, so they can take a picture.
- (IBAction)onTapTakePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    else {
        [self createAlert:@"Please allow camera access and try again!" error:@"Unable to Acccess Camera"];
    }
}

// The below is what happens when a user clicks from photos, so they can select or re-select a photo from their library.
- (IBAction)onTapChoosePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    else {
        [self createAlert:@"Please allow photo library access and try again!" error:@"Unable to Acccess Photo Library"];
    }
}

// When they click done, we make sure the information in the database associated with the user is updated, and then we can pop over back to the profile page.
- (IBAction)onTapDone:(id)sender {
    self.user[@"fullName"] = self.nameField.text;
    self.user[@"username"] = self.usernameField.text;
    self.user[@"bioText"] = self.bioField.text;
    self.user[@"profileImage"] = [self getPFFileFromImage:self.profilePictureView.image];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          // The PFUser has been saved.
            NSLog(@"User data was updated");
            //[self performSegueWithIdentifier:@"profileEdited" sender:nil];
            UINavigationController *nav = [self navigationController];
            [nav popViewControllerAnimated:YES]; // Allows us to go back without stacking too many views over each other each time.
        } else {
          // There was a problem, check error.description
            [self createAlert:error.description error:@"Error"];
        }
      }];
}

// This function does what the function in Post does, by converting images into files that can be stored in the database.
- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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

// This function is to set the profile image to the image picked or taken and to make sure it's been resized.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    CGSize imageSize = CGSizeMake(self.profilePictureView.frame.size.width, self.profilePictureView.frame.size.height);
    UIImage *resizedImage = [self resizeImage:originalImage withSize:imageSize];
    // Do something with the images (based on your use case)
    self.profilePictureView.image = resizedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

// This function resizes images in case they are too large so they can be stored in the database.
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
