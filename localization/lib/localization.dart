/// This is generated content. There is no point to change it by hands.

// ignore_for_file: type=lint

import 'dart:developer' show log;

import 'package:easiest_localization/easiest_localization.dart' show LocalizationProvider;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart' show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalMaterialLocalizations;
import 'package:intl/intl.dart' show Intl;

final RegExp _variableRegExp = RegExp(r'\$\{[^}]+\} ?');

typedef Checker<T> = bool Function(T value);

const String localizationPackageVersion = r'1.0.0';

const String? localizationVersion = null;

enum Gender {
  male,
  female,
  other,
}

class LocalizationMessages {
  LocalizationMessages({
    required this.appTitle,
    required this.appBarTitle,
    required this.deliveryTo,
    required this.locationCity,
    required this.retry,
    required this.continueShopping,
    required this.viewCart,
    required this.cancel,
    required this.signIn,
    required this.loginRequired,
    required this.loginRequiredToAccess,
    required this.loginToViewCart,
    required this.loginToViewProfile,
    required this.loginToSelectCity,
    required this.emailLabel,
    required this.passwordLabel,
    required this.signInButton,
    required this.forgetPassword,
    required this.createAccount,
    required this.dividerText,
    required this.signInWith,
    required this.validationEmailPasswordRequired,
    required this.googleSignInSuccess,
    required this.googleSignInFailed,
    required this.googleTokenError,
    required this.appleSignInSuccess,
    required this.appleSignInFailed,
    required this.appleTokenError,
    required this.loginFailed,
    required this.registrationFailed,
    required this.generalError,
    required this.formAllFieldRequired,
    required this.fieldRequired,
    required this.fieldsMarkedRequired,
    required this.forgetPasswordTitle,
    required this.forgetPasswordInstruction,
    required this.resetPasswordButton,
    required this.passwordResetLinkSent,
    required this.createAccountTitle,
    required this.createAccountButton,
    required this.nameLabel,
    required this.phoneLabel,
    required this.selectCountryLabel,
    required this.homeGiftsForEveryMoment,
    required this.homeExploreUniqueGiftIdeas,
    required this.homeChooseGiftsNow,
    required this.homeRoundedBeautyEndlessCharm,
    required this.homeStartTheYearWithTulips,
    required this.homeWoodntYouLoveThis,
    required this.homeAnExtraLuxuriousTouch,
    required this.homeBestSellers,
    required this.homeCaptivationAromasOfMubkhar,
    required this.homeGiftYourLovedOnes,
    required this.homeNaturesMagic,
    required this.homeLatestAndLoveliest,
    required this.homeGiftsForEveryone,
    required this.homeBrandsYoullLove,
    required this.bottomNavHome,
    required this.bottomNavExplore,
    required this.bottomNavCart,
    required this.bottomNavMyAccount,
    required this.exploreScreenTitle,
    required this.exploreSearchHint,
    required this.exploreCardMoments,
    required this.exploreCardRecipients,
    required this.exploreCategoryFlowersPlants,
    required this.exploreCategoryFlowersGifts,
    required this.exploreCategoryExpressDelivery,
    required this.exploreCategoryFloralSubscription,
    required this.exploreBrandsYoullLove,
    required this.discoverNewIdeasTitle,
    required this.discoverCardExpressDeliveryTitle,
    required this.discoverCardExpressDeliveryButton,
    required this.discoverCardWeeklySurpriseTitle,
    required this.discoverCardWeeklySurpriseButton,
    required this.momentsScreenTitle,
    required this.recipientsScreenTitle,
    required this.flowersPlanetsScreenTitle,
    required this.flowersGiftsScreenTitle,
    required this.searchPlaceholder,
    required this.searchButton,
    required this.filterTitle,
    required this.filterApply,
    required this.filterOccasion,
    required this.filterRecipient,
    required this.filterColor,
    required this.filterBundleType,
    required this.filterClear,
    required this.filterClose,
    required this.gotIt,
    required this.filterButton,
    required this.showingProductsCount,
    required this.viewGrid,
    required this.viewList,
    required this.allChip,
    required this.categoryFilterTitle,
    required this.occasionFilterTitle,
    required this.recipientFilterTitle,
    required this.colorFilterTitle,
    required this.showProductsPart1,
    required this.showProductsPart2,
    required this.filtersTitle,
    required this.addToCart,
    required this.noAddressHassle,
    required this.collectAddressText,
    required this.descriptionHeader,
    required this.descriptionTab,
    required this.careTipsTab,
    required this.seeMore,
    required this.seeLess,
    required this.allPricesIncludeTax,
    required this.payWith,
    required this.productDetailsTitle,
    required this.wardayaPoints,
    required this.currencySar,
    required this.splitPaymentsWithTamara,
    required this.earn,
    required this.similarProducts,
    required this.noSimilarProducts,
    required this.cartEmptyTitle,
    required this.cartEmptySubtitle,
    required this.startShoppingButton,
    required this.cartTitle,
    required this.proceedToPayment,
    required this.freeDeliveryUnlocked,
    required this.giftCardMessage,
    required this.selectGiftCard,
    required this.addMessage,
    required this.customizeButton,
    required this.makeItPerfect,
    required this.recommendedTab,
    required this.flowersAddOnTab,
    required this.stickersTab,
    required this.productPrice,
    required this.productTitle,
    required this.toLabel,
    required this.fromLabel,
    required this.optionalHint,
    required this.suggestedMessagesPromptPart1,
    required this.suggestedMessagesPromptPart2,
    required this.signatureButton,
    required this.qrCodeLabel,
    required this.recordVideoButton,
    required this.orLabel,
    required this.pasteLinkButton,
    required this.messageHint,
    required this.charactersLeft,
    required this.removeTooltip,
    required this.signatureRemove,
    required this.linkRemove,
    required this.handwrittenStyle,
    required this.typedStyle,
    required this.charactersLimit,
    required this.typingStyleLabel,
    required this.handwritingOption,
    required this.typedOption,
    required this.addMediaTitle,
    required this.mediaIntroText,
    required this.howItWorks,
    required this.pasteLinkInstruction,
    required this.recordVideoInstruction,
    required this.qrCodeNote,
    required this.freeLabel,
    required this.pasteLinkHint,
    required this.addToMessageButton,
    required this.startRecordingButton,
    required this.recordVideoTab,
    required this.pasteLinkTab,
    required this.noCardSelected,
    required this.frontSideLabel,
    required this.backSideLabel,
    required this.qrQuestion,
    required this.qrInstruction,
    required this.signatureTitle,
    required this.drawInstruction,
    required this.clearButton,
    required this.saveButton,
    required this.customizeGiftCard,
    required this.selectCard,
    required this.preview,
    required this.saveAndContinue,
    required this.profileScreenTitle,
    required this.viewEditProfile,
    required this.myOrders,
    required this.mySubscriptions,
    required this.invoices,
    required this.savedAddresses,
    required this.occasions,
    required this.favouriteGifts,
    required this.wardayaWallet,
    required this.customerCare,
    required this.language,
    required this.faq,
    required this.termsConditions,
    required this.customerCareTitle,
    required this.phoneCall,
    required this.whatsapp,
    required this.arabic,
    required this.english,
    required this.logout,
    required this.deleteAccount,
    required this.deleteAccountConfirmation,
    required this.confirm,
    required this.editProfileTitle,
    required this.saveChangesButton,
    required this.firstNameLabel,
    required this.lastNameLabel,
    required this.fullNameLabel,
    required this.phoneNumberLabel,
    required this.emailAddressLabel,
    required this.changePasswordButton,
    required this.changePasswordTitle,
    required this.birthdayLabel,
    required this.mySubscriptionsTitle,
    required this.wardayaSubscriptions,
    required this.subscriptionDescription,
    required this.subscriptionHowItWorks,
    required this.subscriptionSelectYourPlan,
    required this.subscriptionChooseWhatFitsYourNeeds,
    required this.subscriptionCustomizeDelivery,
    required this.subscriptionSetDeliveryFrequencyAndPayment,
    required this.subscriptionEnjoyFreshFlowers,
    required this.subscriptionReceiveFreshFlowersEveryTime,
    required this.subscriptionPlans,
    required this.subscriptionStartingFrom,
    required this.subscriptionButton,
    required this.more,
    required this.less,
    required this.startingFrom,
    required this.perDelivery,
    required this.subscriptionDurationTitle,
    required this.deliveryFrequency,
    required this.onceAWeek,
    required this.everyTwoWeeks,
    required this.onceAMonth,
    required this.subscriptionDuration,
    required this.deliveries,
    required this.total,
    required this.startingDate,
    required this.selectOtherDate,
    required this.weSelectDeleveryBasedArea,
    required this.off,
    required this.perDelivery1,
    required this.favoritesScreenTitle,
    required this.favoritesEmptyTitle,
    required this.favoritesEmptyButton,
    required this.subMenuItemsScreenTitle,
    required this.subMenuItemsEmptyTitle,
    required this.addressesScreenTitle,
    required this.addressesScreenAddNewAddressButton,
    required this.addressesScreenNoAddressesFound,
    required this.addressSavedSuccessfully,
    required this.addressUpdatedSuccessfully,
    required this.addressDeletedSuccessfully,
    required this.fillRequiredFields,
    required this.dropAddressFromMap,
    required this.enterAddressDetails,
    required this.enterPhoneNumber,
    required this.enterRecipientName,
    required this.defaultAddressTitle,
    required this.defaultAddressWithArea,
    required this.addressLabelHint,
    required this.extraAddressLabelHint,
    required this.recipientDetailsScreenTitle,
    required this.recipientDetailsScreenContinueButton,
    required this.recipientDetailsScreenRecipientNameLabel,
    required this.recipientDetailsScreenRecipientPhoneLabel,
    required this.recipientDetailsScreenRecipientAreaLabel,
    required this.recipientDetailsScreenRecipientAddressLabel,
    required this.recipientDetailsScreenRecipientExtraAddressLabel,
    required this.orderNumber,
    required this.date,
    required this.orderId,
    required this.orderStatus,
    required this.deliveryInfo,
    required this.recipientName,
    required this.phoneNumber,
    required this.address,
    required this.estimatedDeliveryTime,
    required this.myIdentity,
    required this.expressDelivery,
    required this.hidden,
    required this.visible,
    required this.yes,
    required this.no,
    required this.quantity,
    required this.noOrders,
    required this.recipient,
    required this.deliveryDate,
    required this.paymentDetails,
    required this.subtotal,
    required this.deliveryCharges,
    required this.vatLabel,
    required this.paymentMethod,
    required this.searchOrderPlaceholder,
    required this.paymentTitle,
    required this.cancelPaymentTitle,
    required this.cancelPaymentMessage,
    required this.cancelPaymentNo,
    required this.cancelPaymentYes,
    required this.paymentAmountTitle,
    required this.paymentOrderIdLabel,
    required this.paymentError,
    required this.paymentTryAgain,
    required this.paymentSuccessTitle,
    required this.paymentSuccessMessage,
    required this.paymentFailedTitle,
    required this.paymentFailedMessage,
    required this.paymentOkButton,
    required this.paymentMethodsTitle,
    required this.proceedToPaymentButton,
    required this.creditDebitCardTitle,
    required this.creditDebitCardDescription,
    required this.madaTitle,
    required this.madaDescription,
    required this.applePayTitle,
    required this.applePayDescription,
    required this.googlePayTitle,
    required this.googlePayDescription,
    required this.benefitPayTitle,
    required this.benefitPayDescription,
    required this.selectCityTitle,
    required this.sAfilter,
    required this.sendYourGiftTo,
    required this.myOccasions,
    required this.quickAdd,
    required this.selectAnOccasionToCreateAreminder,
    required this.yourUpcomingOccasion,
    required this.noUpcomingOccasions,
    required this.noOccasionsAvailable,
    required this.edit,
    required this.delete,
    required this.loading,
    required this.deleteOccasionTitle,
    required this.deleteOccasionConfirm,
    required this.deleteButton,
    required this.cancelButton,
    required this.errorText,
    required this.selectDeliveryDate,
    required this.invoiceTitle,
    required this.noInvoicesTitle,
    required this.noInvoicesSubtitle,
    required this.invoiceDetails,
    required this.subscriptionCheckoutTitle,
    required this.recipientDetailsTitle,
    required this.paymentMethodTitle,
    required this.paymentDetailsTitle,
    required this.proceedToPaymentButton1,
    required this.useSavedAddresses,
    required this.recipientNameLabel,
    required this.recipientNameHint,
    required this.recipientPhoneLabel,
    required this.deliveryAddressLabel,
    required this.askRecipientForAddress,
    required this.enterRecipientAddress,
    required this.selectSavedAddress,
    required this.noSavedAddresses,
    required this.addNewAddress,
    required this.tryAgain,
    required this.errorLoadingAddresses,
    required this.creditCard,
    required this.mada,
    required this.googlePay,
    required this.applePay,
    required this.stcPay,
    required this.firstDeliveryPaymentDetails,
    required this.subtotalLabel,
    required this.deliveryChargesLabel,
    required this.totalVatIncluded,
    required this.totalVatIncludedLabel,
    required this.nextPaymentLabel,
    required this.pleaseFillFields,
    required this.selectLocation,
    required this.searchForLocation,
    required this.dragMapToAdjustLocation,
    required this.selectedLocation,
    required this.confirmLocation,
    required this.locationServicesDisabled,
    required this.locationPermissionsDenied,
    required this.locationPermissionsPermanentlyDenied,
    required this.currentLocationPinned,
    required this.couldNotGetCurrentLocation,
    required this.voucherCode,
    required this.addVoucherCode,
    required this.validatingPromoCode,
    required this.promoCodeApplied,
    required this.discount,
    required this.invalidPromoCode,
    required this.pleaseEnterVoucherCode,
    required this.applied,
    required this.apply,
    required this.startTypingToSearch,
    required this.toBeProvidedByRecipient,
    required this.tomorrow,
    required this.editOccasion,
    required this.remindMeAbout,
    required this.updateOccasionDetails,
    required this.occasionDetailsPrompt,
    required this.nameLabel1,
    required this.dateLabel,
    required this.pleaseEnterName,
    required this.updateOccasionButton,
    required this.createOccasionButton,
    required this.errorPrefix,
    required this.deleteMyAccount,
    required this.deliveryFrequency1,
    required this.subscriptionDuration1,
  });
  factory LocalizationMessages.fromJson(Map<String, dynamic> json) {
    return LocalizationMessages(
      appTitle: (json['app_title'] ?? '').toString(),
      appBarTitle: (json['app_bar_title'] ?? '').toString(),
      deliveryTo: (json['delivery_to'] ?? '').toString(),
      locationCity: (json['location_city'] ?? '').toString(),
      retry: (json['retry'] ?? '').toString(),
      continueShopping: (json['continue_shopping'] ?? '').toString(),
      viewCart: (json['view_cart'] ?? '').toString(),
      cancel: (json['cancel'] ?? '').toString(),
      signIn: (json['sign_in'] ?? '').toString(),
      loginRequired: (json['loginRequired'] ?? '').toString(),
      loginRequiredToAccess: (json['loginRequiredToAccess'] ?? '').toString(),
      loginToViewCart: (json['loginToViewCart'] ?? '').toString(),
      loginToViewProfile: (json['loginToViewProfile'] ?? '').toString(),
      loginToSelectCity: (json['loginToSelectCity'] ?? '').toString(),
      emailLabel: (json['email_label'] ?? '').toString(),
      passwordLabel: (json['password_label'] ?? '').toString(),
      signInButton: (json['sign_in_button'] ?? '').toString(),
      forgetPassword: (json['forget_password'] ?? '').toString(),
      createAccount: (json['create_account'] ?? '').toString(),
      dividerText: (json['divider_text'] ?? '').toString(),
      signInWith: (json['sign_in_with'] ?? '').toString(),
      validationEmailPasswordRequired: (json['validation_email_password_required'] ?? '').toString(),
      googleSignInSuccess: (json['google_sign_in_success'] ?? '').toString(),
      googleSignInFailed: (json['google_sign_in_failed'] ?? '').toString(),
      googleTokenError: (json['google_token_error'] ?? '').toString(),
      appleSignInSuccess: (json['apple_sign_in_success'] ?? '').toString(),
      appleSignInFailed: (json['apple_sign_in_failed'] ?? '').toString(),
      appleTokenError: (json['apple_token_error'] ?? '').toString(),
      loginFailed: (json['login_failed'] ?? '').toString(),
      registrationFailed: (json['registration_failed'] ?? '').toString(),
      generalError: (json['general_error'] ?? '').toString(),
      formAllFieldRequired: (json['form_all_field_required'] ?? '').toString(),
      fieldRequired: (json['field_required'] ?? '').toString(),
      fieldsMarkedRequired: (json['fields_marked_required'] ?? '').toString(),
      forgetPasswordTitle: (json['forget_password_title'] ?? '').toString(),
      forgetPasswordInstruction: (json['forget_password_instruction'] ?? '').toString(),
      resetPasswordButton: (json['reset_password_button'] ?? '').toString(),
      passwordResetLinkSent: (json['password_reset_link_sent'] ?? '').toString(),
      createAccountTitle: (json['create_account_title'] ?? '').toString(),
      createAccountButton: (json['create_account_button'] ?? '').toString(),
      nameLabel: (json['name_label'] ?? '').toString(),
      phoneLabel: (json['phone_label'] ?? '').toString(),
      selectCountryLabel: (json['select_country_label'] ?? '').toString(),
      homeGiftsForEveryMoment: (json['home_gifts_for_every_moment'] ?? '').toString(),
      homeExploreUniqueGiftIdeas: (json['home_explore_unique_gift_ideas'] ?? '').toString(),
      homeChooseGiftsNow: (json['home_choose_gifts_now'] ?? '').toString(),
      homeRoundedBeautyEndlessCharm: (json['home_rounded_beauty_endless_charm'] ?? '').toString(),
      homeStartTheYearWithTulips: (json['home_start_the_year_with_tulips'] ?? '').toString(),
      homeWoodntYouLoveThis: (json['home_woodnt_you_love_this'] ?? '').toString(),
      homeAnExtraLuxuriousTouch: (json['home_an_extra_luxurious_touch'] ?? '').toString(),
      homeBestSellers: (json['home_best_sellers'] ?? '').toString(),
      homeCaptivationAromasOfMubkhar: (json['home_captivation_aromas_of_mubkhar'] ?? '').toString(),
      homeGiftYourLovedOnes: (json['home_gift_your_loved_ones'] ?? '').toString(),
      homeNaturesMagic: (json['home_natures_magic'] ?? '').toString(),
      homeLatestAndLoveliest: (json['home_latest_and_loveliest'] ?? '').toString(),
      homeGiftsForEveryone: (json['home_gifts_for_everyone'] ?? '').toString(),
      homeBrandsYoullLove: (json['home_brands_youll_love'] ?? '').toString(),
      bottomNavHome: (json['bottom_nav_home'] ?? '').toString(),
      bottomNavExplore: (json['bottom_nav_explore'] ?? '').toString(),
      bottomNavCart: (json['bottom_nav_cart'] ?? '').toString(),
      bottomNavMyAccount: (json['bottom_nav_my_account'] ?? '').toString(),
      exploreScreenTitle: (json['explore_screen_title'] ?? '').toString(),
      exploreSearchHint: (json['explore_search_hint'] ?? '').toString(),
      exploreCardMoments: (json['explore_card_moments'] ?? '').toString(),
      exploreCardRecipients: (json['explore_card_recipients'] ?? '').toString(),
      exploreCategoryFlowersPlants: (json['explore_category_flowers_plants'] ?? '').toString(),
      exploreCategoryFlowersGifts: (json['explore_category_flowers_gifts'] ?? '').toString(),
      exploreCategoryExpressDelivery: (json['explore_category_express_delivery'] ?? '').toString(),
      exploreCategoryFloralSubscription: (json['explore_category_floral_subscription'] ?? '').toString(),
      exploreBrandsYoullLove: (json['explore_brands_youll_love'] ?? '').toString(),
      discoverNewIdeasTitle: (json['discover_new_ideas_title'] ?? '').toString(),
      discoverCardExpressDeliveryTitle: (json['discover_card_express_delivery_title'] ?? '').toString(),
      discoverCardExpressDeliveryButton: (json['discover_card_express_delivery_button'] ?? '').toString(),
      discoverCardWeeklySurpriseTitle: (json['discover_card_weekly_surprise_title'] ?? '').toString(),
      discoverCardWeeklySurpriseButton: (json['discover_card_weekly_surprise_button'] ?? '').toString(),
      momentsScreenTitle: (json['moments_screen_title'] ?? '').toString(),
      recipientsScreenTitle: (json['recipients_screen_title'] ?? '').toString(),
      flowersPlanetsScreenTitle: (json['flowers_planets_screen_title'] ?? '').toString(),
      flowersGiftsScreenTitle: (json['flowers_gifts_screen_title'] ?? '').toString(),
      searchPlaceholder: (json['search_placeholder'] ?? '').toString(),
      searchButton: (json['search_button'] ?? '').toString(),
      filterTitle: (json['filter_title'] ?? '').toString(),
      filterApply: (json['filter_apply'] ?? '').toString(),
      filterOccasion: (json['filter_occasion'] ?? '').toString(),
      filterRecipient: (json['filter_recipient'] ?? '').toString(),
      filterColor: (json['filter_color'] ?? '').toString(),
      filterBundleType: (json['filter_bundle_type'] ?? '').toString(),
      filterClear: (json['filter_clear'] ?? '').toString(),
      filterClose: (json['filter_close'] ?? '').toString(),
      gotIt: (json['got_it'] ?? '').toString(),
      filterButton: (json['filter_button'] ?? '').toString(),
      showingProductsCount: (json['showing_products_count'] ?? '').toString(),
      viewGrid: (json['view_grid'] ?? '').toString(),
      viewList: (json['view_list'] ?? '').toString(),
      allChip: (json['all_chip'] ?? '').toString(),
      categoryFilterTitle: (json['category_filter_title'] ?? '').toString(),
      occasionFilterTitle: (json['occasion_filter_title'] ?? '').toString(),
      recipientFilterTitle: (json['recipient_filter_title'] ?? '').toString(),
      colorFilterTitle: (json['color_filter_title'] ?? '').toString(),
      showProductsPart1: (json['show_products_part1'] ?? '').toString(),
      showProductsPart2: (json['show_products_part2'] ?? '').toString(),
      filtersTitle: (json['filters_title'] ?? '').toString(),
      addToCart: (json['add_to_cart'] ?? '').toString(),
      noAddressHassle: (json['no_address_hassle'] ?? '').toString(),
      collectAddressText: (json['collect_address_text'] ?? '').toString(),
      descriptionHeader: (json['description_header'] ?? '').toString(),
      descriptionTab: (json['description_tab'] ?? '').toString(),
      careTipsTab: (json['care_tips_tab'] ?? '').toString(),
      seeMore: (json['see_more'] ?? '').toString(),
      seeLess: (json['see_less'] ?? '').toString(),
      allPricesIncludeTax: (json['all_prices_include_tax'] ?? '').toString(),
      payWith: (json['pay_with'] ?? '').toString(),
      productDetailsTitle: (json['product_details_title'] ?? '').toString(),
      wardayaPoints: (json['wardaya_points'] ?? '').toString(),
      currencySar: (json['currency_sar'] ?? '').toString(),
      splitPaymentsWithTamara: (json['split_payments_with_tamara'] ?? '').toString(),
      earn: (json['earn'] ?? '').toString(),
      similarProducts: (json['similarProducts'] ?? '').toString(),
      noSimilarProducts: (json['noSimilarProducts'] ?? '').toString(),
      cartEmptyTitle: (json['cart_empty_title'] ?? '').toString(),
      cartEmptySubtitle: (json['cart_empty_subtitle'] ?? '').toString(),
      startShoppingButton: (json['start_shopping_button'] ?? '').toString(),
      cartTitle: (json['cart_title'] ?? '').toString(),
      proceedToPayment: (json['proceed_to_payment'] ?? '').toString(),
      freeDeliveryUnlocked: (json['free_delivery_unlocked'] ?? '').toString(),
      giftCardMessage: (json['gift_card_message'] ?? '').toString(),
      selectGiftCard: (json['select_gift_card'] ?? '').toString(),
      addMessage: (json['add_message'] ?? '').toString(),
      customizeButton: (json['customize_button'] ?? '').toString(),
      makeItPerfect: (json['make_it_perfect'] ?? '').toString(),
      recommendedTab: (json['recommended_tab'] ?? '').toString(),
      flowersAddOnTab: (json['flowers_add_on_tab'] ?? '').toString(),
      stickersTab: (json['stickers_tab'] ?? '').toString(),
      productPrice: (json['product_price'] ?? '').toString(),
      productTitle: (json['product_title'] ?? '').toString(),
      toLabel: (json['to_label'] ?? '').toString(),
      fromLabel: (json['from_label'] ?? '').toString(),
      optionalHint: (json['optional_hint'] ?? '').toString(),
      suggestedMessagesPromptPart1: (json['suggested_messages_prompt_part1'] ?? '').toString(),
      suggestedMessagesPromptPart2: (json['suggested_messages_prompt_part2'] ?? '').toString(),
      signatureButton: (json['signature_button'] ?? '').toString(),
      qrCodeLabel: (json['qr_code_label'] ?? '').toString(),
      recordVideoButton: (json['record_video_button'] ?? '').toString(),
      orLabel: (json['or_label'] ?? '').toString(),
      pasteLinkButton: (json['paste_link_button'] ?? '').toString(),
      messageHint: (json['message_hint'] ?? '').toString(),
      charactersLeft: (json['characters_left'] ?? '').toString(),
      removeTooltip: (json['remove_tooltip'] ?? '').toString(),
      signatureRemove: (json['signature_remove'] ?? '').toString(),
      linkRemove: (json['link_remove'] ?? '').toString(),
      handwrittenStyle: (json['handwritten_style'] ?? '').toString(),
      typedStyle: (json['typed_style'] ?? '').toString(),
      charactersLimit: (json['characters_limit'] ?? '').toString(),
      typingStyleLabel: (json['typing_style_label'] ?? '').toString(),
      handwritingOption: (json['handwriting_option'] ?? '').toString(),
      typedOption: (json['typed_option'] ?? '').toString(),
      addMediaTitle: (json['add_media_title'] ?? '').toString(),
      mediaIntroText: (json['media_intro_text'] ?? '').toString(),
      howItWorks: (json['how_it_works'] ?? '').toString(),
      pasteLinkInstruction: (json['paste_link_instruction'] ?? '').toString(),
      recordVideoInstruction: (json['record_video_instruction'] ?? '').toString(),
      qrCodeNote: (json['qr_code_note'] ?? '').toString(),
      freeLabel: (json['free_label'] ?? '').toString(),
      pasteLinkHint: (json['paste_link_hint'] ?? '').toString(),
      addToMessageButton: (json['add_to_message_button'] ?? '').toString(),
      startRecordingButton: (json['start_recording_button'] ?? '').toString(),
      recordVideoTab: (json['record_video_tab'] ?? '').toString(),
      pasteLinkTab: (json['paste_link_tab'] ?? '').toString(),
      noCardSelected: (json['no_card_selected'] ?? '').toString(),
      frontSideLabel: (json['front_side_label'] ?? '').toString(),
      backSideLabel: (json['back_side_label'] ?? '').toString(),
      qrQuestion: (json['qr_question'] ?? '').toString(),
      qrInstruction: (json['qr_instruction'] ?? '').toString(),
      signatureTitle: (json['signature_title'] ?? '').toString(),
      drawInstruction: (json['draw_instruction'] ?? '').toString(),
      clearButton: (json['clear_button'] ?? '').toString(),
      saveButton: (json['save_button'] ?? '').toString(),
      customizeGiftCard: (json['customize_gift_card'] ?? '').toString(),
      selectCard: (json['select_card'] ?? '').toString(),
      preview: (json['preview'] ?? '').toString(),
      saveAndContinue: (json['save_and_continue'] ?? '').toString(),
      profileScreenTitle: (json['profile_screen_title'] ?? '').toString(),
      viewEditProfile: (json['view_edit_profile'] ?? '').toString(),
      myOrders: (json['my_orders'] ?? '').toString(),
      mySubscriptions: (json['my_subscriptions'] ?? '').toString(),
      invoices: (json['invoices'] ?? '').toString(),
      savedAddresses: (json['saved_addresses'] ?? '').toString(),
      occasions: (json['occasions'] ?? '').toString(),
      favouriteGifts: (json['favourite_gifts'] ?? '').toString(),
      wardayaWallet: (json['wardaya_wallet'] ?? '').toString(),
      customerCare: (json['customer_care'] ?? '').toString(),
      language: (json['language'] ?? '').toString(),
      faq: (json['faq'] ?? '').toString(),
      termsConditions: (json['terms_conditions'] ?? '').toString(),
      customerCareTitle: (json['customer_care_title'] ?? '').toString(),
      phoneCall: (json['phone_call'] ?? '').toString(),
      whatsapp: (json['whatsapp'] ?? '').toString(),
      arabic: (json['arabic'] ?? '').toString(),
      english: (json['english'] ?? '').toString(),
      logout: (json['logout'] ?? '').toString(),
      deleteAccount: (json['delete_account'] ?? '').toString(),
      deleteAccountConfirmation: (json['delete_account_confirmation'] ?? '').toString(),
      confirm: (json['confirm'] ?? '').toString(),
      editProfileTitle: (json['edit_profile_title'] ?? '').toString(),
      saveChangesButton: (json['save_changes_button'] ?? '').toString(),
      firstNameLabel: (json['first_name_label'] ?? '').toString(),
      lastNameLabel: (json['last_name_label'] ?? '').toString(),
      fullNameLabel: (json['full_name_label'] ?? '').toString(),
      phoneNumberLabel: (json['phone_number_label'] ?? '').toString(),
      emailAddressLabel: (json['email_address_label'] ?? '').toString(),
      changePasswordButton: (json['change_password_button'] ?? '').toString(),
      changePasswordTitle: (json['change_password_title'] ?? '').toString(),
      birthdayLabel: (json['birthday_label'] ?? '').toString(),
      mySubscriptionsTitle: (json['my_subscriptions_title'] ?? '').toString(),
      wardayaSubscriptions: (json['wardaya_subscriptions'] ?? '').toString(),
      subscriptionDescription: (json['subscription_description'] ?? '').toString(),
      subscriptionHowItWorks: (json['subscription_how_it_works'] ?? '').toString(),
      subscriptionSelectYourPlan: (json['subscription_select_your_plan'] ?? '').toString(),
      subscriptionChooseWhatFitsYourNeeds: (json['subscription_choose_what_fits_your_needs'] ?? '').toString(),
      subscriptionCustomizeDelivery: (json['subscription_customize_delivery'] ?? '').toString(),
      subscriptionSetDeliveryFrequencyAndPayment:
          (json['subscription_set_delivery_frequency_and_payment'] ?? '').toString(),
      subscriptionEnjoyFreshFlowers: (json['subscription_enjoy_fresh_flowers'] ?? '').toString(),
      subscriptionReceiveFreshFlowersEveryTime:
          (json['subscription_receive_fresh_flowers_every_time'] ?? '').toString(),
      subscriptionPlans: (json['subscription_plans'] ?? '').toString(),
      subscriptionStartingFrom: (json['subscription_starting_from'] ?? '').toString(),
      subscriptionButton: (json['subscription_button'] ?? '').toString(),
      more: (json['more'] ?? '').toString(),
      less: (json['less'] ?? '').toString(),
      startingFrom: (json['starting_from'] ?? '').toString(),
      perDelivery: (json['per_delivery'] ?? '').toString(),
      subscriptionDurationTitle: (json['subscription_duration_title'] ?? '').toString(),
      deliveryFrequency: (json['deliveryـfrequency'] ?? '').toString(),
      onceAWeek: (json['once_a_week'] ?? '').toString(),
      everyTwoWeeks: (json['every_two_weeks'] ?? '').toString(),
      onceAMonth: (json['once_a_month'] ?? '').toString(),
      subscriptionDuration: (json['subscriptionـduration'] ?? '').toString(),
      deliveries: (json['deliveries'] ?? '').toString(),
      total: (json['total'] ?? '').toString(),
      startingDate: (json['starting_date'] ?? '').toString(),
      selectOtherDate: (json['select_other_date'] ?? '').toString(),
      weSelectDeleveryBasedArea: (json['we_select_delevery_based_area'] ?? '').toString(),
      off: (json['off'] ?? '').toString(),
      perDelivery1: (json['perـdelivery'] ?? '').toString(),
      favoritesScreenTitle: (json['favorites_screen_title'] ?? '').toString(),
      favoritesEmptyTitle: (json['favorites_empty_title'] ?? '').toString(),
      favoritesEmptyButton: (json['favorites_empty_button'] ?? '').toString(),
      subMenuItemsScreenTitle: (json['sub_menu_items_screen_title'] ?? '').toString(),
      subMenuItemsEmptyTitle: (json['sub_menu_items_empty_title'] ?? '').toString(),
      addressesScreenTitle: (json['addresses_screen_title'] ?? '').toString(),
      addressesScreenAddNewAddressButton: (json['addresses_screen_add_new_address_button'] ?? '').toString(),
      addressesScreenNoAddressesFound: (json['addresses_screen_no_addresses_found'] ?? '').toString(),
      addressSavedSuccessfully: (json['address_saved_successfully'] ?? '').toString(),
      addressUpdatedSuccessfully: (json['address_updated_successfully'] ?? '').toString(),
      addressDeletedSuccessfully: (json['address_deleted_successfully'] ?? '').toString(),
      fillRequiredFields: (json['fill_required_fields'] ?? '').toString(),
      dropAddressFromMap: (json['drop_address_from_map'] ?? '').toString(),
      enterAddressDetails: (json['enter_address_details'] ?? '').toString(),
      enterPhoneNumber: (json['enter_phone_number'] ?? '').toString(),
      enterRecipientName: (json['enter_recipient_name'] ?? '').toString(),
      defaultAddressTitle: (json['default_address_title'] ?? '').toString(),
      defaultAddressWithArea: (json['default_address_with_area'] ?? '').toString(),
      addressLabelHint: (json['address_label_hint'] ?? '').toString(),
      extraAddressLabelHint: (json['extra_address_label_hint'] ?? '').toString(),
      recipientDetailsScreenTitle: (json['recipient_details_screen_title'] ?? '').toString(),
      recipientDetailsScreenContinueButton: (json['recipient_details_screen_continue_button'] ?? '').toString(),
      recipientDetailsScreenRecipientNameLabel:
          (json['recipient_details_screen_recipient_name_label'] ?? '').toString(),
      recipientDetailsScreenRecipientPhoneLabel:
          (json['recipient_details_screen_recipient_phone_label'] ?? '').toString(),
      recipientDetailsScreenRecipientAreaLabel:
          (json['recipient_details_screen_recipient_area_label'] ?? '').toString(),
      recipientDetailsScreenRecipientAddressLabel:
          (json['recipient_details_screen_recipient_address_label'] ?? '').toString(),
      recipientDetailsScreenRecipientExtraAddressLabel:
          (json['recipient_details_screen_recipient_extra_address_label'] ?? '').toString(),
      orderNumber: (json['orderNumber'] ?? '').toString(),
      date: (json['date'] ?? '').toString(),
      orderId: (json['orderId'] ?? '').toString(),
      orderStatus: (json['orderStatus'] ?? '').toString(),
      deliveryInfo: (json['deliveryInfo'] ?? '').toString(),
      recipientName: (json['recipientName'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      estimatedDeliveryTime: (json['estimatedDeliveryTime'] ?? '').toString(),
      myIdentity: (json['myIdentity'] ?? '').toString(),
      expressDelivery: (json['expressDelivery'] ?? '').toString(),
      hidden: (json['hidden'] ?? '').toString(),
      visible: (json['visible'] ?? '').toString(),
      yes: (json['yes'] ?? '').toString(),
      no: (json['no'] ?? '').toString(),
      quantity: (json['quantity'] ?? '').toString(),
      noOrders: (json['noOrders'] ?? '').toString(),
      recipient: (json['recipient'] ?? '').toString(),
      deliveryDate: (json['deliveryDate'] ?? '').toString(),
      paymentDetails: (json['paymentDetails'] ?? '').toString(),
      subtotal: (json['subtotal'] ?? '').toString(),
      deliveryCharges: (json['deliveryCharges'] ?? '').toString(),
      vatLabel: (json['vatLabel'] ?? '').toString(),
      paymentMethod: (json['paymentMethod'] ?? '').toString(),
      searchOrderPlaceholder: (json['search_order_placeholder'] ?? '').toString(),
      paymentTitle: (json['paymentTitle'] ?? '').toString(),
      cancelPaymentTitle: (json['cancelPaymentTitle'] ?? '').toString(),
      cancelPaymentMessage: (json['cancelPaymentMessage'] ?? '').toString(),
      cancelPaymentNo: (json['cancelPaymentNo'] ?? '').toString(),
      cancelPaymentYes: (json['cancelPaymentYes'] ?? '').toString(),
      paymentAmountTitle: (json['paymentAmountTitle'] ?? '').toString(),
      paymentOrderIdLabel: (json['paymentOrderIdLabel'] ?? '').toString(),
      paymentError: (json['paymentError'] ?? '').toString(),
      paymentTryAgain: (json['paymentTryAgain'] ?? '').toString(),
      paymentSuccessTitle: (json['paymentSuccessTitle'] ?? '').toString(),
      paymentSuccessMessage: (json['paymentSuccessMessage'] ?? '').toString(),
      paymentFailedTitle: (json['paymentFailedTitle'] ?? '').toString(),
      paymentFailedMessage: (json['paymentFailedMessage'] ?? '').toString(),
      paymentOkButton: (json['paymentOkButton'] ?? '').toString(),
      paymentMethodsTitle: (json['paymentMethodsTitle'] ?? '').toString(),
      proceedToPaymentButton: (json['proceedToPaymentButton'] ?? '').toString(),
      creditDebitCardTitle: (json['creditDebitCardTitle'] ?? '').toString(),
      creditDebitCardDescription: (json['creditDebitCardDescription'] ?? '').toString(),
      madaTitle: (json['madaTitle'] ?? '').toString(),
      madaDescription: (json['madaDescription'] ?? '').toString(),
      applePayTitle: (json['applePayTitle'] ?? '').toString(),
      applePayDescription: (json['applePayDescription'] ?? '').toString(),
      googlePayTitle: (json['googlePayTitle'] ?? '').toString(),
      googlePayDescription: (json['googlePayDescription'] ?? '').toString(),
      benefitPayTitle: (json['benefitPayTitle'] ?? '').toString(),
      benefitPayDescription: (json['benefitPayDescription'] ?? '').toString(),
      selectCityTitle: (json['selectCityTitle'] ?? '').toString(),
      sAfilter: (json['sAFilter'] ?? '').toString(),
      sendYourGiftTo: (json['SendYourGiftTo'] ?? '').toString(),
      myOccasions: (json['myOccasions'] ?? '').toString(),
      quickAdd: (json['quickAdd'] ?? '').toString(),
      selectAnOccasionToCreateAreminder: (json['selectAnOccasionToCreateAReminder'] ?? '').toString(),
      yourUpcomingOccasion: (json['yourUpcomingOccasion'] ?? '').toString(),
      noUpcomingOccasions: (json['noUpcomingOccasions'] ?? '').toString(),
      noOccasionsAvailable: (json['noOccasionsAvailable'] ?? '').toString(),
      edit: (json['edit'] ?? '').toString(),
      delete: (json['delete'] ?? '').toString(),
      loading: (json['loading'] ?? '').toString(),
      deleteOccasionTitle: (json['deleteOccasionTitle'] ?? '').toString(),
      deleteOccasionConfirm: (json['deleteOccasionConfirm'] ?? '').toString(),
      deleteButton: (json['deleteButton'] ?? '').toString(),
      cancelButton: (json['cancelButton'] ?? '').toString(),
      errorText: (json['errorText'] ?? '').toString(),
      selectDeliveryDate: (json['selectDeliveryDate'] ?? '').toString(),
      invoiceTitle: (json['invoiceTitle'] ?? '').toString(),
      noInvoicesTitle: (json['noInvoicesTitle'] ?? '').toString(),
      noInvoicesSubtitle: (json['noInvoicesSubtitle'] ?? '').toString(),
      invoiceDetails: (json['invoiceDetails'] ?? '').toString(),
      subscriptionCheckoutTitle: (json['subscription_checkout_title'] ?? '').toString(),
      recipientDetailsTitle: (json['recipient_details_title'] ?? '').toString(),
      paymentMethodTitle: (json['payment_method_title'] ?? '').toString(),
      paymentDetailsTitle: (json['payment_details_title'] ?? '').toString(),
      proceedToPaymentButton1: (json['proceed_to_payment_button'] ?? '').toString(),
      useSavedAddresses: (json['use_saved_addresses'] ?? '').toString(),
      recipientNameLabel: (json['recipient_name_label'] ?? '').toString(),
      recipientNameHint: (json['recipient_name_hint'] ?? '').toString(),
      recipientPhoneLabel: (json['recipient_phone_label'] ?? '').toString(),
      deliveryAddressLabel: (json['delivery_address_label'] ?? '').toString(),
      askRecipientForAddress: (json['ask_recipient_for_address'] ?? '').toString(),
      enterRecipientAddress: (json['enter_recipient_address'] ?? '').toString(),
      selectSavedAddress: (json['select_saved_address'] ?? '').toString(),
      noSavedAddresses: (json['no_saved_addresses'] ?? '').toString(),
      addNewAddress: (json['add_new_address'] ?? '').toString(),
      tryAgain: (json['try_again'] ?? '').toString(),
      errorLoadingAddresses: (json['error_loading_addresses'] ?? '').toString(),
      creditCard: (json['credit_card'] ?? '').toString(),
      mada: (json['mada'] ?? '').toString(),
      googlePay: (json['google_pay'] ?? '').toString(),
      applePay: (json['apple_pay'] ?? '').toString(),
      stcPay: (json['stc_pay'] ?? '').toString(),
      firstDeliveryPaymentDetails: (json['first_delivery_payment_details'] ?? '').toString(),
      subtotalLabel: (json['subtotal_label'] ?? '').toString(),
      deliveryChargesLabel: (json['delivery_charges_label'] ?? '').toString(),
      totalVatIncluded: (json['total_vat_included'] ?? '').toString(),
      totalVatIncludedLabel: (json['total_vat_included_label'] ?? '').toString(),
      nextPaymentLabel: (json['next_payment_label'] ?? '').toString(),
      pleaseFillFields: (json['please_fill_fields'] ?? '').toString(),
      selectLocation: (json['selectLocation'] ?? '').toString(),
      searchForLocation: (json['searchForLocation'] ?? '').toString(),
      dragMapToAdjustLocation: (json['dragMapToAdjustLocation'] ?? '').toString(),
      selectedLocation: (json['selectedLocation'] ?? '').toString(),
      confirmLocation: (json['confirmLocation'] ?? '').toString(),
      locationServicesDisabled: (json['locationServicesDisabled'] ?? '').toString(),
      locationPermissionsDenied: (json['locationPermissionsDenied'] ?? '').toString(),
      locationPermissionsPermanentlyDenied: (json['locationPermissionsPermanentlyDenied'] ?? '').toString(),
      currentLocationPinned: (json['currentLocationPinned'] ?? '').toString(),
      couldNotGetCurrentLocation: (json['couldNotGetCurrentLocation'] ?? '').toString(),
      voucherCode: (json['voucher_code'] ?? '').toString(),
      addVoucherCode: (json['add_voucher_code'] ?? '').toString(),
      validatingPromoCode: (json['validating_promo_code'] ?? '').toString(),
      promoCodeApplied: (json['promo_code_applied'] ?? '').toString(),
      discount: (json['discount'] ?? '').toString(),
      invalidPromoCode: (json['invalid_promo_code'] ?? '').toString(),
      pleaseEnterVoucherCode: (json['please_enter_voucher_code'] ?? '').toString(),
      applied: (json['applied'] ?? '').toString(),
      apply: (json['apply'] ?? '').toString(),
      startTypingToSearch: (json['start_typing_to_search'] ?? '').toString(),
      toBeProvidedByRecipient: (json['to_be_provided_by_recipient'] ?? '').toString(),
      tomorrow: (json['tomorrow'] ?? '').toString(),
      editOccasion: (json['editOccasion'] ?? '').toString(),
      remindMeAbout: (json['remindMeAbout'] ?? '').toString(),
      updateOccasionDetails: (json['updateOccasionDetails'] ?? '').toString(),
      occasionDetailsPrompt: (json['occasionDetailsPrompt'] ?? '').toString(),
      nameLabel1: (json['nameLabel'] ?? '').toString(),
      dateLabel: (json['dateLabel'] ?? '').toString(),
      pleaseEnterName: (json['pleaseEnterName'] ?? '').toString(),
      updateOccasionButton: (json['updateOccasionButton'] ?? '').toString(),
      createOccasionButton: (json['createOccasionButton'] ?? '').toString(),
      errorPrefix: (json['errorPrefix'] ?? '').toString(),
      deleteMyAccount: (json['delete_my_account'] ?? '').toString(),
      deliveryFrequency1: (json['delivery_frequency'] ?? '').toString(),
      subscriptionDuration1: (json['subscription_duration'] ?? '').toString(),
    );
  }
  final String appTitle;
  final String appBarTitle;
  final String deliveryTo;
  final String locationCity;
  final String retry;
  final String continueShopping;
  final String viewCart;
  final String cancel;
  final String signIn;
  final String loginRequired;
  final String loginRequiredToAccess;
  final String loginToViewCart;
  final String loginToViewProfile;
  final String loginToSelectCity;
  final String emailLabel;
  final String passwordLabel;
  final String signInButton;
  final String forgetPassword;
  final String createAccount;
  final String dividerText;
  final String signInWith;
  final String validationEmailPasswordRequired;
  final String googleSignInSuccess;
  final String googleSignInFailed;
  final String googleTokenError;
  final String appleSignInSuccess;
  final String appleSignInFailed;
  final String appleTokenError;
  final String loginFailed;
  final String registrationFailed;
  final String generalError;
  final String formAllFieldRequired;
  final String fieldRequired;
  final String fieldsMarkedRequired;
  final String forgetPasswordTitle;
  final String forgetPasswordInstruction;
  final String resetPasswordButton;
  final String passwordResetLinkSent;
  final String createAccountTitle;
  final String createAccountButton;
  final String nameLabel;
  final String phoneLabel;
  final String selectCountryLabel;
  final String homeGiftsForEveryMoment;
  final String homeExploreUniqueGiftIdeas;
  final String homeChooseGiftsNow;
  final String homeRoundedBeautyEndlessCharm;
  final String homeStartTheYearWithTulips;
  final String homeWoodntYouLoveThis;
  final String homeAnExtraLuxuriousTouch;
  final String homeBestSellers;
  final String homeCaptivationAromasOfMubkhar;
  final String homeGiftYourLovedOnes;
  final String homeNaturesMagic;
  final String homeLatestAndLoveliest;
  final String homeGiftsForEveryone;
  final String homeBrandsYoullLove;
  final String bottomNavHome;
  final String bottomNavExplore;
  final String bottomNavCart;
  final String bottomNavMyAccount;
  final String exploreScreenTitle;
  final String exploreSearchHint;
  final String exploreCardMoments;
  final String exploreCardRecipients;
  final String exploreCategoryFlowersPlants;
  final String exploreCategoryFlowersGifts;
  final String exploreCategoryExpressDelivery;
  final String exploreCategoryFloralSubscription;
  final String exploreBrandsYoullLove;
  final String discoverNewIdeasTitle;
  final String discoverCardExpressDeliveryTitle;
  final String discoverCardExpressDeliveryButton;
  final String discoverCardWeeklySurpriseTitle;
  final String discoverCardWeeklySurpriseButton;
  final String momentsScreenTitle;
  final String recipientsScreenTitle;
  final String flowersPlanetsScreenTitle;
  final String flowersGiftsScreenTitle;
  final String searchPlaceholder;
  final String searchButton;
  final String filterTitle;
  final String filterApply;
  final String filterOccasion;
  final String filterRecipient;
  final String filterColor;
  final String filterBundleType;
  final String filterClear;
  final String filterClose;
  final String gotIt;
  final String filterButton;
  final String showingProductsCount;
  final String viewGrid;
  final String viewList;
  final String allChip;
  final String categoryFilterTitle;
  final String occasionFilterTitle;
  final String recipientFilterTitle;
  final String colorFilterTitle;
  final String showProductsPart1;
  final String showProductsPart2;
  final String filtersTitle;
  final String addToCart;
  final String noAddressHassle;
  final String collectAddressText;
  final String descriptionHeader;
  final String descriptionTab;
  final String careTipsTab;
  final String seeMore;
  final String seeLess;
  final String allPricesIncludeTax;
  final String payWith;
  final String productDetailsTitle;
  final String wardayaPoints;
  final String currencySar;
  final String splitPaymentsWithTamara;
  final String earn;
  final String similarProducts;
  final String noSimilarProducts;
  final String cartEmptyTitle;
  final String cartEmptySubtitle;
  final String startShoppingButton;
  final String cartTitle;
  final String proceedToPayment;
  final String freeDeliveryUnlocked;
  final String giftCardMessage;
  final String selectGiftCard;
  final String addMessage;
  final String customizeButton;
  final String makeItPerfect;
  final String recommendedTab;
  final String flowersAddOnTab;
  final String stickersTab;
  final String productPrice;
  final String productTitle;
  final String toLabel;
  final String fromLabel;
  final String optionalHint;
  final String suggestedMessagesPromptPart1;
  final String suggestedMessagesPromptPart2;
  final String signatureButton;
  final String qrCodeLabel;
  final String recordVideoButton;
  final String orLabel;
  final String pasteLinkButton;
  final String messageHint;
  final String charactersLeft;
  final String removeTooltip;
  final String signatureRemove;
  final String linkRemove;
  final String handwrittenStyle;
  final String typedStyle;
  final String charactersLimit;
  final String typingStyleLabel;
  final String handwritingOption;
  final String typedOption;
  final String addMediaTitle;
  final String mediaIntroText;
  final String howItWorks;
  final String pasteLinkInstruction;
  final String recordVideoInstruction;
  final String qrCodeNote;
  final String freeLabel;
  final String pasteLinkHint;
  final String addToMessageButton;
  final String startRecordingButton;
  final String recordVideoTab;
  final String pasteLinkTab;
  final String noCardSelected;
  final String frontSideLabel;
  final String backSideLabel;
  final String qrQuestion;
  final String qrInstruction;
  final String signatureTitle;
  final String drawInstruction;
  final String clearButton;
  final String saveButton;
  final String customizeGiftCard;
  final String selectCard;
  final String preview;
  final String saveAndContinue;
  final String profileScreenTitle;
  final String viewEditProfile;
  final String myOrders;
  final String mySubscriptions;
  final String invoices;
  final String savedAddresses;
  final String occasions;
  final String favouriteGifts;
  final String wardayaWallet;
  final String customerCare;
  final String language;
  final String faq;
  final String termsConditions;
  final String customerCareTitle;
  final String phoneCall;
  final String whatsapp;
  final String arabic;
  final String english;
  final String logout;
  final String deleteAccount;
  final String deleteAccountConfirmation;
  final String confirm;
  final String editProfileTitle;
  final String saveChangesButton;
  final String firstNameLabel;
  final String lastNameLabel;
  final String fullNameLabel;
  final String phoneNumberLabel;
  final String emailAddressLabel;
  final String changePasswordButton;
  final String changePasswordTitle;
  final String birthdayLabel;
  final String mySubscriptionsTitle;
  final String wardayaSubscriptions;
  final String subscriptionDescription;
  final String subscriptionHowItWorks;
  final String subscriptionSelectYourPlan;
  final String subscriptionChooseWhatFitsYourNeeds;
  final String subscriptionCustomizeDelivery;
  final String subscriptionSetDeliveryFrequencyAndPayment;
  final String subscriptionEnjoyFreshFlowers;
  final String subscriptionReceiveFreshFlowersEveryTime;
  final String subscriptionPlans;
  final String subscriptionStartingFrom;
  final String subscriptionButton;
  final String more;
  final String less;
  final String startingFrom;
  final String perDelivery;
  final String subscriptionDurationTitle;
  final String deliveryFrequency;
  final String onceAWeek;
  final String everyTwoWeeks;
  final String onceAMonth;
  final String subscriptionDuration;
  final String deliveries;
  final String total;
  final String startingDate;
  final String selectOtherDate;
  final String weSelectDeleveryBasedArea;
  final String off;
  final String perDelivery1;
  final String favoritesScreenTitle;
  final String favoritesEmptyTitle;
  final String favoritesEmptyButton;
  final String subMenuItemsScreenTitle;
  final String subMenuItemsEmptyTitle;
  final String addressesScreenTitle;
  final String addressesScreenAddNewAddressButton;
  final String addressesScreenNoAddressesFound;
  final String addressSavedSuccessfully;
  final String addressUpdatedSuccessfully;
  final String addressDeletedSuccessfully;
  final String fillRequiredFields;
  final String dropAddressFromMap;
  final String enterAddressDetails;
  final String enterPhoneNumber;
  final String enterRecipientName;
  final String defaultAddressTitle;
  final String defaultAddressWithArea;
  final String addressLabelHint;
  final String extraAddressLabelHint;
  final String recipientDetailsScreenTitle;
  final String recipientDetailsScreenContinueButton;
  final String recipientDetailsScreenRecipientNameLabel;
  final String recipientDetailsScreenRecipientPhoneLabel;
  final String recipientDetailsScreenRecipientAreaLabel;
  final String recipientDetailsScreenRecipientAddressLabel;
  final String recipientDetailsScreenRecipientExtraAddressLabel;
  final String orderNumber;
  final String date;
  final String orderId;
  final String orderStatus;
  final String deliveryInfo;
  final String recipientName;
  final String phoneNumber;
  final String address;
  final String estimatedDeliveryTime;
  final String myIdentity;
  final String expressDelivery;
  final String hidden;
  final String visible;
  final String yes;
  final String no;
  final String quantity;
  final String noOrders;
  final String recipient;
  final String deliveryDate;
  final String paymentDetails;
  final String subtotal;
  final String deliveryCharges;
  final String vatLabel;
  final String paymentMethod;
  final String searchOrderPlaceholder;
  final String paymentTitle;
  final String cancelPaymentTitle;
  final String cancelPaymentMessage;
  final String cancelPaymentNo;
  final String cancelPaymentYes;
  final String paymentAmountTitle;
  final String paymentOrderIdLabel;
  final String paymentError;
  final String paymentTryAgain;
  final String paymentSuccessTitle;
  final String paymentSuccessMessage;
  final String paymentFailedTitle;
  final String paymentFailedMessage;
  final String paymentOkButton;
  final String paymentMethodsTitle;
  final String proceedToPaymentButton;
  final String creditDebitCardTitle;
  final String creditDebitCardDescription;
  final String madaTitle;
  final String madaDescription;
  final String applePayTitle;
  final String applePayDescription;
  final String googlePayTitle;
  final String googlePayDescription;
  final String benefitPayTitle;
  final String benefitPayDescription;
  final String selectCityTitle;
  final String sAfilter;
  final String sendYourGiftTo;
  final String myOccasions;
  final String quickAdd;
  final String selectAnOccasionToCreateAreminder;
  final String yourUpcomingOccasion;
  final String noUpcomingOccasions;
  final String noOccasionsAvailable;
  final String edit;
  final String delete;
  final String loading;
  final String deleteOccasionTitle;
  final String deleteOccasionConfirm;
  final String deleteButton;
  final String cancelButton;
  final String errorText;
  final String selectDeliveryDate;
  final String invoiceTitle;
  final String noInvoicesTitle;
  final String noInvoicesSubtitle;
  final String invoiceDetails;
  final String subscriptionCheckoutTitle;
  final String recipientDetailsTitle;
  final String paymentMethodTitle;
  final String paymentDetailsTitle;
  final String proceedToPaymentButton1;
  final String useSavedAddresses;
  final String recipientNameLabel;
  final String recipientNameHint;
  final String recipientPhoneLabel;
  final String deliveryAddressLabel;
  final String askRecipientForAddress;
  final String enterRecipientAddress;
  final String selectSavedAddress;
  final String noSavedAddresses;
  final String addNewAddress;
  final String tryAgain;
  final String errorLoadingAddresses;
  final String creditCard;
  final String mada;
  final String googlePay;
  final String applePay;
  final String stcPay;
  final String firstDeliveryPaymentDetails;
  final String subtotalLabel;
  final String deliveryChargesLabel;
  final String totalVatIncluded;
  final String totalVatIncludedLabel;
  final String nextPaymentLabel;
  final String pleaseFillFields;
  final String selectLocation;
  final String searchForLocation;
  final String dragMapToAdjustLocation;
  final String selectedLocation;
  final String confirmLocation;
  final String locationServicesDisabled;
  final String locationPermissionsDenied;
  final String locationPermissionsPermanentlyDenied;
  final String currentLocationPinned;
  final String couldNotGetCurrentLocation;
  final String voucherCode;
  final String addVoucherCode;
  final String validatingPromoCode;
  final String promoCodeApplied;
  final String discount;
  final String invalidPromoCode;
  final String pleaseEnterVoucherCode;
  final String applied;
  final String apply;
  final String startTypingToSearch;
  final String toBeProvidedByRecipient;
  final String tomorrow;
  final String editOccasion;
  final String remindMeAbout;
  final String updateOccasionDetails;
  final String occasionDetailsPrompt;
  final String nameLabel1;
  final String dateLabel;
  final String pleaseEnterName;
  final String updateOccasionButton;
  final String createOccasionButton;
  final String errorPrefix;
  final String deleteMyAccount;
  final String deliveryFrequency1;
  final String subscriptionDuration1;
  Map<String, Object> get _content => {
        r'''app_title''': appTitle,
        r'''app_bar_title''': appBarTitle,
        r'''delivery_to''': deliveryTo,
        r'''location_city''': locationCity,
        r'''retry''': retry,
        r'''continue_shopping''': continueShopping,
        r'''view_cart''': viewCart,
        r'''cancel''': cancel,
        r'''sign_in''': signIn,
        r'''loginRequired''': loginRequired,
        r'''loginRequiredToAccess''': loginRequiredToAccess,
        r'''loginToViewCart''': loginToViewCart,
        r'''loginToViewProfile''': loginToViewProfile,
        r'''loginToSelectCity''': loginToSelectCity,
        r'''email_label''': emailLabel,
        r'''password_label''': passwordLabel,
        r'''sign_in_button''': signInButton,
        r'''forget_password''': forgetPassword,
        r'''create_account''': createAccount,
        r'''divider_text''': dividerText,
        r'''sign_in_with''': signInWith,
        r'''validation_email_password_required''': validationEmailPasswordRequired,
        r'''google_sign_in_success''': googleSignInSuccess,
        r'''google_sign_in_failed''': googleSignInFailed,
        r'''google_token_error''': googleTokenError,
        r'''apple_sign_in_success''': appleSignInSuccess,
        r'''apple_sign_in_failed''': appleSignInFailed,
        r'''apple_token_error''': appleTokenError,
        r'''login_failed''': loginFailed,
        r'''registration_failed''': registrationFailed,
        r'''general_error''': generalError,
        r'''form_all_field_required''': formAllFieldRequired,
        r'''field_required''': fieldRequired,
        r'''fields_marked_required''': fieldsMarkedRequired,
        r'''forget_password_title''': forgetPasswordTitle,
        r'''forget_password_instruction''': forgetPasswordInstruction,
        r'''reset_password_button''': resetPasswordButton,
        r'''password_reset_link_sent''': passwordResetLinkSent,
        r'''create_account_title''': createAccountTitle,
        r'''create_account_button''': createAccountButton,
        r'''name_label''': nameLabel,
        r'''phone_label''': phoneLabel,
        r'''select_country_label''': selectCountryLabel,
        r'''home_gifts_for_every_moment''': homeGiftsForEveryMoment,
        r'''home_explore_unique_gift_ideas''': homeExploreUniqueGiftIdeas,
        r'''home_choose_gifts_now''': homeChooseGiftsNow,
        r'''home_rounded_beauty_endless_charm''': homeRoundedBeautyEndlessCharm,
        r'''home_start_the_year_with_tulips''': homeStartTheYearWithTulips,
        r'''home_woodnt_you_love_this''': homeWoodntYouLoveThis,
        r'''home_an_extra_luxurious_touch''': homeAnExtraLuxuriousTouch,
        r'''home_best_sellers''': homeBestSellers,
        r'''home_captivation_aromas_of_mubkhar''': homeCaptivationAromasOfMubkhar,
        r'''home_gift_your_loved_ones''': homeGiftYourLovedOnes,
        r'''home_natures_magic''': homeNaturesMagic,
        r'''home_latest_and_loveliest''': homeLatestAndLoveliest,
        r'''home_gifts_for_everyone''': homeGiftsForEveryone,
        r'''home_brands_youll_love''': homeBrandsYoullLove,
        r'''bottom_nav_home''': bottomNavHome,
        r'''bottom_nav_explore''': bottomNavExplore,
        r'''bottom_nav_cart''': bottomNavCart,
        r'''bottom_nav_my_account''': bottomNavMyAccount,
        r'''explore_screen_title''': exploreScreenTitle,
        r'''explore_search_hint''': exploreSearchHint,
        r'''explore_card_moments''': exploreCardMoments,
        r'''explore_card_recipients''': exploreCardRecipients,
        r'''explore_category_flowers_plants''': exploreCategoryFlowersPlants,
        r'''explore_category_flowers_gifts''': exploreCategoryFlowersGifts,
        r'''explore_category_express_delivery''': exploreCategoryExpressDelivery,
        r'''explore_category_floral_subscription''': exploreCategoryFloralSubscription,
        r'''explore_brands_youll_love''': exploreBrandsYoullLove,
        r'''discover_new_ideas_title''': discoverNewIdeasTitle,
        r'''discover_card_express_delivery_title''': discoverCardExpressDeliveryTitle,
        r'''discover_card_express_delivery_button''': discoverCardExpressDeliveryButton,
        r'''discover_card_weekly_surprise_title''': discoverCardWeeklySurpriseTitle,
        r'''discover_card_weekly_surprise_button''': discoverCardWeeklySurpriseButton,
        r'''moments_screen_title''': momentsScreenTitle,
        r'''recipients_screen_title''': recipientsScreenTitle,
        r'''flowers_planets_screen_title''': flowersPlanetsScreenTitle,
        r'''flowers_gifts_screen_title''': flowersGiftsScreenTitle,
        r'''search_placeholder''': searchPlaceholder,
        r'''search_button''': searchButton,
        r'''filter_title''': filterTitle,
        r'''filter_apply''': filterApply,
        r'''filter_occasion''': filterOccasion,
        r'''filter_recipient''': filterRecipient,
        r'''filter_color''': filterColor,
        r'''filter_bundle_type''': filterBundleType,
        r'''filter_clear''': filterClear,
        r'''filter_close''': filterClose,
        r'''got_it''': gotIt,
        r'''filter_button''': filterButton,
        r'''showing_products_count''': showingProductsCount,
        r'''view_grid''': viewGrid,
        r'''view_list''': viewList,
        r'''all_chip''': allChip,
        r'''category_filter_title''': categoryFilterTitle,
        r'''occasion_filter_title''': occasionFilterTitle,
        r'''recipient_filter_title''': recipientFilterTitle,
        r'''color_filter_title''': colorFilterTitle,
        r'''show_products_part1''': showProductsPart1,
        r'''show_products_part2''': showProductsPart2,
        r'''filters_title''': filtersTitle,
        r'''add_to_cart''': addToCart,
        r'''no_address_hassle''': noAddressHassle,
        r'''collect_address_text''': collectAddressText,
        r'''description_header''': descriptionHeader,
        r'''description_tab''': descriptionTab,
        r'''care_tips_tab''': careTipsTab,
        r'''see_more''': seeMore,
        r'''see_less''': seeLess,
        r'''all_prices_include_tax''': allPricesIncludeTax,
        r'''pay_with''': payWith,
        r'''product_details_title''': productDetailsTitle,
        r'''wardaya_points''': wardayaPoints,
        r'''currency_sar''': currencySar,
        r'''split_payments_with_tamara''': splitPaymentsWithTamara,
        r'''earn''': earn,
        r'''similarProducts''': similarProducts,
        r'''noSimilarProducts''': noSimilarProducts,
        r'''cart_empty_title''': cartEmptyTitle,
        r'''cart_empty_subtitle''': cartEmptySubtitle,
        r'''start_shopping_button''': startShoppingButton,
        r'''cart_title''': cartTitle,
        r'''proceed_to_payment''': proceedToPayment,
        r'''free_delivery_unlocked''': freeDeliveryUnlocked,
        r'''gift_card_message''': giftCardMessage,
        r'''select_gift_card''': selectGiftCard,
        r'''add_message''': addMessage,
        r'''customize_button''': customizeButton,
        r'''make_it_perfect''': makeItPerfect,
        r'''recommended_tab''': recommendedTab,
        r'''flowers_add_on_tab''': flowersAddOnTab,
        r'''stickers_tab''': stickersTab,
        r'''product_price''': productPrice,
        r'''product_title''': productTitle,
        r'''to_label''': toLabel,
        r'''from_label''': fromLabel,
        r'''optional_hint''': optionalHint,
        r'''suggested_messages_prompt_part1''': suggestedMessagesPromptPart1,
        r'''suggested_messages_prompt_part2''': suggestedMessagesPromptPart2,
        r'''signature_button''': signatureButton,
        r'''qr_code_label''': qrCodeLabel,
        r'''record_video_button''': recordVideoButton,
        r'''or_label''': orLabel,
        r'''paste_link_button''': pasteLinkButton,
        r'''message_hint''': messageHint,
        r'''characters_left''': charactersLeft,
        r'''remove_tooltip''': removeTooltip,
        r'''signature_remove''': signatureRemove,
        r'''link_remove''': linkRemove,
        r'''handwritten_style''': handwrittenStyle,
        r'''typed_style''': typedStyle,
        r'''characters_limit''': charactersLimit,
        r'''typing_style_label''': typingStyleLabel,
        r'''handwriting_option''': handwritingOption,
        r'''typed_option''': typedOption,
        r'''add_media_title''': addMediaTitle,
        r'''media_intro_text''': mediaIntroText,
        r'''how_it_works''': howItWorks,
        r'''paste_link_instruction''': pasteLinkInstruction,
        r'''record_video_instruction''': recordVideoInstruction,
        r'''qr_code_note''': qrCodeNote,
        r'''free_label''': freeLabel,
        r'''paste_link_hint''': pasteLinkHint,
        r'''add_to_message_button''': addToMessageButton,
        r'''start_recording_button''': startRecordingButton,
        r'''record_video_tab''': recordVideoTab,
        r'''paste_link_tab''': pasteLinkTab,
        r'''no_card_selected''': noCardSelected,
        r'''front_side_label''': frontSideLabel,
        r'''back_side_label''': backSideLabel,
        r'''qr_question''': qrQuestion,
        r'''qr_instruction''': qrInstruction,
        r'''signature_title''': signatureTitle,
        r'''draw_instruction''': drawInstruction,
        r'''clear_button''': clearButton,
        r'''save_button''': saveButton,
        r'''customize_gift_card''': customizeGiftCard,
        r'''select_card''': selectCard,
        r'''preview''': preview,
        r'''save_and_continue''': saveAndContinue,
        r'''profile_screen_title''': profileScreenTitle,
        r'''view_edit_profile''': viewEditProfile,
        r'''my_orders''': myOrders,
        r'''my_subscriptions''': mySubscriptions,
        r'''invoices''': invoices,
        r'''saved_addresses''': savedAddresses,
        r'''occasions''': occasions,
        r'''favourite_gifts''': favouriteGifts,
        r'''wardaya_wallet''': wardayaWallet,
        r'''customer_care''': customerCare,
        r'''language''': language,
        r'''faq''': faq,
        r'''terms_conditions''': termsConditions,
        r'''customer_care_title''': customerCareTitle,
        r'''phone_call''': phoneCall,
        r'''whatsapp''': whatsapp,
        r'''arabic''': arabic,
        r'''english''': english,
        r'''logout''': logout,
        r'''delete_account''': deleteAccount,
        r'''delete_account_confirmation''': deleteAccountConfirmation,
        r'''confirm''': confirm,
        r'''edit_profile_title''': editProfileTitle,
        r'''save_changes_button''': saveChangesButton,
        r'''first_name_label''': firstNameLabel,
        r'''last_name_label''': lastNameLabel,
        r'''full_name_label''': fullNameLabel,
        r'''phone_number_label''': phoneNumberLabel,
        r'''email_address_label''': emailAddressLabel,
        r'''change_password_button''': changePasswordButton,
        r'''change_password_title''': changePasswordTitle,
        r'''birthday_label''': birthdayLabel,
        r'''my_subscriptions_title''': mySubscriptionsTitle,
        r'''wardaya_subscriptions''': wardayaSubscriptions,
        r'''subscription_description''': subscriptionDescription,
        r'''subscription_how_it_works''': subscriptionHowItWorks,
        r'''subscription_select_your_plan''': subscriptionSelectYourPlan,
        r'''subscription_choose_what_fits_your_needs''': subscriptionChooseWhatFitsYourNeeds,
        r'''subscription_customize_delivery''': subscriptionCustomizeDelivery,
        r'''subscription_set_delivery_frequency_and_payment''': subscriptionSetDeliveryFrequencyAndPayment,
        r'''subscription_enjoy_fresh_flowers''': subscriptionEnjoyFreshFlowers,
        r'''subscription_receive_fresh_flowers_every_time''': subscriptionReceiveFreshFlowersEveryTime,
        r'''subscription_plans''': subscriptionPlans,
        r'''subscription_starting_from''': subscriptionStartingFrom,
        r'''subscription_button''': subscriptionButton,
        r'''more''': more,
        r'''less''': less,
        r'''starting_from''': startingFrom,
        r'''per_delivery''': perDelivery,
        r'''subscription_duration_title''': subscriptionDurationTitle,
        r'''deliveryـfrequency''': deliveryFrequency,
        r'''once_a_week''': onceAWeek,
        r'''every_two_weeks''': everyTwoWeeks,
        r'''once_a_month''': onceAMonth,
        r'''subscriptionـduration''': subscriptionDuration,
        r'''deliveries''': deliveries,
        r'''total''': total,
        r'''starting_date''': startingDate,
        r'''select_other_date''': selectOtherDate,
        r'''we_select_delevery_based_area''': weSelectDeleveryBasedArea,
        r'''off''': off,
        r'''perـdelivery''': perDelivery1,
        r'''favorites_screen_title''': favoritesScreenTitle,
        r'''favorites_empty_title''': favoritesEmptyTitle,
        r'''favorites_empty_button''': favoritesEmptyButton,
        r'''sub_menu_items_screen_title''': subMenuItemsScreenTitle,
        r'''sub_menu_items_empty_title''': subMenuItemsEmptyTitle,
        r'''addresses_screen_title''': addressesScreenTitle,
        r'''addresses_screen_add_new_address_button''': addressesScreenAddNewAddressButton,
        r'''addresses_screen_no_addresses_found''': addressesScreenNoAddressesFound,
        r'''address_saved_successfully''': addressSavedSuccessfully,
        r'''address_updated_successfully''': addressUpdatedSuccessfully,
        r'''address_deleted_successfully''': addressDeletedSuccessfully,
        r'''fill_required_fields''': fillRequiredFields,
        r'''drop_address_from_map''': dropAddressFromMap,
        r'''enter_address_details''': enterAddressDetails,
        r'''enter_phone_number''': enterPhoneNumber,
        r'''enter_recipient_name''': enterRecipientName,
        r'''default_address_title''': defaultAddressTitle,
        r'''default_address_with_area''': defaultAddressWithArea,
        r'''address_label_hint''': addressLabelHint,
        r'''extra_address_label_hint''': extraAddressLabelHint,
        r'''recipient_details_screen_title''': recipientDetailsScreenTitle,
        r'''recipient_details_screen_continue_button''': recipientDetailsScreenContinueButton,
        r'''recipient_details_screen_recipient_name_label''': recipientDetailsScreenRecipientNameLabel,
        r'''recipient_details_screen_recipient_phone_label''': recipientDetailsScreenRecipientPhoneLabel,
        r'''recipient_details_screen_recipient_area_label''': recipientDetailsScreenRecipientAreaLabel,
        r'''recipient_details_screen_recipient_address_label''': recipientDetailsScreenRecipientAddressLabel,
        r'''recipient_details_screen_recipient_extra_address_label''': recipientDetailsScreenRecipientExtraAddressLabel,
        r'''orderNumber''': orderNumber,
        r'''date''': date,
        r'''orderId''': orderId,
        r'''orderStatus''': orderStatus,
        r'''deliveryInfo''': deliveryInfo,
        r'''recipientName''': recipientName,
        r'''phoneNumber''': phoneNumber,
        r'''address''': address,
        r'''estimatedDeliveryTime''': estimatedDeliveryTime,
        r'''myIdentity''': myIdentity,
        r'''expressDelivery''': expressDelivery,
        r'''hidden''': hidden,
        r'''visible''': visible,
        r'''yes''': yes,
        r'''no''': no,
        r'''quantity''': quantity,
        r'''noOrders''': noOrders,
        r'''recipient''': recipient,
        r'''deliveryDate''': deliveryDate,
        r'''paymentDetails''': paymentDetails,
        r'''subtotal''': subtotal,
        r'''deliveryCharges''': deliveryCharges,
        r'''vatLabel''': vatLabel,
        r'''paymentMethod''': paymentMethod,
        r'''search_order_placeholder''': searchOrderPlaceholder,
        r'''paymentTitle''': paymentTitle,
        r'''cancelPaymentTitle''': cancelPaymentTitle,
        r'''cancelPaymentMessage''': cancelPaymentMessage,
        r'''cancelPaymentNo''': cancelPaymentNo,
        r'''cancelPaymentYes''': cancelPaymentYes,
        r'''paymentAmountTitle''': paymentAmountTitle,
        r'''paymentOrderIdLabel''': paymentOrderIdLabel,
        r'''paymentError''': paymentError,
        r'''paymentTryAgain''': paymentTryAgain,
        r'''paymentSuccessTitle''': paymentSuccessTitle,
        r'''paymentSuccessMessage''': paymentSuccessMessage,
        r'''paymentFailedTitle''': paymentFailedTitle,
        r'''paymentFailedMessage''': paymentFailedMessage,
        r'''paymentOkButton''': paymentOkButton,
        r'''paymentMethodsTitle''': paymentMethodsTitle,
        r'''proceedToPaymentButton''': proceedToPaymentButton,
        r'''creditDebitCardTitle''': creditDebitCardTitle,
        r'''creditDebitCardDescription''': creditDebitCardDescription,
        r'''madaTitle''': madaTitle,
        r'''madaDescription''': madaDescription,
        r'''applePayTitle''': applePayTitle,
        r'''applePayDescription''': applePayDescription,
        r'''googlePayTitle''': googlePayTitle,
        r'''googlePayDescription''': googlePayDescription,
        r'''benefitPayTitle''': benefitPayTitle,
        r'''benefitPayDescription''': benefitPayDescription,
        r'''selectCityTitle''': selectCityTitle,
        r'''sAFilter''': sAfilter,
        r'''SendYourGiftTo''': sendYourGiftTo,
        r'''myOccasions''': myOccasions,
        r'''quickAdd''': quickAdd,
        r'''selectAnOccasionToCreateAReminder''': selectAnOccasionToCreateAreminder,
        r'''yourUpcomingOccasion''': yourUpcomingOccasion,
        r'''noUpcomingOccasions''': noUpcomingOccasions,
        r'''noOccasionsAvailable''': noOccasionsAvailable,
        r'''edit''': edit,
        r'''delete''': delete,
        r'''loading''': loading,
        r'''deleteOccasionTitle''': deleteOccasionTitle,
        r'''deleteOccasionConfirm''': deleteOccasionConfirm,
        r'''deleteButton''': deleteButton,
        r'''cancelButton''': cancelButton,
        r'''errorText''': errorText,
        r'''selectDeliveryDate''': selectDeliveryDate,
        r'''invoiceTitle''': invoiceTitle,
        r'''noInvoicesTitle''': noInvoicesTitle,
        r'''noInvoicesSubtitle''': noInvoicesSubtitle,
        r'''invoiceDetails''': invoiceDetails,
        r'''subscription_checkout_title''': subscriptionCheckoutTitle,
        r'''recipient_details_title''': recipientDetailsTitle,
        r'''payment_method_title''': paymentMethodTitle,
        r'''payment_details_title''': paymentDetailsTitle,
        r'''proceed_to_payment_button''': proceedToPaymentButton1,
        r'''use_saved_addresses''': useSavedAddresses,
        r'''recipient_name_label''': recipientNameLabel,
        r'''recipient_name_hint''': recipientNameHint,
        r'''recipient_phone_label''': recipientPhoneLabel,
        r'''delivery_address_label''': deliveryAddressLabel,
        r'''ask_recipient_for_address''': askRecipientForAddress,
        r'''enter_recipient_address''': enterRecipientAddress,
        r'''select_saved_address''': selectSavedAddress,
        r'''no_saved_addresses''': noSavedAddresses,
        r'''add_new_address''': addNewAddress,
        r'''try_again''': tryAgain,
        r'''error_loading_addresses''': errorLoadingAddresses,
        r'''credit_card''': creditCard,
        r'''mada''': mada,
        r'''google_pay''': googlePay,
        r'''apple_pay''': applePay,
        r'''stc_pay''': stcPay,
        r'''first_delivery_payment_details''': firstDeliveryPaymentDetails,
        r'''subtotal_label''': subtotalLabel,
        r'''delivery_charges_label''': deliveryChargesLabel,
        r'''total_vat_included''': totalVatIncluded,
        r'''total_vat_included_label''': totalVatIncludedLabel,
        r'''next_payment_label''': nextPaymentLabel,
        r'''please_fill_fields''': pleaseFillFields,
        r'''selectLocation''': selectLocation,
        r'''searchForLocation''': searchForLocation,
        r'''dragMapToAdjustLocation''': dragMapToAdjustLocation,
        r'''selectedLocation''': selectedLocation,
        r'''confirmLocation''': confirmLocation,
        r'''locationServicesDisabled''': locationServicesDisabled,
        r'''locationPermissionsDenied''': locationPermissionsDenied,
        r'''locationPermissionsPermanentlyDenied''': locationPermissionsPermanentlyDenied,
        r'''currentLocationPinned''': currentLocationPinned,
        r'''couldNotGetCurrentLocation''': couldNotGetCurrentLocation,
        r'''voucher_code''': voucherCode,
        r'''add_voucher_code''': addVoucherCode,
        r'''validating_promo_code''': validatingPromoCode,
        r'''promo_code_applied''': promoCodeApplied,
        r'''discount''': discount,
        r'''invalid_promo_code''': invalidPromoCode,
        r'''please_enter_voucher_code''': pleaseEnterVoucherCode,
        r'''applied''': applied,
        r'''apply''': apply,
        r'''start_typing_to_search''': startTypingToSearch,
        r'''to_be_provided_by_recipient''': toBeProvidedByRecipient,
        r'''tomorrow''': tomorrow,
        r'''editOccasion''': editOccasion,
        r'''remindMeAbout''': remindMeAbout,
        r'''updateOccasionDetails''': updateOccasionDetails,
        r'''occasionDetailsPrompt''': occasionDetailsPrompt,
        r'''nameLabel''': nameLabel1,
        r'''dateLabel''': dateLabel,
        r'''pleaseEnterName''': pleaseEnterName,
        r'''updateOccasionButton''': updateOccasionButton,
        r'''createOccasionButton''': createOccasionButton,
        r'''errorPrefix''': errorPrefix,
        r'''delete_my_account''': deleteMyAccount,
        r'''delivery_frequency''': deliveryFrequency1,
        r'''subscription_duration''': subscriptionDuration1,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key with type $T');
  }

  Map<String, Object> get content => _content;

  List<Object> get contentList => _content.values.toList();

  int get length => _content.length;

  Object? operator [](Object? key) {
    final Object? value = _content[key];
    if (value == null && key is String) {
      final int? index = int.tryParse(key);
      if (index == null || index >= contentList.length || index < 0) {
        return null;
      }

      return contentList[index];
    }
    return value;
  }
}

final LocalizationMessages en = LocalizationMessages(
  appTitle: 'Wardaya',
  appBarTitle: 'WARDAYA',
  deliveryTo: 'Delivery To',
  locationCity: 'Riyadh',
  retry: 'Retry',
  continueShopping: 'Continue Shopping',
  viewCart: 'View Cart',
  cancel: 'Cancel',
  signIn: 'Sign In',
  loginRequired: 'Login Required',
  loginRequiredToAccess: 'You need to sign in to access this feature.',
  loginToViewCart: 'Sign in to view your cart',
  loginToViewProfile: 'Sign in to view your profile',
  loginToSelectCity: 'Sign in to change delivery location',
  emailLabel: 'Email',
  passwordLabel: 'Password',
  signInButton: 'Sign In',
  forgetPassword: 'Forget Password?',
  createAccount: 'Create Account',
  dividerText: 'OR',
  signInWith: 'Sign in with',
  validationEmailPasswordRequired: 'Email and password are required',
  googleSignInSuccess: 'Successfully signed in with Google',
  googleSignInFailed: 'Google login failed',
  googleTokenError: 'Failed to get authentication token from Google',
  appleSignInSuccess: 'Successfully signed in with Apple',
  appleSignInFailed: 'Apple login failed',
  appleTokenError: 'Failed to get authentication token from Apple',
  loginFailed: 'Login failed',
  registrationFailed: 'Registration failed',
  generalError: 'An error occurred. Please try again.',
  formAllFieldRequired: 'Make sure to fill all fields',
  fieldRequired: 'Required',
  fieldsMarkedRequired: 'Fields marked with red * are required',
  forgetPasswordTitle: 'Forget Password?',
  forgetPasswordInstruction: 'Enter the email address associated with your account',
  resetPasswordButton: 'Reset Password',
  passwordResetLinkSent: 'Password reset link sent to your email',
  createAccountTitle: 'Create Account',
  createAccountButton: 'Create Account',
  nameLabel: 'Name',
  phoneLabel: 'Phone',
  selectCountryLabel: 'Select Country',
  homeGiftsForEveryMoment: 'Gifts For Every Moment',
  homeExploreUniqueGiftIdeas: 'Explore Unique Gift Ideas',
  homeChooseGiftsNow: 'Choose Gifts Now',
  homeRoundedBeautyEndlessCharm: 'Rounded Beauty, Endless Charm',
  homeStartTheYearWithTulips: 'Start the Year with Tulips',
  homeWoodntYouLoveThis: 'Woodn’t You Love This?',
  homeAnExtraLuxuriousTouch: 'An Extra Luxurious Touch',
  homeBestSellers: 'Best Sellers',
  homeCaptivationAromasOfMubkhar: 'Captivation Aromas of Mubkhar',
  homeGiftYourLovedOnes: 'Gift your loved ones while stocks last',
  homeNaturesMagic: 'Nature’s Magic',
  homeLatestAndLoveliest: 'Latest & Loveliest',
  homeGiftsForEveryone: 'Gifts for Everyone',
  homeBrandsYoullLove: 'Brands You’ll Love',
  bottomNavHome: 'HOME',
  bottomNavExplore: 'EXPLORE',
  bottomNavCart: 'CART',
  bottomNavMyAccount: 'MY ACCOUNT',
  exploreScreenTitle: 'Explore',
  exploreSearchHint: 'Search for flowers, gifts, and more',
  exploreCardMoments: 'Moments',
  exploreCardRecipients: 'Recipients',
  exploreCategoryFlowersPlants: 'Flowers & Plants',
  exploreCategoryFlowersGifts: 'Flowers & Gifts',
  exploreCategoryExpressDelivery: 'Express Delivery',
  exploreCategoryFloralSubscription: 'Floral Subscription',
  exploreBrandsYoullLove: 'Brands You’ll Love',
  discoverNewIdeasTitle: 'Discover New Ideas',
  discoverCardExpressDeliveryTitle: 'Express Delivery',
  discoverCardExpressDeliveryButton: 'Gift Now',
  discoverCardWeeklySurpriseTitle: 'Weekly Surprise',
  discoverCardWeeklySurpriseButton: 'Subscribe',
  momentsScreenTitle: 'Moments',
  recipientsScreenTitle: 'Recipients',
  flowersPlanetsScreenTitle: 'Flowers & Plants',
  flowersGiftsScreenTitle: 'Flowers & Gifts',
  searchPlaceholder: 'Search for flowers, gifts, and more',
  searchButton: 'Search',
  filterTitle: 'Filters',
  filterApply: 'Apply',
  filterOccasion: 'Occasion',
  filterRecipient: 'Recipient',
  filterColor: 'Color',
  filterBundleType: 'Bundle Type',
  filterClear: 'Clear',
  filterClose: 'Close',
  gotIt: 'Got it',
  filterButton: 'Filter',
  showingProductsCount: 'Showing {count} products',
  viewGrid: 'Grid View',
  viewList: 'List View',
  allChip: 'All',
  categoryFilterTitle: 'Category',
  occasionFilterTitle: 'Occasion',
  recipientFilterTitle: 'Recipient',
  colorFilterTitle: 'Color',
  showProductsPart1: 'Show ',
  showProductsPart2: ' Products',
  filtersTitle: 'Filters',
  addToCart: 'Add To Cart',
  noAddressHassle: 'No Address Hassle',
  collectAddressText: 'We will collect the address for you',
  descriptionHeader: 'Description',
  descriptionTab: 'Description',
  careTipsTab: 'Care Tips',
  seeMore: 'See More',
  seeLess: 'See Less',
  allPricesIncludeTax: 'All prices include tax',
  payWith: 'Pay with',
  productDetailsTitle: '''Helen's Happy Birthday Drawing Cake''',
  wardayaPoints: 'Wardaya Points',
  currencySar: 'SAR ',
  splitPaymentsWithTamara: 'Split in up to 4 payments with Tamara',
  earn: 'Earn ',
  similarProducts: 'Similar Products',
  noSimilarProducts: 'No similar products found',
  cartEmptyTitle: 'Your Cart is Empty!',
  cartEmptySubtitle: 'Looks like you havn’t added anything to your cart yet.',
  startShoppingButton: 'Start Shopping',
  cartTitle: 'Cart ',
  proceedToPayment: 'Proceed To Payment',
  freeDeliveryUnlocked: '🎉 You’ve unlocked free delivery!',
  giftCardMessage: 'Gift Card & Message',
  selectGiftCard: 'Select Gift Card',
  addMessage: 'Add a Message',
  customizeButton: 'Customize',
  makeItPerfect: 'Make it perfect',
  recommendedTab: 'Recommended',
  flowersAddOnTab: 'Flowers Add On',
  stickersTab: 'Stickers',
  productPrice: 'SAR ',
  productTitle: 'Happy Birthday Acrylic Topper - Gold',
  toLabel: 'To:',
  fromLabel: 'From:',
  optionalHint: 'Optional',
  suggestedMessagesPromptPart1: 'Not sure what to say? ',
  suggestedMessagesPromptPart2: 'Try Suggested Messages',
  signatureButton: 'Signature',
  qrCodeLabel: 'Added as a QR Code',
  recordVideoButton: 'Record Video',
  orLabel: 'OR',
  pasteLinkButton: 'Paste a Link',
  messageHint: 'Type your message and express your feelings',
  charactersLeft: 'Characters left',
  removeTooltip: 'Remove',
  signatureRemove: 'Remove Signature',
  linkRemove: 'Remove Link',
  handwrittenStyle: 'Handwritten',
  typedStyle: 'Typed',
  charactersLimit: 'Characters left',
  typingStyleLabel: 'Style:',
  handwritingOption: 'Handwriting',
  typedOption: 'Typed',
  addMediaTitle: 'Add a Video or Photo',
  mediaIntroText: 'Words are tough? Express yourself with a video or a photo.',
  howItWorks: 'How it works?',
  pasteLinkInstruction: 'Paste a link of video or photo from the internet',
  recordVideoInstruction: 'Record a 10-second video or take a picture',
  qrCodeNote: 'A QR code will be added to your card message',
  freeLabel: 'Free',
  pasteLinkHint: 'Paste your link here',
  addToMessageButton: 'Add to Message',
  startRecordingButton: 'Start Recording',
  recordVideoTab: 'Record Video',
  pasteLinkTab: 'Paste a Link',
  noCardSelected: 'No card selected',
  frontSideLabel: 'Front Side (Message)',
  backSideLabel: 'Back Side (Cover)',
  qrQuestion: 'Did you enjoy this gift?',
  qrInstruction: 'Scan the QR code to share your heartfelt message with the sender.',
  signatureTitle: 'Your Signature',
  drawInstruction: 'Draw your signature inside the frame',
  clearButton: 'Clear',
  saveButton: 'Save',
  customizeGiftCard: 'Customize Gift Card',
  selectCard: 'Select Card',
  preview: 'Preview',
  saveAndContinue: 'Save & Continue',
  profileScreenTitle: 'Profile',
  viewEditProfile: 'View/Edit My Profile',
  myOrders: 'My Orders',
  mySubscriptions: 'My Subscriptions',
  invoices: 'Invoices',
  savedAddresses: 'Saved Addresses',
  occasions: 'Occasions',
  favouriteGifts: 'Favourite Gifts',
  wardayaWallet: 'Wardaya Wallet',
  customerCare: 'Customer Care',
  language: 'Language',
  faq: 'FAQ',
  termsConditions: 'Terms & Conditions',
  customerCareTitle: '''We are happy to help you!
Need help with something?''',
  phoneCall: 'Phone Call',
  whatsapp: 'WhatsApp',
  arabic: 'Arabic',
  english: 'English',
  logout: 'Logout',
  deleteAccount: 'Delete My Account',
  deleteAccountConfirmation: 'Are you sure you want to delete your account? This action cannot be undone.',
  confirm: 'Confirm',
  editProfileTitle: 'Edit Profile',
  saveChangesButton: 'Save',
  firstNameLabel: 'First Name',
  lastNameLabel: 'Last Name',
  fullNameLabel: 'Full Name',
  phoneNumberLabel: 'Phone Number',
  emailAddressLabel: 'Email Address',
  changePasswordButton: 'Change',
  changePasswordTitle: 'Password',
  birthdayLabel: 'Birthday',
  mySubscriptionsTitle: 'My Subscriptions',
  wardayaSubscriptions: '''Wardaya
Subscription''',
  subscriptionDescription: '''
Enjoy the magic of regular fresh flower deliveries that transofrm your space, uplift your spirit, and spread joy all y...''',
  subscriptionHowItWorks: 'How it works?',
  subscriptionSelectYourPlan: 'Select Your Plan:',
  subscriptionChooseWhatFitsYourNeeds: 'Choose what fits your needs.',
  subscriptionCustomizeDelivery: 'Customize Delivery:',
  subscriptionSetDeliveryFrequencyAndPayment: 'Set delivery frequency and payment.',
  subscriptionEnjoyFreshFlowers: 'Enjoy Fresh Flowers:',
  subscriptionReceiveFreshFlowersEveryTime: 'Receive fresh flowers every time.',
  subscriptionPlans: 'Subscription Plans',
  subscriptionStartingFrom: 'Starting From',
  subscriptionButton: 'Subscribe Now',
  more: 'More',
  less: 'Less',
  startingFrom: 'Starting From',
  perDelivery: 'Per Delivery',
  subscriptionDurationTitle: 'Classic Flowers Subscription',
  deliveryFrequency: 'Delivery Frequency',
  onceAWeek: 'Once a week',
  everyTwoWeeks: 'Every two weeks',
  onceAMonth: 'Once a month',
  subscriptionDuration: 'Subscription Duration',
  deliveries: 'Deliveries',
  total: 'Total',
  startingDate: 'Starting Date',
  selectOtherDate: 'Select Other Date',
  weSelectDeleveryBasedArea: 'We’ll select the best delivery time based on your area and delivery date',
  off: 'OFF',
  perDelivery1: 'Per delivery',
  favoritesScreenTitle: 'Favorites',
  favoritesEmptyTitle: 'No Favorite products found!',
  favoritesEmptyButton: 'Start Shopping',
  subMenuItemsScreenTitle: 'Sub Menu Items',
  subMenuItemsEmptyTitle: 'No sub-menu items available',
  addressesScreenTitle: 'Saved Addresses',
  addressesScreenAddNewAddressButton: 'Add a new Address',
  addressesScreenNoAddressesFound: 'No addresses found',
  addressSavedSuccessfully: 'Address saved successfully',
  addressUpdatedSuccessfully: 'Address updated successfully',
  addressDeletedSuccessfully: 'Address deleted successfully',
  fillRequiredFields: 'Please fill all required fields',
  dropAddressFromMap: 'Drop address from Map',
  enterAddressDetails: 'Enter address details',
  enterPhoneNumber: 'Enter phone number',
  enterRecipientName: 'Enter recipient name',
  defaultAddressTitle: 'My Address',
  defaultAddressWithArea: 'My Address in {area}',
  addressLabelHint: 'Ex:Building 125, King Fahd Road, Al Olaya District',
  extraAddressLabelHint: 'Ex:Apartment number, floor, landmark, etc.',
  recipientDetailsScreenTitle: 'Recipient Details',
  recipientDetailsScreenContinueButton: 'Continue',
  recipientDetailsScreenRecipientNameLabel: 'Recipient Name',
  recipientDetailsScreenRecipientPhoneLabel: 'Phone Number',
  recipientDetailsScreenRecipientAreaLabel: 'Area',
  recipientDetailsScreenRecipientAddressLabel: 'Address',
  recipientDetailsScreenRecipientExtraAddressLabel: 'Extra address details(optional)',
  orderNumber: 'Order Number',
  date: 'Date',
  orderId: 'Order ID',
  orderStatus: 'Status',
  deliveryInfo: 'Delivery Info',
  recipientName: 'Name',
  phoneNumber: 'Phone Number',
  address: 'Address',
  estimatedDeliveryTime: 'Estimated Delivery Time',
  myIdentity: 'My Identity',
  expressDelivery: 'Express Delivery',
  hidden: 'Hidden',
  visible: 'Visible',
  yes: 'Yes',
  no: 'No',
  quantity: 'x',
  noOrders: 'No orders found',
  recipient: 'Recipient',
  deliveryDate: 'Delivery Date',
  paymentDetails: 'Payment Details',
  subtotal: 'Subtotal',
  deliveryCharges: 'Delivery charges',
  vatLabel: 'VAT',
  paymentMethod: 'Payment Method',
  searchOrderPlaceholder: 'Search for orders by order number or recipient name',
  paymentTitle: 'Payment',
  cancelPaymentTitle: 'Cancel Payment?',
  cancelPaymentMessage: 'Are you sure you want to cancel this payment?',
  cancelPaymentNo: 'No',
  cancelPaymentYes: 'Yes',
  paymentAmountTitle: 'Payment Amount',
  paymentOrderIdLabel: 'Order ID:',
  paymentError: 'Error loading payment page:',
  paymentTryAgain: 'Try Again',
  paymentSuccessTitle: 'Payment Successful',
  paymentSuccessMessage: 'Your payment has been processed successfully.',
  paymentFailedTitle: 'Payment Failed',
  paymentFailedMessage: 'Your payment could not be processed. Please try again.',
  paymentOkButton: 'OK',
  paymentMethodsTitle: 'Payment Methods',
  proceedToPaymentButton: 'Proceed to Payment',
  creditDebitCardTitle: 'Credit/Debit Card',
  creditDebitCardDescription: 'Pay with Visa, Mastercard, or other cards',
  madaTitle: 'Mada',
  madaDescription: 'Pay with Mada debit card',
  applePayTitle: 'Apple Pay',
  applePayDescription: 'Quick and secure payment with Apple Pay',
  googlePayTitle: 'Google Pay',
  googlePayDescription: 'Quick and secure payment with Google Pay',
  benefitPayTitle: 'Benefit Pay',
  benefitPayDescription: 'Pay using Benefit Pay service',
  selectCityTitle: 'Select City',
  sAfilter: 'Saudi Arabia',
  sendYourGiftTo: 'Send your gift to...',
  myOccasions: 'My Occasions',
  quickAdd: 'Quick Add',
  selectAnOccasionToCreateAreminder: 'Select an occasion to create a reminder',
  yourUpcomingOccasion: 'Your Upcoming Occasion',
  noUpcomingOccasions: 'No upcoming occasions found',
  noOccasionsAvailable: 'No occasions available',
  edit: 'Edit',
  delete: 'Delete',
  loading: 'Loading...',
  deleteOccasionTitle: 'Delete Occasion',
  deleteOccasionConfirm: '''Are you sure you want to delete "{name}"?''',
  deleteButton: 'Delete',
  cancelButton: 'Cancel',
  errorText: 'Error: {message}',
  selectDeliveryDate: 'Select Delivery Date',
  invoiceTitle: 'Invoice',
  noInvoicesTitle: 'You have no invoices from Wardaya.',
  noInvoicesSubtitle: '''Order's invoices will appear here.''',
  invoiceDetails: 'Invoice Details',
  subscriptionCheckoutTitle: 'Checkout',
  recipientDetailsTitle: 'Recipient Details',
  paymentMethodTitle: 'Payment Method',
  paymentDetailsTitle: 'Payment Details',
  proceedToPaymentButton1: 'Proceed To Payment',
  useSavedAddresses: 'Use saved addresses',
  recipientNameLabel: 'Recipient Name',
  recipientNameHint: 'Enter Recipient Name',
  recipientPhoneLabel: 'Recipient Phone Number',
  deliveryAddressLabel: 'Delivery Address',
  askRecipientForAddress: 'Ask the recipient for the address',
  enterRecipientAddress: 'Enter recipient address',
  selectSavedAddress: 'Select a saved address',
  noSavedAddresses: 'No saved addresses found',
  addNewAddress: 'Add New Address',
  tryAgain: 'Try Again',
  errorLoadingAddresses: 'Error loading addresses',
  creditCard: 'Credit Card',
  mada: 'Mada',
  googlePay: 'Google Pay',
  applePay: 'Apple Pay',
  stcPay: 'STC Pay',
  firstDeliveryPaymentDetails: 'First delivery payment details',
  subtotalLabel: 'Subtotal',
  deliveryChargesLabel: 'Delivery charges',
  totalVatIncluded: 'Total (15.0% VAT Included)',
  totalVatIncludedLabel: 'Total (15.0% VAT Included)',
  nextPaymentLabel: 'Next payment',
  pleaseFillFields: 'Please fill in all required fields',
  selectLocation: 'Select Location',
  searchForLocation: 'Search for location',
  dragMapToAdjustLocation: 'Drag map to adjust location',
  selectedLocation: 'Selected Location',
  confirmLocation: 'Confirm Location',
  locationServicesDisabled: 'Location services are disabled. Please enable them in settings.',
  locationPermissionsDenied: 'Location permissions denied. Please grant permission to use your location.',
  locationPermissionsPermanentlyDenied:
      'Location permissions are permanently denied. Please enable them in app settings.',
  currentLocationPinned: 'Current location pinned',
  couldNotGetCurrentLocation: 'Could not get your current location',
  voucherCode: 'Voucher Code',
  addVoucherCode: 'Add a voucher code',
  validatingPromoCode: 'Validating promo code...',
  promoCodeApplied: 'Promo code applied! You get',
  discount: 'discount',
  invalidPromoCode: 'Invalid promo code:',
  pleaseEnterVoucherCode: 'Please enter a voucher code',
  applied: 'Applied',
  apply: 'Apply',
  startTypingToSearch: 'Start typing to search',
  toBeProvidedByRecipient: 'To be provided by recipient',
  tomorrow: 'Tomorrow',
  editOccasion: 'Edit Occasion',
  remindMeAbout: 'Remind me about...',
  updateOccasionDetails: 'Update your occasion details',
  occasionDetailsPrompt: 'Tell us a few details to save your reminder',
  nameLabel1: 'Name',
  dateLabel: 'Date',
  pleaseEnterName: 'Please enter a name for the occasion',
  updateOccasionButton: 'Update Occasion',
  createOccasionButton: 'Create Occasion',
  errorPrefix: 'Error: {message}',
  deleteMyAccount: '',
  deliveryFrequency1: '',
  subscriptionDuration1: '',
);
final LocalizationMessages ar = LocalizationMessages(
  appTitle: 'وردايا',
  appBarTitle: 'وردايا',
  deliveryTo: 'التوصيل إلى',
  locationCity: 'الرياض',
  retry: 'إعادة المحاولة',
  continueShopping: 'مواصلة التسوق',
  viewCart: 'عرض السلة',
  cancel: 'إلغاء',
  signIn: 'تسجيل الدخول',
  loginRequired: 'تسجيل الدخول مطلوب',
  loginRequiredToAccess: 'تسجيل الدخول مطلوب للوصول إلى هذه الصفحة',
  loginToViewCart: 'تسجيل الدخول لعرض سلة التسوق',
  loginToViewProfile: 'تسجيل الدخول لعرض الملف الشخصي',
  loginToSelectCity: 'تسجيل الدخول لاختيار المدينة',
  emailLabel: 'البريد الإلكتروني',
  passwordLabel: 'كلمة المرور',
  signInButton: 'تسجيل الدخول',
  forgetPassword: 'نسيت كلمة المرور؟',
  createAccount: 'إنشاء حساب',
  dividerText: 'أو',
  signInWith: 'سجل دخول باستخدام',
  validationEmailPasswordRequired: 'البريد الإلكتروني وكلمة المرور مطلوبان',
  googleSignInSuccess: 'تم تسجيل الدخول بنجاح باستخدام Google',
  googleSignInFailed: 'فشل تسجيل الدخول باستخدام Google',
  googleTokenError: 'فشل في الحصول على رمز المصادقة من Google',
  appleSignInSuccess: 'تم تسجيل الدخول بنجاح باستخدام Apple',
  appleSignInFailed: 'فشل تسجيل الدخول باستخدام Apple',
  appleTokenError: 'فشل في الحصول على رمز المصادقة من Apple',
  loginFailed: 'فشل تسجيل الدخول',
  registrationFailed: 'فشل التسجيل',
  generalError: 'حدث خطأ. يرجى المحاولة مرة أخرى.',
  formAllFieldRequired: 'جميع الحقول مطلوبة',
  fieldRequired: 'هذا الحقل مطلوب',
  fieldsMarkedRequired: 'الحقول المميزة بعلامة * الحمراء مطلوبة',
  forgetPasswordTitle: 'نسيت كلمة المرور؟',
  forgetPasswordInstruction: 'أدخل البريد الإلكتروني المرتبط بحسابك',
  resetPasswordButton: 'إعادة تعيين كلمة المرور',
  passwordResetLinkSent: 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
  createAccountTitle: 'إنشاء حساب',
  createAccountButton: 'إنشاء حساب',
  nameLabel: 'الاسم',
  phoneLabel: 'الهاتف',
  selectCountryLabel: 'اختر الدولة',
  homeGiftsForEveryMoment: 'هدايا لكل المناسبات',
  homeExploreUniqueGiftIdeas: 'اكتشف أفكار هدايا فريدة',
  homeChooseGiftsNow: 'اختر الهدايا الآن',
  homeRoundedBeautyEndlessCharm: 'جمال دائري وسحر لا ينتهي',
  homeStartTheYearWithTulips: 'ابدأ العام مع التيوليب',
  homeWoodntYouLoveThis: 'ألا تحبين هذا الخشب؟',
  homeAnExtraLuxuriousTouch: 'لمسة فاخرة إضافية',
  homeBestSellers: 'الأكثر مبيعاً',
  homeCaptivationAromasOfMubkhar: 'عطور المباخر الساحرة',
  homeGiftYourLovedOnes: 'اهدي أحبائك قبل نفاذ الكمية',
  homeNaturesMagic: 'سحر الطبيعة',
  homeLatestAndLoveliest: 'الأحدث والأجمل',
  homeGiftsForEveryone: 'هدايا للجميع',
  homeBrandsYoullLove: 'علامات تجارية ستحبها',
  bottomNavHome: 'الرئيسية',
  bottomNavExplore: 'استكشف',
  bottomNavCart: 'السلة',
  bottomNavMyAccount: 'حسابي',
  exploreScreenTitle: 'استكشف',
  exploreSearchHint: 'ابحث عن زهور، هدايا، والمزيد',
  exploreCardMoments: 'اللحظات',
  exploreCardRecipients: 'المستلمون',
  exploreCategoryFlowersPlants: 'زهور ونباتات',
  exploreCategoryFlowersGifts: 'زهور وهدايا',
  exploreCategoryExpressDelivery: 'توصيل سريع',
  exploreCategoryFloralSubscription: 'اشتراك زهري',
  exploreBrandsYoullLove: 'علامات تجارية ستحبها',
  discoverNewIdeasTitle: 'اكتشف أفكاراً جديدة',
  discoverCardExpressDeliveryTitle: 'توصيل سريع',
  discoverCardExpressDeliveryButton: 'اهدِ الآن',
  discoverCardWeeklySurpriseTitle: 'مفاجأة أسبوعية',
  discoverCardWeeklySurpriseButton: 'اشترك',
  momentsScreenTitle: 'اللحظات',
  recipientsScreenTitle: 'المستلمون',
  flowersPlanetsScreenTitle: 'الزهور والنباتات',
  flowersGiftsScreenTitle: 'الزهور والهدايا',
  searchPlaceholder: 'ابحث عن زهور، هدايا، والمزيد',
  searchButton: 'بحث',
  filterTitle: 'الفلاتر',
  filterApply: 'تطبيق',
  filterOccasion: 'المناسبة',
  filterRecipient: 'المستلم',
  filterColor: 'اللون',
  filterBundleType: 'نوع الباقة',
  filterClear: 'مسح',
  filterClose: 'إغلاق',
  gotIt: 'فهمت',
  filterButton: 'فلتر',
  showingProductsCount: 'عرض {count} منتج',
  viewGrid: 'عرض شبكي',
  viewList: 'عرض قائمة',
  allChip: 'الكل',
  categoryFilterTitle: 'الفئة',
  occasionFilterTitle: 'المناسبة',
  recipientFilterTitle: 'المستلم',
  colorFilterTitle: 'اللون',
  showProductsPart1: 'عرض ',
  showProductsPart2: ' منتج',
  filtersTitle: 'الفلاتر',
  addToCart: 'أضف إلى السلة',
  noAddressHassle: 'لا مشكلة في العنوان',
  collectAddressText: 'سنقوم بجمع العنوان نيابة عنك',
  descriptionHeader: 'الوصف',
  descriptionTab: 'الوصف',
  careTipsTab: 'نصائح العناية',
  seeMore: 'عرض المزيد',
  seeLess: 'عرض أقل',
  allPricesIncludeTax: 'جميع الأسعار تشمل الضريبة',
  payWith: 'الدفع باستخدام',
  productDetailsTitle: 'كعكة هيلين المرسومة لعيد الميلاد',
  wardayaPoints: 'نقاط وردايا',
  currencySar: 'ر.س. ',
  splitPaymentsWithTamara: 'قسط دفعاتك على 4 دفعات مع تمارا',
  earn: 'اكسب ',
  similarProducts: 'منتجات مشابهة',
  noSimilarProducts: 'لا توجد منتجات مشابهة',
  cartEmptyTitle: 'سلة التسوق فارغة!',
  cartEmptySubtitle: 'يبدو أنك لم تضيف أي شيء إلى سلة التسوق بعد.',
  startShoppingButton: 'ابدأ التسوق',
  cartTitle: 'السلة ',
  proceedToPayment: 'الدفع الآن',
  freeDeliveryUnlocked: '🎉 لقد حصلت على توصيل مجاني!',
  giftCardMessage: 'بطاقة هدية ورسالة',
  selectGiftCard: 'اختر بطاقة هدية',
  addMessage: 'أضف رسالة',
  customizeButton: 'تخصيص',
  makeItPerfect: 'اجعله مثالياً',
  recommendedTab: 'مُوصى به',
  flowersAddOnTab: 'إضافات زهور',
  stickersTab: 'ملصقات',
  productPrice: 'ر.س. ',
  productTitle: 'لوحة أكريليك عيد ميلاد سعيد - ذهبي',
  toLabel: 'إلى:',
  fromLabel: 'من:',
  optionalHint: 'اختياري',
  suggestedMessagesPromptPart1: 'لا تعرف ماذا تكتب؟ ',
  suggestedMessagesPromptPart2: 'جرب الرسائل المقترحة',
  signatureButton: 'توقيع',
  qrCodeLabel: 'تمت إضافته كرمز QR',
  recordVideoButton: 'تسجيل فيديو',
  orLabel: 'أو',
  pasteLinkButton: 'لصق رابط',
  messageHint: 'اكتب رسالتك عبر عن مشاعرك',
  charactersLeft: 'أحرف متبقية',
  removeTooltip: 'إزالة',
  signatureRemove: 'إزالة التوقيع',
  linkRemove: 'إزالة الرابط',
  handwrittenStyle: 'بخط اليد',
  typedStyle: 'مكتوب',
  charactersLimit: 'أحرف متبقية',
  typingStyleLabel: 'النمط:',
  handwritingOption: 'خط اليد',
  typedOption: 'مكتوب',
  addMediaTitle: 'إضافة فيديو أو صورة',
  mediaIntroText: 'الكلمات صعبة؟ عبر عن نفسك بفيديو أو صورة.',
  howItWorks: 'كيفية الاستخدام',
  pasteLinkInstruction: 'الصق رابط فيديو أو صورة من الإنترنت',
  recordVideoInstruction: 'سجل فيديو لمدة 10 ثوانٍ أو التقط صورة',
  qrCodeNote: 'سيتم إضافة رمز QR إلى رسالة البطاقة الخاصة بك',
  freeLabel: 'مجاني',
  pasteLinkHint: 'الصق الرابط هنا',
  addToMessageButton: 'إضافة إلى الرسالة',
  startRecordingButton: 'بدء التسجيل',
  recordVideoTab: 'تسجيل فيديو',
  pasteLinkTab: 'لصق رابط',
  noCardSelected: 'لم يتم اختيار بطاقة',
  frontSideLabel: 'الوجه الأمامي (الرسالة)',
  backSideLabel: 'الوجه الخلفي (الغلاف)',
  qrQuestion: 'هل استمتعت بهذه الهدية؟',
  qrInstruction: 'امسح رمز QR لمشاركة رسالتك الصادقة مع المرسل',
  signatureTitle: 'توقيعك',
  drawInstruction: 'ارسم توقيعك داخل الإطار',
  clearButton: 'مسح',
  saveButton: 'حفظ',
  customizeGiftCard: 'خصص بطاقة الهدية',
  selectCard: 'اختر البطاقة',
  preview: 'معاينة',
  saveAndContinue: 'حفظ ومتابعة',
  profileScreenTitle: 'الملف الشخصي',
  viewEditProfile: 'عرض/تعديل الملف الشخصي',
  myOrders: 'طلباتي',
  mySubscriptions: 'اشتراكاتي',
  invoices: 'الفواتير',
  savedAddresses: 'العناوين المحفوظة',
  occasions: 'المناسبات',
  favouriteGifts: 'الهدايا المفضلة',
  wardayaWallet: 'محفظة وردايا',
  customerCare: 'خدمة العملاء',
  language: 'اللغة',
  faq: 'الأسئلة الشائعة',
  termsConditions: 'الشروط والأحكام',
  customerCareTitle: '''يسعدنا مساعدتك!
هل تحتاج مساعدة في شيء ما؟''',
  phoneCall: 'مكالمة هاتفية',
  whatsapp: 'واتساب',
  arabic: 'العربية',
  english: 'الإنجليزية',
  logout: 'تسجيل خروج',
  deleteAccount: 'حذف حسابي',
  deleteAccountConfirmation: 'هل أنت متأكد أنك تريد حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.',
  confirm: 'تأكيد',
  editProfileTitle: 'تعديل الملف الشخصي',
  saveChangesButton: 'حفظ',
  firstNameLabel: 'الاسم الأول',
  lastNameLabel: 'اسم العائلة',
  fullNameLabel: 'الاسم الكامل',
  phoneNumberLabel: 'رقم الهاتف',
  emailAddressLabel: 'البريد الإلكتروني',
  changePasswordButton: 'تغيير',
  changePasswordTitle: 'كلمة المرور',
  birthdayLabel: 'تاريخ الميلاد',
  mySubscriptionsTitle: 'اشتراكاتي',
  wardayaSubscriptions: '''وردايا
اشتراكات''',
  subscriptionDescription: '''
استمتع بسحر توصيل الزهور الطازجة المنتظمة التي تعمل على تحويل مساحتك، ورفع روحك، ونشر الفرح طوال الوقت''',
  subscriptionHowItWorks: 'كيف يعمل؟',
  subscriptionSelectYourPlan: 'حدد خطتك:',
  subscriptionChooseWhatFitsYourNeeds: 'اختر ما يناسب احتياجاتك.',
  subscriptionCustomizeDelivery: 'تخصيص التسليم:',
  subscriptionSetDeliveryFrequencyAndPayment: 'تعيين تردد التسليم والدفع.',
  subscriptionEnjoyFreshFlowers: 'استمتع بالزهور النضرة:',
  subscriptionReceiveFreshFlowersEveryTime: 'احصل على زهور نضرة في كل مرة.',
  subscriptionPlans: 'خطط الاشتراك',
  subscriptionStartingFrom: 'بدءا من',
  subscriptionButton: 'اشترك الآن',
  more: 'المزيد',
  less: 'أقل',
  startingFrom: 'بدءا من',
  perDelivery: 'لكل تسليم',
  subscriptionDurationTitle: 'اشتراك الزهور الكلاسيكية',
  deliveryFrequency: '',
  onceAWeek: 'مرة واحدة في الأسبوع',
  everyTwoWeeks: 'كل أسبوعين',
  onceAMonth: 'مرة واحدة في الشهر',
  subscriptionDuration: '',
  deliveries: 'عمليات التوصيل',
  total: 'الإجمالي',
  startingDate: 'تاريخ البدء',
  selectOtherDate: 'اختر تاريخًا آخر',
  weSelectDeleveryBasedArea: 'سنختار أفضل وقت توصيل بناءً على منطقتك وتاريخ التوصيل',
  off: 'خصم',
  perDelivery1: '',
  favoritesScreenTitle: 'المفضلة',
  favoritesEmptyTitle: 'لا يوجد منتجات مفضلة بعد',
  favoritesEmptyButton: 'ابدأ التسوق',
  subMenuItemsScreenTitle: 'المنتجات',
  subMenuItemsEmptyTitle: 'لا يوجد منتجات بعد',
  addressesScreenTitle: 'العنوان المحفوظ',
  addressesScreenAddNewAddressButton: 'إضافة عنوان جديد',
  addressesScreenNoAddressesFound: 'لا يوجد عنوان محفوظ',
  addressSavedSuccessfully: 'تم حفظ العنوان بنجاح',
  addressUpdatedSuccessfully: 'تم تحديث العنوان بنجاح',
  addressDeletedSuccessfully: 'تم حذف العنوان بنجاح',
  fillRequiredFields: 'يرجى ملء جميع الحقول المطلوبة',
  dropAddressFromMap: 'حدد العنوان من الخريطة',
  enterAddressDetails: 'أدخل تفاصيل العنوان',
  enterPhoneNumber: 'أدخل رقم الهاتف',
  enterRecipientName: 'أدخل اسم المستلم',
  defaultAddressTitle: 'عنواني',
  defaultAddressWithArea: 'عنواني في {area}',
  addressLabelHint: 'مثال: مبنى 125، طريق الملك فهد، حي العليا',
  extraAddressLabelHint: 'مثال: الطابق الثاني، شقة 5',
  recipientDetailsScreenTitle: 'تفاصيل المستلم',
  recipientDetailsScreenContinueButton: 'متابعة',
  recipientDetailsScreenRecipientNameLabel: 'الاسم',
  recipientDetailsScreenRecipientPhoneLabel: 'رقم الهاتف',
  recipientDetailsScreenRecipientAreaLabel: 'المنطقة',
  recipientDetailsScreenRecipientAddressLabel: 'العنوان',
  recipientDetailsScreenRecipientExtraAddressLabel: 'العنوان الإضافي (اختياري)',
  orderNumber: 'رقم الطلب',
  date: 'التاريخ',
  orderId: 'رقم الطلب',
  orderStatus: 'الحالة',
  deliveryInfo: 'معلومات التوصيل',
  recipientName: 'الاسم',
  phoneNumber: 'رقم الهاتف',
  address: 'العنوان',
  estimatedDeliveryTime: 'وقت التوصيل المتوقع',
  myIdentity: 'هويتي',
  expressDelivery: 'توصيل سريع',
  hidden: 'مخفي',
  visible: 'ظاهر',
  yes: 'نعم',
  no: 'لا',
  quantity: '×',
  noOrders: 'لا توجد طلبات',
  recipient: 'المستلم',
  deliveryDate: 'تاريخ التوصيل',
  paymentDetails: 'تفاصيل الدفع',
  subtotal: 'المجموع الفرعي',
  deliveryCharges: 'رسوم التوصيل',
  vatLabel: 'ضريبة القيمة المضافة',
  paymentMethod: 'طريقة الدفع',
  searchOrderPlaceholder: 'ابحث عن رقم الطلب أو اسم المستلم',
  paymentTitle: 'الدفع',
  cancelPaymentTitle: 'إلغاء الدفع؟',
  cancelPaymentMessage: 'هل أنت متأكد أنك تريد إلغاء عملية الدفع؟',
  cancelPaymentNo: 'لا',
  cancelPaymentYes: 'نعم',
  paymentAmountTitle: 'مبلغ الدفع',
  paymentOrderIdLabel: 'رقم الطلب:',
  paymentError: 'خطأ في تحميل صفحة الدفع:',
  paymentTryAgain: 'حاول مرة أخرى',
  paymentSuccessTitle: 'تم الدفع بنجاح',
  paymentSuccessMessage: 'تمت معالجة عملية الدفع الخاصة بك بنجاح.',
  paymentFailedTitle: 'فشلت عملية الدفع',
  paymentFailedMessage: 'تعذر معالجة عملية الدفع الخاصة بك. يرجى المحاولة مرة أخرى.',
  paymentOkButton: 'موافق',
  paymentMethodsTitle: 'طرق الدفع',
  proceedToPaymentButton: 'المتابعة للدفع',
  creditDebitCardTitle: 'بطاقة ائتمان/خصم',
  creditDebitCardDescription: 'ادفع باستخدام فيزا، ماستركارد، أو بطاقات أخرى',
  madaTitle: 'مدى',
  madaDescription: 'ادفع باستخدام بطاقة مدى',
  applePayTitle: 'Apple Pay',
  applePayDescription: 'دفع سريع وآمن باستخدام Apple Pay',
  googlePayTitle: 'Google Pay',
  googlePayDescription: 'دفع سريع وآمن باستخدام Google Pay',
  benefitPayTitle: 'بنفت باي',
  benefitPayDescription: 'ادفع باستخدام خدمة بنفت باي',
  selectCityTitle: 'اختر المدينة',
  sAfilter: 'المملكة العربية السعودية',
  sendYourGiftTo: 'أرسل هديتك إلى...',
  myOccasions: 'مناسباتي',
  quickAdd: 'إضافة سريعة',
  selectAnOccasionToCreateAreminder: 'اختر مناسبة لإنشاء تذكير',
  yourUpcomingOccasion: 'مناسباتك القادمة',
  noUpcomingOccasions: 'لا توجد مناسبات قادمة',
  noOccasionsAvailable: 'لا توجد مناسبات متاحة',
  edit: 'تعديل',
  delete: 'حذف',
  loading: 'جار التحميل...',
  deleteOccasionTitle: 'حذف المناسبة',
  deleteOccasionConfirm: 'هل أنت متأكد أنك تريد حذف هذه المناسبة؟',
  deleteButton: 'حذف',
  cancelButton: 'إلغاء',
  errorText: 'حدث خطأ أثناء تحميل المناسبات',
  selectDeliveryDate: 'اختر تاريخ التوصيل',
  invoiceTitle: 'الفواتير',
  noInvoicesTitle: 'لا توجد فواتير',
  noInvoicesSubtitle: 'لا توجد فواتير متاحة',
  invoiceDetails: 'تفاصيل الفاتورة',
  subscriptionCheckoutTitle: 'إتمام الطلب',
  recipientDetailsTitle: 'بيانات المستلم',
  paymentMethodTitle: 'طريقة الدفع',
  paymentDetailsTitle: 'تفاصيل الدفع',
  proceedToPaymentButton1: 'المتابعة للدفع',
  useSavedAddresses: 'استخدم العناوين المحفوظة',
  recipientNameLabel: 'اسم المستلم',
  recipientNameHint: 'أدخل اسم المستلم',
  recipientPhoneLabel: 'رقم هاتف المستلم',
  deliveryAddressLabel: 'عنوان التوصيل',
  askRecipientForAddress: 'اطلب العنوان من المستلم',
  enterRecipientAddress: 'أدخل عنوان المستلم',
  selectSavedAddress: 'اختر عنوانًا محفوظًا',
  noSavedAddresses: 'لا توجد عناوين محفوظة',
  addNewAddress: 'إضافة عنوان جديد',
  tryAgain: 'حاول مرة أخرى',
  errorLoadingAddresses: 'خطأ في تحميل العناوين',
  creditCard: 'بطاقة ائتمان',
  mada: 'مدى',
  googlePay: 'جوجل باي',
  applePay: 'آبل باي',
  stcPay: 'STC باي',
  firstDeliveryPaymentDetails: 'تفاصيل دفع التوصيل الأول',
  subtotalLabel: 'المجموع الفرعي',
  deliveryChargesLabel: 'رسوم التوصيل',
  totalVatIncluded: 'الإجمالي (شامل ض.ق.م 15.0%)',
  totalVatIncludedLabel: 'الإجمالي (شامل ض.ق.م 15.0%)',
  nextPaymentLabel: 'الدفعة التالية',
  pleaseFillFields: 'يرجى تعبئة جميع الحقول المطلوبة',
  selectLocation: 'اختيار الموقع',
  searchForLocation: 'ابحث عن موقع',
  dragMapToAdjustLocation: 'اسحب الخريطة لتعديل الموقع',
  selectedLocation: 'الموقع المحدد',
  confirmLocation: 'تأكيد الموقع',
  locationServicesDisabled: 'خدمات الموقع معطلة. يرجى تفعيلها في الإعدادات.',
  locationPermissionsDenied: 'تم رفض أذونات الموقع. يرجى منح الإذن لاستخدام موقعك.',
  locationPermissionsPermanentlyDenied: 'تم رفض أذونات الموقع بشكل دائم. يرجى تمكينها في إعدادات التطبيق.',
  currentLocationPinned: 'تم تحديد موقعك الحالي',
  couldNotGetCurrentLocation: 'تعذر الحصول على موقعك الحالي',
  voucherCode: 'كود الخصم',
  addVoucherCode: 'أضف كود خصم',
  validatingPromoCode: 'جاري التحقق من كود الخصم...',
  promoCodeApplied: 'تم تطبيق كود الخصم! لديك',
  discount: 'خصم',
  invalidPromoCode: 'كود الخصم غير صالح:',
  pleaseEnterVoucherCode: 'الرجاء إدخال كود خصم',
  applied: 'تم التطبيق',
  apply: 'تطبيق',
  startTypingToSearch: 'ابدأ الكتابة للبحث',
  toBeProvidedByRecipient: 'سيقدمه المستلم',
  tomorrow: 'غداً',
  editOccasion: 'تعديل المناسبة',
  remindMeAbout: '...ذكرني عن',
  updateOccasionDetails: 'تحديث تفاصيل المناسبة',
  occasionDetailsPrompt: 'أدخل تفاصيل المناسبة',
  nameLabel1: 'الاسم',
  dateLabel: 'التاريخ',
  pleaseEnterName: 'الرجاء إدخال الاسم',
  updateOccasionButton: 'تحديث المناسبة',
  createOccasionButton: 'إنشاء مناسبة',
  errorPrefix: 'خطأ: ',
  deleteMyAccount: 'حذف الحساب',
  deliveryFrequency1: 'تكرار التوصيل',
  subscriptionDuration1: 'مدة الاشتراك',
);
final Map<Locale, LocalizationMessages> _languageMap = {
  Locale('en'): en,
  Locale('ar'): ar,
};

final Map<Locale, LocalizationMessages> _providersLanguagesMap = {};

class EasiestLocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  EasiestLocalizationDelegate({
    List<LocalizationProvider<LocalizationMessages>> providers = const [],
  }) {
    providers.forEach(registerProvider);
  }

  final List<LocalizationProvider<LocalizationMessages>> _providers = [];

  void registerProvider(LocalizationProvider<LocalizationMessages> provider) {
    _providers.add(provider);
  }

  @override
  bool isSupported(Locale locale) {
    final bool supportedByProviders = _providers.any((LocalizationProvider value) => value.canLoad(locale));
    if (supportedByProviders) {
      return true;
    }
    final bool hasInLanguageMap = _languageMap.containsKey(locale);
    if (hasInLanguageMap) {
      return true;
    }
    for (final Locale supportedLocale in _languageMap.keys) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.toString();

    LocalizationProvider<LocalizationMessages>? localizationProvider;

    for (final LocalizationProvider<LocalizationMessages> provider in _providers) {
      if (provider.canLoad(locale)) {
        localizationProvider = provider;
        break;
      }
    }

    LocalizationMessages? localeContent;

    if (localizationProvider != null) {
      try {
        localeContent = await localizationProvider.fetchLocalization(locale);
        _providersLanguagesMap[locale] = localeContent;
      } catch (error, stackTrace) {
        log('Error on loading localization with provider "${localizationProvider.name}"',
            error: error, stackTrace: stackTrace);
      }
    }

    localeContent ??= _loadLocalLocale(locale) ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => old != this;
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages? getContent(Locale locale) => _loadLocalLocale(locale);

  static LocalizationMessages get el {
    final String? defaultLocaleString = Intl.defaultLocale;
    final List<String> localeParticles = defaultLocaleString == null ? [] : defaultLocaleString.split(RegExp(r'[_-]'));
    final Locale? defaultLocale = localeParticles.isEmpty
        ? null
        : Locale(localeParticles.first, localeParticles.length > 1 ? localeParticles[1] : null);
    LocalizationMessages? localeContent = _providersLanguagesMap[defaultLocale];
    localeContent ??= _languageMap[defaultLocale] ?? _languageMap.values.first;
    return localeContent;
  }
}

LocalizationMessages? _loadLocalLocale(Locale locale) {
  final bool hasInLanguageMap = _languageMap.containsKey(locale);
  if (hasInLanguageMap) {
    return _languageMap[locale];
  }
  for (final Locale supportedLocale in _languageMap.keys) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return _languageMap[supportedLocale];
    }
  }
  return null;
}

