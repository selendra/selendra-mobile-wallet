/* -------------This file is hold all Packages, Path of file -------------*/

/* flutter Package */
export 'dart:async';
export 'package:flutter/material.dart';
export 'package:wallet_apps/src/service/services.dart';
export 'dart:convert';
export 'package:flutter/services.dart';
export 'dart:io' show Platform;
export 'dart:io';
export 'package:flutter/foundation.dart';
export 'package:flutter/rendering.dart';
export 'dart:typed_data';

/* Package from Pub.dev */
export 'package:connectivity/connectivity.dart';
export 'package:wallet_apps/src/firebase/firebase_remote_config.dart';
export 'package:store_redirect/store_redirect.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:package_info/package_info.dart';
export 'package:outline_material_icons/outline_material_icons.dart';
export 'package:pinput/pin_put/pin_put.dart';
export 'package:barcode_scan/barcode_scan.dart';
export 'package:flutter_circular_chart/flutter_circular_chart.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:fluttercontactpicker/fluttercontactpicker.dart';
export 'package:autocomplete_textfield/autocomplete_textfield.dart';
export 'package:image_picker/image_picker.dart';
export 'package:qr_flutter/qr_flutter.dart';
export 'package:firebase_remote_config/firebase_remote_config.dart';
export 'package:share/share.dart';
export 'package:flare_flutter/flare_actor.dart';
export 'package:flare_flutter/flare_controller.dart';
export 'package:http_parser/http_parser.dart';
export 'package:flutter_image_compress/flutter_image_compress.dart';
export 'package:flare_flutter/flare_controls.dart';
export 'package:local_auth/local_auth.dart';
export 'package:share_extend/share_extend.dart';
export 'package:path_provider/path_provider.dart';
export 'package:sms_autofill/sms_autofill.dart';
export 'package:async/async.dart';
// export 'package:line_icons/line_icons.dart';
// export 'package:line_awesome_icons/line_awesome_icons.dart';
export 'package:line_awesome_flutter/line_awesome_flutter.dart';
export 'package:qr_code_scanner/qr_code_scanner.dart';

/* Local File */
export 'package:wallet_apps/src/service/services.dart';
export 'package:wallet_apps/theme/string.dart';
export 'package:wallet_apps/src/utils/app_utils.dart';
export 'package:wallet_apps/theme/color.dart';
export 'package:wallet_apps/src/components/reuse_widget.dart';
export 'package:wallet_apps/src/bloc/bloc.dart';
export 'package:wallet_apps/src/bloc/bloc_provider.dart';
export 'package:wallet_apps/src/bloc/validator_mixin.dart';
export 'package:wallet_apps/src/config/app_config.dart';
export 'package:wallet_apps/src/routes/routing.dart';
export 'package:wallet_apps/theme/style.dart';
export 'package:wallet_apps/src/components/animation.dart';
export 'package:wallet_apps/src/utils/instance_trx_order.dart';
export 'package:wallet_apps/src/components/trx_component.dart';
export 'package:wallet_apps/src/components/platform_specific/android_native.dart';
export 'package:wallet_apps/src/components/platform_specific/ios_native.dart';

/* Utils */
export 'package:wallet_apps/src/utils/get_wallet_fns.dart';

// Backend
export 'package:wallet_apps/src/backend/api.dart';
export 'package:wallet_apps/src/backend/get/get_request.dart';
export 'package:wallet_apps/src/backend/post/post_request.dart';

export 'package:wallet_apps/src/backend/component.dart';

//Service
export 'package:wallet_apps/src/service/storage.dart';

/* ----------------------Route To Screen---------------------- */

// Main Screeen
export 'package:wallet_apps/src/screen/main/welcome/welcome.dart';
export  'package:wallet_apps/src/screen/main/welcome/welcome_body.dart';

// Finger Print

