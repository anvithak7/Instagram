//
//  FeedViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/7/21.
//

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "PostUserViewController.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Parse/Parse.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, PostCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *feedPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

// This view controller is for the home screen, where users can see the latest 20 posts.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.user = [PFUser currentUser];
    [self getPosts];
    // The below three lines add pull to refresh functionality.
    self.refreshControl = [[UIRefreshControl alloc] init]; // We create a refresh control.
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged]; // It calls get posts whenever activated.
    [self.tableView insertSubview:self.refreshControl atIndex:0]; // We want to make sure it's visible.
}

// When a user presses logout, we got back to the login view controller, and the current user is now nil because there is no current user (using the Parse logout method).
- (IBAction)pressedLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

// If a user wants to create a post, we want to move to the Compose View Controller.
- (IBAction)pressedShare:(id)sender {
    [self performSegueWithIdentifier:@"composePostSegue" sender:nil];
}

// This function interacts with Parse database to fetch the latest posts created.
- (void) getPosts {
    // construct query to get posts
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100]; Can use this as a filter later!
    query.limit = 20; // We only want the 20 latest posts!
    [query includeKey:@"fullName"]; // This allows us to use .fullName later.
    [query orderByDescending:@"createdAt"]; // We want the latest posts first!
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.feedPosts = [posts copy]; // We add the posts to our view controller's property.
            [self.refreshControl endRefreshing];
            [self.tableView reloadData]; // We want to reload the table data.
        } else {
            NSLog(@"%@", error.localizedDescription);
            [self createAlert:@"Please check your wifi connection and try again!" error:@"Unable to Load Feed"];
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // To show the details of a post, the Details View Controller needs to know which post we're looking at.
    if ([segue.identifier isEqual:@"postDetails"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.feedPosts[indexPath.row];
        DetailsViewController *detailViewController = [segue destinationViewController];
        detailViewController.post = post; // Passing over post to next view controller.
    }
    // If we are going to a user's profile page, that new view controller will have to know who the post's user was.
    if ([segue.identifier isEqual:@"picToProfile"]) {
        PostUserViewController *postUserViewController = [segue destinationViewController];
        postUserViewController.user = sender; // Passing over user to next view controller.
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"]; // We create a table view cell of type PostCell.
    Post *currentPost = self.feedPosts[indexPath.row];
    cell.delegate = self; // The view controller is the delegate for the post cell (this allows us to add segue functionality to the button inside each post cell, with each cell allowing for going to the associated user.
    cell.post = currentPost; // We want to make sure this cell knows what it's post is.
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPosts.count; // User can view last 20 posts posted to Instagram
}

// This function creates alerts, so we don't have to retype the code several times.
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

// If a user taps on the profile picture or username of the user of a post, they can go to that user's profile page.
- (void) profilePicTap:(nonnull PostCell *)postCell didTap:(nonnull PFUser *)postUser {
    [self performSegueWithIdentifier:@"picToProfile" sender:postUser];
}

@end