LocalizationMessages get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

List<LocalizationsDelegate> localizationsDelegatesWithProviders(
    List<LocalizationProvider<LocalizationMessages>> providers) {
  return [
    EasiestLocalizationDelegate(providers: providers),
    ...GlobalMaterialLocalizations.delegates,
  ];
}

// Supported locales: en, ar
const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('ar'),
];

List<Locale> supportedLocalesWithProviders(List<LocalizationProvider<LocalizationMessages>> providers) => [
      for (final LocalizationProvider provider in providers) ...provider.supportedLocales,
      ...supportedLocales,
    ];

extension EasiestLocalizationContext on BuildContext {
  LocalizationMessages get el {
    return Messages.of(this);
  }

  dynamic tr(String key) => key.tr();
}

extension EasiestLocalizationString on String {
  dynamic get el {
    final List<String> groupOfStrings = contains('.') ? split('.') : [this];
    dynamic targetContent;
    for (int i = 0; i < groupOfStrings.length; i++) {
      final String key = groupOfStrings[i];
      if (i == 0) {
        targetContent = Messages.el[key];
        if (targetContent == null) {
          return '';
        }
      } else {
        try {
          targetContent = targetContent[key];
          if (targetContent == null) {
            return '';
          }
        } catch (error) {
          if (kDebugMode) {
            print(
                '[ERROR] Incorrect retrieving of value by key "$key" from value "$targetContent"; Original key was "$this"');
          }
          return '';
        }
      }
    }
    return targetContent;
  }

  dynamic tr() => el;
}

dynamic tr(String key) => key.tr();