export 'package:wallet_apps/src/screen/main/login/login.dart';
export 'package:wallet_apps/src/screen/main/splash_screen/splash_screen.dart';
export 'package:wallet_apps/src/screen/main/forgot_password/forgot_password.dart';
export 'package:wallet_apps/src/screen/main/login/login_body.dart';
export 'package:wallet_apps/src/screen/home/add_user_info/add_user_info.dart';
export 'package:wallet_apps/src/screen/home/fill_documents_screen/fill_documents.dart';
export 'package:wallet_apps/src/screen/main/local_auth/finger_print.dart';

// Reset Password
export 'package:wallet_apps/src/screen/main/forgot_password/reset_password_screen/reset_password.dart';
export 'package:wallet_apps/src/screen/main/forgot_password/reset_password_screen/reset_password_body.dart';

// Forgot Password
export 'package:wallet_apps/src/screen/main/sign_up/create_password/create_password.dart';
export 'package:wallet_apps/src/screen/main/forgot_password/forgot_password_body.dart';

// Create Password
export 'package:wallet_apps/src/screen/main/sign_up/create_password/create_password_body.dart'; 

// Reset Code
export 'package:wallet_apps/src/screen/main/forgot_password/reset_code/reset_code_body.dart';

//SMS verify
export 'package:wallet_apps/src/screen/main/sign_up/sms_code/sms_code_verify_body.dart';

// User Information
export 'package:wallet_apps/src/screen/main/sign_up/user_info/user_info.dart';
export 'package:wallet_apps/src/screen/main/sign_up/user_info/user_info_body.dart';

// Sign Up
export 'package:wallet_apps/src/screen/main/sign_up/sign_up.dart';
export 'package:wallet_apps/src/screen/main/sign_up/sign_up_body.dart';

// Sms Code Verification
export 'package:wallet_apps/src/screen/main/sign_up/sms_code/sms_code_verify.dart';

// Slide Screen
export 'package:wallet_apps/src/screen/main/slide/widget/slide_dot.dart';
export 'package:wallet_apps/src/screen/main/slide/widget/slide_item.dart';
export 'package:wallet_apps/src/screen/main/slide/slider_builder.dart';

/* Home Screen */

// Dashbaord
export 'package:wallet_apps/src/screen/home/dashboard/dashboard.dart';
export 'package:wallet_apps/src/screen/home/dashboard/dashboard_body.dart';

export 'package:wallet_apps/src/screen/home/dashboard/transaction/submit_trx/submit_trx.dart';
export 'package:wallet_apps/src/screen/home/dashboard/get_wallet/get_wallet.dart';
export 'package:wallet_apps/src/screen/home/dashboard/send_wallet_option/send_wallet_option.dart';
export 'package:wallet_apps/src/screen/home/dashboard/component.dart';
export 'package:wallet_apps/src/screen/home/dashboard/transaction/submit_trx/fill_pin_dialog.dart';
export 'package:wallet_apps/src/screen/home/dashboard/invoice/invoice_summary/invoice_reuse_widget.dart';
export 'package:wallet_apps/src/screen/home/dashboard/invoice/invoice_summary/invoice_summary_body.dart';
export 'package:wallet_apps/src/screen/home/dashboard/transaction/submit_trx/submit_trx_body.dart';
export 'package:wallet_apps/src/screen/home/dashboard/transaction/get_wallet_from_contact/get_wallet_from_contact_body.dart';
export 'package:wallet_apps/src/screen/home/dashboard/chart/chart_body.dart';

export 'package:wallet_apps/src/screen/home/dashboard/get_wallet/get_wallet_body.dart';

/* Component File */
export 'package:wallet_apps/src/components/component.dart';
export 'package:wallet_apps/src/components/menu_component.dart';
export 'package:wallet_apps/src/components/main_component.dart';

/* Menu Screen */
export 'package:wallet_apps/src/screen/home/menu/menu.dart';

export 'package:wallet_apps/src/screen/home/menu/menu_body.dart';

export 'package:wallet_apps/src/screen/home/menu/add_phone/add_phone.dart';
export 'package:wallet_apps/src/screen/home/menu/add_phone/add_phone_body.dart';

