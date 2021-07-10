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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.nameField.text = self.user[@"fullName"];
    self.usernameField.text = self.user.username;
    self.bioField.text = self.user[@"bioText"];
    self.profilePictureView.file = self.user[@"profileImage"];
    [self.profilePictureView loadInBackground];
}

- (IBAction)onTapChangeProfilePhoto:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.takePhotoButton.alpha = 1;
        self.choosePhotoButton.alpha = 1;
    }];
}

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
            [nav popViewControllerAnimated:YES];
        } else {
          // There was a problem, check error.description
            [self createAlert:error.description error:@"Error"];
        }
      }];
}

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
