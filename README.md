# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **25** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [X] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [X] Show the username and creation time for each post
- [X] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user (work in progress))
- User Profiles:
  - [X] Allow the logged in user to add and edit a profile photo
  - [X] Display the profile photo with each post
  - [X] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [X] User can like a post and see number of likes for each post in the post details screen.
- [X] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [X] A user can edit their name, username, and bio.
- [X] Captions show up like on the real Instagram, with username bolded and attached to the caption.
- [X] Launch screen with Instagram font (and added Instagram font everywhere).
- [X] New user page looks like the real Instagram.
- [X] Made user interface cleaner with compose view having options to pick image from camera or from photos if user closes ImagePickerController accidentally

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. What are more effective ways of adding a scrollable collection view to the profile page (which causes the bio, etc. to scroll up too?)?
2. How do we implement the UI for comments?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

- Login/Persisted User/Logout Functionality
<img src='http://g.recordit.co/gNVzXSV6vH.gif' title='Login/Persistence/Logout' width='' alt='Login/Persistence/Logout' />

- Instagram New User Page Validation
<img src='http://g.recordit.co/Wxq7S27XSO.gif' title='New User Page Validation' width='' alt='New User Page Validation' />

- Taking a Photo, Adding a Caption, and Posting It to Instagram
<img src='http://g.recordit.co/xTTElvWY4r.gif' title='Taking a Photo, Adding a Caption, and Posting It to Instagram' width='' alt='Taking a Photo, Adding a Caption, and Posting It to Instagram' />

- Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post's User
<img src='http://g.recordit.co/LsI6DPhz1N.gif' title='Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post User' width='' alt='Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post User' />

- Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts
<img src='http://g.recordit.co/jfGqzVheok.gif' title='Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts' width='' alt='Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts' />

- User Login Validation and Editing Profile to Add Profile Picture and Change Name/Username/Bio
<img src='http://g.recordit.co/P4qtRtEoKM.gif' title='Editing Profile to Add Profile Picture and Change Name/Username/Bio' width='' alt='Editing Profile to Add Profile Picture and Change Name/Username/Bio' />


GIF created with [Kap](https://getkap.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Parse](https://www.back4app.com/docs/get-started/welcome)
- [Parse/UI](https://github.com/parse-community/ParseUI-iOS)
- [DateTools](https://github.com/MatthewYork/DateTools)


## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2021] [Anvitha Kachinthaya]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