// Add User Information
export 'package:wallet_apps/src/screen/home/add_user_info/add_user_info_body.dart';

// Edit Profile
export 'package:wallet_apps/src/screen/home/menu/edit_profile/edit_profile.dart';
export 'package:wallet_apps/src/screen/home/fill_documents_screen/take_selfie_screen/take_selfie_body.dart';
export 'package:wallet_apps/src/screen/home/menu/edit_profile/edit_profile_body.dart';

// Transaction Activiity
export 'package:wallet_apps/src/screen/home/menu/trx_activity/reuse_activity_widget.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_activity/transaction_activity.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_activity/transaction_activity_details/transaction_activity_details.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_activity/transaction_activity_body.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_activity/transaction_activity_details/transaction_activity_details_body.dart';

// Transaction History
export 'package:wallet_apps/src/screen/home/menu/trx_history/tab_bars_list/all_trx.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/tab_bars_list/received_trx.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/tab_bars_list/send_transaction.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/trx_history_details/trx_history_detail.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/trx_history.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/trx_history_details/trx_history_detail_body.dart';
export 'package:wallet_apps/src/screen/home/menu/trx_history/trx_history_body.dart';

// Change Password
export 'package:wallet_apps/src/screen/home/menu/change_password/change_password.dart';
export 'package:wallet_apps/src/screen/home/menu/change_password/change_password_body.dart';

// Change PIN
export 'package:wallet_apps/src/screen/home/menu/change_pin/change_pin.dart';
export 'package:wallet_apps/src/screen/home/menu/change_pin/change_pin_body.dart';

// Document
export 'package:wallet_apps/src/screen/home/fill_documents_screen/take_selfie_screen/take_selfie.dart';
export 'package:wallet_apps/src/screen/home/fill_documents_screen/upload_documents_screen/upload_documents.dart';

// Get Wallet
export 'package:wallet_apps/src/screen/home/menu/private_key/private_key.dart';
export 'package:wallet_apps/src/screen/home/menu/set_pin/confirm_pin.dart';
export 'package:wallet_apps/src/screen/home/menu/set_pin/pin.dart';
export 'package:wallet_apps/src/screen/home/menu/private_key/private_key_body.dart';

// Reward From Invoice
export 'package:wallet_apps/src/screen/home/dashboard/invoice/invoice_info/invoice_info_body.dart';
export 'package:wallet_apps/src/screen/home/dashboard/invoice/invoice_summary/invoice_summary.dart';

// Add Assets
export 'package:wallet_apps/src/screen/home/menu/add_asset/add_asset.dart';
export 'package:wallet_apps/src/screen/home/menu/add_asset/add_asset_body.dart';

/* ------------------- App Model ------------------*/

/* Main Screen */

export 'package:wallet_apps/src/model/model_signup.dart';
export 'package:wallet_apps/src/model/model_user_info.dart';
export 'package:wallet_apps/src/model/model_forgot_pass.dart';
export 'package:wallet_apps/src/model/slide.dart';

/* Home Screen */

// Dashboard
export 'package:wallet_apps/src/model/model_login.dart';
export 'package:wallet_apps/src/model/model_document.dart';
export 'package:wallet_apps/src/model/model_dashboard.dart';
export 'package:wallet_apps/src/model/model_scan_pay.dart';
export 'package:wallet_apps/src/model/model_scan_invoice.dart';
export 'package:wallet_apps/src/model/model_get_wallet_from_contact.dart';

/* Menu */
export 'package:wallet_apps/src/model/menu.dart';

// Change PIN
export 'package:wallet_apps/src/model/model_change_pin.dart';

// Change Password
export 'package:wallet_apps/src/model/model_change_password.dart';

// Add Asset
export 'package:wallet_apps/src/model/model_asset.dart';

// Add Phone
export 'package:wallet_apps/src/model/add_phone_number.dart';

export 'package:wallet_apps/src/model/sms_code_model.dart';

