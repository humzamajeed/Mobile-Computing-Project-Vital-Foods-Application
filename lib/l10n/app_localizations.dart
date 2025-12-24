import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Food Delivery App'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Greeting message
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Home address label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Shopping cart
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// User profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Orders screen
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Favorites screen
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Add to cart button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// Checkout button
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Total amount label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Delivery address label
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// Payment screen
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// Order tracking screen
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get orderTracking;

  /// Reviews label
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Notifications setting
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Address management
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Offers and promotions
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// Customer support
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Change language button
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// French language
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Arabic language
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Select language dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Edit profile button
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Personal info menu item
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// Change password button
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Phone number label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button/label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button/label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Add button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Remove button
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Empty state message
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItems;

  /// Price label
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Quantity label
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// Subtotal label
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Delivery fee label
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// Confirm order button
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// Order placed message
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderPlaced;

  /// Order status label
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// Pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Preparing status
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get preparing;

  /// Order status - on the way
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get onTheWay;

  /// Delivered status
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// Rating sort option
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Write review button
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReview;

  /// Add address button
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// Edit address button
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// Default address label
  ///
  /// In en, this message translates to:
  /// **'Default Address'**
  String get defaultAddress;

  /// Account section
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// General settings
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// About section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of service
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Contact us
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Delete account button
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Please sign in to your existing account'**
  String get pleaseSignIn;

  /// Remember me checkbox
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Sign up prompt
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Or divider text
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// Delivery location label
  ///
  /// In en, this message translates to:
  /// **'DELIVER TO'**
  String get deliverTo;

  /// Addresses screen title
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses;

  /// My orders menu item
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// Favorites menu item
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// Payment method label
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// FAQs menu item
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// User reviews menu item
  ///
  /// In en, this message translates to:
  /// **'User Reviews'**
  String get userReviews;

  /// Preferences section
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Notifications setting description
  ///
  /// In en, this message translates to:
  /// **'Enable push notifications'**
  String get enablePushNotifications;

  /// Location services setting
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get locationServices;

  /// Location services description
  ///
  /// In en, this message translates to:
  /// **'Allow location access'**
  String get allowLocationAccess;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Dark mode description
  ///
  /// In en, this message translates to:
  /// **'Switch to dark theme'**
  String get switchToDarkTheme;

  /// Legal section
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// Help center menu item
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// Help center description
  ///
  /// In en, this message translates to:
  /// **'Get help and support'**
  String get getHelpAndSupport;

  /// Send feedback menu item
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// Send feedback description
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts with us'**
  String get shareYourThoughts;

  /// Rate us menu item
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// Rate us description
  ///
  /// In en, this message translates to:
  /// **'Rate us on the app store'**
  String get rateUsOnAppStore;

  /// Terms of service description
  ///
  /// In en, this message translates to:
  /// **'Read our terms and conditions'**
  String get readTermsAndConditions;

  /// Privacy policy description
  ///
  /// In en, this message translates to:
  /// **'Learn about our privacy practices'**
  String get learnAboutPrivacy;

  /// Change password description
  ///
  /// In en, this message translates to:
  /// **'Update your password'**
  String get updateYourPassword;

  /// Payment methods description
  ///
  /// In en, this message translates to:
  /// **'Manage your payment options'**
  String get managePaymentOptions;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureLogout;

  /// Track order screen title
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get trackOrder;

  /// Cancel order button
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// Cancel order dialog title
  ///
  /// In en, this message translates to:
  /// **'Cancel Order?'**
  String get cancelOrderQuestion;

  /// Keep order button
  ///
  /// In en, this message translates to:
  /// **'No, Keep Order'**
  String get noKeepOrder;

  /// Confirm cancel button
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// Empty reviews message
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// Login required for favorites message
  ///
  /// In en, this message translates to:
  /// **'Please login to add favorites'**
  String get pleaseLoginToAddFavorites;

  /// Item added to cart success message
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get itemAddedToCart;

  /// Empty cart message
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCart;

  /// Start shopping button
  ///
  /// In en, this message translates to:
  /// **'Start Shopping'**
  String get startShopping;

  /// Cancel order confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get areYouSureCancelOrder;

  /// Cancel order warning message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order? This action cannot be undone.'**
  String get cancelOrderCannotUndone;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Restaurants tab
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// Food items tab
  ///
  /// In en, this message translates to:
  /// **'Food Items'**
  String get foodItems;

  /// Sign up screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Please sign up to get started'**
  String get pleaseSignUp;

  /// Confirm password label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Email required message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Password reset success message
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent!'**
  String get passwordResetEmailSent;

  /// Verification screen title
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// Verification code instruction
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your email'**
  String get enterVerificationCode;

  /// Verify button
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Resend code button
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// Resend code prompt
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// Login prompt on signup
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Apply button
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Clear button
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Filter button
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Sort button
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// View all button
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// See more button
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// See less button
  ///
  /// In en, this message translates to:
  /// **'See Less'**
  String get seeLess;

  /// Select button
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// Choose button
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// Proceed button
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Place order button
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// Pay now button
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// Add card button
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// Card number label
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// Expiry date label
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// CVV label
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// Cardholder name label
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// Payment processing message
  ///
  /// In en, this message translates to:
  /// **'Processing Payment...'**
  String get processingPayment;

  /// Payment success message
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// Payment failed message
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// Order confirmed message
  ///
  /// In en, this message translates to:
  /// **'Order Confirmed'**
  String get orderConfirmed;

  /// Thank you message
  ///
  /// In en, this message translates to:
  /// **'Thank You!'**
  String get thankYou;

  /// Order placed success message
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully'**
  String get yourOrderHasBeenPlaced;

  /// Street address label
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// City label
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// State label
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// Zip code label
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// Country label
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Set as default address checkbox
  ///
  /// In en, this message translates to:
  /// **'Set as Default'**
  String get setAsDefault;

  /// Review text field placeholder
  ///
  /// In en, this message translates to:
  /// **'Write your review'**
  String get writeYourReview;

  /// Add tags label
  ///
  /// In en, this message translates to:
  /// **'Add Tags'**
  String get addTags;

  /// Submit review button
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// Review submitted thank you message
  ///
  /// In en, this message translates to:
  /// **'Thank you for your review!'**
  String get thankYouForReview;

  /// Empty notifications message
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// Allow location button
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// Location access required message
  ///
  /// In en, this message translates to:
  /// **'Location access is required for delivery'**
  String get locationAccessRequired;

  /// Enable location button
  ///
  /// In en, this message translates to:
  /// **'Enable Location'**
  String get enableLocation;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get getStarted;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome to Food Delivery'**
  String get welcomeToApp;

  /// Onboarding message
  ///
  /// In en, this message translates to:
  /// **'Discover delicious food from your favorite restaurants'**
  String get discoverDeliciousFood;

  /// Fast delivery feature
  ///
  /// In en, this message translates to:
  /// **'Fast Delivery'**
  String get fastDelivery;

  /// Easy ordering feature
  ///
  /// In en, this message translates to:
  /// **'Easy Ordering'**
  String get easyOrdering;

  /// Secure payment feature
  ///
  /// In en, this message translates to:
  /// **'Secure Payment'**
  String get securePayment;

  /// Add card required message
  ///
  /// In en, this message translates to:
  /// **'Please add a card first in order to proceed'**
  String get pleaseAddCardFirst;

  /// Cash payment method
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// PayPal payment method
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// Mastercard payment method
  ///
  /// In en, this message translates to:
  /// **'Mastercard'**
  String get mastercard;

  /// Visa payment method
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get visa;

  /// Recent keywords section title
  ///
  /// In en, this message translates to:
  /// **'Recent Keywords'**
  String get recentKeywords;

  /// Suggested restaurants section title
  ///
  /// In en, this message translates to:
  /// **'Suggested Restaurants'**
  String get suggestedRestaurants;

  /// Popular fast food section title
  ///
  /// In en, this message translates to:
  /// **'Popular Fast Food'**
  String get popularFastFood;

  /// Empty addresses message
  ///
  /// In en, this message translates to:
  /// **'No addresses saved'**
  String get noAddressesSaved;

  /// Office address label
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// Default label
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// No card added message
  ///
  /// In en, this message translates to:
  /// **'No card added'**
  String get noCardAdded;

  /// Add card instruction
  ///
  /// In en, this message translates to:
  /// **'You can add a card and save it for later'**
  String get youCanAddCardAndSave;

  /// Pay and confirm button
  ///
  /// In en, this message translates to:
  /// **'Pay & Confirm'**
  String get payAndConfirm;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search for food...'**
  String get searchForFood;

  /// Ingredients label
  ///
  /// In en, this message translates to:
  /// **'INGRIDENTS'**
  String get ingredients;

  /// Size label
  ///
  /// In en, this message translates to:
  /// **'SIZE'**
  String get size;

  /// Add to favorites button
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// Remove from favorites button
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// Description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Delivery time filter label
  ///
  /// In en, this message translates to:
  /// **'Delivery time'**
  String get deliveryTime;

  /// Minimum order label
  ///
  /// In en, this message translates to:
  /// **'Minimum Order'**
  String get minimumOrder;

  /// Popular sort option
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// Recommended label
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// New label
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// Special offers label
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get specialOffers;

  /// All categories section title
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// Full name label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Date of birth label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Gender label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Male gender
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Other gender
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// Address label field
  ///
  /// In en, this message translates to:
  /// **'Address Label'**
  String get addressLabel;

  /// Save address button
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get saveAddress;

  /// Your rating label
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get yourRating;

  /// Review text field placeholder
  ///
  /// In en, this message translates to:
  /// **'Write your review here...'**
  String get writeYourReviewHere;

  /// Add photos button
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get addPhotos;

  /// Post review button
  ///
  /// In en, this message translates to:
  /// **'Post Review'**
  String get postReview;

  /// All reviews label
  ///
  /// In en, this message translates to:
  /// **'All Reviews'**
  String get allReviews;

  /// Help and support title
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// FAQ title
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// Contact support button
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// Send message button
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// Message field label
  ///
  /// In en, this message translates to:
  /// **'Your Message'**
  String get yourMessage;

  /// Subject label
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// Apply filters button
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// Reset filters button
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// Price range label
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// Cuisine label
  ///
  /// In en, this message translates to:
  /// **'Cuisine'**
  String get cuisine;

  /// Distance label
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// Rating filter label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingFilter;

  /// Location permission title
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get locationPermissionRequired;

  /// Location permission message
  ///
  /// In en, this message translates to:
  /// **'We need your location to show nearby restaurants'**
  String get weNeedYourLocation;

  /// Grant permission button
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// Next step button
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// Previous button
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No items found message
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// Try again button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Review tag for delicious food
  ///
  /// In en, this message translates to:
  /// **'Delicious'**
  String get delicious;

  /// Review tag for hot and fresh food
  ///
  /// In en, this message translates to:
  /// **'Hot & Fresh'**
  String get hotFresh;

  /// Review tag for good packaging
  ///
  /// In en, this message translates to:
  /// **'Good Packaging'**
  String get goodPackaging;

  /// Review tag for value for money
  ///
  /// In en, this message translates to:
  /// **'Value for Money'**
  String get valueForMoney;

  /// Review tag for friendly rider
  ///
  /// In en, this message translates to:
  /// **'Friendly Rider'**
  String get friendlyRider;

  /// Title for rating delivery person section
  ///
  /// In en, this message translates to:
  /// **'Rate Delivery Person'**
  String get rateDeliveryPerson;

  /// Button to mark all notifications as read
  ///
  /// In en, this message translates to:
  /// **'Mark all'**
  String get markAll;

  /// Today label for notifications
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday label for notifications
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// This week label for notifications
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// Message about location access
  ///
  /// In en, this message translates to:
  /// **'DFOOD WILL ACCESS YOUR LOCATION ONLY WHILE USING THE APP'**
  String get locationAccessMessage;

  /// Onboarding title for favorites page
  ///
  /// In en, this message translates to:
  /// **'All your favorites'**
  String get allYourFavorites;

  /// Onboarding description for favorites page
  ///
  /// In en, this message translates to:
  /// **'Get all your loved foods in one once place,\nyou just place the orer we do the rest'**
  String get allYourFavoritesDesc;

  /// Onboarding title for chef page
  ///
  /// In en, this message translates to:
  /// **'Order from chosen chef'**
  String get orderFromChosenChef;

  /// Onboarding description for chef page
  ///
  /// In en, this message translates to:
  /// **'Get your food delivered from hand-picked\nchefs near you'**
  String get orderFromChosenChefDesc;

  /// Onboarding title for delivery page
  ///
  /// In en, this message translates to:
  /// **'Free delivery offers'**
  String get freeDeliveryOffers;

  /// Onboarding description for delivery page
  ///
  /// In en, this message translates to:
  /// **'Get all your loved foods in one once place,\nyou just place the orer we do the rest'**
  String get freeDeliveryOffersDesc;

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get nextButton;

  /// Support greeting message
  ///
  /// In en, this message translates to:
  /// **'Hello! How can I help you today?'**
  String get helloHowCanIHelp;

  /// Online status label
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// Support category for order issues
  ///
  /// In en, this message translates to:
  /// **'Order Issue'**
  String get orderIssue;

  /// Support category for payment issues
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentIssue;

  /// Support category for delivery issues
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryIssue;

  /// Support category for account issues
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountIssue;

  /// Placeholder for message input
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeAMessage;

  /// Sort by label
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// Price sort option low to high
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get priceLowToHigh;

  /// Price sort option high to low
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get priceHighToLow;

  /// Specials filter label
  ///
  /// In en, this message translates to:
  /// **'Specials'**
  String get specials;

  /// Reset button text
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Offers screen title
  ///
  /// In en, this message translates to:
  /// **'Hurry Offers!'**
  String get hurryOffers;

  /// Coupon discount message
  ///
  /// In en, this message translates to:
  /// **'Use the coupon get 25% discount'**
  String get useCouponGetDiscount;

  /// Got it button text
  ///
  /// In en, this message translates to:
  /// **'GOT IT'**
  String get gotIt;

  /// Free delivery label
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// Minutes abbreviation
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// Burger category
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get burger;

  /// Sandwich category
  ///
  /// In en, this message translates to:
  /// **'Sandwich'**
  String get sandwich;

  /// Pizza category
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get pizza;

  /// Taco category
  ///
  /// In en, this message translates to:
  /// **'Taco'**
  String get taco;

  /// My reviews screen title
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviews;

  /// Free delivery option
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get freeDelivery;

  /// Order number label
  ///
  /// In en, this message translates to:
  /// **'Order #{orderId}'**
  String orderNumber(String orderId);

  /// Estimated delivery time
  ///
  /// In en, this message translates to:
  /// **'Estimated delivery: {time}'**
  String estimatedDelivery(String time);

  /// Delivery person label
  ///
  /// In en, this message translates to:
  /// **'Delivery Person'**
  String get deliveryPerson;

  /// Reviews count
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String reviewsCount(int count);

  /// Deliveries count label
  ///
  /// In en, this message translates to:
  /// **'deliveries'**
  String get deliveries;

  /// Call connecting status
  ///
  /// In en, this message translates to:
  /// **'Connecting.......'**
  String get connecting;

  /// Message input placeholder
  ///
  /// In en, this message translates to:
  /// **'Write somethings'**
  String get writeSomething;

  /// Chat message
  ///
  /// In en, this message translates to:
  /// **'Are you coming?'**
  String get areYouComing;

  /// Chat message
  ///
  /// In en, this message translates to:
  /// **'Hay, Congratulation for order'**
  String get congratulationsForOrder;

  /// Chat message
  ///
  /// In en, this message translates to:
  /// **'Hey Where are you now?'**
  String get whereAreYouNow;

  /// Chat message
  ///
  /// In en, this message translates to:
  /// **'I\'m Coming , just wait ...'**
  String get imComingJustWait;

  /// Chat message
  ///
  /// In en, this message translates to:
  /// **'Hurry Up, Man'**
  String get hurryUpMan;

  /// Time label for just sent message
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// Greeting
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon!'**
  String get goodAfternoon;

  /// Greeting with name
  ///
  /// In en, this message translates to:
  /// **'Hey {name},'**
  String heyName(String name);

  /// Search bar placeholder
  ///
  /// In en, this message translates to:
  /// **'Search dishes, restaurants'**
  String get searchDishesRestaurants;

  /// See all link
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// Open restaurants section title
  ///
  /// In en, this message translates to:
  /// **'Open Restaurants'**
  String get openRestaurants;

  /// Location label
  ///
  /// In en, this message translates to:
  /// **'LOCATION'**
  String get location;

  /// Dashboard title
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Revenue label
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// Popular items label
  ///
  /// In en, this message translates to:
  /// **'Popular Items'**
  String get popularItems;

  /// Running orders label
  ///
  /// In en, this message translates to:
  /// **'Running Orders'**
  String get runningOrders;

  /// My food list label
  ///
  /// In en, this message translates to:
  /// **'My Food List'**
  String get myFoodList;

  /// Add new food label
  ///
  /// In en, this message translates to:
  /// **'Add New Food'**
  String get addNewFood;

  /// Seller profile label
  ///
  /// In en, this message translates to:
  /// **'Seller Profile'**
  String get sellerProfile;

  /// Seller notifications label
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get sellerNotifications;

  /// Seller reviews label
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get sellerReviews;

  /// Popular items this week label
  ///
  /// In en, this message translates to:
  /// **'Popular Items This Weeks'**
  String get popularItemsThisWeek;

  /// See all reviews link
  ///
  /// In en, this message translates to:
  /// **'See All Reviews'**
  String get seeAllReviews;

  /// See details link
  ///
  /// In en, this message translates to:
  /// **'See Details'**
  String get seeDetails;

  /// Daily time period
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// Total revenue label
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// Add new items title
  ///
  /// In en, this message translates to:
  /// **'Add New Items'**
  String get addNewItems;

  /// Item name label
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// Upload photo/video label
  ///
  /// In en, this message translates to:
  /// **'UPLOAD PHOTO/VIDEO'**
  String get uploadPhotoVideo;

  /// Price label
  ///
  /// In en, this message translates to:
  /// **'PRICE'**
  String get priceLabel;

  /// Details label
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Pickup option
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// Delivery option
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// Total items count
  ///
  /// In en, this message translates to:
  /// **'Total {count} Items'**
  String totalItems(int count);

  /// All category
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Breakfast category
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// Lunch category
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// Dinner category
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// Running orders count
  ///
  /// In en, this message translates to:
  /// **'{count} Running Orders'**
  String runningOrdersCount(int count);

  /// Withdrawal history menu item
  ///
  /// In en, this message translates to:
  /// **'Withdrawal History'**
  String get withdrawalHistory;

  /// Number of orders menu item
  ///
  /// In en, this message translates to:
  /// **'Number of Orders'**
  String get numberOfOrders;

  /// Log out menu item
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// Messages tab
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// Messages with count
  ///
  /// In en, this message translates to:
  /// **'Messages ({count})'**
  String messagesCount(int count);

  /// Notification action
  ///
  /// In en, this message translates to:
  /// **'Placed a new order'**
  String get placedNewOrder;

  /// Food details title
  ///
  /// In en, this message translates to:
  /// **'Food Details'**
  String get foodDetails;

  /// Withdraw success message
  ///
  /// In en, this message translates to:
  /// **'Withdraw Successful'**
  String get withdrawSuccessful;

  /// Starting price label
  ///
  /// In en, this message translates to:
  /// **'Starting'**
  String get starting;

  /// Cuisine types display
  ///
  /// In en, this message translates to:
  /// **'Burger - Chicken - Rich - Wings'**
  String get cuisineTypes;

  /// Popular category title
  ///
  /// In en, this message translates to:
  /// **'Popular {category}'**
  String popularCategory(String category);

  /// Login required message for reviews
  ///
  /// In en, this message translates to:
  /// **'Please login to submit a review'**
  String get pleaseLoginToSubmitReview;

  /// No chefs available error message
  ///
  /// In en, this message translates to:
  /// **'No chefs available. Please try again later.'**
  String get noChefsAvailable;

  /// Unable to find chef error message
  ///
  /// In en, this message translates to:
  /// **'Unable to find chef. Please try again later.'**
  String get unableToFindChef;

  /// Error submitting review message
  ///
  /// In en, this message translates to:
  /// **'Error submitting review: {error}'**
  String errorSubmittingReview(String error);

  /// Empty reviews state message
  ///
  /// In en, this message translates to:
  /// **'Your submitted reviews will appear here'**
  String get reviewsWillAppearHere;

  /// Error picking image message
  ///
  /// In en, this message translates to:
  /// **'Error picking image: {error}'**
  String errorPickingImage(String error);

  /// Image upload success message
  ///
  /// In en, this message translates to:
  /// **'Image uploaded successfully'**
  String get imageUploadedSuccessfully;

  /// Error uploading image message
  ///
  /// In en, this message translates to:
  /// **'Error uploading image: {error}'**
  String errorUploadingImage(String error);

  /// Failed to submit review error message
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review. Please try again.'**
  String get failedToSubmitReview;

  /// Empty reviews state message for sellers
  ///
  /// In en, this message translates to:
  /// **'Reviews from customers will appear here'**
  String get reviewsFromCustomersWillAppearHere;

  /// Older label for notifications
  ///
  /// In en, this message translates to:
  /// **'Older'**
  String get older;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
